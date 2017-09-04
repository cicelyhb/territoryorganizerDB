#DROP PROCEDURE getusername;

delimiter #

CREATE PROCEDURE getusername(in p_CongregationNumber VARCHAR(10))
BEGIN

SELECT Username,
       concat(Firstname,' ',Lastname) Name
FROM ministryapp.user_account a
INNER JOIN ministryapp.user_profile p ON a.UserID=p.UserID
WHERE p.HomeCongregationNumber=p_CongregationNumber ;

END#

delimiter ;