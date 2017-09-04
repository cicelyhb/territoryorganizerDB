
#DROP PROCEDURE gethouse;

delimiter #

CREATE PROCEDURE gethouse (in p_CongregationNumber VARCHAR(10), in p_TerritoryNumber VARCHAR(10))
BEGIN

SELECT  AddressGUID,
		PlaceID,
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
        null 'BuildingName'
FROM ministryapp.territory 
WHERE CongregationNumber = p_CongregationNumber and 
      TerritoryNumber = p_TerritoryNumber and
      bMulti = 0 and
      bUnit = 0;
   

END#

delimiter ;