#DROP PROCEDURE addterritoryaddressUnit;

delimiter #

CREATE PROCEDURE addterritoryaddressUnit (
                                in p_CongregationNumber VARCHAR(10),                                
                                in p_TerritoryNumber VARCHAR(10),
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
                                in p_Unit VARCHAR(10),
                                in p_BuildingName VARCHAR(100)
                              )
BEGIN
declare vLanguage varchar(50);
declare vLanguage0 varchar(50);
declare vAddressGUID varchar(150);
declare vAddressGUID0 varchar(150);

if (select 1=1 from ministryapp.territory where CongregationNumber = p_CongregationNumber and TerritoryNumber = p_TerritoryNumber and PlaceID = p_PlaceID group by CongregationNumber, TerritoryNumber, PlaceID) then
begin
	if (select 1=1 from ministryapp.territory where CongregationNumber = p_CongregationNumber and TerritoryNumber = p_TerritoryNumber and PlaceID = p_PlaceID and Building = p_Building and Unit = p_Unit) then
    begin
		SET vAddressGUID0 = (SELECT AddressGUID FROM ministryapp.territory WHERE CongregationNumber = p_CongregationNumber and TerritoryNumber = p_TerritoryNumber and PlaceID = p_PlaceID and Building = p_Building and Unit = p_Unit);
		call updateterritoryaddress (
										p_CongregationNumber,                                
										p_TerritoryNumber,
										vAddressGUID0,  
										p_PlaceID,                                   
										p_Latitude,
										p_Longitude,
										p_FormattedAddress,
										p_FormattedXYAddress,                                
										p_Street,
										p_StreetSuffix,
										p_bMulti,                                  
										p_bUnit,                                
										p_bPhone,                                
										p_Resident,
										p_Phone,
										p_Building,                                
										p_Unit,
                                        p_BuildingName
									);
    end;
    else
    begin
		SET vLanguage0 = (SELECT LanguageGUID FROM ministryapp.congregation WHERE CongregationNumber = p_CongregationNumber);
		SET vAddressGUID0 = UUID();
    
		INSERT INTO ministryapp.territory (AddressGUID,PlaceID,CongregationNumber,TerritoryNumber,Latitude,Longitude,FormattedAddress,FormattedXYAddress,Type,PhoneType,Language,Notes,Resident,Phone,Building,bPhone,bMulti,bUnit,Unit,bTouched,bLetter,LetterType,iSubmit)
						     VALUES   (vAddressGUID0,p_PlaceID,p_CongregationNumber,p_TerritoryNumber,p_Latitude,p_Longitude,p_FormattedAddress,p_FormattedXYAddress,'NH','NC',vLanguage0,null,nullif(p_Resident,''),nullif(p_Phone,''),nullif(p_Building,''),p_bPhone,p_bMulti,p_bUnit,nullif(p_Unit,''),0,0,'LNS',0);                             
        
		INSERT INTO ministryapp.streets (AddressGUID,Street,StreetSuffix)
						     VALUES (vAddressGUID0,p_Street,p_StreetSuffix);        
                             								

		SELECT 0 'Error', 'Address added successfully' Message, vAddressGUID0 'GUID';    
    end;
    end if;
end;
else
begin  

    SET vLanguage = (SELECT LanguageGUID FROM ministryapp.congregation WHERE CongregationNumber = p_CongregationNumber);
    SET vAddressGUID = UUID();
    
    INSERT INTO ministryapp.territory (AddressGUID,PlaceID,CongregationNumber,TerritoryNumber,Latitude,Longitude,FormattedAddress,FormattedXYAddress,Type,PhoneType,Language,Notes,Resident,Phone,Building,bPhone,bMulti,bUnit,Unit,bTouched,bLetter,LetterType,iSubmit)
						     VALUES   (vAddressGUID,p_PlaceID,p_CongregationNumber,p_TerritoryNumber,p_Latitude,p_Longitude,p_FormattedAddress,p_FormattedXYAddress,'NH','NC',vLanguage,null,nullif(p_Resident,''),nullif(p_Phone,''),nullif(p_Building,''),p_bPhone,p_bMulti,p_bUnit,nullif(p_Unit,''),0,0,'LNS',0);
                                     
    INSERT INTO ministryapp.streets (AddressGUID,Street,StreetSuffix)
						     VALUES (vAddressGUID,p_Street,p_StreetSuffix);  
                             
	INSERT INTO ministryapp.building (BuildingGUID,PlaceID,CongregationNumber,TerritoryNumber,BuildingType,BuildingName)
						 VALUES (UUID(),p_PlaceID,p_CongregationNumber,p_TerritoryNumber,'ABC',nullif(p_BuildingName,''));       
                         

	SELECT 0 'Error', 'Address added successfully' Message, vAddressGUID 'GUID';
                                  
end;
end if;



END#

delimiter ;