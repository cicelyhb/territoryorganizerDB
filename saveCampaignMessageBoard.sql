#DROP PROCEDURE saveCampaignMessageBoard;

delimiter #

CREATE PROCEDURE saveCampaignMessageBoard (
                                in p_CampaignGUID VARCHAR(150),
                                in p_CongregationNumber VARCHAR(10),
                                in p_MessageBoard VARCHAR(255)
                              )
BEGIN
declare vUserID bigint;

if (select 1=1 from ministryapp.campaign where CampaignGUID = p_CampaignGUID and CongregationNumber = p_CongregationNumber ) then
begin                                 
	UPDATE ministryapp.campaign
    SET MessageBoard = p_MessageBoard
    WHERE CampaignGUID = p_CampaignGUID AND CongregationNumber = p_CongregationNumber;

    SELECT 0 'Error', 'MessageBoard Updated' Message;                                 
end;
end if;



END#

delimiter ;