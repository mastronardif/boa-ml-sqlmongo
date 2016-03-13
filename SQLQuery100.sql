INSERT INTO TViews(XmlCol)
SELECT * FROM OPENROWSET(
   BULK 'C:\FxM\Dev\BOA-ML\jsonxarrayml.txt',
   SINGLE_BLOB) AS x;
   
   SELECT * FROM TViews
   
--CREATE TABLE TViews (_id int IDENTITY(1000,10),IntCol int, XmlCol xml);
GO   



SELECT 
  XmlCol.value('(Root/ProductDescription/@ProductModelID)[1]', 'nvarchar(max)') as Summary
, XmlCol.value('(Root/ProductDescription/Summary/node())[1]', 'nvarchar(max)') as Summary

--, XmlCol.nodes('(/root/employees', 'nvarchar(max)') as tag
, XmlCol.value('(root/employees/element/firstName/node())[1]', 'nvarchar(max)') as Name
--, XmlCol.nodes('(/root/glossary/GlossDiv/GlossList/GlossEntry', 'nvarchar(max)') as tag
,*
FROM TViews