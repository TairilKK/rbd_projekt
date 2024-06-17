-- Wszystkio co zawiea schemat dbo
------------------------------------
USE [RBDHOTEL]
GO
-------------- --------------------- -------------- 
-------------- -- PERSONEL HOTELU -- -------------- 
-------------- --------------------- -------------- 
CREATE OR ALTER PROCEDURE dbo.UTWORZ_WIDOK_PERSONEL_HOTELU
    @ID_HOTELU INT
AS
BEGIN
    DECLARE @SQL NVARCHAR(MAX);

    SET @SQL = '
        CREATE OR ALTER VIEW wlasciciel.PERSONEL_HOTELU AS
        SELECT * FROM HOTEL..RBDHOTEL.PERSONEL
        WHERE ID_HOTELU = ' + CAST(@ID_HOTELU AS NVARCHAR(10)) + ';
    ';

    EXEC sp_executesql @SQL;
END;
GO
-------------- ------------------- -------------- 
-------------- -- POKOJE HOTELU -- -------------- 
-------------- ------------------- -------------- 
CREATE OR ALTER PROCEDURE dbo.UTWORZ_WIDOK_POKOJE_HOTELU
    @ID_HOTELU INT
AS
BEGIN
    DECLARE @SQL NVARCHAR(MAX);

    SET @SQL = '
        CREATE OR ALTER VIEW [recepcja].POKOJE_HOTELU AS
        SELECT * FROM HOTEL..RBDHOTEL.POKOJE
        WHERE ID_HOTELU = ' + CAST(@ID_HOTELU AS NVARCHAR(10)) + ';
    ';

    EXEC sp_executesql @SQL;
END;
GO
-------------- ------------------------- -------------- 
-------------- -- WYPOSAZENIE POKOJOW -- -------------- 
-------------- ------------------------- -------------- 
CREATE OR ALTER PROCEDURE dbo.UTWORZ_WIDOK_WYPOSAZENIE_POKOJOW_HOTELU
    @ID_HOTELU INT
AS
BEGIN
    DECLARE @SQL NVARCHAR(MAX);

    SET @SQL = '
        CREATE OR ALTER VIEW wlasciciel.WYPOSAZENIE_POKOJOW_HOTELU AS
        SELECT p.NR_POKOJU, w.NAZWA, w.ILOSC FROM HOTEL..RBDHOTEL.WYPOSAZENIE w JOIN 
		HOTEL..RBDHOTEL.POKOJE p on w.ID_POKOJU = p.ID_POKOJU
        WHERE p.ID_HOTELU = ' + CAST(@ID_HOTELU AS NVARCHAR(10)) + ';
    ';

    EXEC sp_executesql @SQL;
END;
GO

-------------- ------------------------------ -------------- 
-------------- -- TWORZENIE WIDOKOW HOTELU -- -------------- 
-------------- ------------------------------ -------------- 
DECLARE
	@ID_HOTELU INT = 1
BEGIN
	EXEC UTWORZ_WIDOK_PERSONEL_HOTELU @ID_HOTELU;
	EXEC UTWORZ_WIDOK_POKOJE_HOTELU @ID_HOTELU;
	EXEC UTWORZ_WIDOK_WYPOSAZENIE_POKOJOW_HOTELU @ID_HOTELU;

END;