
#DROP PROCEDURE streetmodule;

delimiter #

CREATE PROCEDURE streetmodule  (in p_CongregationNumber VARCHAR(10), 
                                in p_TerritoryNumber VARCHAR(10),
                                in p_Street VARCHAR(50),
                                in p_StreetSuffix VARCHAR(10),
                                in detail_type CHAR(1)
                                )
BEGIN   
if (detail_type = '1') then
begin                                     
SELECT  IFNULL(t.AddressGUID,'') AddressGUID,
        IFNULL(t.TerritoryNumber,'') TerritoryNumber, 
		IFNULL(t.Latitude,'') Latitude ,
		IFNULL(t.Longitude,'') Longitude,
		IFNULL(t.FormattedAddress,'') FormattedAddress,
		IFNULL(t.Type,'') Type,
		IFNULL(t.Resident,'') Resident,
		IFNULL(t.PhoneType,'') PhoneType,
		IFNULL(l.LanguageName,'') Language,
		IFNULL(t.InitialDate,'') InitialDate,
		IFNULL(t.Notes,'') Notes,
		IFNULL(t.DateModified,'') DateModified,
		IFNULL(t.bPhone,'') bPhone,
		IFNULL(t.Unit,'') Unit,
		IFNULL(t.bMulti,'') bMulti,
		IFNULL(t.bUnit,'') bUnit,    
		IFNULL(t.Phone,'') Phone,                                                                               
		IFNULL(t.Building,'') Building,
		IFNULL(t.LetterType,'') LetterType,
		IFNULL(t.bLetter,'') bLetter,
		IFNULL(t.bTouched,'') bTouched,  
		IFNULL(t.iSubmit,'') iSubmit          
FROM ministryapp.streets s
INNER JOIN ministryapp.territory t ON s.AddressGUID=t.AddressGUID
INNER JOIN ministryapp.language l  ON t.Language=l.LanguageGUID
WHERE   CongregationNumber = p_CongregationNumber AND 
		TerritoryNumber = p_TerritoryNumber AND 
		Street= p_Street AND 
		StreetSuffix = p_StreetSuffix
ORDER BY t.FormattedAddress;
end;
end if;

if (detail_type = '2') then
begin  
SELECT  IFNULL(t.AddressGUID,'') AddressGUID,
        IFNULL(t.TerritoryNumber,'') TerritoryNumber, 
		IFNULL(t.Latitude,'') Latitude ,
		IFNULL(t.Longitude,'') Longitude,
		IFNULL(t.FormattedAddress,'') FormattedAddress,
		IFNULL(t.Type,'') Type,
		IFNULL(t.Resident,'') Resident,
		IFNULL(t.PhoneType,'') PhoneType,
		IFNULL(l.LanguageName,'') Language,
		IFNULL(t.InitialDate,'') InitialDate,
		IFNULL(t.Notes,'') Notes,
		IFNULL(t.DateModified,'') DateModified,
		IFNULL(t.bPhone,'') bPhone,
		IFNULL(t.Unit,'') Unit,
		IFNULL(t.bMulti,'') bMulti,
		IFNULL(t.bUnit,'') bUnit,    
		IFNULL(t.Phone,'') Phone,                                                                               
		IFNULL(t.Building,'') Building,
		IFNULL(t.LetterType,'') LetterType,
		IFNULL(t.bLetter,'') bLetter,
		IFNULL(t.bTouched,'') bTouched,  
		IFNULL(t.iSubmit,'') iSubmit          
FROM ministryapp.streets s
INNER JOIN ministryapp.territory t ON s.AddressGUID=t.AddressGUID
INNER JOIN ministryapp.language l  ON t.Language=l.LanguageGUID
WHERE 	CongregationNumber = p_CongregationNumber AND 
		TerritoryNumber = p_TerritoryNumber AND 
		Street= p_Street AND 
		StreetSuffix = p_StreetSuffix AND
        t.Type = 'DNC'
ORDER BY t.FormattedAddress;
end;
end if;


if (detail_type = '3') then
begin 
SELECT  IFNULL(t.AddressGUID,'') AddressGUID,
        IFNULL(t.TerritoryNumber,'') TerritoryNumber, 
		IFNULL(t.Latitude,'') Latitude ,
		IFNULL(t.Longitude,'') Longitude,
		IFNULL(t.FormattedAddress,'') FormattedAddress,
		IFNULL(t.Type,'') Type,
		IFNULL(t.Resident,'') Resident,
		IFNULL(t.PhoneType,'') PhoneType,
		IFNULL(l.LanguageName,'') Language,
		IFNULL(t.InitialDate,'') InitialDate,
		IFNULL(t.Notes,'') Notes,
		IFNULL(t.DateModified,'') DateModified,
		IFNULL(t.bPhone,'') bPhone,
		IFNULL(t.Unit,'') Unit,
		IFNULL(t.bMulti,'') bMulti,
		IFNULL(t.bUnit,'') bUnit,    
		IFNULL(t.Phone,'') Phone,                                                                               
		IFNULL(t.Building,'') Building,
		IFNULL(t.LetterType,'') LetterType,
		IFNULL(t.bLetter,'') bLetter,
		IFNULL(t.bTouched,'') bTouched,  
		IFNULL(t.iSubmit,'') iSubmit      
