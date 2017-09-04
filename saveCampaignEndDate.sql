#DROP PROCEDURE saveCampaignEndDate;

delimiter #

CREATE PROCEDURE saveCampaignEndDate (
                                in p_CampaignGUID VARCHAR(150),
                                in p_CongregationNumber VARCHAR(10),
                                in p_Enddate DATETIME
                              )
BEGIN
declare vUserID bigint;

if (select 1=1 from ministryapp.campaign where CampaignGUID = p_CampaignGUID and CongregationNumber = p_CongregationNumber ) then
begin     
SET SQL_SAFE_UPDATES = 0;    
                         
	UPDATE ministryapp.campaign
    SET Enddate = p_Enddate
    WHERE CampaignGUID = p_CampaignGUID AND CongregationNumber = p_CongregationNumber;
    
	UPDATE ministryapp.territorycheckout
    SET ExpiredDate = p_Enddate
    WHERE CongregationNumber = p_CongregationNumber AND CampaignGUID = p_CampaignGUID;  
    
SET SQL_SAFE_UPDATES = 1;      

    SELECT 0 'Error', 'Enddate Updated' Message;                                 
end;
end if;



END#

delimiter ;