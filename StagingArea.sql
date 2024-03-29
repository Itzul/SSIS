﻿USE [master]
GO
/****** Object:  Database [StagingArea]    Script Date: 5/25/2022 9:54:30 AM ******/
CREATE DATABASE [StagingArea]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'StagingArea', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\StagingArea.mdf' , SIZE = 21614592KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'StagingArea_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\StagingArea_log.ldf' , SIZE = 9228288KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [StagingArea] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [StagingArea].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [StagingArea] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [StagingArea] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [StagingArea] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [StagingArea] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [StagingArea] SET ARITHABORT OFF 
GO
ALTER DATABASE [StagingArea] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [StagingArea] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [StagingArea] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [StagingArea] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [StagingArea] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [StagingArea] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [StagingArea] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [StagingArea] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [StagingArea] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [StagingArea] SET  DISABLE_BROKER 
GO
ALTER DATABASE [StagingArea] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [StagingArea] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [StagingArea] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [StagingArea] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [StagingArea] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [StagingArea] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [StagingArea] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [StagingArea] SET RECOVERY FULL 
GO
ALTER DATABASE [StagingArea] SET  MULTI_USER 
GO
ALTER DATABASE [StagingArea] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [StagingArea] SET DB_CHAINING OFF 
GO
ALTER DATABASE [StagingArea] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [StagingArea] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [StagingArea] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [StagingArea] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'StagingArea', N'ON'
GO
ALTER DATABASE [StagingArea] SET QUERY_STORE = OFF
GO
USE [StagingArea]
GO

/****** Object:  Table [dbo].[AirportData]    Script Date: 5/25/2022 9:54:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AirportData](
	[AirportID] [varchar](5) NULL,
	[AirportName] [varchar](41) NULL,
	[City] [varchar](33) NULL,
	[State] [varchar](2) NULL,
	[Country] [varchar](30) NULL,
	[Latitude] [real] NULL,
	[Longitude] [real] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Carrier]    Script Date: 5/25/2022 9:54:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Carrier](
	[CarrierID] [varchar](15) NULL,
	[Description] [varchar](60) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DimPlane]    Script Date: 5/25/2022 9:54:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimPlane](
	[Tailnumber] [varchar](10) NULL,
	[OwnerType] [varchar](50) NULL,
	[Manufacturer] [varchar](50) NULL,
	[IssueDate] [varchar](50) NULL,
	[Model] [varchar](50) NULL,
	[Status] [varchar](50) NULL,
	[AircraftType] [varchar](50) NULL,
	[EngineType] [varchar](50) NULL,
	[Year] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FlightData]    Script Date: 5/25/2022 9:54:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FlightData](
	[Date] [date] NULL,
	[Dateint] [int] NULL,
	[Year] [smallint] NULL,
	[Month] [tinyint] NULL,
	[DayofMonth] [tinyint] NULL,
	[DayOfWeek] [tinyint] NULL,
	[UniqueCarrier] [varchar](5) NULL,
	[FlightNum] [varchar](5) NULL,
	[TailNum] [varchar](10) NULL,
	[Origin] [varchar](5) NULL,
	[Dest] [varchar](5) NULL,
	[Distance] [varchar](10) NULL,
	[TaxiIn] [varchar](3) NULL,
	[TaxiOut] [varchar](3) NULL,
	[Cancelled] [varchar](2) NULL,
	[CancellationCode] [varchar](5) NULL,
	[Diverted] [varchar](5) NULL,
	[CarrierDelay] [varchar](5) NULL,
	[WeatherDelay] [varchar](5) NULL,
	[NASDelay] [varchar](5) NULL,
	[SecurityDelay] [varchar](5) NULL,
	[LateAircraftDelay] [varchar](5) NULL,
	[ActualElapsedTime_int] [int] NULL,
	[AirTime] [int] NULL,
	[ArrDelay] [int] NULL,
	[DepDelay_int] [int] NULL,
	[CRSDepTime] [time](0) NULL,
	[ArrTime] [time](0) NULL,
	[DepTime] [time](0) NULL,
	[CRSArrTime] [time](0) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NA]    Script Date: 5/25/2022 9:54:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NA](
	[Year] [varchar](50) NULL,
	[Month] [varchar](50) NULL,
	[DayofMonth] [varchar](50) NULL,
	[DayOfWeek] [varchar](50) NULL,
	[DepTime] [varchar](50) NULL,
	[CRSDepTime] [varchar](50) NULL,
	[ArrTime] [varchar](50) NULL,
	[CRSArrTime] [varchar](50) NULL,
	[UniqueCarrier] [varchar](50) NULL,
	[FlightNum] [varchar](50) NULL,
	[TailNum] [varchar](50) NULL,
	[ActualElapsedTime] [varchar](50) NULL,
	[CRSElapsedTime] [varchar](50) NULL,
	[AirTime] [varchar](50) NULL,
	[ArrDelay] [varchar](50) NULL,
	[DepDelay] [varchar](50) NULL,
	[Origin] [varchar](50) NULL,
	[Dest] [varchar](50) NULL,
	[Distance] [varchar](50) NULL,
	[TaxiIn] [varchar](50) NULL,
	[TaxiOut] [varchar](50) NULL,
	[Cancelled] [varchar](50) NULL,
	[CancellationCode] [varchar](50) NULL,
	[Diverted] [varchar](50) NULL,
	[CarrierDelay] [varchar](2) NULL,
	[WeatherDelay] [varchar](50) NULL,
	[NASDelay] [varchar](50) NULL,
	[SecurityDelay] [varchar](50) NULL,
	[LateAircraftDelay] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PlaneData]    Script Date: 5/25/2022 9:54:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PlaneData](
	[TailNumber] [varchar](10) NULL,
	[OwnerType] [varchar](50) NULL,
	[Manufacturer] [varchar](50) NULL,
	[IssueDate] [varchar](50) NULL,
	[Model] [varchar](50) NULL,
	[Status] [varchar](50) NULL,
	[AircraftType] [varchar](50) NULL,
	[EngineType] [varchar](50) NULL,
	[Year] [varchar](50) NULL,
	[Copy of TailNumber] [varchar](10) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Routes]    Script Date: 5/25/2022 9:54:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Routes](
	[Origin] [varchar](3) NULL,
	[Destination] [varchar](10) NULL,
	[Distance] [varchar](10) NULL,
	[RouteID] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]
GO
USE [master]
GO
ALTER DATABASE [StagingArea] SET  READ_WRITE 
GO
