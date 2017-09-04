#DROP PROCEDURE createEditPolygon;

delimiter #

CREATE PROCEDURE createEditPolygon (
                                in p_CongregationNumber VARCHAR(10),                                
                                in p_TerritoryNumber VARCHAR(10),
                                in p_Polygon TEXT,
                                in p_Property TEXT,
                                in p_InitialDate DATETIME,
                                in p_Username VARCHAR(10)                                 
                              )
BEGIN
declare vUserID bigint;

if (select 1=1 from ministryapp.territorycard where CongregationNumber = p_CongregationNumber and TerritoryNumber = p_TerritoryNumber) then
begin                                 
	UPDATE ministryapp.territorycard 
    SET  Polygon =  p_Polygon, Property = p_Property, Modifier = p_Username   
    WHERE CongregationNumber = p_CongregationNumber AND TerritoryNumber = p_TerritoryNumber;
    
    UPDATE ministryapp.territorycard
    SET Enabled = 1
    WHERE Enabled = 0  AND nullif(LatLng,'') <> '' AND nullif(Boundary,'') <> '' AND nullif(Polygon,'')  <> '' AND nullif(NorthArrow,'') <> '';    
                                 
    SELECT 0 'Error', 'Polygon updated' Message;                                 
end;
else
begin  
    
	INSERT INTO ministryapp.territorycard (CongregationNumber,TerritoryNumber,Zoom,Polygon,Enabled,Property,InitialDate,iSort,bDefault,Creator)
		                         VALUES   (p_CongregationNumber,p_TerritoryNumber,17,p_Polygon,0,p_Property,p_InitialDate,0,0,p_Username);
    SELECT 0 'Error', 'Polygon created' Message;   								
end;
end if;



END#

delimiter ;