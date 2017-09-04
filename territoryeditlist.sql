USE ministryapp;

#DROP PROCEDURE territoryeditlist;

delimiter #

CREATE PROCEDURE territoryeditlist (in p_CongregationNumber VARCHAR(10))
BEGIN
if (select 1=1 from ministryapp.territorycard where CongregationNumber = p_CongregationNumber group by CongregationNumber) then
begin
SELECT 	0 'Error',
        TerritoryNumber,
        null Message
FROM ministryapp.territorycard 
WHERE CongregationNumber = p_CongregationNumber
ORDER BY iSort,TerritoryNumber;
end;
else
begin
SELECT 	1 'Error',
        null TerritoryNumber,
        'No territories to edit' Message;
end;
end if;
END#

delimiter ;