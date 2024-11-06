using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static System.Runtime.InteropServices.JavaScript.JSType;

namespace TP_Datos.Dominio
{
    public class Persona
    {
        public string Nombre { get; set; }
        public string Apellido { get; set; }
        public string Legajo { get; set; }

        public Persona(string nombre, string apellido, string legajo)
        {
            Nombre = nombre;
            Apellido = apellido;
            Legajo = legajo;
        }
    }
}
