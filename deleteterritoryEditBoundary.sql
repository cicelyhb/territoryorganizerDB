#DROP PROCEDURE deleteEditBoundary;

delimiter #

CREATE PROCEDURE deleteEditBoundary (
                                in p_CongregationNumber VARCHAR(10),                                
                                in p_TerritoryNumber VARCHAR(10),
                                in p_Property TEXT
                              )
BEGIN
declare vUserID bigint;

if (select 1=1 from ministryapp.territorycard where CongregationNumber = p_CongregationNumber and TerritoryNumber = p_TerritoryNumber) then
begin                                 
	UPDATE ministryapp.territorycard 
    SET  LatLng = null, Boundary = null, Enabled = 0, Property = p_Property 
    WHERE CongregationNumber = p_CongregationNumber AND TerritoryNumber = p_TerritoryNumber;
       
    SELECT 0 'Error', 'Rectangle removed' Message;                                 
end;
end if;



END#

delimiter ;