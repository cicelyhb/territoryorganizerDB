#DROP PROCEDURE deleteterritory;

delimiter #

CREATE PROCEDURE deleteterritory (
										in p_CongregationNumber VARCHAR(10),                                
										in p_TerritoryNumber VARCHAR(10)
                                      )
BEGIN
declare vCount smallint;

SET SQL_SAFE_UPDATES = 0;

    DELETE FROM ministryapp.building 
    WHERE CongregationNumber = p_CongregationNumber AND TerritoryNumber = p_TerritoryNumber;  

    DELETE
    FROM ministryapp.streets
    WHERE AddressGUID IN (SELECT AddressGUID FROM ministryapp.territory WHERE CongregationNumber = p_CongregationNumber AND TerritoryNumber = p_TerritoryNumber);

	DELETE 
    FROM ministryapp.territory
    WHERE CongregationNumber = p_CongregationNumber AND TerritoryNumber = p_TerritoryNumber;  
    
	DELETE 
    FROM ministryapp.territorycard
    WHERE CongregationNumber = p_CongregationNumber AND TerritoryNumber = p_TerritoryNumber;       
    
SET SQL_SAFE_UPDATES = 1;    
     
    
	SELECT 0 'Error', 'Territory delete successfully' Message;    

END#

delimiter ;