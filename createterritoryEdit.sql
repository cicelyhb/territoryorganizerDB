#DROP PROCEDURE createterritoryEdit;

delimiter #

CREATE PROCEDURE createterritoryEdit (
                                in p_CongregationNumber VARCHAR(10),                                
                                in p_TerritoryNumber VARCHAR(10),
                                in p_LatLng VARCHAR(100),                                
                                in p_Boundary VARCHAR(250),
                                in p_Polygon TEXT,                                
                                in p_NorthArrow VARCHAR(100),
                                in p_Property TEXT,
                                in p_InitialDate DATETIME                                 
                              )
BEGIN
declare vUserID bigint;

if (select 1=1 from ministryapp.territorycard where CongregationNumber = p_CongregationNumber and TerritoryNumber = p_TerritoryNumber) then
begin                                 
	UPDATE ministryapp.territorycard 
    SET  LatLng =  p_LatLng, Boundary = p_Boundary, p_Polygon =  p_Polygon, NorthArrow = p_NorthArrow, Enabled = 1, Property = p_Property 
    WHERE CongregationNumber = p_CongregationNumber AND TerritoryNumber = p_TerritoryNumber;
                                 
    SELECT 0 'Error', 'Territory updated' Message;                                 
end;
else
begin  

	INSERT INTO ministryapp.territorycard (CongregationNumber,TerritoryNumber,Zoom,LatLng,Boundary,Polygon,NorthArrow,Enabled,Property,InitialDate)
		                         VALUES   (p_CongregationNumber,p_TerritoryNumber,17,p_LatLng,p_Boundary,p_Polygon,p_NorthArrow,1,p_Property,p_InitialDate);
    SELECT 0 'Error', 'Territory created' Message; 								
end;
end if;



END#

delimiter ;