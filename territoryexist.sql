
#DROP PROCEDURE territoryexist;

delimiter #

CREATE PROCEDURE territoryexist (in p_CongregationNumber VARCHAR(10), in p_TerritoryNumber VARCHAR(10))
BEGIN
if (select 1=1 from ministryapp.territorycard where CongregationNumber = p_CongregationNumber and TerritoryNumber = p_TerritoryNumber) then
begin
   SELECT 1 'Exist';
end;
else
begin
   SELECT 0 'Exist';
end;
end if;
END#

delimiter ;