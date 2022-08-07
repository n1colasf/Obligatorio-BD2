--STORED PROCEDURE
USE [OBLIGATORIOBD2]
GO

/****** Object:  StoredProcedure [dbo].[Cambiar_estacion_destino_de_linea]    Script Date: 07/08/2022 20:11:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Cambiar_estacion_destino_de_linea] 
	@numero_linea int,
	@codigo_estacion int
AS

DECLARE @parametro int
SET @parametro = 1
declare @Estacion_Final int

BEGIN
	SELECT 
	 @Estacion_Final=Codigo_Estacion_Final
	FROM
	LINEAS L
	WHERE
	Numero=@numero_linea
	
	IF 	@Estacion_Final <> @codigo_estacion
		UPDATE
		LINEAS 
		SET
		Codigo_Estacion_Final=@codigo_estacion, @parametro = 0
		WHERE
		Numero=@numero_linea

		PRINT @parametro


END
GO

--FUNCION
USE [OBLIGATORIOBD2]
GO

/****** Object:  UserDefinedFunction [dbo].[estacion_mas_trenes_fecha]    Script Date: 07/08/2022 20:13:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[estacion_mas_trenes_fecha]

(@desde datetime, @hasta datetime)

RETURNS varchar(50)

AS
BEGIN

declare @descripcion varchar (50)

set @descripcion = ( SELECT top 1 e.Descripcion
  from estaciones e 
  order By (select count(*) 
					from pasa p 
					where p.codigo_estacion = e.codigo and 
					p.fecha_hora >= @desde
					and p.fecha_hora < @hasta) DESC)


RETURN @descripcion


END
GO


