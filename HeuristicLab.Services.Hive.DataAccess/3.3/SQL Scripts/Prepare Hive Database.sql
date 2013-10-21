USE [HeuristicLab.Hive-3.3]
/* this script is supposed to be executed after the plain DB is generated by the linq-to-sql schema */
/* adds default values */
/* creates delete and update cascades */
/* creates indices */
/* creates views */
/* creates triggers */


ALTER TABLE [dbo].[AssignedResources]  DROP  CONSTRAINT [Task_AssignedResource]
ALTER TABLE [dbo].[AssignedResources]  WITH CHECK ADD  CONSTRAINT [Task_AssignedResource] FOREIGN KEY([TaskId])
REFERENCES [dbo].[Task] ([TaskId])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AssignedResources]  DROP  CONSTRAINT [Resource_AssignedResource]
ALTER TABLE [dbo].[AssignedResources]  WITH CHECK ADD  CONSTRAINT [Resource_AssignedResource] FOREIGN KEY([ResourceId])
REFERENCES [dbo].[Resource] ([ResourceId])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE dbo.Task ALTER COLUMN TaskId ADD ROWGUIDCOL;
ALTER TABLE dbo.Task WITH NOCHECK ADD CONSTRAINT [DF_Task_TaskId] DEFAULT (NEWSEQUENTIALID()) FOR TaskId;
GO

ALTER TABLE [dbo].[StateLog]  DROP  CONSTRAINT [Task_StateLog]
ALTER TABLE [dbo].[StateLog]  WITH CHECK ADD CONSTRAINT [Task_StateLog] FOREIGN KEY([TaskId])
REFERENCES [dbo].[Task] ([TaskId])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[StateLog]  DROP  CONSTRAINT [Resource_StateLog]
ALTER TABLE [dbo].[StateLog]  WITH CHECK ADD CONSTRAINT [Resource_StateLog] FOREIGN KEY([SlaveId])
REFERENCES [dbo].[Resource] ([ResourceId])
ON UPDATE CASCADE
ON DELETE SET NULL
GO

ALTER TABLE dbo.Plugin ALTER COLUMN PluginId ADD ROWGUIDCOL;
ALTER TABLE dbo.Plugin WITH NOCHECK ADD CONSTRAINT [DF_Plugin_PluginId] DEFAULT (NEWSEQUENTIALID()) FOR PluginId;

ALTER TABLE dbo.PluginData WITH NOCHECK ADD CONSTRAINT [DF_PluginData_PluginDataId] DEFAULT (NEWSEQUENTIALID()) FOR PluginDataId;

ALTER TABLE [dbo].[PluginData]  DROP  CONSTRAINT [Plugin_PluginData]
ALTER TABLE [dbo].[PluginData]  WITH CHECK ADD  CONSTRAINT [Plugin_PluginData] FOREIGN KEY([PluginId])
REFERENCES [dbo].[Plugin] ([PluginId])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE dbo.RequiredPlugins ALTER COLUMN RequiredPluginId ADD ROWGUIDCOL;
ALTER TABLE dbo.RequiredPlugins WITH NOCHECK ADD CONSTRAINT [DF_RequiredPlugins_RequiredPluginId] DEFAULT (NEWSEQUENTIALID()) FOR RequiredPluginId;

ALTER TABLE [dbo].[RequiredPlugins]  DROP  CONSTRAINT [Task_RequiredPlugin]
ALTER TABLE [dbo].[RequiredPlugins]  WITH CHECK ADD  CONSTRAINT [Task_RequiredPlugin] FOREIGN KEY([TaskId])
REFERENCES [dbo].[Task] ([TaskId])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[RequiredPlugins]  DROP  CONSTRAINT [Plugin_RequiredPlugin]
ALTER TABLE [dbo].[RequiredPlugins]  WITH CHECK ADD  CONSTRAINT [Plugin_RequiredPlugin] FOREIGN KEY([PluginId])
REFERENCES [dbo].[Plugin] ([PluginId])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE dbo.Resource ALTER COLUMN ResourceId ADD ROWGUIDCOL;
ALTER TABLE dbo.Resource WITH NOCHECK ADD CONSTRAINT [DF_Resource_ResourceId] DEFAULT (NEWSEQUENTIALID()) FOR ResourceId;

ALTER TABLE dbo.Downtime ALTER COLUMN DowntimeId ADD ROWGUIDCOL;
ALTER TABLE dbo.Downtime WITH NOCHECK ADD CONSTRAINT [DF_Downtime_DowntimeId] DEFAULT (NEWSEQUENTIALID()) FOR DowntimeId;

ALTER TABLE dbo.Job ALTER COLUMN JobId ADD ROWGUIDCOL;
ALTER TABLE dbo.Job WITH NOCHECK ADD CONSTRAINT [DF_Job_JobId] DEFAULT (NEWSEQUENTIALID()) FOR JobId;

