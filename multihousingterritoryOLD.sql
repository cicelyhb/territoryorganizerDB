
#DROP PROCEDURE multihousingterritory;

delimiter #

CREATE PROCEDURE multihousingterritory (in p_CongregationNumber VARCHAR(10), 
                                        in p_TerritoryNumber VARCHAR(10), 
                                        in p_bUnit TINYINT,
                                        in p_bMulti TINYINT)
BEGIN

if (p_bUnit = 1) then
begin 
SELECT 
		 a.TerritoryNumber
		,a.Latitude
		,a.Longitude
		,a.FormattedAddress
		,GetTerritoryXML(a.CongregationNumber,a.TerritoryNumber,a.PlaceID,1,0) Territory 
        ,COALESCE(c.BuildingName,d.BuildingDescription) Building
        ,a.PlaceID
FROM ministryapp.territory a 
INNER JOIN
	(
		 SELECT Latitude,
				Longitude,
                PlaceID,
                CongregationNumber,
                TerritoryNumber
		 FROM ministryapp.territory 
		 WHERE CongregationNumber= p_CongregationNumber AND
               TerritoryNumber= p_TerritoryNumber  AND
			   bUnit = 1 
		 GROUP BY Latitude,
				  Longitude,
                  PlaceID,
                  CongregationNumber,
                  TerritoryNumber
		 HAVING Count(*)>1 
	) b  ON   a.CongregationNumber=b.CongregationNumber AND a.TerritoryNumber=b.TerritoryNumber AND a.PlaceID=b.PlaceID
INNER JOIN ministryapp.building c      
         ON a.PlaceID=c.PlaceID AND a.CongregationNumber=c.CongregationNumber AND a.TerritoryNumber=c.TerritoryNumber
INNER JOIN ministryapp.buildingType d  
         ON c.BuildingType=d.BuildingType
WHERE a.bUnit = 1 
GROUP BY 
		 a.TerritoryNumber
		,a.Latitude
		,a.Longitude
		,a.FormattedAddress
        ,a.PlaceID
        
ORDER BY a.Latitude
		,a.Longitude
        ,a.FormattedAddress;
end;					
end if;
 
if (p_bMulti = 1) then
begin

 SELECT 
		 a.TerritoryNumber
		,a.Latitude
		,a.Longitude
		,a.FormattedXYAddress
		,GetTerritoryXML(a.CongregationNumber,a.TerritoryNumber,a.PlaceID,0,1) Territory 
        ,COALESCE(c.BuildingName,d.BuildingDescription) Building
        ,a.PlaceID
FROM ministryapp.territory a 
INNER JOIN
	(
		 SELECT Latitude,
				Longitude,
                PlaceID,
                CongregationNumber,
                TerritoryNumber
		 FROM ministryapp.territory 
		 WHERE CongregationNumber= p_CongregationNumber AND
               TerritoryNumber= p_TerritoryNumber  AND
			   bMulti = 1 
		 GROUP BY Latitude,
				  Longitude,
                  PlaceID,
                  CongregationNumber,
                  TerritoryNumber
		 HAVING Count(*)>1 
	) b  ON   a.CongregationNumber=b.CongregationNumber AND a.TerritoryNumber=b.TerritoryNumber AND a.PlaceID=b.PlaceID
INNER JOIN ministryapp.building c      
         ON a.PlaceID=c.PlaceID AND a.CongregationNumber=c.CongregationNumber AND a.TerritoryNumber=c.TerritoryNumber
INNER JOIN ministryapp.buildingType d  
         ON c.BuildingType=d.BuildingType
WHERE a.bMulti = 1 
GROUP BY 
		 a.TerritoryNumber
		,a.Latitude
		,a.Longitude
		,a.FormattedXYAddress
        ,a.PlaceID

ORDER BY a.Latitude
		,a.Longitude
        ,a.FormattedXYAddress;
end;
end if;
 
END#

delimiter ;