#DROP PROCEDURE createcongregation;

delimiter #

CREATE PROCEDURE createcongregation (
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
                                in p_Password_Key VARCHAR(8),
                                in p_NewCongregationNumber VARCHAR(10),                                
                                in p_CongregationName VARCHAR(100),
                                in p_PhoneNumber VARCHAR(20),
                                in p_CongregationApartment VARCHAR(10),
                                in p_CongregationCity VARCHAR(50),
                                in p_CongregationState VARCHAR(3),
                                in p_CongregationZipCode VARCHAR(5),
                                in p_CongregationFormattedAddress VARCHAR(255),
                                in p_Latitude VARCHAR(50),
                                in p_Longitude VARCHAR(50),
                                in p_LanguageGUID VARCHAR(150)
                              )
BEGIN
declare vUserID bigint;

if (select 1=1 from ministryapp.congregation where CongregationNumber = p_HomeCongregationNumber) then
begin
     call ministryapp.createaccount(p_Firstname,
                                    p_Lastname,
                                    p_MiddleInit,
                                    p_Suffixname,
                                    p_Address,
                                    p_Apartment,
                                    p_City,
                                    p_State,
                                    p_ZipCode,
                                    p_HomeCongregationNumber,
                                    p_Username,
                                    p_Email,
                                    p_Password,
                                    p_Password_Key);    
end;
elseif (select 1=1 from ministryapp.congregation where p_CongregationFormattedAddress <> '') then
begin
    INSERT INTO ministryapp.congregation (CongregationNumber,CongregationName,PhoneNumber,
                                          Apartment,City,State,ZipCode,FormattedAddress,Latitude,Longitude,DateModified,LanguageGUID)
								VALUES	 (p_NewCongregationNumber,p_CongregationName,nullif(p_PhoneNumber,''),
										  nullif(p_CongregationApartment,''),p_CongregationCity,p_CongregationState,p_CongregationZipCode,
                                          p_CongregationFormattedAddress,p_Latitude,p_Longitude,now(),p_LanguageGUID);
                                
    INSERT INTO ministryapp.user_account (Username,Email,Password,Password_Key,RoleType,Enabled,EmailVerification,InitialDate)
								VALUES   (p_Username,p_Email,p_Password,p_Password_Key,'ADM',1,0,now());
                                
    SET vUserID= (SELECT UserID FROM ministryapp.user_account WHERE username = p_Username);
    
    INSERT INTO ministryapp.user_profile (UserID,Firstname,Lastname,MiddleInit,Suffixname,Address,Apartment,City,State,ZipCode,HomeCongregationNumber,VisitCongregationNumber,DateModified)
                                VALUES   (vUserID,p_Firstname,p_Lastname,nullif(p_MiddleInit,''),nullif(p_Suffixname,''),p_Address,nullif(p_Apartment,''),p_City,p_State,p_ZipCode,p_NewCongregationNumber,p_NewCongregationNumber,now());
                                
    INSERT INTO ministryapp.user_emailconfirmation (Username,EmailSent,DateModified)                             
                                VALUES   (p_Username,0,now());
    SELECT 0 'Error', (1000 + vUserID) Message;
  
end;
else
begin
	SELECT 1 'Error', 'Invalid Congregation' Message;
end;
end if;



END#

delimiter ;