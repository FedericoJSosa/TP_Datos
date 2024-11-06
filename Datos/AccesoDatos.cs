using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using TP_Datos.Properties;
using static System.Windows.Forms.VisualStyles.VisualStyleElement;

namespace TP_Datos.Datos
{
    public class AccesoDatos
    {
        private string cadenaConexion = Resources.cadenaConexion;
        private SqlConnection cnn;
        private SqlCommand comando;

        public AccesoDatos()
        {
            cnn = new SqlConnection(cadenaConexion);
        }
        public void Conectar()
        {
            cnn.Open();
            comando = new SqlCommand();
            comando.Connection = cnn;
            comando.CommandType = CommandType.Text;
        }
        public string ObtenerCadenaConexion()
        {
            return cadenaConexion;
        }
        public void Desconectar()
        {
            cnn.Close();
        }
        public DataTable ConsultarBaseDeDatos(string nombreSP, List<SqlParameter> parametros = null)
        {
            DataTable dataTable = new DataTable();
            Conectar();
            comando.CommandText = nombreSP;
            comando.CommandType = CommandType.StoredProcedure;

            if (parametros != null)
            {
                comando.Parameters.AddRange(parametros.ToArray());
            }

            dataTable.Load(comando.ExecuteReader());
            Desconectar();

            return dataTable;
        }
        public int ActualizarBD(string consulta)
        {
            Conectar();
            comando.CommandText = consulta;
            int filasMod = comando.ExecuteNonQuery();
            Desconectar();
            return filasMod;

        }
        public int ActualizarBD(string consulta, List<Parametros> parametros)
        {
            Conectar();
            comando.CommandText = consulta;
            foreach (Parametros param in parametros)
            {
                comando.Parameters.AddWithValue(param.Nombre, param.Valor);
            }
            int filasMod = comando.ExecuteNonQuery();
            Desconectar();
            return filasMod;

        }
    }
}
