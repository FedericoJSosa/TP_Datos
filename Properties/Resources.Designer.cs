﻿//------------------------------------------------------------------------------
// <auto-generated>
//     Este código fue generado por una herramienta.
//     Versión de runtime:4.0.30319.42000
//
//     Los cambios en este archivo podrían causar un comportamiento incorrecto y se perderán si
//     se vuelve a generar el código.
// </auto-generated>
//------------------------------------------------------------------------------

namespace TP_Datos.Properties {
    using System;
    
    
    /// <summary>
    ///   Clase de recurso fuertemente tipado, para buscar cadenas traducidas, etc.
    /// </summary>
    // StronglyTypedResourceBuilder generó automáticamente esta clase
    // a través de una herramienta como ResGen o Visual Studio.
    // Para agregar o quitar un miembro, edite el archivo .ResX y, a continuación, vuelva a ejecutar ResGen
    // con la opción /str o recompile su proyecto de VS.
    [global::System.CodeDom.Compiler.GeneratedCodeAttribute("System.Resources.Tools.StronglyTypedResourceBuilder", "17.0.0.0")]
    [global::System.Diagnostics.DebuggerNonUserCodeAttribute()]
    [global::System.Runtime.CompilerServices.CompilerGeneratedAttribute()]
    internal class Resources {
        
        private static global::System.Resources.ResourceManager resourceMan;
        
        private static global::System.Globalization.CultureInfo resourceCulture;
        
