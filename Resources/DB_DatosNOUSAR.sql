USE [master]
GO
/****** Object:  Database [Cinema_TP]    Script Date: 13/11/2024 01:11:07 ******/
CREATE DATABASE [Cinema_TP]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Cinema_TP', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Cinema_TP.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Cinema_TP_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Cinema_TP_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [Cinema_TP] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Cinema_TP].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Cinema_TP] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Cinema_TP] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Cinema_TP] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Cinema_TP] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Cinema_TP] SET ARITHABORT OFF 
GO
ALTER DATABASE [Cinema_TP] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Cinema_TP] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Cinema_TP] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Cinema_TP] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Cinema_TP] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Cinema_TP] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Cinema_TP] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Cinema_TP] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Cinema_TP] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Cinema_TP] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Cinema_TP] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Cinema_TP] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Cinema_TP] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Cinema_TP] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Cinema_TP] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Cinema_TP] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Cinema_TP] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Cinema_TP] SET RECOVERY FULL 
GO
ALTER DATABASE [Cinema_TP] SET  MULTI_USER 
GO
ALTER DATABASE [Cinema_TP] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Cinema_TP] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Cinema_TP] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Cinema_TP] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Cinema_TP] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Cinema_TP] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'Cinema_TP', N'ON'
GO
ALTER DATABASE [Cinema_TP] SET QUERY_STORE = ON
GO
ALTER DATABASE [Cinema_TP] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [Cinema_TP]
GO
/****** Object:  UserDefinedFunction [dbo].[Total_Boletos_Reservas]    Script Date: 13/11/2024 01:11:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[Total_Boletos_Reservas] (
@IdCliente INT,
@FechaDesde DATETIME,
@FechaHasta DATETIME
)
RETURNS INT
AS
BEGIN
    RETURN (
        SELECT SUM(r.cantidad_boletos)
        FROM Reservas r
        WHERE r.id_cliente = @IdCliente
          AND r.fecha_reserva BETWEEN @FechaDesde AND @FechaHasta
		  )
END

GO
/****** Object:  UserDefinedFunction [dbo].[Total_Boletos_Ventas]    Script Date: 13/11/2024 01:11:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[Total_Boletos_Ventas] (
    @IdCliente INT,
    @FechaDesde DATETIME,
    @FechaHasta DATETIME
)
RETURNS INT
AS
BEGIN
    RETURN (
        SELECT SUM(dv.cantidad)
        FROM Ventas v
        JOIN D_Ventas dv ON v.id_venta = dv.id_venta
        WHERE v.id_cliente = @IdCliente
          AND v.fecha_venta BETWEEN @FechaDesde AND @FechaHasta
    )
END

GO
/****** Object:  UserDefinedFunction [dbo].[Total_Recaudado_Comestibles]    Script Date: 13/11/2024 01:11:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[Total_Recaudado_Comestibles] (@IdSucursal INT,
@FechaDesde dateTIME,
@FechaHasta dateTIME
)
RETURNS DECIMAL(10, 2)
AS
BEGIN
    RETURN (
        SELECT SUM(dv.cantidad * c.precio_unit)
        FROM Ventas AS v
        left JOIN D_Ventas AS dv ON v.id_venta = dv.id_venta
        left JOIN Comestibles AS c ON dv.id_comestible = c.id_comestible
        WHERE v.id_sucursal = @IdSucursal 
          AND v.fecha_venta BETWEEN @FechaDesde and @FechaHasta
)
END
GO
/****** Object:  UserDefinedFunction [dbo].[Total_Recaudado_Funciones]    Script Date: 13/11/2024 01:11:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[Total_Recaudado_Funciones] (@IdSucursal INT,
@FechaDesde dateTIME,
@FechaHasta dateTIME
)
RETURNS DECIMAL(10, 2)
AS
BEGIN
    RETURN (
        SELECT SUM(f.precio_unit * r.cantidad_boletos)
        FROM Salas AS sa
        left JOIN Funciones AS f ON sa.id_sala = f.id_sala
        left JOIN Reservas AS r ON f.id_funcion = r.id_funcion
        WHERE sa.id_sucursal = @IdSucursal 
          AND f.fecha BETWEEN @FechaDesde and @FechaHasta
)
END
GO
/****** Object:  Table [dbo].[Sucursales]    Script Date: 13/11/2024 01:11:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sucursales](
	[id_sucursal] [int] NOT NULL,
	[sucursal] [nvarchar](100) NOT NULL,
	[direccion] [nvarchar](200) NULL,
	[id_barrio_suc] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_sucursal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Comestibles]    Script Date: 13/11/2024 01:11:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Comestibles](
	[id_comestible] [int] NOT NULL,
	[comestible] [nvarchar](100) NOT NULL,
	[precio_unit] [decimal](10, 2) NULL,
	[descripcion] [nvarchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_comestible] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ventas]    Script Date: 13/11/2024 01:11:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ventas](
	[id_venta] [int] NOT NULL,
	[id_sucursal] [int] NULL,
	[id_cliente] [int] NULL,
	[fecha_venta] [datetime] NULL,
	[metodo_pago] [nvarchar](100) NULL,
	[impuestos] [decimal](10, 2) NULL,
	[descuentos] [decimal](10, 2) NULL,
	[estado_trans] [nvarchar](100) NULL,
	[tipo_venta] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_venta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[D_Ventas]    Script Date: 13/11/2024 01:11:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[D_Ventas](
	[id_d_ventas] [int] NOT NULL,
	[id_funcion] [int] NULL,
	[id_comestible] [int] NULL,
	[id_venta] [int] NULL,
	[cantidad] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_d_ventas] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Vent_Com_Año_Actu]    Script Date: 13/11/2024 01:11:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[Vent_Com_Año_Actu]
as
select C.comestible,
C.precio_unit ,
sum(C.precio_unit*DV.cantidad) "Facturacion",
sum(DV.cantidad) "Cantidad vendida", S.sucursal, V.fecha_venta
from D_Ventas as DV
join Comestibles as C on DV.id_comestible=C.id_comestible
join Ventas as V on DV.id_venta=V.id_venta
join Sucursales as S on V.id_sucursal=S.id_sucursal
group by C.comestible, C.precio_unit, S.sucursal, fecha_venta
GO
/****** Object:  Table [dbo].[Barrios]    Script Date: 13/11/2024 01:11:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Barrios](
	[id_barrio] [int] NOT NULL,
	[barrio] [nvarchar](100) NOT NULL,
	[id_provincia] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_barrio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cargos]    Script Date: 13/11/2024 01:11:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cargos](
	[id_cargo] [int] NOT NULL,
	[cargo] [nvarchar](100) NOT NULL,
	[sueldo_basic] [decimal](10, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_cargo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Clientes]    Script Date: 13/11/2024 01:11:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Clientes](
	[id_cliente] [int] NOT NULL,
	[nombre] [nvarchar](100) NOT NULL,
	[direccion] [nvarchar](200) NULL,
	[id_barrio] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_cliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Contactos]    Script Date: 13/11/2024 01:11:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Contactos](
	[id_contacto] [int] NOT NULL,
	[contacto] [nvarchar](100) NOT NULL,
	[id_sucursal] [int] NULL,
	[id_empleado] [int] NULL,
	[id_cliente] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_contacto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Empleados]    Script Date: 13/11/2024 01:11:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Empleados](
	[id_empleado] [int] NOT NULL,
	[nombre] [nvarchar](100) NOT NULL,
	[direccion] [nvarchar](200) NULL,
	[id_cargo] [int] NULL,
	[id_barrio] [int] NULL,
	[id_sucursal] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_empleado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Funciones]    Script Date: 13/11/2024 01:11:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Funciones](
	[id_funcion] [int] NOT NULL,
	[id_pelicula] [int] NULL,
	[id_sala] [int] NULL,
	[fecha] [date] NULL,
	[idioma] [nvarchar](50) NULL,
	[subtitulado] [bit] NULL,
	[precio_unit] [decimal](10, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_funcion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Generos]    Script Date: 13/11/2024 01:11:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Generos](
	[id_genero] [int] NOT NULL,
	[genero] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_genero] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Paises]    Script Date: 13/11/2024 01:11:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Paises](
	[id_pais] [int] NOT NULL,
	[pais] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_pais] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Peliculas]    Script Date: 13/11/2024 01:11:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Peliculas](
	[id_pelicula] [int] NOT NULL,
	[pelicula] [nvarchar](200) NOT NULL,
	[fecha_estreno] [date] NULL,
	[id_pais_produccion] [int] NULL,
	[clasificacion] [nvarchar](50) NULL,
	[idioma] [nvarchar](50) NULL,
	[duracion] [int] NULL,
	[director] [nvarchar](100) NULL,
	[produccion] [nvarchar](100) NULL,
	[guion] [nvarchar](100) NULL,
	[musica] [nvarchar](100) NULL,
	[fotografia] [nvarchar](100) NULL,
	[montaje] [nvarchar](100) NULL,
	[vestuario] [nvarchar](100) NULL,
	[protagonista] [nvarchar](100) NULL,
	[compania_productora] [nvarchar](100) NULL,
	[distribucion] [nvarchar](100) NULL,
	[presupuesto] [decimal](15, 2) NULL,
	[recaudacion] [decimal](15, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_pelicula] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Peliculas_Generos]    Script Date: 13/11/2024 01:11:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Peliculas_Generos](
	[id_pelicula] [int] NOT NULL,
	[id_genero] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_pelicula] ASC,
	[id_genero] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Provincias]    Script Date: 13/11/2024 01:11:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Provincias](
	[id_provincia] [int] NOT NULL,
	[provincia] [nvarchar](100) NOT NULL,
	[id_pais] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_provincia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Reservas]    Script Date: 13/11/2024 01:11:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reservas](
	[id_reserva] [int] NOT NULL,
	[id_cliente] [int] NULL,
	[id_funcion] [int] NULL,
	[cantidad_boletos] [int] NULL,
	[fecha_reserva] [date] NULL,
	[hubutaca] [int] NOT NULL,
	[estado_reserva] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_reserva] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Salas]    Script Date: 13/11/2024 01:11:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Salas](
	[id_sala] [int] NOT NULL,
	[numero_sala] [int] NOT NULL,
	[capacidad] [int] NULL,
	[tipo_sala] [nvarchar](100) NULL,
	[id_sucursal] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_sala] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Stocks]    Script Date: 13/11/2024 01:11:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Stocks](
	[id_stock] [int] NOT NULL,
	[id_sucursal] [int] NULL,
	[id_comestible] [int] NULL,
	[cantidad] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_stock] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tipos_Contactos]    Script Date: 13/11/2024 01:11:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tipos_Contactos](
	[id_tipo_contacto] [int] NOT NULL,
	[tipo_contacto] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_tipo_contacto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Barrios] ([id_barrio], [barrio], [id_provincia]) VALUES (1, N'Centro', 1)
INSERT [dbo].[Barrios] ([id_barrio], [barrio], [id_provincia]) VALUES (2, N'Nueva Córdoba', 1)
INSERT [dbo].[Barrios] ([id_barrio], [barrio], [id_provincia]) VALUES (3, N'Palermo', 2)
GO
INSERT [dbo].[Cargos] ([id_cargo], [cargo], [sueldo_basic]) VALUES (1, N'Gerente', CAST(50000.00 AS Decimal(10, 2)))
INSERT [dbo].[Cargos] ([id_cargo], [cargo], [sueldo_basic]) VALUES (2, N'Vendedor', CAST(30000.00 AS Decimal(10, 2)))
INSERT [dbo].[Cargos] ([id_cargo], [cargo], [sueldo_basic]) VALUES (3, N'Cajero', CAST(25000.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Clientes] ([id_cliente], [nombre], [direccion], [id_barrio]) VALUES (1, N'Juan Perez', N'Av. Colón 1234', 1)
INSERT [dbo].[Clientes] ([id_cliente], [nombre], [direccion], [id_barrio]) VALUES (2, N'Ana Lopez', N'Bv. San Juan 5678', 2)
INSERT [dbo].[Clientes] ([id_cliente], [nombre], [direccion], [id_barrio]) VALUES (3, N'Carlos Souza', N'Rua Paulista 890', 3)
INSERT [dbo].[Clientes] ([id_cliente], [nombre], [direccion], [id_barrio]) VALUES (4, N'Carlos López', N'Av. Libertad 123', 1)
INSERT [dbo].[Clientes] ([id_cliente], [nombre], [direccion], [id_barrio]) VALUES (5, N'Ana Martínez', N'Calle Primavera 456', 2)
INSERT [dbo].[Clientes] ([id_cliente], [nombre], [direccion], [id_barrio]) VALUES (6, N'Luciana Pérez', N'Calle 123', 1)
INSERT [dbo].[Clientes] ([id_cliente], [nombre], [direccion], [id_barrio]) VALUES (7, N'Juan Rivera', N'Avenida 456', 2)
INSERT [dbo].[Clientes] ([id_cliente], [nombre], [direccion], [id_barrio]) VALUES (8, N'Sandra Torres', N'Boulevard 789', 3)
INSERT [dbo].[Clientes] ([id_cliente], [nombre], [direccion], [id_barrio]) VALUES (9, N'Luis Pérez', N'Av. Siempreviva 789', 3)
INSERT [dbo].[Clientes] ([id_cliente], [nombre], [direccion], [id_barrio]) VALUES (10, N'Marta Díaz', N'Calle Norte 101', 1)
INSERT [dbo].[Clientes] ([id_cliente], [nombre], [direccion], [id_barrio]) VALUES (11, N'Jorge Ramírez', N'Av. Sur 202', 2)
INSERT [dbo].[Clientes] ([id_cliente], [nombre], [direccion], [id_barrio]) VALUES (12, N'Patricia González', N'Calle Este 303', 3)
INSERT [dbo].[Clientes] ([id_cliente], [nombre], [direccion], [id_barrio]) VALUES (13, N'Ricardo Herrera', N'Av. Oeste 404', 1)
INSERT [dbo].[Clientes] ([id_cliente], [nombre], [direccion], [id_barrio]) VALUES (14, N'Lucía Torres', N'Calle Central 505', 2)
INSERT [dbo].[Clientes] ([id_cliente], [nombre], [direccion], [id_barrio]) VALUES (15, N'Enrique Morales', N'Av. Bosque 606', 3)
INSERT [dbo].[Clientes] ([id_cliente], [nombre], [direccion], [id_barrio]) VALUES (16, N'Laura Ríos', N'Calle Valle 707', 1)
GO
INSERT [dbo].[Comestibles] ([id_comestible], [comestible], [precio_unit], [descripcion]) VALUES (1, N'Popcorn', CAST(5.50 AS Decimal(10, 2)), N'Bolsa de palomitas de maíz')
INSERT [dbo].[Comestibles] ([id_comestible], [comestible], [precio_unit], [descripcion]) VALUES (2, N'Soda', CAST(3.25 AS Decimal(10, 2)), N'Bebida gaseosa')
INSERT [dbo].[Comestibles] ([id_comestible], [comestible], [precio_unit], [descripcion]) VALUES (3, N'Chocolate', CAST(2.75 AS Decimal(10, 2)), N'Barra de chocolate')
INSERT [dbo].[Comestibles] ([id_comestible], [comestible], [precio_unit], [descripcion]) VALUES (6, N'Combo Familiar', CAST(2500.00 AS Decimal(10, 2)), N'Incluye 2 refrescos y palomitas grandes')
INSERT [dbo].[Comestibles] ([id_comestible], [comestible], [precio_unit], [descripcion]) VALUES (7, N'Nachos Grandes', CAST(1200.00 AS Decimal(10, 2)), N'Nachos con queso cheddar')
INSERT [dbo].[Comestibles] ([id_comestible], [comestible], [precio_unit], [descripcion]) VALUES (8, N'Refresco Grande', CAST(800.00 AS Decimal(10, 2)), N'Vaso grande de refresco')
GO
INSERT [dbo].[Contactos] ([id_contacto], [contacto], [id_sucursal], [id_empleado], [id_cliente]) VALUES (1, N'3512345678', 1, 1, 1)
INSERT [dbo].[Contactos] ([id_contacto], [contacto], [id_sucursal], [id_empleado], [id_cliente]) VALUES (2, N'3518765432', 2, 2, 2)
INSERT [dbo].[Contactos] ([id_contacto], [contacto], [id_sucursal], [id_empleado], [id_cliente]) VALUES (3, N'5521987654321', 3, 3, 3)
GO
INSERT [dbo].[D_Ventas] ([id_d_ventas], [id_funcion], [id_comestible], [id_venta], [cantidad]) VALUES (1, 1, 1, 1, 2)
INSERT [dbo].[D_Ventas] ([id_d_ventas], [id_funcion], [id_comestible], [id_venta], [cantidad]) VALUES (2, 2, 2, 2, 1)
INSERT [dbo].[D_Ventas] ([id_d_ventas], [id_funcion], [id_comestible], [id_venta], [cantidad]) VALUES (3, 1, 1, 9, 7)
INSERT [dbo].[D_Ventas] ([id_d_ventas], [id_funcion], [id_comestible], [id_venta], [cantidad]) VALUES (4, 1, 2, 1, 3)
INSERT [dbo].[D_Ventas] ([id_d_ventas], [id_funcion], [id_comestible], [id_venta], [cantidad]) VALUES (5, 3, 1, 21, 2)
INSERT [dbo].[D_Ventas] ([id_d_ventas], [id_funcion], [id_comestible], [id_venta], [cantidad]) VALUES (6, 6, 6, 6, 2)
INSERT [dbo].[D_Ventas] ([id_d_ventas], [id_funcion], [id_comestible], [id_venta], [cantidad]) VALUES (7, 7, 7, 7, 3)
INSERT [dbo].[D_Ventas] ([id_d_ventas], [id_funcion], [id_comestible], [id_venta], [cantidad]) VALUES (8, 8, 8, 8, 4)
INSERT [dbo].[D_Ventas] ([id_d_ventas], [id_funcion], [id_comestible], [id_venta], [cantidad]) VALUES (9, 1, 1, 10, 7)
INSERT [dbo].[D_Ventas] ([id_d_ventas], [id_funcion], [id_comestible], [id_venta], [cantidad]) VALUES (10, 1, 1, 11, 7)
INSERT [dbo].[D_Ventas] ([id_d_ventas], [id_funcion], [id_comestible], [id_venta], [cantidad]) VALUES (11, 5, 3, 4, 1)
INSERT [dbo].[D_Ventas] ([id_d_ventas], [id_funcion], [id_comestible], [id_venta], [cantidad]) VALUES (12, 7, 6, 5, 4)
INSERT [dbo].[D_Ventas] ([id_d_ventas], [id_funcion], [id_comestible], [id_venta], [cantidad]) VALUES (13, 8, 7, 22, 2)
INSERT [dbo].[D_Ventas] ([id_d_ventas], [id_funcion], [id_comestible], [id_venta], [cantidad]) VALUES (14, 10, 8, 11, 5)
INSERT [dbo].[D_Ventas] ([id_d_ventas], [id_funcion], [id_comestible], [id_venta], [cantidad]) VALUES (15, 12, 2, 23, 3)
INSERT [dbo].[D_Ventas] ([id_d_ventas], [id_funcion], [id_comestible], [id_venta], [cantidad]) VALUES (16, 14, 3, 24, 2)
INSERT [dbo].[D_Ventas] ([id_d_ventas], [id_funcion], [id_comestible], [id_venta], [cantidad]) VALUES (17, 15, 6, 9, 1)
INSERT [dbo].[D_Ventas] ([id_d_ventas], [id_funcion], [id_comestible], [id_venta], [cantidad]) VALUES (18, 16, 7, 27, 4)
GO
INSERT [dbo].[Empleados] ([id_empleado], [nombre], [direccion], [id_cargo], [id_barrio], [id_sucursal]) VALUES (1, N'Lucas Gomez', N'Av. Colón 2345', 1, 1, 1)
INSERT [dbo].[Empleados] ([id_empleado], [nombre], [direccion], [id_cargo], [id_barrio], [id_sucursal]) VALUES (2, N'María Sanchez', N'Bv. San Juan 6789', 2, 2, 2)
INSERT [dbo].[Empleados] ([id_empleado], [nombre], [direccion], [id_cargo], [id_barrio], [id_sucursal]) VALUES (3, N'Pedro Silva', N'Rua Paulista 456', 3, 3, 3)
GO
INSERT [dbo].[Funciones] ([id_funcion], [id_pelicula], [id_sala], [fecha], [idioma], [subtitulado], [precio_unit]) VALUES (1, 1, 1, CAST(N'2024-10-16' AS Date), N'Inglés', 1, CAST(10.50 AS Decimal(10, 2)))
INSERT [dbo].[Funciones] ([id_funcion], [id_pelicula], [id_sala], [fecha], [idioma], [subtitulado], [precio_unit]) VALUES (2, 2, 2, CAST(N'2024-10-17' AS Date), N'Español', 0, CAST(8.00 AS Decimal(10, 2)))
INSERT [dbo].[Funciones] ([id_funcion], [id_pelicula], [id_sala], [fecha], [idioma], [subtitulado], [precio_unit]) VALUES (3, 1, 2, CAST(N'2024-11-10' AS Date), N'Español', 1, CAST(150.00 AS Decimal(10, 2)))
INSERT [dbo].[Funciones] ([id_funcion], [id_pelicula], [id_sala], [fecha], [idioma], [subtitulado], [precio_unit]) VALUES (4, 5, 3, CAST(N'2024-11-12' AS Date), N'Inglés', 0, CAST(180.00 AS Decimal(10, 2)))
INSERT [dbo].[Funciones] ([id_funcion], [id_pelicula], [id_sala], [fecha], [idioma], [subtitulado], [precio_unit]) VALUES (5, 10, 4, CAST(N'2024-11-13' AS Date), N'Español', 1, CAST(200.00 AS Decimal(10, 2)))
INSERT [dbo].[Funciones] ([id_funcion], [id_pelicula], [id_sala], [fecha], [idioma], [subtitulado], [precio_unit]) VALUES (6, 6, 6, CAST(N'2024-07-15' AS Date), N'Español', 1, CAST(1100.00 AS Decimal(10, 2)))
INSERT [dbo].[Funciones] ([id_funcion], [id_pelicula], [id_sala], [fecha], [idioma], [subtitulado], [precio_unit]) VALUES (7, 7, 2, CAST(N'2024-07-20' AS Date), N'Inglés', 0, CAST(1350.00 AS Decimal(10, 2)))
INSERT [dbo].[Funciones] ([id_funcion], [id_pelicula], [id_sala], [fecha], [idioma], [subtitulado], [precio_unit]) VALUES (8, 8, 5, CAST(N'2024-11-20' AS Date), N'Español', 1, CAST(1600.00 AS Decimal(10, 2)))
INSERT [dbo].[Funciones] ([id_funcion], [id_pelicula], [id_sala], [fecha], [idioma], [subtitulado], [precio_unit]) VALUES (9, 7, 5, CAST(N'2020-04-11' AS Date), N'Ruso', 0, CAST(20000.00 AS Decimal(10, 2)))
INSERT [dbo].[Funciones] ([id_funcion], [id_pelicula], [id_sala], [fecha], [idioma], [subtitulado], [precio_unit]) VALUES (10, 8, 1, CAST(N'2024-11-14' AS Date), N'Inglés', 0, CAST(170.00 AS Decimal(10, 2)))
INSERT [dbo].[Funciones] ([id_funcion], [id_pelicula], [id_sala], [fecha], [idioma], [subtitulado], [precio_unit]) VALUES (11, 15, 5, CAST(N'2024-11-15' AS Date), N'Español', 1, CAST(160.00 AS Decimal(10, 2)))
INSERT [dbo].[Funciones] ([id_funcion], [id_pelicula], [id_sala], [fecha], [idioma], [subtitulado], [precio_unit]) VALUES (12, 3, 6, CAST(N'2024-11-16' AS Date), N'Inglés', 0, CAST(190.00 AS Decimal(10, 2)))
INSERT [dbo].[Funciones] ([id_funcion], [id_pelicula], [id_sala], [fecha], [idioma], [subtitulado], [precio_unit]) VALUES (13, 7, 2, CAST(N'2024-11-17' AS Date), N'Español', 1, CAST(150.00 AS Decimal(10, 2)))
INSERT [dbo].[Funciones] ([id_funcion], [id_pelicula], [id_sala], [fecha], [idioma], [subtitulado], [precio_unit]) VALUES (14, 14, 4, CAST(N'2024-11-18' AS Date), N'Inglés', 1, CAST(180.00 AS Decimal(10, 2)))
INSERT [dbo].[Funciones] ([id_funcion], [id_pelicula], [id_sala], [fecha], [idioma], [subtitulado], [precio_unit]) VALUES (15, 4, 3, CAST(N'2024-11-19' AS Date), N'Español', 0, CAST(200.00 AS Decimal(10, 2)))
INSERT [dbo].[Funciones] ([id_funcion], [id_pelicula], [id_sala], [fecha], [idioma], [subtitulado], [precio_unit]) VALUES (16, 13, 5, CAST(N'2024-11-20' AS Date), N'Inglés', 1, CAST(170.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Generos] ([id_genero], [genero]) VALUES (1, N'Acción')
INSERT [dbo].[Generos] ([id_genero], [genero]) VALUES (2, N'Drama')
INSERT [dbo].[Generos] ([id_genero], [genero]) VALUES (3, N'Comedia')
INSERT [dbo].[Generos] ([id_genero], [genero]) VALUES (5, N'Fantasía')
INSERT [dbo].[Generos] ([id_genero], [genero]) VALUES (6, N'Ciencia Ficción')
INSERT [dbo].[Generos] ([id_genero], [genero]) VALUES (7, N'Romance')
GO
INSERT [dbo].[Paises] ([id_pais], [pais]) VALUES (1, N'Argentina')
INSERT [dbo].[Paises] ([id_pais], [pais]) VALUES (2, N'Brasil')
INSERT [dbo].[Paises] ([id_pais], [pais]) VALUES (3, N'Estados Unidos')
INSERT [dbo].[Paises] ([id_pais], [pais]) VALUES (4, N'México')
INSERT [dbo].[Paises] ([id_pais], [pais]) VALUES (5, N'España')
INSERT [dbo].[Paises] ([id_pais], [pais]) VALUES (6, N'Francia')
INSERT [dbo].[Paises] ([id_pais], [pais]) VALUES (7, N'Italia')
INSERT [dbo].[Paises] ([id_pais], [pais]) VALUES (8, N'Alemania')
INSERT [dbo].[Paises] ([id_pais], [pais]) VALUES (9, N'Japón')
INSERT [dbo].[Paises] ([id_pais], [pais]) VALUES (10, N'Reino Unido')
INSERT [dbo].[Paises] ([id_pais], [pais]) VALUES (11, N'Canadá')
INSERT [dbo].[Paises] ([id_pais], [pais]) VALUES (12, N'Colombia')
INSERT [dbo].[Paises] ([id_pais], [pais]) VALUES (13, N'Chile')
GO
INSERT [dbo].[Peliculas] ([id_pelicula], [pelicula], [fecha_estreno], [id_pais_produccion], [clasificacion], [idioma], [duracion], [director], [produccion], [guion], [musica], [fotografia], [montaje], [vestuario], [protagonista], [compania_productora], [distribucion], [presupuesto], [recaudacion]) VALUES (1, N'Avengers', CAST(N'2019-04-26' AS Date), 3, N'PG-13', N'Inglés', 180, N'Anthony Russo', N'Marvel Studios', N'Christopher Markus', N'Alan Silvestri', N'Trent Opaloch', N'Jeffrey Ford', N'Judianna Makovsky', N'Robert Downey Jr.', N'Marvel', N'Walt Disney', CAST(356000000.00 AS Decimal(15, 2)), CAST(2797800564.00 AS Decimal(15, 2)))
INSERT [dbo].[Peliculas] ([id_pelicula], [pelicula], [fecha_estreno], [id_pais_produccion], [clasificacion], [idioma], [duracion], [director], [produccion], [guion], [musica], [fotografia], [montaje], [vestuario], [protagonista], [compania_productora], [distribucion], [presupuesto], [recaudacion]) VALUES (2, N'El Secreto de Sus Ojos', CAST(N'2009-08-13' AS Date), 1, N'R', N'Español', 129, N'Juan José Campanella', N'100 Bares', N'Eduardo Sacheri', N'Federico Jusid', N'Félix Monti', N'Juan José Campanella', N'Cecilia Monti', N'Ricardo Darín', N'Sony Pictures', N'Warner Bros', CAST(2000000.00 AS Decimal(15, 2)), CAST(34000000.00 AS Decimal(15, 2)))
INSERT [dbo].[Peliculas] ([id_pelicula], [pelicula], [fecha_estreno], [id_pais_produccion], [clasificacion], [idioma], [duracion], [director], [produccion], [guion], [musica], [fotografia], [montaje], [vestuario], [protagonista], [compania_productora], [distribucion], [presupuesto], [recaudacion]) VALUES (3, N'La Isla del Tesoro', CAST(N'2024-06-15' AS Date), 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Peliculas] ([id_pelicula], [pelicula], [fecha_estreno], [id_pais_produccion], [clasificacion], [idioma], [duracion], [director], [produccion], [guion], [musica], [fotografia], [montaje], [vestuario], [protagonista], [compania_productora], [distribucion], [presupuesto], [recaudacion]) VALUES (4, N'La Sombra del Viento', CAST(N'2023-08-23' AS Date), 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Peliculas] ([id_pelicula], [pelicula], [fecha_estreno], [id_pais_produccion], [clasificacion], [idioma], [duracion], [director], [produccion], [guion], [musica], [fotografia], [montaje], [vestuario], [protagonista], [compania_productora], [distribucion], [presupuesto], [recaudacion]) VALUES (5, N'El Último Viaje', CAST(N'2022-11-10' AS Date), 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Peliculas] ([id_pelicula], [pelicula], [fecha_estreno], [id_pais_produccion], [clasificacion], [idioma], [duracion], [director], [produccion], [guion], [musica], [fotografia], [montaje], [vestuario], [protagonista], [compania_productora], [distribucion], [presupuesto], [recaudacion]) VALUES (6, N'Estrellas de Plata', CAST(N'2023-05-22' AS Date), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Peliculas] ([id_pelicula], [pelicula], [fecha_estreno], [id_pais_produccion], [clasificacion], [idioma], [duracion], [director], [produccion], [guion], [musica], [fotografia], [montaje], [vestuario], [protagonista], [compania_productora], [distribucion], [presupuesto], [recaudacion]) VALUES (7, N'El Ascenso del Guerrero', CAST(N'2023-09-10' AS Date), 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Peliculas] ([id_pelicula], [pelicula], [fecha_estreno], [id_pais_produccion], [clasificacion], [idioma], [duracion], [director], [produccion], [guion], [musica], [fotografia], [montaje], [vestuario], [protagonista], [compania_productora], [distribucion], [presupuesto], [recaudacion]) VALUES (8, N'Amor Infinito', CAST(N'2023-08-30' AS Date), 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Peliculas] ([id_pelicula], [pelicula], [fecha_estreno], [id_pais_produccion], [clasificacion], [idioma], [duracion], [director], [produccion], [guion], [musica], [fotografia], [montaje], [vestuario], [protagonista], [compania_productora], [distribucion], [presupuesto], [recaudacion]) VALUES (9, N'Cielos Rojos', CAST(N'2021-05-05' AS Date), 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Peliculas] ([id_pelicula], [pelicula], [fecha_estreno], [id_pais_produccion], [clasificacion], [idioma], [duracion], [director], [produccion], [guion], [musica], [fotografia], [montaje], [vestuario], [protagonista], [compania_productora], [distribucion], [presupuesto], [recaudacion]) VALUES (10, N'Sombras en el Mar', CAST(N'2023-02-17' AS Date), 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Peliculas] ([id_pelicula], [pelicula], [fecha_estreno], [id_pais_produccion], [clasificacion], [idioma], [duracion], [director], [produccion], [guion], [musica], [fotografia], [montaje], [vestuario], [protagonista], [compania_productora], [distribucion], [presupuesto], [recaudacion]) VALUES (11, N'El Refugio de la Luna', CAST(N'2024-03-29' AS Date), 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Peliculas] ([id_pelicula], [pelicula], [fecha_estreno], [id_pais_produccion], [clasificacion], [idioma], [duracion], [director], [produccion], [guion], [musica], [fotografia], [montaje], [vestuario], [protagonista], [compania_productora], [distribucion], [presupuesto], [recaudacion]) VALUES (12, N'Cuentos del Bosque', CAST(N'2022-09-04' AS Date), 8, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Peliculas] ([id_pelicula], [pelicula], [fecha_estreno], [id_pais_produccion], [clasificacion], [idioma], [duracion], [director], [produccion], [guion], [musica], [fotografia], [montaje], [vestuario], [protagonista], [compania_productora], [distribucion], [presupuesto], [recaudacion]) VALUES (13, N'Corazón de Hierro', CAST(N'2021-12-11' AS Date), 9, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Peliculas] ([id_pelicula], [pelicula], [fecha_estreno], [id_pais_produccion], [clasificacion], [idioma], [duracion], [director], [produccion], [guion], [musica], [fotografia], [montaje], [vestuario], [protagonista], [compania_productora], [distribucion], [presupuesto], [recaudacion]) VALUES (14, N'Eclipse en la Ciudad', CAST(N'2024-04-01' AS Date), 10, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Peliculas] ([id_pelicula], [pelicula], [fecha_estreno], [id_pais_produccion], [clasificacion], [idioma], [duracion], [director], [produccion], [guion], [musica], [fotografia], [montaje], [vestuario], [protagonista], [compania_productora], [distribucion], [presupuesto], [recaudacion]) VALUES (15, N'El Último Guardián', CAST(N'2022-07-19' AS Date), 11, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Peliculas_Generos] ([id_pelicula], [id_genero]) VALUES (1, 1)
INSERT [dbo].[Peliculas_Generos] ([id_pelicula], [id_genero]) VALUES (2, 2)
INSERT [dbo].[Peliculas_Generos] ([id_pelicula], [id_genero]) VALUES (6, 5)
INSERT [dbo].[Peliculas_Generos] ([id_pelicula], [id_genero]) VALUES (7, 6)
INSERT [dbo].[Peliculas_Generos] ([id_pelicula], [id_genero]) VALUES (8, 7)
GO
INSERT [dbo].[Provincias] ([id_provincia], [provincia], [id_pais]) VALUES (1, N'Córdoba', 1)
INSERT [dbo].[Provincias] ([id_provincia], [provincia], [id_pais]) VALUES (2, N'Buenos Aires', 1)
INSERT [dbo].[Provincias] ([id_provincia], [provincia], [id_pais]) VALUES (3, N'Sao Paulo', 2)
GO
INSERT [dbo].[Reservas] ([id_reserva], [id_cliente], [id_funcion], [cantidad_boletos], [fecha_reserva], [hubutaca], [estado_reserva]) VALUES (1, 1, 1, 2, CAST(N'2024-10-09' AS Date), 1, N'Confirmada')
INSERT [dbo].[Reservas] ([id_reserva], [id_cliente], [id_funcion], [cantidad_boletos], [fecha_reserva], [hubutaca], [estado_reserva]) VALUES (2, 2, 2, 1, CAST(N'2024-10-10' AS Date), 15, N'Pendiente')
INSERT [dbo].[Reservas] ([id_reserva], [id_cliente], [id_funcion], [cantidad_boletos], [fecha_reserva], [hubutaca], [estado_reserva]) VALUES (6, 6, 6, 3, CAST(N'2024-07-10' AS Date), 12, N'Confirmada')
INSERT [dbo].[Reservas] ([id_reserva], [id_cliente], [id_funcion], [cantidad_boletos], [fecha_reserva], [hubutaca], [estado_reserva]) VALUES (7, 7, 7, 2, CAST(N'2024-07-12' AS Date), 5, N'Pendiente')
INSERT [dbo].[Reservas] ([id_reserva], [id_cliente], [id_funcion], [cantidad_boletos], [fecha_reserva], [hubutaca], [estado_reserva]) VALUES (8, 8, 8, 5, CAST(N'2024-07-13' AS Date), 8, N'Confirmada')
GO
INSERT [dbo].[Salas] ([id_sala], [numero_sala], [capacidad], [tipo_sala], [id_sucursal]) VALUES (1, 1, 150, N'IMAX', 1)
INSERT [dbo].[Salas] ([id_sala], [numero_sala], [capacidad], [tipo_sala], [id_sucursal]) VALUES (2, 2, 100, N'2D', 2)
INSERT [dbo].[Salas] ([id_sala], [numero_sala], [capacidad], [tipo_sala], [id_sucursal]) VALUES (3, 3, 120, N'3D', 3)
INSERT [dbo].[Salas] ([id_sala], [numero_sala], [capacidad], [tipo_sala], [id_sucursal]) VALUES (4, 4, 90, N'2D', 4)
INSERT [dbo].[Salas] ([id_sala], [numero_sala], [capacidad], [tipo_sala], [id_sucursal]) VALUES (5, 5, 110, N'3D', 5)
INSERT [dbo].[Salas] ([id_sala], [numero_sala], [capacidad], [tipo_sala], [id_sucursal]) VALUES (6, 6, 130, N'IMAX', 6)
GO
INSERT [dbo].[Stocks] ([id_stock], [id_sucursal], [id_comestible], [cantidad]) VALUES (1, 1, 1, 50)
INSERT [dbo].[Stocks] ([id_stock], [id_sucursal], [id_comestible], [cantidad]) VALUES (2, 2, 2, 75)
INSERT [dbo].[Stocks] ([id_stock], [id_sucursal], [id_comestible], [cantidad]) VALUES (3, 3, 3, 100)
INSERT [dbo].[Stocks] ([id_stock], [id_sucursal], [id_comestible], [cantidad]) VALUES (6, 4, 6, 20)
INSERT [dbo].[Stocks] ([id_stock], [id_sucursal], [id_comestible], [cantidad]) VALUES (7, 5, 7, 30)
INSERT [dbo].[Stocks] ([id_stock], [id_sucursal], [id_comestible], [cantidad]) VALUES (8, 6, 8, 40)
GO
INSERT [dbo].[Sucursales] ([id_sucursal], [sucursal], [direccion], [id_barrio_suc]) VALUES (1, N'Sucursal 1', N'Av. Colón 1000', 1)
INSERT [dbo].[Sucursales] ([id_sucursal], [sucursal], [direccion], [id_barrio_suc]) VALUES (2, N'Sucursal 2', N'Bv. San Juan 1500', 2)
INSERT [dbo].[Sucursales] ([id_sucursal], [sucursal], [direccion], [id_barrio_suc]) VALUES (3, N'Sucursal 3', N'Rua Paulista 2000', 3)
INSERT [dbo].[Sucursales] ([id_sucursal], [sucursal], [direccion], [id_barrio_suc]) VALUES (4, N'Sucursal Centro', N'Av. Mitre 450', 1)
INSERT [dbo].[Sucursales] ([id_sucursal], [sucursal], [direccion], [id_barrio_suc]) VALUES (5, N'Sucursal Este', N'Calle 22 de Mayo 190', 2)
INSERT [dbo].[Sucursales] ([id_sucursal], [sucursal], [direccion], [id_barrio_suc]) VALUES (6, N'Sucursal Norte', N'Ruta 9 Km 305', 3)
INSERT [dbo].[Sucursales] ([id_sucursal], [sucursal], [direccion], [id_barrio_suc]) VALUES (7, N'Sucursal Centro', N'Av. Central 123', 1)
INSERT [dbo].[Sucursales] ([id_sucursal], [sucursal], [direccion], [id_barrio_suc]) VALUES (8, N'Sucursal Norte', N'Calle Norte 456', 2)
INSERT [dbo].[Sucursales] ([id_sucursal], [sucursal], [direccion], [id_barrio_suc]) VALUES (9, N'Sucursal Sur', N'Av. Sur 789', 3)
INSERT [dbo].[Sucursales] ([id_sucursal], [sucursal], [direccion], [id_barrio_suc]) VALUES (10, N'Sucursal Este', N'Calle Este 101', 1)
INSERT [dbo].[Sucursales] ([id_sucursal], [sucursal], [direccion], [id_barrio_suc]) VALUES (11, N'Sucursal Oeste', N'Av. Oeste 202', 2)
INSERT [dbo].[Sucursales] ([id_sucursal], [sucursal], [direccion], [id_barrio_suc]) VALUES (12, N'Sucursal Bosque', N'Calle Bosque 303', 3)
INSERT [dbo].[Sucursales] ([id_sucursal], [sucursal], [direccion], [id_barrio_suc]) VALUES (13, N'Sucursal Río', N'Av. Río 404', 1)
INSERT [dbo].[Sucursales] ([id_sucursal], [sucursal], [direccion], [id_barrio_suc]) VALUES (14, N'Sucursal Valle', N'Calle Valle 505', 2)
INSERT [dbo].[Sucursales] ([id_sucursal], [sucursal], [direccion], [id_barrio_suc]) VALUES (15, N'Sucursal Costa', N'Av. Costa 606', 3)
INSERT [dbo].[Sucursales] ([id_sucursal], [sucursal], [direccion], [id_barrio_suc]) VALUES (16, N'Sucursal Ciudadela', N'Calle Ciudadela 707', 1)
GO
INSERT [dbo].[Tipos_Contactos] ([id_tipo_contacto], [tipo_contacto]) VALUES (1, N'Teléfono')
INSERT [dbo].[Tipos_Contactos] ([id_tipo_contacto], [tipo_contacto]) VALUES (2, N'Email')
INSERT [dbo].[Tipos_Contactos] ([id_tipo_contacto], [tipo_contacto]) VALUES (3, N'Dirección')
GO
INSERT [dbo].[Ventas] ([id_venta], [id_sucursal], [id_cliente], [fecha_venta], [metodo_pago], [impuestos], [descuentos], [estado_trans], [tipo_venta]) VALUES (1, 1, 1, CAST(N'2024-10-10T00:00:00.000' AS DateTime), N'Tarjeta de Crédito', CAST(1.50 AS Decimal(10, 2)), CAST(0.50 AS Decimal(10, 2)), N'Completo', N'Online')
INSERT [dbo].[Ventas] ([id_venta], [id_sucursal], [id_cliente], [fecha_venta], [metodo_pago], [impuestos], [descuentos], [estado_trans], [tipo_venta]) VALUES (2, 2, 2, CAST(N'2024-10-11T00:00:00.000' AS DateTime), N'Efectivo', CAST(2.00 AS Decimal(10, 2)), CAST(1.00 AS Decimal(10, 2)), N'Pendiente', N'En persona')
INSERT [dbo].[Ventas] ([id_venta], [id_sucursal], [id_cliente], [fecha_venta], [metodo_pago], [impuestos], [descuentos], [estado_trans], [tipo_venta]) VALUES (3, 7, 4, CAST(N'2021-01-15T00:00:00.000' AS DateTime), N'Tarjeta', CAST(15.00 AS Decimal(10, 2)), CAST(5.00 AS Decimal(10, 2)), N'Completado', N'Online')
INSERT [dbo].[Ventas] ([id_venta], [id_sucursal], [id_cliente], [fecha_venta], [metodo_pago], [impuestos], [descuentos], [estado_trans], [tipo_venta]) VALUES (4, 8, 5, CAST(N'2022-02-10T00:00:00.000' AS DateTime), N'Efectivo', CAST(18.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)), N'Pendiente', N'Presencial')
INSERT [dbo].[Ventas] ([id_venta], [id_sucursal], [id_cliente], [fecha_venta], [metodo_pago], [impuestos], [descuentos], [estado_trans], [tipo_venta]) VALUES (5, 9, 6, CAST(N'2023-03-20T00:00:00.000' AS DateTime), N'Tarjeta', CAST(10.00 AS Decimal(10, 2)), CAST(2.50 AS Decimal(10, 2)), N'Completado', N'Online')
INSERT [dbo].[Ventas] ([id_venta], [id_sucursal], [id_cliente], [fecha_venta], [metodo_pago], [impuestos], [descuentos], [estado_trans], [tipo_venta]) VALUES (6, 4, 6, CAST(N'2024-07-15T00:00:00.000' AS DateTime), N'Tarjeta', CAST(250.00 AS Decimal(10, 2)), CAST(100.00 AS Decimal(10, 2)), N'Completada', N'Online')
INSERT [dbo].[Ventas] ([id_venta], [id_sucursal], [id_cliente], [fecha_venta], [metodo_pago], [impuestos], [descuentos], [estado_trans], [tipo_venta]) VALUES (7, 5, 7, CAST(N'2024-07-20T00:00:00.000' AS DateTime), N'Efectivo', CAST(300.00 AS Decimal(10, 2)), CAST(50.00 AS Decimal(10, 2)), N'Completada', N'Física')
INSERT [dbo].[Ventas] ([id_venta], [id_sucursal], [id_cliente], [fecha_venta], [metodo_pago], [impuestos], [descuentos], [estado_trans], [tipo_venta]) VALUES (8, 6, 8, CAST(N'2024-07-21T00:00:00.000' AS DateTime), N'Tarjeta', CAST(320.00 AS Decimal(10, 2)), CAST(120.00 AS Decimal(10, 2)), N'Completada', N'Online')
INSERT [dbo].[Ventas] ([id_venta], [id_sucursal], [id_cliente], [fecha_venta], [metodo_pago], [impuestos], [descuentos], [estado_trans], [tipo_venta]) VALUES (9, 1, 1, CAST(N'2023-10-10T00:00:00.000' AS DateTime), N'Tarjeta de Crédito', CAST(1.00 AS Decimal(10, 2)), CAST(1.50 AS Decimal(10, 2)), N'Completo', N'Online')
INSERT [dbo].[Ventas] ([id_venta], [id_sucursal], [id_cliente], [fecha_venta], [metodo_pago], [impuestos], [descuentos], [estado_trans], [tipo_venta]) VALUES (10, 1, 1, CAST(N'2023-09-10T00:00:00.000' AS DateTime), N'Tarjeta de Crédito', CAST(1.00 AS Decimal(10, 2)), CAST(1.50 AS Decimal(10, 2)), N'Completo', N'Online')
INSERT [dbo].[Ventas] ([id_venta], [id_sucursal], [id_cliente], [fecha_venta], [metodo_pago], [impuestos], [descuentos], [estado_trans], [tipo_venta]) VALUES (11, 1, 1, CAST(N'2024-09-01T00:00:00.000' AS DateTime), N'Tarjeta de Crédito', CAST(1.00 AS Decimal(10, 2)), CAST(1.50 AS Decimal(10, 2)), N'Completo', N'Online')
INSERT [dbo].[Ventas] ([id_venta], [id_sucursal], [id_cliente], [fecha_venta], [metodo_pago], [impuestos], [descuentos], [estado_trans], [tipo_venta]) VALUES (12, 1, NULL, CAST(N'2024-10-10T00:00:00.000' AS DateTime), NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Ventas] ([id_venta], [id_sucursal], [id_cliente], [fecha_venta], [metodo_pago], [impuestos], [descuentos], [estado_trans], [tipo_venta]) VALUES (13, 2, NULL, CAST(N'2024-10-12T00:00:00.000' AS DateTime), NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Ventas] ([id_venta], [id_sucursal], [id_cliente], [fecha_venta], [metodo_pago], [impuestos], [descuentos], [estado_trans], [tipo_venta]) VALUES (14, 5, NULL, CAST(N'2024-10-13T00:00:00.000' AS DateTime), NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Ventas] ([id_venta], [id_sucursal], [id_cliente], [fecha_venta], [metodo_pago], [impuestos], [descuentos], [estado_trans], [tipo_venta]) VALUES (15, 2, NULL, CAST(N'2024-10-03T00:00:00.000' AS DateTime), NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Ventas] ([id_venta], [id_sucursal], [id_cliente], [fecha_venta], [metodo_pago], [impuestos], [descuentos], [estado_trans], [tipo_venta]) VALUES (16, 6, NULL, CAST(N'2024-10-07T00:00:00.000' AS DateTime), NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Ventas] ([id_venta], [id_sucursal], [id_cliente], [fecha_venta], [metodo_pago], [impuestos], [descuentos], [estado_trans], [tipo_venta]) VALUES (17, 3, NULL, CAST(N'2024-10-09T00:00:00.000' AS DateTime), NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Ventas] ([id_venta], [id_sucursal], [id_cliente], [fecha_venta], [metodo_pago], [impuestos], [descuentos], [estado_trans], [tipo_venta]) VALUES (18, 4, NULL, CAST(N'2024-10-11T00:00:00.000' AS DateTime), NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Ventas] ([id_venta], [id_sucursal], [id_cliente], [fecha_venta], [metodo_pago], [impuestos], [descuentos], [estado_trans], [tipo_venta]) VALUES (19, 5, NULL, CAST(N'2024-10-08T00:00:00.000' AS DateTime), NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Ventas] ([id_venta], [id_sucursal], [id_cliente], [fecha_venta], [metodo_pago], [impuestos], [descuentos], [estado_trans], [tipo_venta]) VALUES (20, 6, NULL, CAST(N'2024-10-06T00:00:00.000' AS DateTime), NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Ventas] ([id_venta], [id_sucursal], [id_cliente], [fecha_venta], [metodo_pago], [impuestos], [descuentos], [estado_trans], [tipo_venta]) VALUES (21, 10, 7, CAST(N'2020-04-05T00:00:00.000' AS DateTime), N'Transferencia', CAST(12.00 AS Decimal(10, 2)), CAST(3.00 AS Decimal(10, 2)), N'Cancelado', N'Online')
INSERT [dbo].[Ventas] ([id_venta], [id_sucursal], [id_cliente], [fecha_venta], [metodo_pago], [impuestos], [descuentos], [estado_trans], [tipo_venta]) VALUES (22, 11, 8, CAST(N'2019-05-15T00:00:00.000' AS DateTime), N'Tarjeta', CAST(20.00 AS Decimal(10, 2)), CAST(4.00 AS Decimal(10, 2)), N'Completado', N'Presencial')
INSERT [dbo].[Ventas] ([id_venta], [id_sucursal], [id_cliente], [fecha_venta], [metodo_pago], [impuestos], [descuentos], [estado_trans], [tipo_venta]) VALUES (23, 12, 9, CAST(N'2021-06-25T00:00:00.000' AS DateTime), N'Efectivo', CAST(14.00 AS Decimal(10, 2)), CAST(1.50 AS Decimal(10, 2)), N'Pendiente', N'Online')
INSERT [dbo].[Ventas] ([id_venta], [id_sucursal], [id_cliente], [fecha_venta], [metodo_pago], [impuestos], [descuentos], [estado_trans], [tipo_venta]) VALUES (24, 13, 10, CAST(N'2022-07-30T00:00:00.000' AS DateTime), N'Tarjeta', CAST(15.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)), N'Completado', N'Presencial')
INSERT [dbo].[Ventas] ([id_venta], [id_sucursal], [id_cliente], [fecha_venta], [metodo_pago], [impuestos], [descuentos], [estado_trans], [tipo_venta]) VALUES (25, 14, 11, CAST(N'2023-08-12T00:00:00.000' AS DateTime), N'Transferencia', CAST(17.00 AS Decimal(10, 2)), CAST(2.00 AS Decimal(10, 2)), N'Pendiente', N'Online')
INSERT [dbo].[Ventas] ([id_venta], [id_sucursal], [id_cliente], [fecha_venta], [metodo_pago], [impuestos], [descuentos], [estado_trans], [tipo_venta]) VALUES (26, 15, 12, CAST(N'2020-09-18T00:00:00.000' AS DateTime), N'Tarjeta', CAST(19.00 AS Decimal(10, 2)), CAST(3.50 AS Decimal(10, 2)), N'Completado', N'Presencial')
INSERT [dbo].[Ventas] ([id_venta], [id_sucursal], [id_cliente], [fecha_venta], [metodo_pago], [impuestos], [descuentos], [estado_trans], [tipo_venta]) VALUES (27, 16, 13, CAST(N'2018-10-22T00:00:00.000' AS DateTime), N'Efectivo', CAST(16.00 AS Decimal(10, 2)), CAST(4.00 AS Decimal(10, 2)), N'Cancelado', N'Online')
GO
ALTER TABLE [dbo].[Barrios]  WITH CHECK ADD FOREIGN KEY([id_provincia])
REFERENCES [dbo].[Provincias] ([id_provincia])
GO
ALTER TABLE [dbo].[Clientes]  WITH CHECK ADD FOREIGN KEY([id_barrio])
REFERENCES [dbo].[Barrios] ([id_barrio])
GO
ALTER TABLE [dbo].[Contactos]  WITH CHECK ADD FOREIGN KEY([id_cliente])
REFERENCES [dbo].[Clientes] ([id_cliente])
GO
ALTER TABLE [dbo].[Contactos]  WITH CHECK ADD FOREIGN KEY([id_empleado])
REFERENCES [dbo].[Empleados] ([id_empleado])
GO
ALTER TABLE [dbo].[Contactos]  WITH CHECK ADD FOREIGN KEY([id_sucursal])
REFERENCES [dbo].[Sucursales] ([id_sucursal])
GO
ALTER TABLE [dbo].[D_Ventas]  WITH CHECK ADD FOREIGN KEY([id_comestible])
REFERENCES [dbo].[Comestibles] ([id_comestible])
GO
ALTER TABLE [dbo].[D_Ventas]  WITH CHECK ADD FOREIGN KEY([id_funcion])
REFERENCES [dbo].[Funciones] ([id_funcion])
GO
ALTER TABLE [dbo].[D_Ventas]  WITH CHECK ADD FOREIGN KEY([id_venta])
REFERENCES [dbo].[Ventas] ([id_venta])
GO
ALTER TABLE [dbo].[Empleados]  WITH CHECK ADD FOREIGN KEY([id_barrio])
REFERENCES [dbo].[Barrios] ([id_barrio])
GO
ALTER TABLE [dbo].[Empleados]  WITH CHECK ADD FOREIGN KEY([id_cargo])
REFERENCES [dbo].[Cargos] ([id_cargo])
GO
ALTER TABLE [dbo].[Empleados]  WITH CHECK ADD FOREIGN KEY([id_sucursal])
REFERENCES [dbo].[Sucursales] ([id_sucursal])
GO
ALTER TABLE [dbo].[Funciones]  WITH CHECK ADD FOREIGN KEY([id_pelicula])
REFERENCES [dbo].[Peliculas] ([id_pelicula])
GO
ALTER TABLE [dbo].[Funciones]  WITH CHECK ADD FOREIGN KEY([id_sala])
REFERENCES [dbo].[Salas] ([id_sala])
GO
ALTER TABLE [dbo].[Peliculas]  WITH CHECK ADD FOREIGN KEY([id_pais_produccion])
REFERENCES [dbo].[Paises] ([id_pais])
GO
ALTER TABLE [dbo].[Peliculas_Generos]  WITH CHECK ADD FOREIGN KEY([id_genero])
REFERENCES [dbo].[Generos] ([id_genero])
GO
ALTER TABLE [dbo].[Peliculas_Generos]  WITH CHECK ADD FOREIGN KEY([id_pelicula])
REFERENCES [dbo].[Peliculas] ([id_pelicula])
GO
ALTER TABLE [dbo].[Provincias]  WITH CHECK ADD FOREIGN KEY([id_pais])
REFERENCES [dbo].[Paises] ([id_pais])
GO
ALTER TABLE [dbo].[Reservas]  WITH CHECK ADD FOREIGN KEY([id_cliente])
REFERENCES [dbo].[Clientes] ([id_cliente])
GO
ALTER TABLE [dbo].[Reservas]  WITH CHECK ADD FOREIGN KEY([id_funcion])
REFERENCES [dbo].[Funciones] ([id_funcion])
GO
ALTER TABLE [dbo].[Salas]  WITH CHECK ADD FOREIGN KEY([id_sucursal])
REFERENCES [dbo].[Sucursales] ([id_sucursal])
GO
ALTER TABLE [dbo].[Stocks]  WITH CHECK ADD FOREIGN KEY([id_comestible])
REFERENCES [dbo].[Comestibles] ([id_comestible])
GO
ALTER TABLE [dbo].[Stocks]  WITH CHECK ADD FOREIGN KEY([id_sucursal])
REFERENCES [dbo].[Sucursales] ([id_sucursal])
GO
ALTER TABLE [dbo].[Sucursales]  WITH CHECK ADD FOREIGN KEY([id_barrio_suc])
REFERENCES [dbo].[Barrios] ([id_barrio])
GO
ALTER TABLE [dbo].[Ventas]  WITH CHECK ADD FOREIGN KEY([id_cliente])
REFERENCES [dbo].[Clientes] ([id_cliente])
GO
ALTER TABLE [dbo].[Ventas]  WITH CHECK ADD FOREIGN KEY([id_sucursal])
REFERENCES [dbo].[Sucursales] ([id_sucursal])
GO
/****** Object:  StoredProcedure [dbo].[sp_ClientesConMasBoletos]    Script Date: 13/11/2024 01:11:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ClientesConMasBoletos]
@cantidad int = null
AS
BEGIN
    if @cantidad is not null and @cantidad>0
		BEGIN
		SELECT c.id_cliente, 
			   c.nombre, 
			   r.id_funcion, 
			   SUM(r.cantidad_boletos) AS total_boletos, 
			   SUM(r.cantidad_boletos * f.precio_unit) AS recaudacion_estimadas
		FROM Reservas r
		JOIN Clientes c ON r.id_cliente = c.id_cliente
		JOIN Funciones f ON r.id_funcion = f.id_funcion
		GROUP BY c.id_cliente, c.nombre, r.id_funcion
		HAVING SUM(r.cantidad_boletos) >= @cantidad
		ORDER BY recaudacion_estimadas DESC;
		END
	ELSE
		BEGIN
			RAISERROR('La cantidad minima no es valida', 16, 1)
		END
END;
GO
/****** Object:  StoredProcedure [dbo].[SP_ComestibleMenosVendido]    Script Date: 13/11/2024 01:11:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_ComestibleMenosVendido]
@ano int,
@letra varchar(1)
as
begin
	if @ano is not null and @letra is not null
		begin
			select V.comestible "Producto",V.precio_unit "Precio unitario",
			V.Facturacion,V.[Cantidad vendida],V.sucursal "Sucursal",	
							(
							select avg([Cantidad vendida]) 
							from Vent_Com_Año_Actu as V1 
							where V1.sucursal=V.sucursal
							) "Promedio de cantidad vendida"
			from Vent_Com_Año_Actu as V
			where V.comestible not like @letra+'%'
			and				(
							[Cantidad vendida]=(
							select min([Cantidad vendida])
							from Vent_Com_Año_Actu as V3
							where V3.sucursal=V.sucursal)
							)
			and year(V.fecha_venta)=@ano
			order by V.sucursal desc
		end
	else
		begin
			raiserror('Los parametros son invalidos o incorrectos',16,1)
		end
end
GO
/****** Object:  StoredProcedure [dbo].[SP_Consultar_Recaudacion_Ultimos3Meses]    Script Date: 13/11/2024 01:11:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_Consultar_Recaudacion_Ultimos3Meses]
@FechaDesde dateTIME,
@FechaHasta dateTIME
AS
BEGIN
    SELECT 
        s.sucursal,
        dbo.Total_Recaudado_Funciones(s.id_sucursal,@FechaDesde,@FechaHasta) AS total_recaudado,
        'Funciones' AS tipo_venta
    FROM Sucursales AS s
    WHERE dbo.Total_Recaudado_Funciones(s.id_sucursal,@FechaDesde, @FechaHasta) IS NOT NULL

    UNION 

    SELECT 
        s.sucursal,
        dbo.Total_Recaudado_Comestibles(s.id_sucursal, @FechaDesde, @FechaHasta) AS total_recaudado,
        'Comestibles' AS tipo_venta
    FROM Sucursales AS s
    WHERE dbo.Total_Recaudado_Comestibles(s.id_sucursal, @FechaDesde, @FechaHasta) IS NOT NULL
    ORDER BY s.sucursal
END
GO
/****** Object:  StoredProcedure [dbo].[SP_Consultar_Total_BoletosClientes]    Script Date: 13/11/2024 01:11:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_Consultar_Total_BoletosClientes]
    @FechaDesde DATETIME,
    @FechaHasta DATETIME
AS
BEGIN
    SELECT 
    c.nombre,
		dbo.Total_Boletos_Reservas(c.id_cliente, @FechaDesde, @FechaHasta) 
		+ dbo.Total_Boletos_Ventas(c.id_cliente, @FechaDesde, @FechaHasta) AS Total_Boletos
FROM 
    Clientes c
ORDER BY 
    total_boletos DESC
END
GO
/****** Object:  StoredProcedure [dbo].[SP_FuncionesImax]    Script Date: 13/11/2024 01:11:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_FuncionesImax]
@mes varchar(20),
@tipoSala varchar (10)
as
begin
---
	if @mes is not null and @tipoSala is not null
		begin
		declare @mesConvertido int
		set @mesConvertido=case @mes
							when 'Enero' then 1
							when 'Febrero' then 2
							when 'Marzo' then 3
							when 'Abril' then 4
							when 'Mayo' then 5
							when 'Junio' then 6
							when 'Julio' then 7
							when 'Agosto' then 8 
							when 'Septiembre' then 9
							when 'Octubre' then 10
							when 'Noviembre' then 11
							when 'Diciembre' then 12
							end
			create table #FuncionesImaxMesPasado
			(id_funcion int,
			id_pelicula int,
			fecha datetime,
			boletos int,
			precio_prom decimal)
			---
			insert into
			#FuncionesImaxMesPasado(id_funcion,id_pelicula,fecha,boletos,precio_prom)
			select F.id_funcion, F.id_pelicula, F.fecha,
			sum(R.cantidad_boletos) as "Total Vendidos", 
			avg(F.precio_unit) as "Precio Promedio"
			from Funciones as F
			join Salas as S on F.id_sala=S.id_sala
			join Reservas as R on F.id_funcion=R.id_funcion
			where S.tipo_sala=@tipoSala
			and month(F.fecha)=@mesConvertido --ahora solo hay datos para octubre y julio 
			group by F.id_funcion, F.id_pelicula, F.fecha
			---
			select id_funcion, id_pelicula, fecha, boletos, precio_prom 
			from #FuncionesImaxMesPasado
			where precio_prom   > (
							select avg(F.precio_unit)
							from Funciones as F
							join Salas S on F.id_sala=S.id_sala
							where S.tipo_sala=@tipoSala
							and year(F.fecha)=year(getdate())
							  )
		end
	else
		begin
			raiserror('Los campos son invalidos o incorrectos',16,1)
		end
end
GO
/****** Object:  StoredProcedure [dbo].[SP_Listar]    Script Date: 13/11/2024 01:11:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_Listar]
@cantidadMinima int = null
as
begin
select s.id_sucursal ,sucursal as 'Sucursales', cantidad 'Stock'
from Sucursales as S
join Stocks as ST on S.id_sucursal=ST.id_sucursal
group by s.id_sucursal,sucursal, cantidad 
having cantidad>=@cantidadMinima
and (
select avg(C.precio_unit*DV.cantidad)
from Comestibles as C 
join D_Ventas as DV on C.id_comestible=DV.id_comestible
join Ventas as V on DV.id_venta=V.id_venta
where V.id_sucursal=S.id_sucursal
)>(select avg(C1.precio_unit*DV1.cantidad)
from Comestibles as C1 
join D_Ventas as DV1 on C1.id_comestible=DV1.id_comestible)
end
GO
/****** Object:  StoredProcedure [dbo].[SP_ListarSucursalesConStock]    Script Date: 13/11/2024 01:11:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_ListarSucursalesConStock]
@cantidadMinima int = null
as
begin
	if @cantidadMinima is not null and @cantidadMinima>=0
		begin
			select sucursal as 'Sucursales', cantidad 'Stock', comestible 'Comestibles'
			from Sucursales as S
			join Stocks as ST on S.id_sucursal=ST.id_sucursal
			join Comestibles as C on ST.id_comestible=C.id_comestible
			group by S.id_sucursal,sucursal, cantidad, comestible 
			having cantidad>=@cantidadMinima
			and (
					select avg(C.precio_unit*DV.cantidad)
					from Comestibles as C 
					join D_Ventas as DV on C.id_comestible=DV.id_comestible
					join Ventas as V on DV.id_venta=V.id_venta
					where V.id_sucursal=S.id_sucursal
					)>(
					select avg(C1.precio_unit*DV1.cantidad)
					from Comestibles as C1 
					join D_Ventas as DV1 on C1.id_comestible=DV1.id_comestible
					)
		end
	else
		begin
			raiserror('La cantidad minima no es valida', 16, 1)
		end
end
GO
/****** Object:  StoredProcedure [dbo].[sp_PeliculasSinFunciones]    Script Date: 13/11/2024 01:11:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_PeliculasSinFunciones]
@año int = null
AS
BEGIN
	if @año is not null and @año>0
		BEGIN
		SELECT p.id_pelicula, 
			   p.pelicula, 
			   p.fecha_estreno, 
			   g.genero
		FROM Peliculas p
		JOIN Peliculas_Generos pg ON p.id_pelicula = pg.id_pelicula
		JOIN Generos g ON pg.id_genero = g.id_genero
		WHERE p.id_pelicula NOT IN (
			SELECT f.id_pelicula
			FROM Funciones f
			WHERE YEAR(f.fecha) = @año
		)
		AND p.id_pelicula NOT IN (
			SELECT f.id_pelicula
			FROM Funciones f
			WHERE f.fecha > GETDATE());
		END
	ELSE
		BEGIN
			RAISERROR('El año minimo no es valido', 16, 1)
		END
END
GO
/****** Object:  StoredProcedure [dbo].[sp_ResumenBoletosVendidos]    Script Date: 13/11/2024 01:11:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ResumenBoletosVendidos]
    @Mes varchar(20) = NULL,
	@boletosReq int=null
AS
BEGIN
if @Mes is not null and @boletosReq>=0
	begin
	declare @mesConvertido int
	set @mesConvertido=case @Mes
						when 'Enero' then 1
						when 'Febrero' then 2
						when 'Marzo' then 3
						when 'Abril' then 4
						when 'Mayo' then 5
						when 'Junio' then 6
						when 'Julio' then 7
						when 'Agosto' then 8 
						when 'Septiembre' then 9
						when 'Octubre' then 10
						when 'Noviembre' then 11
						when 'Diciembre' then 12
						end
		SELECT SU.sucursal AS Sucursal,
			   MONTH(F.fecha) AS Mes,
			   SUM(R.cantidad_boletos) AS Boletos,
			   SUM(R.cantidad_boletos * F.precio_unit) AS Recaudado
		FROM Reservas AS R
		JOIN Funciones AS F ON R.id_funcion = F.id_funcion
		JOIN Salas AS S ON F.id_sala = S.id_sala
		JOIN Sucursales AS SU ON S.id_sucursal = SU.id_sucursal
		GROUP BY SU.sucursal, MONTH(F.fecha)
		HAVING SUM(R.cantidad_boletos) >= @boletosReq and MONTH(F.fecha)=@mesConvertido
		ORDER BY Recaudado DESC;
	end
else
	begin
		raiserror('Los datos estan incompletos o son incorrectos.',16,1)
	end
END;
GO
USE [master]
GO
ALTER DATABASE [Cinema_TP] SET  READ_WRITE 
GO
