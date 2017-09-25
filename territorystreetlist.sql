

#DROP PROCEDURE territorystreetlist;

delimiter #

CREATE PROCEDURE territorystreetlist (in p_CongregationNumber VARCHAR(10),in p_TerritoryNumber VARCHAR(10))
BEGIN
declare startdate datetime;

SET startdate = CONVERT('2016-01-01',DATETIME);

CREATE TEMPORARY Table IF NOT EXISTS listTable1
(
rid bigint not null primary key auto_increment,
Street varchar(50) not null,
StreetSuffix varchar(10) null,
Total int not null
); 

CREATE TEMPORARY Table IF NOT EXISTS listTable2
(
rid bigint not null primary key auto_increment,
Street varchar(50) not null,
StreetSuffix varchar(10) null,
Modified int not null
); 

INSERT INTO listTable1
            (
				Street,
				StreetSuffix,
				Total
			) 
SELECT 			Street
			   ,StreetSuffix
	           ,Count(*)
FROM ministryapp.streets s 
INNER JOIN ministryapp.territory t ON s.AddressGUID=t.AddressGUID
WHERE CongregationNumber = p_CongregationNumber AND TerritoryNumber = p_TerritoryNumber 
GROUP BY Street
        ,StreetSuffix
ORDER BY Street
	    ,StreetSuffix;
        
        
INSERT INTO listTable2
            (
				Street,
				StreetSuffix,
				Modified
			) 
SELECT 			Street
			   ,StreetSuffix
	           ,Count(*) 
FROM ministryapp.streets s
INNER JOIN ministryapp.territory t ON s.AddressGUID=t.AddressGUID
WHERE CongregationNumber = p_CongregationNumber AND TerritoryNumber = p_TerritoryNumber AND DateModified >= startdate
GROUP BY Street
        ,StreetSuffix
ORDER BY Street
	    ,StreetSuffix;        
        



SELECT a.Street,a.StreetSuffix, CONVERT((COALESCE(Modified,0)/Total) * 100,SIGNED) Percentage, CONVERT(COALESCE(Modified,0),SIGNED) Modified ,Total, IFNULL(DNC,0) DNC, IFNULL(cPhone,0) Phone, IFNULL(cLetter,0) Letter, IFNULL(cNH,0) NH
FROM listTable1 a 
LEFT JOIN listTable2 b ON a.Street=b.Street AND a.StreetSuffix=b.StreetSuffix
LEFT JOIN 
 (    
SELECT 			Street
			   ,StreetSuffix
	           ,count(1) DNC
FROM ministryapp.streets s
INNER JOIN ministryapp.territory t ON s.AddressGUID=t.AddressGUID
WHERE Type='DNC' AND CongregationNumber = p_CongregationNumber AND TerritoryNumber = p_TerritoryNumber
GROUP BY   CongregationNumber,
		   TerritoryNumber,
           Street,
           StreetSuffix
) c           
ON a.Street=c.Street AND a.StreetSuffix=c.StreetSuffix
LEFT JOIN 
 (    
SELECT 			Street
			   ,StreetSuffix
	           ,count(1) cPhone
FROM ministryapp.streets s
INNER JOIN ministryapp.territory t ON s.AddressGUID=t.AddressGUID
WHERE bPhone = 1 AND CongregationNumber = p_CongregationNumber AND TerritoryNumber = p_TerritoryNumber
GROUP BY   CongregationNumber,
		   TerritoryNumber,
           Street,
           StreetSuffix    
) d           
ON a.Street=d.Street AND a.StreetSuffix=d.StreetSuffix
LEFT JOIN 
 (    
SELECT 			Street
			   ,StreetSuffix
	           ,count(1) cletter
FROM ministryapp.streets s
INNER JOIN ministryapp.territory t ON s.AddressGUID=t.AddressGUID
WHERE Type = 'WL' AND CongregationNumber = p_CongregationNumber AND TerritoryNumber = p_TerritoryNumber
GROUP BY   CongregationNumber,
		   TerritoryNumber,
           Street,
           StreetSuffix    
) e           
ON a.Street=e.Street AND a.StreetSuffix=e.StreetSuffix
LEFT JOIN 
 (    
SELECT 			Street
			   ,StreetSuffix
	           ,count(1) cNH
FROM ministryapp.streets s
INNER JOIN ministryapp.territory t ON s.AddressGUID=t.AddressGUID
WHERE Type = 'NH' AND bTouched = 1 AND CongregationNumber = p_CongregationNumber AND TerritoryNumber = p_TerritoryNumber
GROUP BY   CongregationNumber,
		   TerritoryNumber,
           Street,
           StreetSuffix    
) f           
ON a.Street=f.Street AND a.StreetSuffix=f.StreetSuffix
ORDER BY a.RID;

DROP TEMPORARY TABLE IF EXISTS listTable1;
DROP TEMPORARY TABLE IF EXISTS listTable2;
END#

delimiter ;