using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using TP_Datos.Datos;
using TP_Datos.Dominio;

namespace TP_Datos
{
    public partial class Form3 : Form
    {
        List<Persona> list;
        int currentIndex = 0;
        public Form3()
        {
            InitializeComponent();
            list = new List<Persona>();
        }

        private void Form3_Load(object sender, EventArgs e)
        {
            list.Add(new Persona("Federico", "Sosa", "412302"));
            list.Add(new Persona("Matias", "Moreno", "405109"));
            list.Add(new Persona("Lautaro", "Diego", "404903"));

            MostrarDatos();
        }

        private void MostrarDatos()
        {
            textBox1.Text = list[currentIndex].Nombre;
            textBox2.Text = list[currentIndex].Apellido;
            textBox3.Text = list[currentIndex].Legajo;
        }

        private void button2_Click(object sender, EventArgs e)
        {
            if (currentIndex == 2)
            {
                currentIndex = currentIndex - 2;
            }
            else
            {
                currentIndex++;
            }
            MostrarDatos();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            if (currentIndex == 0)
            {
                currentIndex = currentIndex + 2;
            }
            else
            {
                currentIndex--;
            }
            MostrarDatos();
        }
    }
}
