#DROP PROCEDURE getTerritoryCheckOutInfo;

delimiter #

CREATE PROCEDURE getTerritoryCheckOutInfo (
										in p_CongregationNumber VARCHAR(10)
                                    )
BEGIN
declare vUserID bigint;


    SELECT 
           RequestUsername,
           RequestDate,
           ResponseDate
    FROM   ministryapp.territorycheckout 
    WHERE  CongregationNumber = p_CongregationNumber AND bCheckOut = 1 AND ExpiredDate > now();
    
                                    



END#

delimiter ;