#DROP PROCEDURE admin_email;

delimiter #

CREATE PROCEDURE admin_email(in p_CongregationNumber VARCHAR(120))
BEGIN
SELECT Firstname,Lastname,Email
FROM ministryapp.user_account a 
INNER JOIN ministryapp.user_profile b 
									ON a.UserID=b.UserID
WHERE HomeCongregationNumber = p_CongregationNumber AND 
      RoleType = 'ADM';

END#

delimiter ;