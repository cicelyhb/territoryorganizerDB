
#DROP PROCEDURE displayusers;

delimiter #

CREATE PROCEDURE displayusers(in p_CongregationNumber VARCHAR(10))
BEGIN
SELECT trim(concat(p.Firstname,' ',p.Lastname,concat(' ',COALESCE(p.Suffixname,'')))) Name,
       a.UserID,
       a.Username,
       a.Email,
       a.RoleType,
       a.InitialDate,
       a.LastLoginDate

FROM ministryapp.user_account a 
     INNER JOIN ministryapp.user_profile p ON a.UserID=p.UserID
WHERE  HomeCongregationNumber  = p_CongregationNumber AND
       a.EmailVerification = 1 AND
       a.Enabled = 1;

END#

delimiter ;
