#DROP PROCEDURE deleteterritoryEdit;

delimiter #

CREATE PROCEDURE deleteterritoryEdit (
                                in p_CongregationNumber VARCHAR(10),                                
                                in p_TerritoryNumber VARCHAR(10)                               
                              )
BEGIN
declare vUserID bigint;
 
	DELETE FROM ministryapp.territory
    WHERE CongregationNumber = p_CongregationNumber AND TerritoryNumber = p_TerritoryNumber;
                                 
	DELETE FROM ministryapp.territorycard 
    WHERE CongregationNumber = p_CongregationNumber AND TerritoryNumber = p_TerritoryNumber;
                                 
    SELECT 0 'Error', 'Territory deleted' Message;                                 




END#

delimiter ;