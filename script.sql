USE [master]
GO
/****** Object:  Database [VideoRental]    Script Date: 15-02-2021 10:22:57 ******/
CREATE DATABASE [VideoRental]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'bk_Data', FILENAME = N'C:\Users\Bikramjeet Singh\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\MSSQLLocalDB\bk.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'bk_Log', FILENAME = N'C:\Users\Bikramjeet Singh\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\MSSQLLocalDB\bk.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [VideoRental] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [VideoRental].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [VideoRental] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [VideoRental] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [VideoRental] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [VideoRental] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [VideoRental] SET ARITHABORT OFF 
GO
ALTER DATABASE [VideoRental] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [VideoRental] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [VideoRental] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [VideoRental] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [VideoRental] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [VideoRental] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [VideoRental] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [VideoRental] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [VideoRental] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [VideoRental] SET  DISABLE_BROKER 
GO
ALTER DATABASE [VideoRental] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [VideoRental] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [VideoRental] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [VideoRental] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [VideoRental] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [VideoRental] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [VideoRental] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [VideoRental] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [VideoRental] SET  MULTI_USER 
GO
ALTER DATABASE [VideoRental] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [VideoRental] SET DB_CHAINING OFF 
GO
ALTER DATABASE [VideoRental] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [VideoRental] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [VideoRental] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [VideoRental] SET QUERY_STORE = OFF
GO
USE [VideoRental]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
USE [VideoRental]
GO
/****** Object:  User [RiaG]    Script Date: 15-02-2021 10:22:57 ******/
CREATE USER [RiaG] FOR LOGIN [RiaG] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_accessadmin] ADD MEMBER [RiaG]
GO
ALTER ROLE [db_datareader] ADD MEMBER [RiaG]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [RiaG]
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 15-02-2021 10:22:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[CustId] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](255) NULL,
	[LastName] [nvarchar](255) NULL,
	[Address] [nvarchar](255) NULL,
	[Phone] [nvarchar](50) NULL,
 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
(
	[CustId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Movie]    Script Date: 15-02-2021 10:22:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Movie](
	[MovieId] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](255) NULL,
	[ReleaseDate] [datetime] NULL,
	[RentalCost] [decimal](18, 2) NULL,
	[Genre] [nvarchar](255) NULL,
	[Plot] [nvarchar](255) NULL,
 CONSTRAINT [PK_Movie] PRIMARY KEY CLUSTERED 
