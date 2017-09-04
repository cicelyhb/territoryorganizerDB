#DROP PROCEDURE requestTerritory;

delimiter #

CREATE PROCEDURE requestTerritory (
                                in p_CongregationNumber VARCHAR(10),                                
                                in p_TerritoryNumber VARCHAR(10),
                                in p_RequestUsername VARCHAR(10),
                                in p_GroupGUID VARCHAR(150),
                                in p_RequestDate DATETIME
                              )
BEGIN
declare vCheckInGUID varchar(150);
declare vCampaignGUID varchar(150);

if (select 1=1 from ministryapp.territorycheckout where CongregationNumber = p_CongregationNumber and TerritoryNumber = p_TerritoryNumber and RequestUsername = p_RequestUsername and IFNULL(ExpiredDate,'2000-01-01 00:00:00') > now() group by CongregationNumber,TerritoryNumber,RequestUsername) then
begin  
SELECT 0 'Error', 'Request was already submited.'  Message;						
end;
elseif (select 1=1 from ministryapp.territorycheckout where CongregationNumber = p_CongregationNumber and TerritoryNumber = p_TerritoryNumber and RequestUsername = p_RequestUsername and bCheckOut = 0 group by CongregationNumber,TerritoryNumber,RequestUsername) then
begin 
SELECT 0 'Error', 'Request was already submited.'  Message;						
end;
else
begin
SET vCheckInGUID = UUID();

SET vCampaignGUID = (SELECT CampaignGUID 
				     FROM ministryapp.campaign
					 WHERE now() between startdate and enddate
					 ORDER BY startdate
					 LIMIT 1);

INSERT ministryapp.territorycheckout(CheckInGUID,CongregationNumber,TerritoryNumber,RequestUsername,bCheckOut,RequestDate,GroupGUID,CampaignGUID)
                             VALUES (vCheckInGUID,p_CongregationNumber,p_TerritoryNumber,p_RequestUsername,0,p_RequestDate,nullif(p_GroupGUID,''),vCampaignGUID);
                             
SELECT 0 'Error', 'Thank you!' Message; 
end;
end if;
END#