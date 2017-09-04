#DROP PROCEDURE editterritory;

delimiter #

CREATE PROCEDURE editterritory (
                                in p_CongregationNumber VARCHAR(10),                                
                                in p_TerritoryNumber VARCHAR(10),
                                in p_LatLng VARCHAR(100),
                                in p_NorthArrow VARCHAR(100),
                                in p_Zoom SMALLINT,
                                in p_Polygon TEXT
                              )
BEGIN
declare vUserID bigint;

if (select 1=1 from ministryapp.congregation where CongregationNumber = p_CongregationNumber and TerritoryNumber = p_TerritoryNumber) then
begin                                 
	UPDATE ministryapp.territorycard 
    SET  LatLng = p_LatLng, NorthArrow =  p_NorthArrow, Zoom = p_Zoom,  p_Polygon =  p_Polygon 
    WHERE CongregationNumber = p_CongregationNumber AND TerritoryNumber = p_TerritoryNumber;
                                 
    SELECT 0 'Error', '' Message;                                 
end;
else
begin    
    SELECT 1 'Error', 'Territory not exist' Message;   								
end;
end if;



END#

delimiter ;