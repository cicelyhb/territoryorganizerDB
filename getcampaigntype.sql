#DROP PROCEDURE getcampaigntype;

delimiter #

CREATE PROCEDURE getcampaigntype()
BEGIN


SELECT CampaignType,
       CampaignDescription
FROM ministryapp.campaigntype
ORDER BY CampaignType;

END#

delimiter ;