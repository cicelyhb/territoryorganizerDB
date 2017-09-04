#DROP PROCEDURE assignTerritory;

delimiter #

CREATE PROCEDURE assignTerritory (
                                in p_CheckInGUID VARCHAR(150),    
                                in p_CongregationNumber VARCHAR(10),                                
                                in p_TerritoryNumber VARCHAR(10),                                
                                in p_ResponseUsername VARCHAR(10),
                                in p_ResponseDate DATETIME                              
                              )
BEGIN
declare vEnddate datetime;
if (select 1=1 from ministryapp.territorycheckout where CheckInGUID = p_CheckInGUID) then
begin
SET vEnddate = (SELECT Enddate FROM ministryapp.campaign WHERE now() between Startdate and Enddate ORDER BY startdate LIMIT 1);

SET SQL_SAFE_UPDATES = 0;  

UPDATE ministryapp.territorycheckout
SET ResponseUsername = p_ResponseUsername, ResponseDate = p_ResponseDate, ExpiredDate = vEnddate, bCheckOut = 1
WHERE CheckInGUID = p_CheckInGUID;

DELETE FROM ministryapp.territorycheckout
WHERE CongregationNumber = p_CongregationNumber AND
      TerritoryNumber = p_TerritoryNumber AND
      bCheckOut = 0;
                             
SET SQL_SAFE_UPDATES = 1; 
                             
SELECT 0 'Error', 'Territory assigned' Message; 
end;
else
begin 
SELECT 0 'Error', 'Territory already assigned to another user' Message;                            
end;
end if;
END#