ALTER TABLE dbo.StateLog ALTER COLUMN StateLogId ADD ROWGUIDCOL;
ALTER TABLE dbo.StateLog WITH NOCHECK ADD CONSTRAINT [DF_StateLog_StateLogId] DEFAULT (NEWSEQUENTIALID()) FOR StateLogId;

ALTER TABLE [dbo].[JobPermission]  DROP  CONSTRAINT [Job_JobPermission]
ALTER TABLE [dbo].[JobPermission]  WITH CHECK ADD CONSTRAINT [Job_JobPermission] FOREIGN KEY([JobId])
REFERENCES [dbo].[Job] ([JobId])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[ResourcePermission]  DROP  CONSTRAINT [Resource_ResourcePermission]
ALTER TABLE [dbo].[ResourcePermission]  WITH CHECK ADD CONSTRAINT [Resource_ResourcePermission] FOREIGN KEY([ResourceId])
REFERENCES [dbo].[Resource] ([ResourceId])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[Statistics] ALTER COLUMN StatisticsId ADD ROWGUIDCOL;
ALTER TABLE [dbo].[Statistics] WITH NOCHECK ADD CONSTRAINT [DF_Statistics_StatisticsId] DEFAULT (NEWSEQUENTIALID()) FOR StatisticsId;
GO

ALTER TABLE [dbo].[DeletedJobStatistics] ALTER COLUMN DeletedJobStatisticsId ADD ROWGUIDCOL;
ALTER TABLE [dbo].[DeletedJobStatistics] WITH NOCHECK ADD CONSTRAINT [DF_DeletedJobStatistics_DeletedJobStatisticsId] DEFAULT (NEWSEQUENTIALID()) FOR DeletedJobStatisticsId;
GO

ALTER TABLE [dbo].[SlaveStatistics]  DROP  CONSTRAINT [Statistics_SlaveStatistics]
ALTER TABLE [dbo].[SlaveStatistics]  WITH CHECK ADD  CONSTRAINT [Statistics_SlaveStatistics] FOREIGN KEY([StatisticsId])
REFERENCES [dbo].[Statistics] ([StatisticsId])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[UserStatistics]  DROP  CONSTRAINT [Statistics_UserStatistics]
ALTER TABLE [dbo].[UserStatistics]  WITH CHECK ADD  CONSTRAINT [Statistics_UserStatistics] FOREIGN KEY([StatisticsId])
REFERENCES [dbo].[Statistics] ([StatisticsId])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

/* create indices */
CREATE INDEX Index_RequiredPlugins_TaskId ON RequiredPlugins(TaskId);
GO

/* views */
-- =============================================
-- Author:		cneumuel
-- Description:	Returns the first StateLog entry for each job
-- =============================================
CREATE VIEW [dbo].[view_FirstState]
AS
SELECT     sl.TaskId, sl.DateTime, sl.State
FROM         dbo.StateLog AS sl INNER JOIN
                          (SELECT     TaskId, MIN(DateTime) AS DateTime
                            FROM          dbo.StateLog
                            GROUP BY TaskId) AS minDate ON sl.DateTime = minDate.DateTime AND sl.TaskId = minDate.TaskId

GO

-- =============================================
-- Author:		cneumuel
-- Description:	Returns the last StateLog entry for each job
-- =============================================
CREATE VIEW [dbo].[view_LastState]
AS
SELECT     sl.TaskId, sl.DateTime, sl.State
FROM         dbo.StateLog AS sl INNER JOIN
                          (SELECT     TaskId, MAX(DateTime) AS DateTime
                            FROM          dbo.StateLog
                            GROUP BY TaskId) AS minDate ON sl.DateTime = minDate.DateTime AND sl.TaskId = minDate.TaskId
GO

-- =============================================
-- Author:		cneumuel
-- Description:	returns aggregates statistic information for every minute
-- =============================================
CREATE VIEW [dbo].[view_Statistics]
AS
SELECT  CONVERT(VARCHAR(19), MIN(s.Timestamp), 120) AS DateTime, SUM(ss.Cores) AS Cores, SUM(ss.FreeCores) AS FreeCores, 
        AVG(ss.CpuUtilization) AS CpuUtilization, SUM(ss.Memory) AS Memory, SUM(ss.FreeMemory) AS FreeMemory, x.exSum AS ExecutionTimeHours, 
        x.exFinishedSum AS ExecutionTimeFinished, x.exStartToEndSum AS StartToEndTimeFinished
FROM         dbo.SlaveStatistics AS ss INNER JOIN
                      dbo.[Statistics] AS s ON ss.StatisticsId = s.StatisticsId INNER JOIN
                      dbo.Resource AS r ON ss.SlaveId = r.ResourceId INNER JOIN
                          (SELECT     StatisticsId, SUM(ExecutionTimeMs) / 1000 / 60 / 60 AS exSum, SUM(ExecutionTimeMsFinishedJobs) / 1000 / 60 / 60 AS exFinishedSum, 
                                                   SUM(StartToEndTimeMs) / 1000 / 60 / 60 AS exStartToEndSum
                            FROM          dbo.UserStatistics AS us
                            GROUP BY StatisticsId) AS x ON s.StatisticsId = x.StatisticsId