FROM ministryapp.streets s
INNER JOIN ministryapp.territory t ON s.AddressGUID=t.AddressGUID
INNER JOIN ministryapp.language l  ON t.Language=l.LanguageGUID
WHERE 	CongregationNumber = p_CongregationNumber AND 
		TerritoryNumber = p_TerritoryNumber AND 
		Street= p_Street AND 
		StreetSuffix = p_StreetSuffix AND
        t.bPhone = 1
ORDER BY t.FormattedAddress;
end;
end if;

if (detail_type = '4') then
begin 
SELECT  IFNULL(t.AddressGUID,'') AddressGUID,
        IFNULL(t.TerritoryNumber,'') TerritoryNumber, 
		IFNULL(t.Latitude,'') Latitude ,
		IFNULL(t.Longitude,'') Longitude,
		IFNULL(t.FormattedAddress,'') FormattedAddress,
		IFNULL(t.Type,'') Type,
		IFNULL(t.Resident,'') Resident,
		IFNULL(t.PhoneType,'') PhoneType,
		IFNULL(l.LanguageName,'') Language,
		IFNULL(t.InitialDate,'') InitialDate,
		IFNULL(t.Notes,'') Notes,
		IFNULL(t.DateModified,'') DateModified,
		IFNULL(t.bPhone,'') bPhone,
		IFNULL(t.Unit,'') Unit,
		IFNULL(t.bMulti,'') bMulti,
		IFNULL(t.bUnit,'') bUnit,    
		IFNULL(t.Phone,'') Phone,                                                                               
		IFNULL(t.Building,'') Building,
		IFNULL(t.LetterType,'') LetterType,
		IFNULL(t.bLetter,'') bLetter,
		IFNULL(t.bTouched,'') bTouched,  
		IFNULL(t.iSubmit,'') iSubmit       
FROM ministryapp.streets s
INNER JOIN ministryapp.territory t ON s.AddressGUID=t.AddressGUID
INNER JOIN ministryapp.language l  ON t.Language=l.LanguageGUID
WHERE 	CongregationNumber = p_CongregationNumber AND 
		TerritoryNumber = p_TerritoryNumber AND 
		Street= p_Street AND 
		StreetSuffix = p_StreetSuffix AND
        t.Type = 'WL' 
ORDER BY t.FormattedAddress;
end;
end if;

if (detail_type = '5') then
begin 
SELECT  IFNULL(t.AddressGUID,'') AddressGUID,
        IFNULL(t.TerritoryNumber,'') TerritoryNumber, 
		IFNULL(t.Latitude,'') Latitude ,
		IFNULL(t.Longitude,'') Longitude,
		IFNULL(t.FormattedAddress,'') FormattedAddress,
		IFNULL(t.Type,'') Type,
		IFNULL(t.Resident,'') Resident,
		IFNULL(t.PhoneType,'') PhoneType,
		IFNULL(l.LanguageName,'') Language,
		IFNULL(t.InitialDate,'') InitialDate,
		IFNULL(t.Notes,'') Notes,
		IFNULL(t.DateModified,'') DateModified,
		IFNULL(t.bPhone,'') bPhone,
		IFNULL(t.Unit,'') Unit,
		IFNULL(t.bMulti,'') bMulti,
		IFNULL(t.bUnit,'') bUnit,    
		IFNULL(t.Phone,'') Phone,                                                                               
		IFNULL(t.Building,'') Building,
		IFNULL(t.LetterType,'') LetterType,
		IFNULL(t.bLetter,'') bLetter,
		IFNULL(t.bTouched,'') bTouched,  
		IFNULL(t.iSubmit,'') iSubmit       
FROM ministryapp.streets s
INNER JOIN ministryapp.territory t ON s.AddressGUID=t.AddressGUID
INNER JOIN ministryapp.language l  ON t.Language=l.LanguageGUID
WHERE 	CongregationNumber = p_CongregationNumber AND 
		TerritoryNumber = p_TerritoryNumber AND 
		Street= p_Street AND 
		StreetSuffix = p_StreetSuffix AND
        t.Type = 'NH' AND t.bTouched = 1
ORDER BY t.FormattedAddress;
end;
end if;

END#

delimiter ;