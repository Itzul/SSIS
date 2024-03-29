﻿USE [master]
GO
/****** Object:  Database [DW]    Script Date: 5/25/2022 9:55:22 AM ******/
CREATE DATABASE [DW]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DW', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\DW.mdf' , SIZE = 12615680KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'DW_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\DW_log.ldf' , SIZE = 21790720KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [DW] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DW].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DW] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DW] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DW] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DW] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DW] SET ARITHABORT OFF 
GO
ALTER DATABASE [DW] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [DW] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DW] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DW] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DW] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DW] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DW] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DW] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DW] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DW] SET  DISABLE_BROKER 
GO
ALTER DATABASE [DW] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DW] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DW] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DW] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DW] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DW] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DW] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DW] SET RECOVERY FULL 
GO
ALTER DATABASE [DW] SET  MULTI_USER 
GO
ALTER DATABASE [DW] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DW] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DW] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DW] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [DW] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [DW] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'DW', N'ON'
GO
ALTER DATABASE [DW] SET QUERY_STORE = OFF
GO
USE [DW]
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimCarrier](
	[CarrierID] [varchar](5) NOT NULL,
	[Description] [varchar](60) NULL,
 CONSTRAINT [PK_DimCarrier] PRIMARY KEY CLUSTERED 
(
	[CarrierID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DimDate]    Script Date: 5/25/2022 9:55:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimDate](
	[DateID] [int] NOT NULL,
	[Date] [date] NULL,
	[FullDate] [varchar](25) NULL,
	[Year] [int] NULL,
	[YearMonth] [char](7) NULL,
	[QuarterText] [char](2) NULL,
	[QuarterNumber] [tinyint] NULL,
	[MonthText] [varchar](15) NULL,
	[MonthNumber] [tinyint] NULL,
	[Week] [tinyint] NULL,
	[DayOfWeekText] [varchar](10) NULL,
	[DayOfWeekNumber] [tinyint] NULL,
	[DayOfMonth] [tinyint] NULL,
	[Weekday] [tinyint] NULL,
PRIMARY KEY CLUSTERED 
(
	[DateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DimPlane]    Script Date: 5/25/2022 9:55:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimPlane](
	[Tailnumber] [varchar](10) NOT NULL,
	[OwnerType] [varchar](50) NULL,
	[Manufacturer] [varchar](50) NULL,
	[IssueDate] [varchar](50) NULL,
	[Model] [varchar](50) NULL,
	[Status] [varchar](50) NULL,
	[AircraftType] [varchar](50) NULL,
	[EngineType] [varchar](50) NULL,
	[Year] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[Tailnumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DimRoutes]    Script Date: 5/25/2022 9:55:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimRoutes](
	[RouteID] [int] NOT NULL,
	[Origin.Airport] [varchar](3) NULL,
	[Distance] [varchar](10) NULL,
	[Origin.AirportID] [varchar](5) NULL,
	[Origin.AirportName] [varchar](41) NULL,
	[Origin.City] [varchar](33) NULL,
	[Origin.State] [varchar](2) NULL,
	[Origin.Country] [varchar](30) NULL,
	[Origin.Latitude] [real] NULL,
	[Origin.Longitude] [real] NULL,
	[Destination] [varchar](3) NULL,
	[Destination.AirportID] [varchar](5) NULL,
	[Destination.AirportName] [varchar](41) NULL,
	[Destination.City] [varchar](33) NULL,
	[Destination.State] [varchar](2) NULL,
	[Destination.Country] [varchar](30) NULL,
	[Destination.Latitude] [real] NULL,
	[Destination.Longitude] [real] NULL,
PRIMARY KEY CLUSTERED 
(
	[RouteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FactFlight]    Script Date: 5/25/2022 9:55:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FactFlight](
	[CarrierID] [varchar](5) NULL,
	[RouteID] [int] NOT NULL,
	[DateID] [int] NOT NULL,
	[Date] [date] NOT NULL,
	[Year] [smallint] NULL,
	[Month] [tinyint] NULL,
	[DayofMonth] [tinyint] NULL,
	[DayOfWeek] [tinyint] NULL,
	[FlightNum] [varchar](5) NULL,
	[Tailnumber] [varchar](10) NOT NULL,
	[Origin] [varchar](5) NULL,
	[Destination] [varchar](5) NULL,
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
	[ActualElapsedTime] [int] NULL,
	[AirTime] [int] NULL,
	[ArrDelay] [int] NULL,
	[DepDelay] [int] NULL,
	[CRSDepTime] [time](0) NULL,
	[ArrTime] [time](0) NULL,
	[DepTime] [time](0) NULL,
	[CRSArrTime] [time](0) NULL,
	[FlightID] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_FlightID] PRIMARY KEY CLUSTERED 
(
	[FlightID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[FactFlight]  WITH CHECK ADD  CONSTRAINT [FK_CarrierID] FOREIGN KEY([CarrierID])
REFERENCES [dbo].[DimCarrier] ([CarrierID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[FactFlight] CHECK CONSTRAINT [FK_CarrierID]
GO
ALTER TABLE [dbo].[FactFlight]  WITH CHECK ADD  CONSTRAINT [FK_DimDate] FOREIGN KEY([DateID])
REFERENCES [dbo].[DimDate] ([DateID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[FactFlight] CHECK CONSTRAINT [FK_DimDate]
GO
ALTER TABLE [dbo].[FactFlight]  WITH CHECK ADD  CONSTRAINT [FK_RoutesID] FOREIGN KEY([RouteID])
REFERENCES [dbo].[DimRoutes] ([RouteID])
GO
ALTER TABLE [dbo].[FactFlight] CHECK CONSTRAINT [FK_RoutesID]
GO
ALTER TABLE [dbo].[FactFlight]  WITH CHECK ADD  CONSTRAINT [FK_Tailnumber] FOREIGN KEY([Tailnumber])
REFERENCES [dbo].[DimPlane] ([Tailnumber])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[FactFlight] CHECK CONSTRAINT [FK_Tailnumber]
GO
/****** Object:  StoredProcedure [dbo].[usp_FillDimDate]    Script Date: 5/25/2022 9:55:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[usp_FillDimDate] (@StartDate datetime2, @NoOfYears int)
as 
	begin
    set nocount on
set language swedish
declare @DateToAdd datetime2
declare @EndDate datetime2
declare @cnt int	
set @EndDate = dateadd(year, @NoOfYears, @StartDate)
set @DateToAdd = @StartDate
while @DateToAdd < @EndDate 
	begin
select @cnt = count(*) from DimDate 
where [DateID] = cast(convert(char(10), @DateToAdd, 112) as int) 
if @cnt = 0   -- datumet finns inte, lägg in det i DimDate-tabellen
	begin
insert into DimDate 
select 
cast(convert(char(10), @DateToAdd, 112) as int) as [DateID]	
, cast(convert(char(10), @DateToAdd, 120) as date) as [Date]		
, cast(format(@DateToAdd, 'D', 'sv-se') as varchar(25)) as [FullDate]	
, datepart(year, @DateToAdd) as [Year]			
, convert(char(7), @DateToAdd, 120) as [YearMonth]		
, 'Q' + cast(datename(quarter, @DateToAdd) as char(2)) as [QuarterText]		
, datepart(quarter, @DateToAdd) as [QuarterNumber]		
, datename(month, @DateToAdd) as [MonthText]		
, datepart(month, @DateToAdd) as [MonthNumber]
,CAST(DATEPART(ISO_WEEK, @DateToAdd) AS TINYINT) AS [Week]
, cast(datename(weekday, @DateToAdd) as varchar(10)) as [DayOfWeek]		
, datepart(weekday, @DateToAdd) as [DayOfWeekNumber]	
, datepart(day, @DateToAdd) as [DayOfMonth]		
, case when datepart(weekday, @DateToAdd) between 1 and 5	
then 1	
else 0 
end as [Weekday]

end
set @DateToAdd = dateadd(dd, 1, @DateToAdd)
end
set language us_english
set nocount off


end


GO
USE [master]
GO
ALTER DATABASE [DW] SET  READ_WRITE 
GO
