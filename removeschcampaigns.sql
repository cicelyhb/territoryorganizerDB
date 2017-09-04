#DROP PROCEDURE removeschcampaigns;

delimiter #

CREATE PROCEDURE removeschcampaigns (in p_CampaignGUID VARCHAR(150))
BEGIN

DELETE
FROM ministryapp.campaign
WHERE CampaignGUID = p_CampaignGUID;
      
SELECT 0 'Error', 'Campaign deleted.'  Message;		      
END#

delimiter ;