#DROP PROCEDURE deleteterritoryplace;

delimiter #

CREATE PROCEDURE deleteterritoryplace (
										in p_CongregationNumber VARCHAR(10),                                
										in p_TerritoryNumber VARCHAR(10),
										in p_PlaceID VARCHAR(100)
                                      )
BEGIN
declare vCount smallint;

SET SQL_SAFE_UPDATES = 0;

    DELETE FROM ministryapp.building 
    WHERE PlaceID = p_PlaceID AND CongregationNumber = p_CongregationNumber AND TerritoryNumber = p_TerritoryNumber;  

    DELETE
    FROM ministryapp.streets
    WHERE AddressGUID IN (SELECT AddressGUID FROM ministryapp.territory WHERE CongregationNumber = p_CongregationNumber AND TerritoryNumber = p_TerritoryNumber AND PlaceID = p_PlaceID);

	DELETE 
    FROM ministryapp.territory
    WHERE CongregationNumber = p_CongregationNumber AND TerritoryNumber = p_TerritoryNumber AND PlaceID = p_PlaceID;    
    
SET SQL_SAFE_UPDATES = 1;    
     
    SET vCount = (SELECT Count(1) FROM ministryapp.territory WHERE CongregationNumber = p_CongregationNumber and TerritoryNumber = p_TerritoryNumber);
    
	SELECT 0 'Error', 'Addresses delete successfully' Message, vCount 'Count';    

END#

delimiter ;