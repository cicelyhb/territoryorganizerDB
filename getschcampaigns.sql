#DROP PROCEDURE getschcampaigns;

delimiter #

CREATE PROCEDURE getschcampaigns (in p_CongregationNumber VARCHAR(10))
BEGIN

SELECT c.CampaignGUID,
       c.CampaignType,
       c.Startdate,
       c.Enddate,
       ct.CampaignDescription,
       c.MessageBoard
FROM ministryapp.campaign c
INNER JOIN ministryapp.campaigntype ct ON c.CampaignType=ct.CampaignType
WHERE CongregationNumber = p_CongregationNumber AND 
      Enddate > now()
ORDER BY  c.Startdate;
      
END#

delimiter ;