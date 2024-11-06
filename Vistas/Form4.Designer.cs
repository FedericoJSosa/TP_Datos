namespace TP_Datos
{
    partial class Form4
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(Form4));
            dataGridView1 = new DataGridView();
            label1 = new Label();
            button1 = new Button();
            label2 = new Label();
            label3 = new Label();
            comboBox1 = new ComboBox();
            comboBox2 = new ComboBox();
            label4 = new Label();
            label5 = new Label();
            comboBox4 = new ComboBox();
            label6 = new Label();
            label7 = new Label();
            label8 = new Label();
            textBox1 = new TextBox();
            comboBox3 = new ComboBox();
            textBox2 = new TextBox();
            ((System.ComponentModel.ISupportInitialize)dataGridView1).BeginInit();
            SuspendLayout();
            // 
            // dataGridView1
            // 
            dataGridView1.AllowUserToAddRows = false;
            dataGridView1.AllowUserToDeleteRows = false;
            dataGridView1.AllowUserToResizeColumns = false;
            dataGridView1.AllowUserToResizeRows = false;
            dataGridView1.ColumnHeadersHeightSizeMode = DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            dataGridView1.Location = new Point(12, 207);
            dataGridView1.Name = "dataGridView1";
            dataGridView1.RowHeadersWidth = 51;
            dataGridView1.Size = new Size(776, 231);
            dataGridView1.TabIndex = 1;
            // 
            // label1
            // 
            label1.BorderStyle = BorderStyle.Fixed3D;
            label1.Location = new Point(12, 9);
            label1.Name = "label1";
            label1.Size = new Size(776, 129);
            label1.TabIndex = 6;
            label1.Text = "label1";
            // 
            // button1
            // 
            button1.Location = new Point(694, 172);
            button1.Name = "button1";
            button1.Size = new Size(94, 29);
            button1.TabIndex = 7;
            button1.Text = "Consultar";
            button1.UseVisualStyleBackColor = true;
            button1.Click += button1_Click;
            // 
            // label2
            // 
            label2.AutoSize = true;
            label2.Location = new Point(165, 177);
            label2.Name = "label2";
            label2.Size = new Size(39, 20);
            label2.TabIndex = 9;
            label2.Text = "Mes:";
            // 
            // label3
            // 
            label3.AutoSize = true;
            label3.Location = new Point(372, 177);
            label3.Name = "label3";
            label3.Size = new Size(62, 20);
            label3.TabIndex = 11;
            label3.Text = "Boletos:";
            // 
            // comboBox1
            // 
            comboBox1.AllowDrop = true;
            comboBox1.DropDownStyle = ComboBoxStyle.DropDownList;
            comboBox1.FormattingEnabled = true;
            comboBox1.Items.AddRange(new object[] { "Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre" });
            comboBox1.Location = new Point(232, 171);
            comboBox1.MaxDropDownItems = 12;
            comboBox1.Name = "comboBox1";
            comboBox1.Size = new Size(96, 28);
            comboBox1.TabIndex = 12;
            // 
            // comboBox2
            // 
            comboBox2.AllowDrop = true;
            comboBox2.DropDownStyle = ComboBoxStyle.DropDownList;
            comboBox2.FormattingEnabled = true;
            comboBox2.Items.AddRange(new object[] { "2D", "3D", "IMAX" });
            comboBox2.Location = new Point(443, 172);
            comboBox2.MaxDropDownItems = 12;
            comboBox2.Name = "comboBox2";
            comboBox2.Size = new Size(96, 28);
            comboBox2.TabIndex = 14;
            // 
            // label4
            // 
            label4.AutoSize = true;
            label4.Location = new Point(381, 177);
            label4.Name = "label4";
            label4.Size = new Size(39, 20);
            label4.TabIndex = 13;
            label4.Text = "Mes:";
            // 
            // label5
            // 
            label5.AutoSize = true;
            label5.Location = new Point(12, 146);
            label5.Name = "label5";
            label5.Size = new Size(54, 20);
            label5.TabIndex = 15;
            label5.Text = "Desde:";
            // 
            // comboBox4
            // 
            comboBox4.AllowDrop = true;
            comboBox4.DropDownStyle = ComboBoxStyle.DropDownList;
            comboBox4.FormattingEnabled = true;
            comboBox4.Items.AddRange(new object[] { "2D", "3D", "IMAX" });
            comboBox4.Location = new Point(592, 172);
            comboBox4.MaxDropDownItems = 12;
            comboBox4.Name = "comboBox4";
            comboBox4.Size = new Size(96, 28);
            comboBox4.TabIndex = 17;
            // 
            // label6
            // 
            label6.AutoSize = true;
            label6.Location = new Point(545, 180);
            label6.Name = "label6";
            label6.Size = new Size(39, 20);
            label6.TabIndex = 18;
            label6.Text = "Mes:";
            // 
            // label7
            // 
            label7.AutoSize = true;
            label7.Location = new Point(12, 179);
            label7.Name = "label7";
            label7.Size = new Size(39, 20);
            label7.TabIndex = 19;
            label7.Text = "Año:";
            // 
            // label8
            // 
            label8.AutoSize = true;
            label8.Location = new Point(372, 146);
            label8.Name = "label8";
            label8.Size = new Size(50, 20);
            label8.TabIndex = 20;
            label8.Text = "Hasta:";
            // 
            // textBox1
            // 
            textBox1.Location = new Point(57, 174);
            textBox1.Name = "textBox1";
            textBox1.Size = new Size(89, 27);
            textBox1.TabIndex = 21;
            // 
            // comboBox3
            // 
            comboBox3.AllowDrop = true;
            comboBox3.DropDownStyle = ComboBoxStyle.DropDownList;
            comboBox3.FormattingEnabled = true;
            comboBox3.Items.AddRange(new object[] { "Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre" });
            comboBox3.Location = new Point(592, 172);
            comboBox3.MaxDropDownItems = 12;
            comboBox3.Name = "comboBox3";
            comboBox3.Size = new Size(96, 28);
            comboBox3.TabIndex = 22;
            // 
            // textBox2
            // 
            textBox2.Location = new Point(450, 173);
            textBox2.Name = "textBox2";
            textBox2.Size = new Size(89, 27);
            textBox2.TabIndex = 10;
            // 
            // Form4
            // 
            AutoScaleDimensions = new SizeF(8F, 20F);
            AutoScaleMode = AutoScaleMode.Font;
            ClientSize = new Size(800, 450);
            Controls.Add(comboBox3);
            Controls.Add(textBox1);
            Controls.Add(label8);
            Controls.Add(label7);
            Controls.Add(label6);
            Controls.Add(comboBox4);
            Controls.Add(label5);
            Controls.Add(comboBox2);
            Controls.Add(label4);
            Controls.Add(comboBox1);
            Controls.Add(label3);
            Controls.Add(textBox2);
            Controls.Add(label2);
            Controls.Add(button1);
            Controls.Add(label1);
            Controls.Add(dataGridView1);
            Icon = (Icon)resources.GetObject("$this.Icon");
            Name = "Form4";
            Text = "BackOffice";
            Load += Form4_Load;
            ((System.ComponentModel.ISupportInitialize)dataGridView1).EndInit();
            ResumeLayout(false);
            PerformLayout();
        }

        #endregion
        private DataGridView dataGridView1;
        private Label label1;
        private Button button1;
        private Label label2;
        private Label label3;
        private ComboBox comboBox1;
        private ComboBox comboBox2;
        private Label label4;
        private Label label5;
        private ComboBox comboBox4;
        private Label label6;
        private Label label7;
        private Label label8;
        private TextBox textBox1;
        private ComboBox comboBox3;
        private TextBox textBox2;
    }
}