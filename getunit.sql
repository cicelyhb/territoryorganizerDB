#DROP PROCEDURE getunit;

delimiter #

CREATE PROCEDURE getunit (in p_CongregationNumber VARCHAR(10), in p_TerritoryNumber VARCHAR(10))
BEGIN

SELECT  AddressGUID,
		t.PlaceID,
		Latitude,
		Longitude,
		FormattedAddress,
		FormattedXYAddress,
		bMulti,
		bUnit,
		bPhone,
		Resident,
		Phone,
		Building,
		Unit,
        BuildingName
FROM ministryapp.territory t
INNER JOIN ministryapp.building b ON t.PlaceID=b.PlaceID AND t.CongregationNumber=b.CongregationNumber AND t.TerritoryNumber=b.TerritoryNumber
WHERE t.CongregationNumber = p_CongregationNumber and 
      t.TerritoryNumber = p_TerritoryNumber and
      bUnit = 1;
   

END#

delimiter ;