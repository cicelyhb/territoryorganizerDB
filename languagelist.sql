use ministryapp;
#DROP PROCEDURE languagelist;

delimiter #

CREATE PROCEDURE languagelist ()
BEGIN
SELECT LanguageGUID,LanguageName FROM ministryapp.language ORDER BY LanguageName;
END#

delimiter ;