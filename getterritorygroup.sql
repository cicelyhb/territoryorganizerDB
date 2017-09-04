#DROP PROCEDURE getterritorygroup;

delimiter #

CREATE PROCEDURE getterritorygroup (in p_CongregationNumber VARCHAR(10))
BEGIN

SELECT GroupGUID,
       GroupName
FROM ministryapp.territorygroup
WHERE CongregationNumber = p_CongregationNumber AND ExpiredDate>now()
ORDER BY GroupName;
       
       
END#    