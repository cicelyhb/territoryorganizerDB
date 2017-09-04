#DROP PROCEDURE login_success;

delimiter #

CREATE PROCEDURE login_success (

                                in p_Username VARCHAR(10)
                                					
                              )
BEGIN

if (select 1=1 from ministryapp.user_account where username = p_Username and Enabled = 1) then
begin
    UPDATE ministryapp.user_account SET LastLoginDate = now() WHERE username = p_Username;
    
    SELECT 0 'Error', 'Login Successful' Message;
end;
end if;


END#

delimiter ;
