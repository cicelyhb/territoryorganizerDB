#DROP PROCEDURE deleteterritoryaddress;

delimiter #

CREATE PROCEDURE deleteterritoryaddress (in p_AddressGUID VARCHAR(150))
BEGIN

SET SQL_SAFE_UPDATES = 0;      

	DELETE FROM ministryapp.streets
    WHERE AddressGUID = p_AddressGUID; 

	DELETE FROM ministryapp.territory
    WHERE AddressGUID = p_AddressGUID; 
    
SET SQL_SAFE_UPDATES = 1;      
    
	SELECT 0 'Error', 'Address delete successfully' Message, p_AddressGUID 'GUID';    


END#

delimiter ;