

#DROP PROCEDURE login_username;

delimiter #

CREATE PROCEDURE login_username (

                                in p_Username VARCHAR(10)
                                					
                              )
BEGIN

if (select 1=1 from ministryapp.user_account where username = p_Username and Enabled = 1) then
begin
    
    SELECT 0 'Error', 'User exist' Message, a.Password, a.Password_Key , p.HomeCongregationNumber CongregationNumber,RoleType
    FROM ministryapp.user_account a
    INNER JOIN ministryapp.user_profile p ON a.UserID=p.UserID    
    WHERE a.Username = p_Username;

end;
end if;

if (select 1=1 from ministryapp.user_account where username = p_Username and Enabled = 0) then
begin
    SELECT 1 'Error', 'User has not been activated' Message, null 'Password',  null 'Password_Key';
end;
end if;

if not exists (select 1=1 from ministryapp.user_account where username = p_Username) then
begin
    SELECT 1 'Error', 'User not exist' Message, null 'Password',  null 'Password_Key';
end;
end if;


END#

delimiter ;
