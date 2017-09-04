
#DROP PROCEDURE activateaccount;

delimiter #

CREATE PROCEDURE activateaccount (
                                in p_Username VARCHAR(10),
                                in p_RoleType VARCHAR(10)
                                
                              )
BEGIN
declare vUserID bigint;

if (select 1=1 from ministryapp.user_account where username = p_Username) then
begin
    SET vUserID= (SELECT UserID FROM ministryapp.user_account WHERE username = p_Username);
    
    UPDATE ministryapp.user_account SET Enabled = 1 , RoleType = p_RoleType WHERE UserID = vUserID;
    
    SELECT 0 'Error', 'Account has been activated' Message;
end;

end if;


END#

delimiter ;
