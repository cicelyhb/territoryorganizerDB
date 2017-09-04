
#DROP PROCEDURE getterritoryinfo;

delimiter #

CREATE PROCEDURE getterritoryinfo (in p_CongregationNumber VARCHAR(10), in p_TerritoryNumber VARCHAR(10))
BEGIN

SELECT  LatLng 'Center',
        Boundary 'Rectangle',
        NorthArrow 'Compass',
        Zoom 'Zoom',
        Polygon 'Polygon',
        Property 'Property',
        bDefault 'DefaultView'
FROM ministryapp.territorycard 
WHERE CongregationNumber = p_CongregationNumber and TerritoryNumber = p_TerritoryNumber;
   

END#

delimiter ;