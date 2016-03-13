

/****** purpose: mimick db.getCollection('rdicode').find({name: "Birthday prep", name22: "33311111"}) ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[USP_GET_COLLECTION_FIND]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[USP_GET_COLLECTION_FIND]
GO

/****** Object:  StoredProcedure [dbo].[USP_GET_COLLECTION_FIND]    Script Date: 03/13/2016 14:20:11 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*******
-- db.getCollection('rdicode').find({name: "Birthday prep", name22: "33311111"})
DECLARE @RC int
DECLARE @VAR_COLLECTION nvarchar(100)
DECLARE @VAR_QRY        nvarchar(100)
select @VAR_COLLECTION  = 'BUICs';
select @VAR_QRY         = 'BUICs';

EXECUTE @RC = [iclicker22].[dbo].[USP_GET_COLLECTION_FIND] 
   @VAR_COLLECTION --, @VAR_COLLECTION
   SELECT @RC;
GO

*******/
CREATE PROCEDURE [dbo].[USP_GET_COLLECTION_FIND]
	@VAR_COLLECTION	NVARCHAR(100)
   --,@VAR_QRY_LEFT  	NVARCHAR(100)
   --,@VAR_QRY_OP  	NVARCHAR(100) 
   --,@VAR_QRY_RIGHT 	NVARCHAR(100)
AS
BEGIN

--SET @VAR_QRY_LEFT  = RTRIM(@VAR_QRY_LEFT);
--SET @VAR_QRY_OP    = RTRIM(@VAR_QRY_OP);
--SET @VAR_QRY_RIGHT = RTRIM(@VAR_QRY_LEFT);

PRINT '@VAR_COLLECTION = ' +@VAR_COLLECTION;
--PRINT '@VAR_COLLECTION = ' +@VAR_QRY_LEFT;
--PRINT '@VAR_COLLECTION = ' +@VAR_QRY_OP;
--PRINT '@VAR_COLLECTION = ' +@VAR_QRY_RIGHT;




-- lookup table
	SET  @VAR_COLLECTION  =(select XmlCol.value('(/*/name/node())[1]', 'nvarchar(max)') as Name
		FROM TCollections
		where  XmlCol.value('(/*/name/node())[1]', 'nvarchar(max)')  like @VAR_COLLECTION);
	
	PRINT '@VAR_COLLECTION = ' +@VAR_COLLECTION ;

	IF @VAR_COLLECTION IS NULL
	BEGIN
		RETURN 101;
	END
  
  DECLARE @VAR_LEFT_NODE nvarchar(100); 
 SET @VAR_LEFT_NODE  = '(/*/name/node())[1]'; --RTRIM(@VAR_QRY_LEFT);    
SELECT 
 XmlCol.query('/*') as buic
--  XmlCol.value('(/*/name/node())[1]', 'nvarchar(max)') as Name
--, XmlCol.value('(/*/lastmodified/node())[1]', 'nvarchar(max)') as lastModified
--, XmlCol.query('/*/lastmodified') as lastModified
--, XmlCol.query('/*/version') as version
--, XmlCol.query('/*/name') as Name

,*
FROM TBuics
--where  XmlCol.value((sql:variable("@VAR_LEFT_NODE"))()[1]', 'nvarchar(max)')  like '%seedDemo001%'
where  XmlCol.value('(/*/name/node())[1]', 'nvarchar(max)')  like '%seedDemo001%'

--SELECT TOP 1 SELL_PRICE
--   FROM  UT_ISBN_PRICE_INFO
--WHERE ISBN = @VAR_ISBN;

END
GO


