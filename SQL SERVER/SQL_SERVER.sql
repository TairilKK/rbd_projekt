--EXEC sp_addlinkedserver
--	'HOTEL', '', 'OraOLEDB.Oracle', 'pd19';

--EXEC sp_addlinkedsrvlogin
--	'HOTEL', 'FALSE', 'sa', 'rbdhotel', '12345';

--CREATE DATABASE RBDHOTEL
--GO

--USE RBDHOTEL
--GO

-------------- --------------------- -------------- 
-------------- -- PERSONEL HOTELU -- -------------- 
-------------- --------------------- -------------- 
CREATE OR ALTER PROCEDURE UTWORZ_WIDOK_PERSONEL_HOTELU
    @ID_HOTELU INT
AS
BEGIN
    DECLARE @SQL NVARCHAR(MAX);

    SET @SQL = '
        CREATE OR ALTER VIEW PERSONEL_HOTELU AS
        SELECT * FROM HOTEL..RBDHOTEL.PERSONEL
        WHERE ID_HOTELU = ' + CAST(@ID_HOTELU AS NVARCHAR(10)) + ';
    ';

    EXEC sp_executesql @SQL;
END;
GO

--EXEC UTWORZ_WIDOK_PERSONEL_HOTELU @ID_HOTELU = 1;
--GO

--select * from PERSONEL_HOTELU;
--GO

-------------- ------------------- -------------- 
-------------- -- POKOJE HOTELU -- -------------- 
-------------- ------------------- -------------- 
CREATE OR ALTER PROCEDURE UTWORZ_WIDOK_POKOJE_HOTELU
    @ID_HOTELU INT
AS
BEGIN
    DECLARE @SQL NVARCHAR(MAX);

    SET @SQL = '
        CREATE OR ALTER VIEW POKOJE_HOTELU AS
        SELECT * FROM HOTEL..RBDHOTEL.POKOJE
        WHERE ID_HOTELU = ' + CAST(@ID_HOTELU AS NVARCHAR(10)) + ';
    ';

    EXEC sp_executesql @SQL;
END;
GO

--EXEC UTWORZ_WIDOK_POKOJE_HOTELU @ID_HOTELU = 1;
--GO

--select * from POKOJE_HOTELU;
--GO

-------------- ------------------------- -------------- 
-------------- -- WYPOSAZENIE POKOJOW -- -------------- 
-------------- ------------------------- -------------- 
CREATE OR ALTER PROCEDURE UTWORZ_WIDOK_WYPOSAZENIE_POKOJOW_HOTELU
    @ID_HOTELU INT
AS
BEGIN
    DECLARE @SQL NVARCHAR(MAX);

    SET @SQL = '
        CREATE OR ALTER VIEW WYPOSAZENIE_POKOJOW_HOTELU AS
        SELECT p.NR_POKOJU, w.NAZWA, w.ILOSC FROM HOTEL..RBDHOTEL.WYPOSAZENIE w JOIN 
		HOTEL..RBDHOTEL.POKOJE p on w.ID_POKOJU = p.ID_POKOJU
        WHERE p.ID_HOTELU = ' + CAST(@ID_HOTELU AS NVARCHAR(10)) + ';
    ';

    EXEC sp_executesql @SQL;
END;
GO

--EXEC UTWORZ_WIDOK_WYPOSAZENIE_POKOJOW_HOTELU @ID_HOTELU = 1;
--GO

--select * from WYPOSAZENIE_POKOJOW_HOTELU;
--GO

-------------- ------------------------ -------------- 
-------------- -- WYPOSAZENIE POKOJU -- -------------- 
-------------- ------------------------ -------------- 
CREATE FUNCTION WYPOSAZENIE_POKOJU(
@NR_POKOJU INT
)
RETURNS TABLE
AS
RETURN
(
    SELECT * FROM WYPOSAZENIE_POKOJOW_HOTELU
    WHERE NR_POKOJU = @NR_POKOJU
);
GO

--SELECT * FROM WYPOSAZENIE_POKOJU(201);
--GO

-------------- ---------------------------- -------------- 
-------------- -- DO POSPRZATANIA POKOJU -- -------------- 
-------------- ---------------------------- -------------- 
CREATE OR ALTER FUNCTION DO_POSPRZATANIA()
RETURNS TABLE
AS
RETURN
(
    SELECT * FROM POKOJE_HOTELU
    WHERE POSPRZATANY <> 'TAK'
);
GO
--SELECT * FROM DO_POSPRZATANIA();
--GO

-------------- ----------------------- -------------- 
-------------- -- DO NAPRAWY POKOJU -- -------------- 
-------------- ----------------------- -------------- 
CREATE OR ALTER FUNCTION DO_NAPRAWY()
RETURNS TABLE
AS
RETURN
(
    SELECT * FROM POKOJE_HOTELU
    WHERE WYMAGA_NAPRAWY <> 'NIE'
);
GO
--SELECT * FROM DO_NAPRAWY();
--GO