GROUP BY s.StatisticsId, x.exSum, x.exFinishedSum, x.exStartToEndSum

/* triggers */
GO
/****** Object:  Trigger [dbo].[tr_JobDeleteCascade]    Script Date: 04/19/2011 16:31:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		cneumuel
-- Create date: 19.04.2011
-- Description:	(1) Writes the execution times of deleted jobs into DeletedJobStats to ensure correct statistics
--				(2) Deletes all associated jobs. This cannot be done with cascading delete, 
--              because the job table defines a INSTEAD OF DELETE trigger itself, which
--              is not compatible with cascading deletes.
-- =============================================
CREATE TRIGGER [dbo].[tr_JobDeleteCascade] ON [dbo].[Job] INSTEAD OF DELETE AS 
BEGIN
	DELETE Task FROM deleted, Task WHERE deleted.JobId = Task.JobId
	DELETE Job FROM deleted, Job WHERE deleted.JobId = Job.JobId
END
GO

-- =============================================
-- Author:		cneumuel
-- Create date: 11.11.2010
-- Description:	Recursively deletes all child-jobs of a job when it is deleted. (Source: http://devio.wordpress.com/2008/05/23/recursive-delete-in-sql-server/)
-- =============================================
CREATE TRIGGER [dbo].[tr_TaskDeleteCascade] ON [dbo].[Task] INSTEAD OF DELETE AS 
BEGIN
	-- add statistics
	INSERT INTO dbo.DeletedJobStatistics (UserId, ExecutionTimeS, ExecutionTimeSFinishedJobs, StartToEndTimeS)
	SELECT 
		he.OwnerUserId AS UserId, 
		ROUND(SUM(j.ExecutionTimeMs) / 1000, 0) AS ExecutionTimeS,  
		ROUND(ISNULL(SUM(CASE ls.State WHEN 'Finished' THEN j.ExecutionTimeMs END), 0) / 1000, 0) AS ExecutionTimeSFinishedJobs,
		ISNULL(SUM(CASE ls.State WHEN 'Finished' THEN DATEDIFF(s, fs.DateTime, ls.DateTime) ELSE 0 END), 0) AS StartToEndTimeS
	FROM 
		deleted j, 
		Job he, 
		view_FirstState fs, 
		view_LastState ls
	WHERE 
		he.JobId = j.JobId AND 
		fs.TaskId = j.TaskId AND 
		ls.TaskId = j.TaskId
	GROUP BY he.OwnerUserId

	-- recursively delete jobs
	CREATE TABLE #Table( 
		TaskId uniqueidentifier 
	)
	INSERT INTO #Table (TaskId)
	SELECT TaskId FROM deleted
	
	DECLARE @c INT
	SET @c = 0
	
	WHILE @c <> (SELECT COUNT(TaskId) FROM #Table) BEGIN
		SELECT @c = COUNT(TaskId) FROM #Table
		
		INSERT INTO #Table (TaskId)
			SELECT Task.TaskId
			FROM Task
			LEFT OUTER JOIN #Table ON Task.TaskId = #Table.TaskId
			WHERE Task.ParentTaskId IN (SELECT TaskId FROM #Table)
				AND #Table.TaskId IS NULL
	END
	
	DELETE TaskData FROM TaskData INNER JOIN #Table ON TaskData.TaskId = #Table.TaskId
	DELETE Task FROM Task INNER JOIN #Table ON Task.TaskId = #Table.TaskId
END
GO


CREATE TRIGGER [dbo].[tr_StatisticsDeleteCascade] ON [dbo].[Statistics] INSTEAD OF DELETE AS 
BEGIN
	DELETE SlaveStatistics FROM deleted, SlaveStatistics WHERE deleted.StatisticsId = SlaveStatistics.StatisticsId
	-- should also remove UserStatistics here 
	DELETE [Statistics] FROM deleted, [Statistics] WHERE deleted.StatisticsId = [Statistics].StatisticsId
END
GO


-- ============================================================
-- Description:	Create indices to speed up execution of queries
-- ============================================================

-- speed up joins between Job and Task
CREATE NONCLUSTERED INDEX [TaskJobIdIndex]
ON [dbo].[Task] ([JobId])
INCLUDE ([TaskId],[TaskState],[ExecutionTimeMs],[LastHeartbeat],[ParentTaskId],[Priority],[CoresNeeded],[MemoryNeeded],[IsParentTask],[FinishWhenChildJobsFinished],[Command],[IsPrivileged])
GO

-- this is an index to speed up the GetWaitingTasks() method 
CREATE NONCLUSTERED INDEX [TaskGetWaitingTasksIndex]
ON [dbo].[Task] ([TaskState],[IsParentTask],[FinishWhenChildJobsFinished],[CoresNeeded],[MemoryNeeded])
INCLUDE ([TaskId],[ExecutionTimeMs],[LastHeartbeat],[ParentTaskId],[Priority],[Command],[JobId],[IsPrivileged])
GO
