use ministryapp;
#DROP PROCEDURE getCoordinatesCongregation;

delimiter #

CREATE PROCEDURE getCoordinatesCongregation (in p_CongregationNumber VARCHAR(10))
BEGIN
if (select 1=1 from ministryapp.territorycard where CongregationNumber = p_CongregationNumber and bDefault = 1 group by CongregationNumber) then
begin
	SELECT 
		   trim(REPLACE(SUBSTRING(SUBSTRING_INDEX(LatLng, ',', 1),LENGTH(SUBSTRING_INDEX(LatLng, ',', 1 -1)) + 1),',', '')) as Latitude,
		   trim(REPLACE(SUBSTRING(SUBSTRING_INDEX(LatLng, ',', 2),LENGTH(SUBSTRING_INDEX(LatLng, ',', 2 -1)) + 1),',', '')) as Longitude
	FROM ministryapp.territorycard
	WHERE CongregationNumber = p_CongregationNumber AND bDefault = 1;
end;
else
begin
	SELECT Latitude,Longitude
	FROM ministryapp.congregation
	WHERE CongregationNumber = p_CongregationNumber;
end;
end if;
END#

delimiter ;