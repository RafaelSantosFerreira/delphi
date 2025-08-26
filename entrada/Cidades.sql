USE [dbTaura]
GO

/****** Object:  Table [dbo].[a006_cidades]    Script Date: 25/08/2025 14:55:41 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[a006_cidades](
	[a006_codigo] [nvarchar](12) NOT NULL,
	[a006_sequencial] [numeric](18, 0) NOT NULL,
	[a006_nome] [nvarchar](100) NOT NULL,
	[a006_uf] [nvarchar](12) NOT NULL,
	[a006_nro_habitantes] [numeric](18, 0) NOT NULL,
	[a006_descricao] [text] NOT NULL,
	[a006_cod_ibge] [nvarchar](50) NULL,
 CONSTRAINT [PK_a006_cidades] PRIMARY KEY CLUSTERED 
(
	[a006_codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[a006_cidades]  WITH NOCHECK ADD  CONSTRAINT [FK_a006_cidades_a005_estados] FOREIGN KEY([a006_uf])
REFERENCES [dbo].[a005_estados] ([a005_codigo])
GO

ALTER TABLE [dbo].[a006_cidades] NOCHECK CONSTRAINT [FK_a006_cidades_a005_estados]
GO

ALTER TABLE [dbo].[a006_cidades]  WITH CHECK ADD  CONSTRAINT [uf_cidade] FOREIGN KEY([a006_uf])
REFERENCES [dbo].[a005_estados] ([a005_codigo])
GO

ALTER TABLE [dbo].[a006_cidades] CHECK CONSTRAINT [uf_cidade]
GO

