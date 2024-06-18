--EXEC sp_addlinkedserver
--	'HOTEL', '', 'OraOLEDB.Oracle', 'pd19';

EXEC sp_addlinkedsrvlogin
	'HOTEL', 'FALSE', 'rbd_konserwacja', 'rbdhotel', '12345';

--CREATE DATABASE RBDHOTEL
--GO