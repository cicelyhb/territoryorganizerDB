
#DROP PROCEDURE territory;

delimiter #

CREATE PROCEDURE territory (in p_CongregationNumber VARCHAR(10), 
							in p_TerritoryNumber VARCHAR(10))
BEGIN

		SELECT 
				AddressGUID,
			    TerritoryNumber,
			    Latitude,
				Longitude,
				FormattedAddress,
				Type,
				Resident,
				PhoneType,
				Language,
                InitialDate,
                Notes,
                DateModified,
                bPhone,
                Unit,
                bMulti, 
                bUnit,   
                Phone,                                                                              
                Building,
                bTouched,
                bLetter,
                LetterType,
				iSubmit     
		FROM ministryapp.territory 
		WHERE CongregationNumber = p_CongregationNumber AND 
			  TerritoryNumber = p_TerritoryNumber AND
			  bUnit = 0 AND bMulti = 0;
        

END#

delimiter ;