(
	[MovieId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RentedMovies]    Script Date: 15-02-2021 10:22:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RentedMovies](
	[RentedMovieId] [int] IDENTITY(1,1) NOT NULL,
	[MovieId] [int] NULL,
	[CustId] [int] NULL,
	[DateRented] [datetime] NULL,
	[DateReturned] [datetime] NULL,
 CONSTRAINT [PK_RentedMovies] PRIMARY KEY CLUSTERED 
(
	[RentedMovieId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[RentedMoviesView]    Script Date: 15-02-2021 10:22:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[RentedMoviesView]
AS
SELECT        dbo.Customer.CustId, dbo.Customer.FirstName, dbo.Customer.LastName, dbo.Customer.Address, dbo.Customer.Phone, dbo.Movie.MovieId, dbo.Movie.Title, dbo.Movie.ReleaseDate, dbo.Movie.RentalCost, dbo.Movie.Genre, 
                         dbo.Movie.Plot, dbo.RentedMovies.RentedMovieId, dbo.RentedMovies.DateRented, dbo.RentedMovies.DateReturned
FROM            dbo.Customer INNER JOIN
                         dbo.RentedMovies ON dbo.Customer.CustId = dbo.RentedMovies.CustId INNER JOIN
                         dbo.Movie ON dbo.RentedMovies.MovieId = dbo.Movie.MovieId
GO
SET IDENTITY_INSERT [dbo].[Customer] ON 

INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (1, N'Clifton', N'Shelton', N'326 Academy Street', N'6722981')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (2, N'Lora ', N'Sherman', N'823 Church Street North', N'9564395')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (3, N'Dianne ', N'Shelton', N'484 4th Street North', N'2084708')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (4, N'Harlan ', N'Shields', N'111 Brook Lane', N'4434972')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (5, N'Bobbi ', N'Shannon', N'767 Route 17', N'7225220')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (6, N'Stan ', N'Short', N'875 Edgewood Drive', N'2615295')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (7, N'Leroy ', N'Shaw', N'936 Walnut Street', N'9245619')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (8, N'Tyson ', N'Shepherd', N'398 Pine Street', N'8346936')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (9, N'Laurel ', N'Short', N'955 Valley Drive', N'8406969')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (10, N'Therese ', N'Shepherd', N'226 Front Street South', N'9208849')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (11, N'Ulysses ', N'Shannon', N'529 2nd Avenue', N'5678883')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (12, N'Reuben ', N'Shaffer', N'570 Maiden Lane', N'6049232')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (13, N'Alberta ', N'Sharp', N'222 Route 1', N'5759347')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (14, N'Clara ', N'Shaw', N'807 Route 41', N'7739826')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (15, N'Hugh ', N'Silva', N'206 Main Street', N'8860054')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (16, N'Maxine ', N'Silva', N'305 Prospect Avenue', N'1371532')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (17, N'Shawn ', N'Simmons', N'130 Cooper Street', N'7642181')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (18, N'Van ', N'Singleton', N'775 Edgewood Drive', N'2582573')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (19, N'Ginger ', N'Simon', N'992 Holly Court', N'4053574')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (20, N'Laurence ', N'Simon', N'950 Maple Street', N'5374945')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (21, N'Brent ', N'Sims', N'276 Edgewood Drive', N'1166640')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (22, N'Faith ', N'Singleton', N'526 Virginia Avenue', N'7397034')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (23, N'Tina ', N'Simmons', N'864 Augusta Drive', N'5039366')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (24, N'Vanessa ', N'Sims', N'179 Mulberry Lane', N'3189437')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (25, N'Kyle ', N'Simpson', N'145 Amherst Street', N'7919511')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (26, N'Ellen ', N'Simpson', N'284 4th Street West', N'8419851')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (27, N'Reba ', N'Skinner', N'205 Creek Road', N'6646308')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (28, N'Pierre ', N'Skinner', N'713 Laurel Street', N'8139410')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (29, N'Lea ', N'Sloan', N'417 Chestnut Avenue', N'9980929')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (30, N'Maura ', N'Slater', N'997 Brookside Drive', N'8807197')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (31, N'James ', N'Smith', N'996 North Street', N'6483532')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (32, N'Benito ', N'Small', N'423 Aspen Drive', N'8504545')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (33, N'Mary ', N'Smith', N'747 19th Street', N'4628671')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (34, N'Marion ', N'Snyder', N'353 Orchard Avenue', N'5290108')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (35, N'Derrick ', N'Snyder', N'463 Summit Avenue', N'3000183')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (36, N'Adolfo ', N'Snow', N'584 1st Avenue', N'1426361')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (37, N'Maude ', N'Snow', N'156 Aspen Drive', N'4987086')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (38, N'Nina ', N'Soto', N'194 Route 2', N'8950939')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (39, N'Brianna ', N'Solomon', N'170 Oxford Road', N'3903502')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (40, N'Casey ', N'Soto', N'735 Mechanic Street', N'8994585')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (41, N'Vito ', N'Solomon', N'837 Railroad Avenue', N'7564841')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (42, N'Merrill ', N'Solis', N'623 Primrose Lane', N'6356176')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (43, N'Flossie ', N'Solis', N'608 Hilltop Road', N'9848984')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (44, N'Georgina ', N'Spears', N'894 Cherry Street', N'9151707')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (45, N'Kate ', N'Sparks', N'121 Adams Street', N'4742603')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (46, N'Derek ', N'Spencer', N'884 Academy Street', N'3712692')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (47, N'Liza ', N'Spence', N'120 Locust Street', N'3284008')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (48, N'Clay ', N'Sparks', N'121 Oak Avenue', N'8494860')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (49, N'Erich ', N'Spence', N'607 Cleveland Street', N'7488816')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (50, N'Cathy ', N'Spencer', N'149 Cross Street', N'1669859')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (51, N'Norris ', N'Stephenson', N'690 Sunset Drive', N'4220559')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (52, N'Gustavo ', N'Stokes', N'493 Linda Lane', N'9290724')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (53, N'Maricela ', N'Stout', N'767 Route 30', N'5991031')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (54, N'Dusty ', N'Stein', N'456 Cooper Street', N'8962750')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (55, N'Karl ', N'Stanley', N'370 Heritage Drive', N'6233475')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (56, N'Jamel ', N'Stout', N'661 Heritage Drive', N'3663709')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (57, N'Darrell ', N'Stephens', N'978 Railroad Street', N'9594260')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (58, N'Dianna ', N'Stokes', N'511 Country Club Drive', N'3424684')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (59, N'Ronnie ', N'Stone', N'961 Street Road', N'4315012')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (60, N'Corina ', N'Stanton', N'228 Sycamore Street', N'7515016')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (61, N'Charity ', N'Stephenson', N'889 Forest Street', N'1595456')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (62, N'Alice ', N'Stewart', N'849 Franklin Court', N'3665548')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (63, N'Monty ', N'Stafford', N'845 Heritage Drive', N'8595769')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (64, N'Gabriela ', N'Stafford', N'113 Virginia Avenue', N'1336779')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (65, N'Roderick ', N'Stevenson', N'579 Route 64', N'8476909')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (66, N'Coleen ', N'Stuart', N'789 Sycamore Lane', N'9347154')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (67, N'Ilene ', N'Stein', N'661 Garfield Avenue', N'7177459')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (68, N'Kareem ', N'Stark', N'788 Warren Street', N'7837590')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (69, N'Evan ', N'Steele', N'599 Elm Avenue', N'7657624')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (70, N'Elaine ', N'Stevens', N'766 Woodland Avenue', N'3067661')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (71, N'Ophelia ', N'Stark', N'222 Briarwood Drive', N'1588147')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (72, N'Joe ', N'Stewart', N'640 Buttonwood Drive', N'6968782')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (73, N'Frieda ', N'Strong', N'702 Amherst Street', N'1519153')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (74, N'Carmen ', N'Strong', N'389 Briarwood Drive', N'4299984')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (75, N'Virgil ', N'Sutton', N'759 Aspen Drive', N'4540061')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (76, N'Winifred ', N'Summers', N'730 Prospect Avenue', N'2140812')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (77, N'Jerald ', N'Summers', N'808 Ridge Road', N'6962296')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (78, N'Mallory ', N'Suarez', N'196 Park Street', N'9436127')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (79, N'Dawn ', N'Sullivan', N'712 Pin Oak Drive', N'8337102')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (80, N'Felicia ', N'Sutton', N'209 Delaware Avenue', N'9717774')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (81, N'Mike ', N'Sullivan', N'989 Hillside Drive', N'3319989')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (82, N'Erma ', N'Swanson', N'413 Briarwood Drive', N'6660191')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (83, N'Lacy ', N'Sweet', N'625 Cardinal Drive', N'3492839')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (84, N'Angeline ', N'Sweeney', N'845 Colonial Drive', N'6343179')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (85, N'Stacey ', N'Sweeney', N'892 State Street', N'4793661')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (86, N'Noel ', N'Swanson', N'148 8th Street', N'8906542')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (87, N'Merle ', N'Sykes', N'926 Colonial Drive', N'2117643')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (88, N'Willis ', N'Tate', N'614 Olive Street', N'7471018')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (89, N'Yvette ', N'Tate', N'112 Cypress Court', N'7343379')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (90, N'Thomas ', N'Taylor', N'496 Route 1', N'2934108')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (91, N'Mara ', N'Talley', N'475 Route 70', N'6185505')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (92, N'Dorothy ', N'Taylor', N'924 Jefferson Street', N'5136696')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (93, N'Diego ', N'Tanner', N'657 Morris Street', N'1756986')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (94, N'Carmela ', N'Tanner', N'765 Lafayette Avenue', N'5959838')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (95, N'Laverne ', N'Terrell', N'296 Country Lane', N'7414435')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (96, N'Ken ', N'Terry', N'823 Willow Street', N'5424913')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (97, N'Hillary ', N'Terrell', N'251 Schoolhouse Lane', N'7536401')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (98, N'Jennie ', N'Terry', N'861 Front Street South', N'3776862')
INSERT [dbo].[Customer] ([CustId], [FirstName], [LastName], [Address], [Phone]) VALUES (99, N'Daniel ', N'Thomas', N'476 Lafayette Avenue', N'6460697')
GO
SET IDENTITY_INSERT [dbo].[Customer] OFF
GO
SET IDENTITY_INSERT [dbo].[Movie] ON 

INSERT [dbo].[Movie] ([MovieId], [Title], [ReleaseDate], [RentalCost], [Genre], [Plot]) VALUES (1, N'Spiderman', CAST(N'2011-01-01T00:00:00.000' AS DateTime), CAST(2.00 AS Decimal(18, 2)), N'Adventure', N'A great movie to watch')
INSERT [dbo].[Movie] ([MovieId], [Title], [ReleaseDate], [RentalCost], [Genre], [Plot]) VALUES (2, N'Eragon', CAST(N'2014-01-01T00:00:00.000' AS DateTime), CAST(2.00 AS Decimal(18, 2)), N'Adventure', N'A great movie to watch')
INSERT [dbo].[Movie] ([MovieId], [Title], [ReleaseDate], [RentalCost], [Genre], [Plot]) VALUES (3, N'Pirates of Carribean', CAST(N'2002-01-01T00:00:00.000' AS DateTime), CAST(2.00 AS Decimal(18, 2)), N'Adventure', N'A great movie to watch')
INSERT [dbo].[Movie] ([MovieId], [Title], [ReleaseDate], [RentalCost], [Genre], [Plot]) VALUES (4, N'Holloween', CAST(N'2000-01-01T00:00:00.000' AS DateTime), CAST(2.00 AS Decimal(18, 2)), N'Adventure/Action', N'A great movie to watch')
INSERT [dbo].[Movie] ([MovieId], [Title], [ReleaseDate], [RentalCost], [Genre], [Plot]) VALUES (5, N'Freddy', CAST(N'2013-01-01T00:00:00.000' AS DateTime), CAST(2.00 AS Decimal(18, 2)), N'Horror', N'A great movie to watch')
INSERT [dbo].[Movie] ([MovieId], [Title], [ReleaseDate], [RentalCost], [Genre], [Plot]) VALUES (6, N'HollowMan', CAST(N'2015-01-01T00:00:00.000' AS DateTime), CAST(5.00 AS Decimal(18, 2)), N'Action/Romance', N'A great movie to watch')
INSERT [dbo].[Movie] ([MovieId], [Title], [ReleaseDate], [RentalCost], [Genre], [Plot]) VALUES (7, N'Mr Bond 007', CAST(N'1990-01-01T00:00:00.000' AS DateTime), CAST(2.00 AS Decimal(18, 2)), N'Action/Romance', N'A great movie to watch')
INSERT [dbo].[Movie] ([MovieId], [Title], [ReleaseDate], [RentalCost], [Genre], [Plot]) VALUES (8, N'Karate Kid', CAST(N'2010-01-01T00:00:00.000' AS DateTime), CAST(2.00 AS Decimal(18, 2)), N'Action', N'A great movie to watch')
INSERT [dbo].[Movie] ([MovieId], [Title], [ReleaseDate], [RentalCost], [Genre], [Plot]) VALUES (9, N'Superman', CAST(N'2000-01-01T00:00:00.000' AS DateTime), CAST(2.00 AS Decimal(18, 2)), N'Adventure', N'A great movie to watch')
INSERT [dbo].[Movie] ([MovieId], [Title], [ReleaseDate], [RentalCost], [Genre], [Plot]) VALUES (10, N'DeadPool', CAST(N'2019-01-01T00:00:00.000' AS DateTime), CAST(5.00 AS Decimal(18, 2)), N'Action', N'A great movie to watch')
INSERT [dbo].[Movie] ([MovieId], [Title], [ReleaseDate], [RentalCost], [Genre], [Plot]) VALUES (11, N'Terminator', CAST(N'2016-08-01T00:00:00.000' AS DateTime), CAST(5.00 AS Decimal(18, 2)), N'Action', N'A great Movie to watch')
INSERT [dbo].[Movie] ([MovieId], [Title], [ReleaseDate], [RentalCost], [Genre], [Plot]) VALUES (12, N'Teeth', CAST(N'2016-12-09T00:00:00.000' AS DateTime), CAST(5.00 AS Decimal(18, 2)), N'Horror/Thriller', N'A great Movie to Watch')
INSERT [dbo].[Movie] ([MovieId], [Title], [ReleaseDate], [RentalCost], [Genre], [Plot]) VALUES (13, N'Teeth', CAST(N'2016-12-09T00:00:00.000' AS DateTime), CAST(5.00 AS Decimal(18, 2)), N'Thriller', N'A great movie to watch')
SET IDENTITY_INSERT [dbo].[Movie] OFF
GO
SET IDENTITY_INSERT [dbo].[RentedMovies] ON 

INSERT [dbo].[RentedMovies] ([RentedMovieId], [MovieId], [CustId], [DateRented], [DateReturned]) VALUES (1, 1, 1, CAST(N'2020-12-09T18:33:11.660' AS DateTime), CAST(N'2020-12-09T18:33:20.077' AS DateTime))
INSERT [dbo].[RentedMovies] ([RentedMovieId], [MovieId], [CustId], [DateRented], [DateReturned]) VALUES (2, 2, 1, CAST(N'2020-12-09T21:14:47.973' AS DateTime), CAST(N'2020-12-09T21:17:49.037' AS DateTime))
INSERT [dbo].[RentedMovies] ([RentedMovieId], [MovieId], [CustId], [DateRented], [DateReturned]) VALUES (3, 4, 3, CAST(N'2020-12-10T13:12:33.623' AS DateTime), CAST(N'2020-12-10T13:12:40.233' AS DateTime))
SET IDENTITY_INSERT [dbo].[RentedMovies] OFF
GO
ALTER TABLE [dbo].[RentedMovies]  WITH CHECK ADD  CONSTRAINT [FK_RentedMovies_RentedMovies] FOREIGN KEY([RentedMovieId])
REFERENCES [dbo].[RentedMovies] ([RentedMovieId])
GO
ALTER TABLE [dbo].[RentedMovies] CHECK CONSTRAINT [FK_RentedMovies_RentedMovies]
GO
/****** Object:  StoredProcedure [dbo].[spGetAllCustomers]    Script Date: 15-02-2021 10:22:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spGetAllCustomers]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * from Customer;
END
GO
/****** Object:  StoredProcedure [dbo].[spGetAllRentedVideos]    Script Date: 15-02-2021 10:22:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spGetAllRentedVideos]  
AS  
BEGIN  
    -- SET NOCOUNT ON added to prevent extra result sets from  
    -- interfering with SELECT statements.  
    SET NOCOUNT ON;  
  
    -- Select statements for procedure here  
    Select * from RentedMovies  
END
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Customer"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "Movie"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 136
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "RentedMovies"
            Begin Extent = 
               Top = 6
               Left = 454
               Bottom = 136
               Right = 624
            End
            DisplayFlags = 280
            TopColumn = 1
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'RentedMoviesView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'RentedMoviesView'
GO
USE [master]
GO
ALTER DATABASE [VideoRental] SET  READ_WRITE 
GO
