using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace TP_Datos
{
    public partial class Form2 : Form
    {
        public Form2()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            Form4 form4 = new Form4(ModoForm4.ModoUno);
            form4.ShowDialog();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            Form4 form4 = new Form4(ModoForm4.ModoDos);
            form4.ShowDialog();
        }

        private void button3_Click(object sender, EventArgs e)
        {
            Form4 form4 = new Form4(ModoForm4.ModoTres);
            form4.ShowDialog();
        }
        private void button4_Click(object sender, EventArgs e)
        {
            Form4 form4 = new Form4(ModoForm4.ModoCuatro);
            form4.ShowDialog();
        }
        private void button5_Click(object sender, EventArgs e)
        {
            Form4 form4 = new Form4(ModoForm4.ModoCinco);
            form4.ShowDialog();
        }

        private void button6_Click(object sender, EventArgs e)
        {
            Form4 form4 = new Form4(ModoForm4.ModoSeis);
            form4.ShowDialog();
        }

        private void button7_Click(object sender, EventArgs e)
        {
            Form4 form4 = new Form4(ModoForm4.ModoSiete);
            form4.ShowDialog();
        }

        private void button8_Click(object sender, EventArgs e)
        {
            Form4 form4 = new Form4(ModoForm4.ModoOcho);
            form4.ShowDialog();
        }
    }
}
