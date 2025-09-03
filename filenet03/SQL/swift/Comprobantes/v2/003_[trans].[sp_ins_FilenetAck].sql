USE [swift]
GO
/****** Object:  StoredProcedure [trans].[sp_ins_FilenetAck]    Script Date: 07-07-2025 15:43:02 ******/

IF OBJECT_ID('[trans].[sp_ins_FilenetAck]', 'P') IS NOT NULL
    DROP PROCEDURE [trans].[sp_ins_FilenetAck];
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [trans].[sp_ins_FilenetAck]
    @trans_dsc_uetr NVARCHAR(255),
    @trans_dsc_ref_mensaje NVARCHAR(1000) = NULL,
    @trans_fch_carga DATETIME = NULL,
	@trans_status NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        INSERT INTO [trans].[ope_Filenet_ack] (
            trans_dsc_uetr,
            trans_dsc_ref_mensaje,
            trans_fch_carga,
			trans_status
        )
        VALUES (
            @trans_dsc_uetr,
            @trans_dsc_ref_mensaje,
            ISNULL(@trans_fch_carga, GETDATE()),
			@trans_status
        );
    END TRY
    BEGIN CATCH
        -- Manejo de errores
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR('Error al insertar en [trans].[ope_Filenet_ack]: %s', 16, 1, @ErrorMessage);
    END CATCH
END;
