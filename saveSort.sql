#DROP PROCEDURE saveSort;

delimiter #

CREATE PROCEDURE saveSort (
                                in p_CongregationNumber VARCHAR(10),                                
                                in p_TerritoryNumber VARCHAR(10),
                                in p_iSort SMALLINT                                
                              )
BEGIN
declare vUserID bigint;

if (select 1=1 from ministryapp.territorycard where CongregationNumber = p_CongregationNumber and TerritoryNumber = p_TerritoryNumber) then
begin                                 
	UPDATE ministryapp.territorycard 
    SET  iSort = p_iSort
    WHERE CongregationNumber = p_CongregationNumber AND TerritoryNumber = p_TerritoryNumber;

    SELECT 0 'Error', 'Sort Updated' Message;                                 
end;
end if;



END#

delimiter ;