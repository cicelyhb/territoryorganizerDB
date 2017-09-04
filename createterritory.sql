#DROP PROCEDURE createterritory;

delimiter #

CREATE PROCEDURE createterritory (
                                in p_CongregationNumber VARCHAR(10),                                
                                in p_TerritoryNumber VARCHAR(10),
                                in p_LatLng VARCHAR(100),
                                in p_Boundary VARCHAR(250),
                                in p_NorthArrow VARCHAR(100),
                                in p_Zoom SMALLINT,
                                in p_Polygon TEXT
                              )
BEGIN
declare vUserID bigint;

if (select 1=1 from ministryapp.congregation where CongregationNumber = p_CongregationNumber and TerritoryNumber = p_TerritoryNumber) then
begin
	SELECT 1 'Error', 'Territory already exist' Message;   
end;
else
begin    
    INSERT INTO ministryapp.territorycard (CongregationNumber,TerritoryNumber,LatLng,Boundary,NorthArrow,Zoom,Polygon)
		                         VALUES   (p_CongregationNumber,p_TerritoryNumbe,p_LatLng,p_Boundary,p_NorthArrow,p_Zoom,p_Polygon);

	SELECT 0 'Error', '' Message;
                                  
end;
end if;



END#

delimiter ;