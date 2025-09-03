USE [swift]
GO
/****** Object:  StoredProcedure [trans].[sp_sel_mt103_ack_filenet]    Script Date: 07-07-2025 14:47:22 ******/

IF OBJECT_ID('[trans].[sp_sel_mt103_ack_filenet]', 'P') IS NOT NULL
    DROP PROCEDURE [trans].[sp_sel_mt103_ack_filenet];
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [trans].[sp_sel_mt103_ack_filenet]
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT 1
        FROM [trans].[sw_ope_mt_ack] a
        INNER JOIN [trans].[sw_ope_objetos_ack] b 
            ON a.trans_dsc_uetr = b.trans_dsc_uetr
        WHERE 
            CONVERT(VARCHAR(8), a.trans_fch_carga, 112) BETWEEN convert(varchar(8),getdate()-7,112) AND convert(varchar(8),getdate(),112) 
            AND a.trans_dsc_tipo_mensaje = 'MT103'
            AND (
                a.trans_dsc_ref_mensaje LIKE '753%' 
                OR a.trans_dsc_ref_mensaje LIKE '714%'
            )
    )
    BEGIN
        SELECT  
            cext01.ope.fn_elimina_caracteres(REPLACE(REPLACE(ltrim(rtrim(a.trans_dsc_ref_mensaje)), CHAR(13), ''), CHAR(10), '')) as trans_dsc_ref_mensaje,
            a.trans_fch_carga,
            a.trans_dsc_uetr
        FROM [trans].[sw_ope_mt_ack] a
        INNER JOIN [trans].[sw_ope_objetos_ack] b 
            ON a.trans_dsc_uetr = b.trans_dsc_uetr
        WHERE 
            CONVERT(VARCHAR(8), a.trans_fch_carga, 112) BETWEEN convert(varchar(8),getdate()-7,112) AND convert(varchar(8),getdate(),112) 
            AND a.trans_dsc_tipo_mensaje = 'MT103'
            AND (
                a.trans_dsc_ref_mensaje LIKE '753%' 
                OR a.trans_dsc_ref_mensaje LIKE '714%'
            )
            AND NOT EXISTS (
   							 SELECT 1
   							 FROM [trans].[ope_Filenet_ack] x
   							 WHERE x.trans_dsc_uetr = a.trans_dsc_uetr);
;
			--AND a.trans_dsc_uetr = '30c1c1d7-c2a9-4a25-abd6-a46089764d59';
    END
    ELSE
    BEGIN
        SELECT  
            'SIN DATOS' AS trans_dsc_ref_mensaje,
            NULL AS trans_fch_carga,
            NULL AS trans_dsc_uetr;
    END
END;
