USE [swift]
GO

IF OBJECT_ID('[trans].[ope_Filenet_ack]', 'U') IS NOT NULL
BEGIN
    DROP TABLE [trans].[ope_Filenet_ack];
END
GO

/****** Object:  Table [trans].[ope_Filenet_ack]    Script Date: 07-07-2025 15:27:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [trans].[ope_Filenet_ack](
	[trans_dsc_uetr] [nvarchar](255) NOT NULL,
	[trans_dsc_ref_mensaje] [nvarchar](1000) NULL,
	[trans_fch_carga] [datetime] NULL,
	[trans_status] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[trans_dsc_uetr] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


