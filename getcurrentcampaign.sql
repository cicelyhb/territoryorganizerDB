#DROP PROCEDURE getcurrentcampaign;

delimiter #

CREATE PROCEDURE getcurrentcampaign (in p_CongregationNumber VARCHAR(10))
BEGIN

SELECT c.CampaignType,
       ct.CampaignDescription,
       DATEDIFF(Enddate, now() ) Days,
       YEAR(Enddate) Year,
       c.MessageBoard
FROM ministryapp.campaign c
INNER JOIN ministryapp.campaigntype ct ON c.CampaignType=ct.CampaignType
WHERE CongregationNumber = p_CongregationNumber AND 
       now() BETWEEN Startdate and Enddate;
      
END#

delimiter ;