#DROP PROCEDURE updateterritorybuildingname;

delimiter #

CREATE PROCEDURE updateterritorybuildingname (
                                in p_CongregationNumber VARCHAR(10),                                
                                in p_TerritoryNumber VARCHAR(10), 
                                in p_PlaceID VARCHAR(100),
                                in p_BuildingName VARCHAR(100)                                
                              )
BEGIN
if (select 1=1 from ministryapp.building where PlaceID = p_PlaceID AND CongregationNumber = p_CongregationNumber AND TerritoryNumber = p_TerritoryNumber) then
begin
SET SQL_SAFE_UPDATES = 0;      
    
	UPDATE ministryapp.building
	SET BuildingName = nullif(p_BuildingName,'')
	WHERE PlaceID = p_PlaceID AND CongregationNumber = p_CongregationNumber AND TerritoryNumber = p_TerritoryNumber;
    
SET SQL_SAFE_UPDATES = 1;  
    
  	SELECT 0 'Error', 'Building name updated successfully' Message;
end;
end if;



END#

delimiter ;