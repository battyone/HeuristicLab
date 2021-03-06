#region License Information
/* HeuristicLab
 * Copyright (C) Heuristic and Evolutionary Algorithms Laboratory (HEAL)
 *
 * This file is part of HeuristicLab.
 *
 * HeuristicLab is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * HeuristicLab is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with HeuristicLab. If not, see <http://www.gnu.org/licenses/>.
 */
#endregion

namespace HeuristicLab.Core.Views {
  partial class VariableView {
    /// <summary> 
    /// Required designer variable.
    /// </summary>
    private System.ComponentModel.IContainer components = null;

    #region Component Designer generated code

    /// <summary> 
    /// Required method for Designer support - do not modify 
    /// the contents of this method with the code editor.
    /// </summary>
    private void InitializeComponent() {
      this.dataTypeLabel = new System.Windows.Forms.Label();
      this.dataTypeTextBox = new System.Windows.Forms.TextBox();
      this.valueGroupBox = new System.Windows.Forms.GroupBox();
      this.valuePanel = new System.Windows.Forms.Panel();
      this.viewHost = new HeuristicLab.MainForm.WindowsForms.ViewHost();
      this.clearValueButton = new System.Windows.Forms.Button();
      this.setValueButton = new System.Windows.Forms.Button();
      ((System.ComponentModel.ISupportInitialize)(this.errorProvider)).BeginInit();
      this.valueGroupBox.SuspendLayout();
      this.valuePanel.SuspendLayout();
      this.SuspendLayout();
      // 
      // nameTextBox
      // 
      this.errorProvider.SetIconAlignment(this.nameTextBox, System.Windows.Forms.ErrorIconAlignment.MiddleLeft);
      this.errorProvider.SetIconPadding(this.nameTextBox, 2);
      this.nameTextBox.Location = new System.Drawing.Point(69, 0);
      this.nameTextBox.Size = new System.Drawing.Size(265, 20);
      // 
      // infoLabel
      // 
      this.infoLabel.Location = new System.Drawing.Point(340, 3);
      // 
      // dataTypeLabel
      // 
      this.dataTypeLabel.AutoSize = true;
      this.dataTypeLabel.Location = new System.Drawing.Point(3, 29);
      this.dataTypeLabel.Name = "dataTypeLabel";
      this.dataTypeLabel.Size = new System.Drawing.Size(60, 13);
      this.dataTypeLabel.TabIndex = 3;
      this.dataTypeLabel.Text = "Data &Type:";
      // 
      // dataTypeTextBox
      // 
      this.dataTypeTextBox.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left)
                  | System.Windows.Forms.AnchorStyles.Right)));
      this.dataTypeTextBox.Location = new System.Drawing.Point(69, 26);
      this.dataTypeTextBox.Name = "dataTypeTextBox";
      this.dataTypeTextBox.ReadOnly = true;
      this.dataTypeTextBox.Size = new System.Drawing.Size(290, 20);
      this.dataTypeTextBox.TabIndex = 4;
      // 
      // valueGroupBox
      // 
      this.valueGroupBox.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom)
                  | System.Windows.Forms.AnchorStyles.Left)
                  | System.Windows.Forms.AnchorStyles.Right)));
      this.valueGroupBox.Controls.Add(this.valuePanel);
      this.valueGroupBox.Controls.Add(this.clearValueButton);
      this.valueGroupBox.Controls.Add(this.setValueButton);
      this.valueGroupBox.Location = new System.Drawing.Point(0, 52);
      this.valueGroupBox.Name = "valueGroupBox";
      this.valueGroupBox.Size = new System.Drawing.Size(359, 222);
      this.valueGroupBox.TabIndex = 5;
      this.valueGroupBox.TabStop = false;
      this.valueGroupBox.Text = "Value";
      // 
      // valuePanel
      // 
      this.valuePanel.AllowDrop = true;
      this.valuePanel.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom)
                  | System.Windows.Forms.AnchorStyles.Left)
                  | System.Windows.Forms.AnchorStyles.Right)));
      this.valuePanel.Controls.Add(this.viewHost);
      this.valuePanel.Location = new System.Drawing.Point(6, 49);
      this.valuePanel.Name = "valuePanel";
      this.valuePanel.Size = new System.Drawing.Size(347, 167);
      this.valuePanel.TabIndex = 2;
      this.valuePanel.DragDrop += new System.Windows.Forms.DragEventHandler(this.valuePanel_DragDrop);
      this.valuePanel.DragEnter += new System.Windows.Forms.DragEventHandler(this.valuePanel_DragEnterOver);
      this.valuePanel.DragOver += new System.Windows.Forms.DragEventHandler(this.valuePanel_DragEnterOver);
      // 
      // viewHost
      // 
      this.viewHost.Caption = "View";
      this.viewHost.Content = null;
      this.viewHost.Dock = System.Windows.Forms.DockStyle.Fill;
      this.viewHost.Enabled = false;
      this.viewHost.Location = new System.Drawing.Point(0, 0);
      this.viewHost.Name = "viewHost";
      this.viewHost.ReadOnly = false;
      this.viewHost.Size = new System.Drawing.Size(347, 167);
      this.viewHost.TabIndex = 0;
      this.viewHost.ViewsLabelVisible = true;
      this.viewHost.ViewType = null;
      // 
      // clearValueButton
      // 
      this.clearValueButton.Image = HeuristicLab.Common.Resources.VSImageLibrary.Remove;
      this.clearValueButton.Location = new System.Drawing.Point(36, 19);
      this.clearValueButton.Name = "clearValueButton";
      this.clearValueButton.Size = new System.Drawing.Size(24, 24);
      this.clearValueButton.TabIndex = 1;
      this.toolTip.SetToolTip(this.clearValueButton, "Clear Value");
      this.clearValueButton.UseVisualStyleBackColor = true;
      this.clearValueButton.Click += new System.EventHandler(this.clearValueButton_Click);
      // 
      // setValueButton
      // 
      this.setValueButton.Image = HeuristicLab.Common.Resources.VSImageLibrary.Edit;
      this.setValueButton.Location = new System.Drawing.Point(6, 19);
      this.setValueButton.Name = "setValueButton";
      this.setValueButton.Size = new System.Drawing.Size(24, 24);
      this.setValueButton.TabIndex = 0;
      this.toolTip.SetToolTip(this.setValueButton, "Set Value");
      this.setValueButton.UseVisualStyleBackColor = true;
      this.setValueButton.Click += new System.EventHandler(this.setValueButton_Click);
      // 
      // VariableView
      // 
      this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
      this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Inherit;
      this.Controls.Add(this.valueGroupBox);
      this.Controls.Add(this.dataTypeLabel);
      this.Controls.Add(this.dataTypeTextBox);
      this.Name = "VariableView";
      this.Size = new System.Drawing.Size(359, 274);
      this.Controls.SetChildIndex(this.infoLabel, 0);
      this.Controls.SetChildIndex(this.dataTypeTextBox, 0);
      this.Controls.SetChildIndex(this.dataTypeLabel, 0);
      this.Controls.SetChildIndex(this.nameTextBox, 0);
      this.Controls.SetChildIndex(this.nameLabel, 0);
      this.Controls.SetChildIndex(this.valueGroupBox, 0);
      ((System.ComponentModel.ISupportInitialize)(this.errorProvider)).EndInit();
      this.valueGroupBox.ResumeLayout(false);
      this.valuePanel.ResumeLayout(false);
      this.ResumeLayout(false);
      this.PerformLayout();

    }

    #endregion

    protected System.Windows.Forms.Label dataTypeLabel;
    protected System.Windows.Forms.TextBox dataTypeTextBox;
    protected System.Windows.Forms.GroupBox valueGroupBox;
    protected HeuristicLab.MainForm.WindowsForms.ViewHost viewHost;
    protected System.Windows.Forms.Button clearValueButton;
    protected System.Windows.Forms.Button setValueButton;
    protected System.Windows.Forms.Panel valuePanel;
  }
}
