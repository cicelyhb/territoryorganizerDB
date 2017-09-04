#DROP PROCEDURE updateterritoryaddress;

delimiter #

CREATE PROCEDURE updateterritoryaddress (
                                in p_CongregationNumber VARCHAR(10),                                
                                in p_TerritoryNumber VARCHAR(10),
                                in p_AddressGUID VARCHAR(150),  
                                in p_PlaceID VARCHAR(100),                                   
                                in p_Latitude VARCHAR(50),
                                in p_Longitude VARCHAR(50),
                                in p_FormattedAddress VARCHAR(255),
                                in p_FormattedXYAddress VARCHAR(255),                                
                                in p_Street VARCHAR(50),
                                in p_StreetSuffix VARCHAR(10),
                                in p_bMulti TINYINT,                                  
                                in p_bUnit TINYINT,                                
                                in p_bPhone TINYINT,                                
                                in p_Resident TEXT,
                                in p_Phone VARCHAR(20),
                                in p_Building VARCHAR(15),                                
                                in p_Unit VARCHAR(10)
                              )
BEGIN
if (select 1=1 from ministryapp.territory where AddressGUID = p_AddressGUID) then
begin
SET SQL_SAFE_UPDATES = 0;      

    UPDATE ministryapp.territory
    SET Resident = nullif(p_Resident,''),Phone = nullif(p_Phone,''),bPhone = p_bPhone
    WHERE AddressGUID =  p_AddressGUID;
    
SET SQL_SAFE_UPDATES = 1;  
    
  	SELECT 0 'Error', 'Address updated successfully' Message, p_AddressGUID 'GUID';
end;
end if;



END#

delimiter ;