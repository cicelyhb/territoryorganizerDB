

#DROP PROCEDURE createaccount;

delimiter #

CREATE PROCEDURE createaccount (
                                in p_Firstname VARCHAR(50),
                                in p_Lastname VARCHAR(50),
                                in p_MiddleInit CHAR(1),
                                in p_Suffixname VARCHAR(5),
                                in p_Address VARCHAR(255),
                                in p_Apartment VARCHAR(10),
                                in p_City VARCHAR(50),
                                in p_State VARCHAR(3),
                                in p_ZipCode VARCHAR(5),
                                in p_HomeCongregationNumber VARCHAR(10),
                                in p_Username VARCHAR(10),
                                in p_Email VARCHAR(255),
                                in p_Password VARCHAR(120),
                                in p_Password_Key VARCHAR(8)							
                              )
BEGIN
declare vUserID bigint;

if (select 1=1 from ministryapp.user_account where username = p_Username) then
begin
    SELECT 1 'Error', 'Username already exist.' Message;
end;
else
begin
    INSERT INTO ministryapp.user_account (Username,Email,Password,Password_Key,RoleType,Enabled,EmailVerification,InitialDate)
								VALUES   (p_Username,p_Email,p_Password,p_Password_Key,'POW',0,0,now());
                                
    SET vUserID= (SELECT UserID FROM ministryapp.user_account WHERE username = p_Username);
    
    INSERT INTO ministryapp.user_profile (UserID,Firstname,Lastname,MiddleInit,Suffixname,Address,Apartment,City,State,ZipCode,HomeCongregationNumber,VisitCongregationNumber,DateModified)
                                VALUES   (vUserID,p_Firstname,p_Lastname,nullif(p_MiddleInit,''),nullif(p_Suffixname,''),p_Address,nullif(p_Apartment,''),p_City,p_State,p_ZipCode,p_HomeCongregationNumber,p_HomeCongregationNumber,now());
                                
    INSERT INTO ministryapp.user_emailconfirmation (Username,EmailSent,DateModified)                             
                                VALUES   (p_Username,0,now());
    SELECT 0 'Error', (1000 + vUserID) Message;
end;

end if;


END#

delimiter ;