CREATE TABLE TestTable 
(
ID INT,
Data NVARCHAR(50)
)
GO

INSERT INTO TestTable
VALUES (1,'AABBCC'),
       (2,'FFDD'),
       (3,'TTHHJJKKLL')
GO

SELECT * FROM TestTable

CREATE TABLE #DestinationTable
(
ID INT,
Data NVARCHAR(50)
)
GO  
    SELECT * INTO #Temp FROM TestTable

    DECLARE @String NVARCHAR(2)
    DECLARE @Data NVARCHAR(50)
    DECLARE @ID INT

    WHILE EXISTS (SELECT * FROM #Temp)
     BEGIN 
        SELECT TOP 1 @Data =  DATA, @ID = ID FROM  #Temp

          WHILE LEN(@Data) > 0
            BEGIN
                SET @String = LEFT(@Data, 2)

                INSERT INTO #DestinationTable (ID, Data)
                VALUES (@ID, @String)

                SET @Data = RIGHT(@Data, LEN(@Data) -2)
            END
        DELETE FROM #Temp WHERE ID = @ID
     END


SELECT * FROM #DestinationTable

CREATE TABLE TestTable 
(
ID INT,
Data NVARCHAR(50)
)
GO

INSERT INTO TestTable
VALUES (1,'AABBCC'),
       (2,'FFDD'),
       (3,'TTHHJJKKLL')
GO

SELECT * FROM TestTable
My Suggestion

CREATE TABLE #DestinationTable
(
ID INT,
Data NVARCHAR(50)
)
GO  
    SELECT * INTO #Temp FROM TestTable

    DECLARE @String NVARCHAR(2)
    DECLARE @Data NVARCHAR(50)
    DECLARE @ID INT

    WHILE EXISTS (SELECT * FROM #Temp)
     BEGIN 
        SELECT TOP 1 @Data =  DATA, @ID = ID FROM  #Temp

          WHILE LEN(@Data) > 0
            BEGIN
                SET @String = LEFT(@Data, 2)

                INSERT INTO #DestinationTable (ID, Data)
                VALUES (@ID, @String)

                SET @Data = RIGHT(@Data, LEN(@Data) -2)
            END
        DELETE FROM #Temp WHERE ID = @ID
     END


SELECT * FROM #DestinationTable

DROP TABLE #Temp
DROP TABLE #DestinationTable