#DROP PROCEDURE removeterritorygroup;

delimiter #

CREATE PROCEDURE removeterritorygroup (in p_GroupGUID VARCHAR(150))
BEGIN

UPDATE ministryapp.territorygroup
SET ExpiredDate = now()
WHERE GroupGUID = p_GroupGUID;
      
SELECT 0 'Error', 'Service group deleted.'  Message;		      
END#

delimiter ;