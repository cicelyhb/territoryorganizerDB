#DROP PROCEDURE setDefaultTerritory;

delimiter #

CREATE PROCEDURE setDefaultTerritory (
										in p_CongregationNumber VARCHAR(10),                                
										in p_TerritoryNumber VARCHAR(10),
                                        in p_Username VARCHAR(10)
                                    )
BEGIN
declare vUserID bigint;

if (select 1=1 from ministryapp.territorycard where CongregationNumber = p_CongregationNumber and TerritoryNumber = p_TerritoryNumber) then
begin 
	UPDATE ministryapp.territorycard 
    SET  bDefault =  0
    WHERE CongregationNumber = p_CongregationNumber;
                                
	UPDATE ministryapp.territorycard 
    SET  bDefault =  1, Modifier = p_Username
    WHERE CongregationNumber = p_CongregationNumber AND TerritoryNumber = p_TerritoryNumber;
       

    SELECT 0 'Error', 'Default has been set for territory' Message;                                 
end;
end if;



END#

delimiter ;