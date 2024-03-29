﻿USE [master]
GO
/****** Object:  Database [SourceSystems]    Script Date: 5/25/2022 9:53:30 AM ******/
CREATE DATABASE [SourceSystems]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SourceSystems', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\SourceSystems.mdf' , SIZE = 15417344KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'SourceSystems_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\SourceSystems_log.ldf' , SIZE = 3547136KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [SourceSystems] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SourceSystems].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SourceSystems] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SourceSystems] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SourceSystems] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SourceSystems] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SourceSystems] SET ARITHABORT OFF 
GO
ALTER DATABASE [SourceSystems] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SourceSystems] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SourceSystems] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SourceSystems] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SourceSystems] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SourceSystems] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SourceSystems] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SourceSystems] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SourceSystems] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SourceSystems] SET  DISABLE_BROKER 
GO
ALTER DATABASE [SourceSystems] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SourceSystems] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SourceSystems] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SourceSystems] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SourceSystems] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SourceSystems] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SourceSystems] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SourceSystems] SET RECOVERY FULL 
GO
ALTER DATABASE [SourceSystems] SET  MULTI_USER 
GO
ALTER DATABASE [SourceSystems] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SourceSystems] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SourceSystems] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SourceSystems] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [SourceSystems] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [SourceSystems] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'SourceSystems', N'ON'
GO
ALTER DATABASE [SourceSystems] SET QUERY_STORE = OFF
GO
USE [SourceSystems]
GO

/****** Object:  Table [dbo].[Airports]    Script Date: 5/25/2022 9:53:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Airports](
	[iata] [varchar](5) NULL,
	[airport] [varchar](41) NULL,
	[city] [varchar](33) NULL,
	[state] [varchar](2) NULL,
	[country] [varchar](30) NULL,
	[lat] [real] NULL,
	[long] [real] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Carrier]    Script Date: 5/25/2022 9:53:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Carrier](
	[Code] [varchar](15) NULL,
	[Description] [varchar](60) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ErrorDataflight]    Script Date: 5/25/2022 9:53:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ErrorDataflight](
	[Flat File Source Error Output Column] [varchar](max) NULL,
	[ErrorCode] [int] NULL,
	[ErrorColumn] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FlightData]    Script Date: 5/25/2022 9:53:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FlightData](
	[Year] [smallint] NULL,
	[Month] [smallint] NULL,
	[DayofMonth] [smallint] NULL,
	[DayOfWeek] [smallint] NULL,
	[DepTime] [smallint] NULL,
	[CRSDepTime] [smallint] NULL,
	[ArrTime] [smallint] NULL,
	[CRSArrTime] [smallint] NULL,
	[UniqueCarrier] [varchar](2) NULL,
	[FlightNum] [smallint] NULL,
	[TailNum] [varchar](6) NULL,
	[ActualElapsedTime] [smallint] NULL,
	[CRSElapsedTime] [smallint] NULL,
	[AirTime] [smallint] NULL,
	[ArrDelay] [smallint] NULL,
	[DepDelay] [smallint] NULL,
	[Dest] [varchar](3) NULL,
	[Distance] [smallint] NULL,
	[TaxiIn] [smallint] NULL,
	[TaxiOut] [smallint] NULL,
	[Cancelled] [smallint] NULL,
	[CancellationCode] [varchar](2) NULL,
	[Diverted] [smallint] NULL,
	[CarrierDelay] [varchar](2) NULL,
	[WeatherDelay] [varchar](2) NULL,
	[NASDelay] [varchar](2) NULL,
	[SecurityDelay] [varchar](2) NULL,
	[LateAircraftDelay] [varchar](2) NULL,
	[Origin] [varchar](3) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Plane-data]    Script Date: 5/25/2022 9:53:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Plane-data](
	[tailnum] [varchar](50) NULL,
	[type] [varchar](50) NULL,
	[manufacturer] [varchar](50) NULL,
	[issue_date] [varchar](50) NULL,
	[model] [varchar](50) NULL,
	[status] [varchar](50) NULL,
	[aircraft_type] [varchar](50) NULL,
	[engine_type] [varchar](50) NULL,
	[year] [varchar](50) NULL
) ON [PRIMARY]
GO
USE [master]
GO
ALTER DATABASE [SourceSystems] SET  READ_WRITE 
GO
