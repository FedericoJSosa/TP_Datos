using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using TP_Datos.Datos;
using TP_Datos.Properties;

namespace TP_Datos
{
    public enum ModoForm4
    {
        ModoUno,
        ModoDos,
        ModoTres,
        ModoCuatro,
        ModoCinco,
        ModoSeis,
        ModoSiete,
        ModoOcho
    }
    public partial class Form4 : Form
    {
        private ModoForm4 _modo;
        private AccesoDatos accesoDatos;
        private List<SqlParameter> lista;
        private string consulta;
        public Form4(ModoForm4 modo)
        {
            InitializeComponent();
            _modo = modo;
            accesoDatos = new AccesoDatos();
            lista = new List<SqlParameter>();
        }
        private void Form4_Load(object sender, EventArgs e)
        {
            comboBox1.Enabled = false;
            comboBox1.Visible = false;
            comboBox2.Enabled = false;
            comboBox2.Visible = false;
            comboBox3.Enabled = false;
            comboBox3.Visible = false;
            comboBox4.Enabled = false;
            comboBox4.Visible = false;

            textBox1.Enabled = false;
            textBox1.Visible = false;
            textBox2.Enabled = false;
            textBox2.Visible = false;
            
            label2.Enabled = false;
            label2.Visible = false;
            label3.Enabled = false;
            label3.Visible = false;
            label4.Enabled = false;
            label4.Visible = false;
            label5.Enabled = false;
            label5.Visible = false;
            label6.Enabled = false;
            label6.Visible = false;
            label7.Enabled = false;
            label7.Visible = false;
            label8.Enabled = false;
            label8.Visible = false;
            if (_modo == ModoForm4.ModoUno)
            {
                label2.Enabled = true;
                label2.Visible = true;
                label3.Enabled = true;
                label3.Visible = true;
                textBox2.Enabled = true;
                textBox2.Visible = true;
                comboBox1.Enabled = true;
                comboBox1.Visible = true;
                label1.Text = Resources.ModoUno;
                comboBox1.SelectedIndex = 0;
            }
            if (_modo == ModoForm4.ModoDos)
            {
                label2.Enabled = true;
                label2.Visible = true;
                label3.Enabled = true;
                label3.Visible = true;
                textBox2.Enabled = true;
                textBox2.Visible = true;
                comboBox1.Enabled = true;
                comboBox1.Visible = true;
                label1.Text = Resources.ModoDos;
                label2.Text = "Letra:";
                label3.Text = "Año:";
                comboBox1.Items.Clear();
                for (char letra = 'A'; letra <= 'Z'; letra++)
                {
                    comboBox1.Items.Add(letra.ToString());
                }
                comboBox1.SelectedIndex = 0;
            }
            if (_modo == ModoForm4.ModoTres)
            {
                textBox2.Enabled = true;
                textBox2.Visible = true;
                label3.Enabled = true;
                label3.Visible = true;
                label1.Text = Resources.ModoTres;
                label3.Text = "Cantidad:";
                comboBox1.Enabled = false;
                comboBox1.Visible = false;
                label2.Visible = false;
                label2.Enabled = false;
            }
            if (_modo == ModoForm4.ModoCuatro)
            {
                label1.Text = Resources.ModoCuatro;
                label2.Enabled = true;
                label2.Visible = true;
                label3.Enabled = true;
                label3.Visible = true;
                comboBox1.Enabled = true;
                comboBox1.Visible = true;
                textBox2.Visible = true;
                textBox2.Enabled=true;
                label2.Text = "Mes:";
                label4.Text = "Sala:";
                comboBox1.SelectedIndex = 0;
                comboBox2.SelectedIndex = 0;
            }
            if (_modo == ModoForm4.ModoCinco)
            {
                label1.Text = Resources.ModoCinco;
                textBox2.Enabled = true;
                textBox2.Visible = true;
                label3.Enabled = true;
                label3.Visible = true;

            }
            if (_modo == ModoForm4.ModoSeis)
            {
                textBox2.Enabled = true;
                textBox2.Visible = true;
                label3.Enabled = true;
                label3.Visible = true;
                label1.Text = Resources.ModoSeis;
                label3.Text = "Año:";
            }
            if (_modo == ModoForm4.ModoSiete)
            {
                label1.Text = Resources.ModoSiete;
                label2.Enabled = true;
                label2.Visible = true;
                label4.Enabled = true;
                label4.Visible = true;
                label5.Enabled = true;
                label5.Visible = true;
                label6.Enabled = true;
                label6.Visible = true;
                label7.Enabled = true;
                label7.Visible = true;
                label8.Enabled = true;
                label8.Visible = true;
                textBox1.Enabled = true;
                textBox1.Visible = true;
                textBox2.Enabled = true;
                textBox2.Visible = true;
                comboBox1.Enabled = true;
                comboBox1.Visible = true;
                comboBox3.Enabled = true;
                comboBox3.Visible = true;
                label4.Text = "Año:";
                comboBox1.SelectedIndex = 0;
                comboBox3.SelectedIndex = 0;
            }
            if (_modo == ModoForm4.ModoOcho)
            {
                label1.Text = Resources.ModoOcho;
                label2.Enabled = true;
                label2.Visible = true;
                label4.Enabled = true;
                label4.Visible = true;
                label5.Enabled = true;
                label5.Visible = true;
                label6.Enabled = true;
                label6.Visible = true;
                label7.Enabled = true;
                label7.Visible = true;
                label8.Enabled = true;
                label8.Visible = true;
                textBox1.Enabled = true;
                textBox1.Visible = true;
                textBox2.Enabled = true;
                textBox2.Visible = true;
                comboBox1.Enabled = true;
                comboBox1.Visible = true;
                comboBox3.Enabled = true;
                comboBox3.Visible = true;
                label4.Text = "Año:";
                comboBox1.SelectedIndex = 0;
                comboBox3.SelectedIndex = 0;
            }
        }
        private void button1_Click(object sender, EventArgs e)
        {
            bool validado = Validar(_modo);
            if (validado)
            {
                CargarGrilla(consulta, lista);
                lista.Clear();
            }
        }
        private bool Validar(ModoForm4 modo)
        {
            if (_modo == ModoForm4.ModoUno)
            {
                if (!string.IsNullOrEmpty(textBox2.Text))
                {
                    if (int.TryParse(textBox2.Text, out _))
                    {
                        int aux = int.Parse(textBox2.Text);
                        if (aux >= 0)
                        {
                            lista.Add(new SqlParameter("@Mes", comboBox1.SelectedItem.ToString()));
                            lista.Add(new SqlParameter("@boletosReq", textBox2.Text));
                            consulta = "SP_ResumenBoletosVendidos";
                            return true;
                        }
                        else
                        {
                            MessageBox.Show("El campo -boletos- no puede ser negativo.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                        }
                    }
                    else
                    {
                        MessageBox.Show("El campo -boletos- no es un numero valido.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    }

                }
                else
                {
                    MessageBox.Show("El campo -boletos- no puede estar vacio.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
                return false;
            }
            if (_modo == ModoForm4.ModoDos)
            {
                if (!string.IsNullOrEmpty(textBox2.Text))
                {
                    if (int.TryParse(textBox2.Text, out _))
                    {
                        lista.Add(new SqlParameter("@ano", textBox2.Text));
                        lista.Add(new SqlParameter("@letra", comboBox1.SelectedItem.ToString()));
                        consulta = "SP_ComestibleMenosVendido";
                        return true;
                    }
                    else
                    {
                        MessageBox.Show("El campo -años- no es valido.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    }
                }
                else
                {
                    MessageBox.Show("El campo -años- no puede estar vacio.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
                return false;
            }
            if (_modo == ModoForm4.ModoTres)
            {
                if (!string.IsNullOrEmpty(textBox2.Text))
                {
                    if (int.TryParse(textBox2.Text, out _))
                    {
                        int aux = int.Parse(textBox2.Text);
                        if (aux >= 0)
                        {
                            lista.Add(new SqlParameter("@cantidadMinima", textBox2.Text));
                            consulta = "SP_ListarSucursalesConStock";
                            return true;
                        }
                        else
                        {
                            MessageBox.Show("El campo -Cantidad- no puede ser negativo.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                        }
                    }
                    else
                    {
                        MessageBox.Show("El campo -Cantidad- no es valido.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);

                    }
                }
                else
                {
                    MessageBox.Show("El campo -Cantidad- no puede estar vacio.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
                return false;
            }
            if (_modo == ModoForm4.ModoCuatro)
            {
                lista.Add(new SqlParameter("@mes", comboBox1.Text));
                lista.Add(new SqlParameter("@tipoSala", comboBox2.Text));
                consulta = "SP_FuncionesImax";
                return true;
            }
            if (_modo == ModoForm4.ModoCinco)
            {
                if (!string.IsNullOrEmpty(textBox2.Text))
                {
                    if (int.TryParse(textBox2.Text, out _))
                    {
                        int aux = int.Parse(textBox2.Text);
                        if (aux > 0)
                        {
                            lista.Add(new SqlParameter("@cantidad", textBox2.Text));
                            consulta = "sp_ClientesConMasBoletos";
                            return true;
                        }
                        else
                        {
                            MessageBox.Show("El campo -Boletos- no puede cero o ser negativo.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);

                        }
                    }
                    else
                    {

                        MessageBox.Show("El campo -Boletos- no es valido.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    }
                }
                else
                {
                    MessageBox.Show("El campo -Boletos- no puede estar vacio.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
                return false;
            }
            if (_modo == ModoForm4.ModoSeis)
            {
                if (!string.IsNullOrEmpty(textBox2.Text))
                {
                    if (int.TryParse(textBox2.Text, out _))
                    {
                        int aux = int.Parse(textBox2.Text);
                        if (aux > 0)
                        {
                            lista.Add(new SqlParameter("@año", textBox2.Text));
                            consulta = "sp_PeliculasSinFunciones";
                            return true;
                        }
                        else
                        {
                            MessageBox.Show("El campo -Año- no puede cero o ser negativo.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);

                        }
                    }
                    else
                    {

                        MessageBox.Show("El campo -Año- no es valido.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    }
                }
                else
                {
                    MessageBox.Show("El campo -Año- no puede estar vacio.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
                return false;
            }
            if (_modo == ModoForm4.ModoSiete)
            {
                if (!string.IsNullOrEmpty(textBox2.Text) && !string.IsNullOrEmpty(textBox1.Text))
                {
                    if (int.TryParse(textBox2.Text, out _) && int.TryParse(textBox1.Text, out _))
                    {
                        int aux = int.Parse(textBox2.Text);
                        int aux2 = int.Parse(textBox1.Text);
                        if (aux > 0 && aux2 > 0)
                        {
                            if (DateTime.TryParse($"{textBox1.Text}-{comboBox1.SelectedItem}-01", out _) &&
                             DateTime.TryParse($"{textBox2.Text}-{comboBox3.SelectedItem}-01", out _))
                            {
                                DateTime fechaDesde = DateTime.Parse($"{textBox1.Text}-{comboBox1.SelectedItem}-01");
                                DateTime fechaHasta = DateTime.Parse($"{textBox2.Text}-{comboBox3.SelectedItem}-01");
                                if (fechaHasta >= fechaDesde)
                                {
                                    lista.Add(new SqlParameter("@FechaDesde", fechaDesde));
                                    lista.Add(new SqlParameter("@FechaHasta", fechaHasta));

                                    consulta = "SP_Consultar_Recaudacion_Ultimos3Meses";

                                    return true;

                                }
                                else
                                {
                                    MessageBox.Show("La fecha -Hasta- debe ser mayor que la fecha -Desde-.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);

                                }
                            }
                            else
                            {
                                MessageBox.Show("El campo -Año- no es valido.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                            }
                        }
                        else
                        {
                            MessageBox.Show("El campo -Año- no puede ser cero o negativo.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);

                        }
                    }
                    else
                    {

                        MessageBox.Show("El campo -Año- no es valido.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    }
                }
                else
                {
                    MessageBox.Show("Ningun campo -Año- puede estar vacio.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
                return false;
            }
            if (_modo == ModoForm4.ModoOcho)
            {
                if (!string.IsNullOrEmpty(textBox2.Text) && !string.IsNullOrEmpty(textBox1.Text))
                {
                    if (int.TryParse(textBox2.Text, out _) && int.TryParse(textBox1.Text, out _))
                    {
                        int aux = int.Parse(textBox2.Text);
                        int aux2 = int.Parse(textBox1.Text);
                        if (aux > 0 && aux2 > 0)
                        {
                            if (DateTime.TryParse($"{textBox1.Text}-{comboBox1.SelectedItem}-01", out _) &&
                             DateTime.TryParse($"{textBox2.Text}-{comboBox3.SelectedItem}-01", out _))
                            {
                                DateTime fechaDesde = DateTime.Parse($"{textBox1.Text}-{comboBox1.SelectedItem}-01");
                                DateTime fechaHasta = DateTime.Parse($"{textBox2.Text}-{comboBox3.SelectedItem}-01");
                                if (fechaHasta >= fechaDesde)
                                {
                                    lista.Add(new SqlParameter("@FechaDesde", fechaDesde));
                                    lista.Add(new SqlParameter("@FechaHasta", fechaHasta));

                                    consulta = "SP_Consultar_Total_BoletosClientes";

                                    return true;

                                }
                                else
                                {
                                    MessageBox.Show("La fecha -Hasta- debe ser mayor que la fecha -Desde-.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);

                                }
                            }
                            else
                            {
                                MessageBox.Show("El campo -Año- no es valido.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                            }
                        }
                        else
                        {
                            MessageBox.Show("El campo -Año- no puede ser cero o negativo.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);

                        }
                    }
                    else
                    {

                        MessageBox.Show("El campo -Año- no es valido.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    }
                }
                else
                {
                    MessageBox.Show("Ningun campo -Año- puede estar vacio.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
                return false;
            }
            return false;
        }
        private void CargarGrilla(string consulta, List<SqlParameter> lista = null)
        {
            DataTable dataTable = accesoDatos.ConsultarBaseDeDatos(consulta, lista);
            dataGridView1.Rows.Clear();
            dataGridView1.Columns.Clear();
            if (dataTable.Rows.Count == 0)
            {
                MessageBox.Show("No se encontraron coincidencias con los parámetros establecidos. Por favor cámbielos y vuelva a intentar.", "Sin coincidencias", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return;
            }
            foreach (DataColumn column in dataTable.Columns)
            {
                dataGridView1.Columns.Add(column.ColumnName, column.ColumnName);
            }
            foreach (DataRow row in dataTable.Rows)
            {
                var rowValues = row.ItemArray.Select(value => value == DBNull.Value ? "Ningun" : value).ToArray();
                dataGridView1.Rows.Add(rowValues);
            }
        }
    }
}