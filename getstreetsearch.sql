#DROP PROCEDURE getstreetsearch;

delimiter #

CREATE PROCEDURE getstreetsearch (in p_CongregationNumber VARCHAR(10))
BEGIN

CREATE TEMPORARY Table IF NOT EXISTS listTable1
(
rid bigint not null primary key auto_increment,
StreetNumber varchar(10) ,
Street varchar(50) ,
StreetSuffix varchar(10) ,
FormattedAddress varchar(255) ,
Latitude varchar(50) ,
Longitude varchar(50) ,
TerritoryNumber varchar(10),
Type varchar(10) ,
bPhone tinyint,
bTouched tinyint
); 

INSERT INTO listTable1(StreetNumber,Street,StreetSuffix,FormattedAddress,Latitude,Longitude,TerritoryNumber,Type,bPhone,bTouched)
SELECT RTRIM(LEFT(FormattedAddress,INSTR(FormattedAddress,' '))) StreetNumber,Street,StreetSuffix,FormattedAddress,Latitude,Longitude,TerritoryNumber,Type,bPhone,bTouched
FROM ministryapp.streets s
INNER JOIN ministryapp.territory t ON s.AddressGUID=t.AddressGUID
WHERE t.CongregationNumber = p_CongregationNumber
ORDER BY Street,StreetSuffix,RTRIM(LEFT(FormattedAddress,INSTR(FormattedAddress,' ')));

SELECT rid,FormattedAddress,Latitude,Longitude,TerritoryNumber,Type,bPhone,bTouched
FROM listTable1
ORDER BY rid;
 
 
DROP TEMPORARY TABLE IF EXISTS listTable1; 
END#

delimiter ;