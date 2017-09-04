#DROP PROCEDURE getrole;

delimiter #

CREATE PROCEDURE getrole ()
BEGIN


SELECT RoleType,
       RoleDescription,
       IF(RoleType='POW', 'true', 'false') 'Default'
FROM ministryapp.user_role 
ORDER BY RoleType;

END#

delimiter ;