        [global::System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1811:AvoidUncalledPrivateCode")]
        internal Resources() {
        }
        
        /// <summary>
        ///   Devuelve la instancia de ResourceManager almacenada en caché utilizada por esta clase.
        /// </summary>
        [global::System.ComponentModel.EditorBrowsableAttribute(global::System.ComponentModel.EditorBrowsableState.Advanced)]
        internal static global::System.Resources.ResourceManager ResourceManager {
            get {
                if (object.ReferenceEquals(resourceMan, null)) {
                    global::System.Resources.ResourceManager temp = new global::System.Resources.ResourceManager("TP_Datos.Properties.Resources", typeof(Resources).Assembly);
                    resourceMan = temp;
                }
                return resourceMan;
            }
        }
        
        /// <summary>
        ///   Reemplaza la propiedad CurrentUICulture del subproceso actual para todas las
        ///   búsquedas de recursos mediante esta clase de recurso fuertemente tipado.
        /// </summary>
        [global::System.ComponentModel.EditorBrowsableAttribute(global::System.ComponentModel.EditorBrowsableState.Advanced)]
        internal static global::System.Globalization.CultureInfo Culture {
            get {
                return resourceCulture;
            }
            set {
                resourceCulture = value;
            }
        }
        
        /// <summary>
        ///   Busca una cadena traducida similar a Data Source=DESKTOP-QMJF5KL;Initial Catalog=Cinema_TP;Integrated Security=True.
        /// </summary>
        internal static string cadenaConexion {
            get {
                return ResourceManager.GetString("cadenaConexion", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Busca un recurso adaptado de tipo System.Byte[].
        /// </summary>
        internal static byte[] iconoCine {
            get {
                object obj = ResourceManager.GetObject("iconoCine", resourceCulture);
                return ((byte[])(obj));
            }
        }
        
        /// <summary>
        ///   Busca un recurso adaptado de tipo System.Byte[].
        /// </summary>
        internal static byte[] iconoID {
            get {
                object obj = ResourceManager.GetObject("iconoID", resourceCulture);
                return ((byte[])(obj));
            }
        }
        
        /// <summary>
        ///   Busca un recurso adaptado de tipo System.Byte[].
        /// </summary>
        internal static byte[] imagenCine {
            get {
                object obj = ResourceManager.GetObject("imagenCine", resourceCulture);
                return ((byte[])(obj));
            }
        }
        
        /// <summary>
        ///   Busca una cadena traducida similar a Reporte que muestra el total de boletos reservados por cada cliente y función, junto con la recaudación estimada de dichas reservas. Solo se incluiran clientes que hayan reservado más de una cantidad especificada de boletos. Los resultados seran ordenados en función de la recaudación estimada, de mayor a menor..
        /// </summary>
        internal static string ModoCinco {
            get {
                return ResourceManager.GetString("ModoCinco", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Busca una cadena traducida similar a Este reporte muestra todas las funciones proyectadas en un tipo de sala específico durante el mes indicado por el usuario. Se incluye el total de boletos vendidos y el precio promedio por boleto para cada función. Además, se filtran las funciones que tuvieron un precio promedio superior al precio promedio anual de todas las funciones en salas de ese mismo tipo, permitiendo identificar aquellas con mayor rentabilidad relativa..
        /// </summary>
        internal static string ModoCuatro {
            get {
                return ResourceManager.GetString("ModoCuatro", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Busca una cadena traducida similar a Este reporte tiene como objetivo identificar el comestible menos vendido en un año especificado por el usuario por cada sucursal. Se pueden excluir productos en base a la primer letra del mismo. El informe mostrará nombre del comestible,  precio unitario, facturación total, cantidad total vendida, el promedio de cantidad vendida y la sucursal correspondiente. Los resultados estarán ordenados de manera descendente por sucursal, facilitando la evaluación del desempeño de cada uno..
        /// </summary>
        internal static string ModoDos {
            get {
                return ResourceManager.GetString("ModoDos", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Busca una cadena traducida similar a Reporte que muestra una lista de clientes que han comprado boletos para funciones de películas en un período de tiempo determinado. La consulta muestra las ventas, mostrando el nombre de cada cliente y la cantidad total de boletos adquiridos..
        /// </summary>
        internal static string ModoOcho {
            get {
                return ResourceManager.GetString("ModoOcho", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Busca una cadena traducida similar a Reporte que lista las películas que no han sido proyectadas en ninguna función durante el año solicitado, incluyendo su género y fecha de estreno. Esta lista debe excluir aquellas películas que ya cuentan con funciones programadas..
        /// </summary>
        internal static string ModoSeis {
            get {
                return ResourceManager.GetString("ModoSeis", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Busca una cadena traducida similar a 
        ///Reporte que muestra el total recaudado por funciones y ventas de comestibles para cada sucursal durante el periodo especificado. El reporte incluye todas las sucursales y una columna que indica el tipo de venta, ya sea &quot;Funciones&quot; o &quot;Comestibles&quot;..
        /// </summary>
        internal static string ModoSiete {
            get {
                return ResourceManager.GetString("ModoSiete", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Busca una cadena traducida similar a Este reporte lista las sucursales que tienen un mínimo de unidades de comestibles en stock, especificado por el usuario. Muestra la sucursal y el total de comestibles, incluyendo solo aquellas sucursales cuyo promedio de ventas de comestibles supera el promedio de todas las sucursales..
        /// </summary>
        internal static string ModoTres {
            get {
                return ResourceManager.GetString("ModoTres", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Busca una cadena traducida similar a Este reporte presenta la cantidad total de boletos vendidos y la recaudación mensual por sucursal. Se incluirán únicamente las sucursales que superen un umbral mínimo de boletos vendidos. Los resultados están ordenados de mayor a menor recaudación, permitiendo identificar fácilmente las sucursales con mejor desempeño en ventas..
        /// </summary>
        internal static string ModoUno {
            get {
                return ResourceManager.GetString("ModoUno", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Busca una cadena traducida similar a En Cine de Luxe, presentamos un sistema innovador diseñado para optimizar la gestión de la venta de entradas por parte de nuestros empleados. Este sistema intuitivo permite la emisión de comprobantes, la gestión de butacas numeradas y la implementación de promociones, garantizando una experiencia fluida para los clientes. Con herramientas que facilitan el proceso de compra y reservas en línea, nuestro equipo podrá ofrecer un servicio excepcional, elevando así la calidad de nuestra oferta cinematográfica..
        /// </summary>
        internal static string Presentacion {
            get {
                return ResourceManager.GetString("Presentacion", resourceCulture);
            }
        }
    }
}
