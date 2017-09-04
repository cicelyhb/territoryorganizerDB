#DROP PROCEDURE saveschcampaigns;

delimiter #

CREATE PROCEDURE saveschcampaigns (in p_CongregationNumber VARCHAR(10), 
                                   in p_CampaignType VARCHAR(10),
                                   in p_Startdate DATETIME,
                                   in p_Enddate DATETIME
                                   )
BEGIN
declare vCampaignGUID varchar(150);

if not exists (select 1=1 from ministryapp.campaign where CongregationNumber = p_CongregationNumber and Startdate = p_Startdate and Enddate = p_Enddate) then
begin     
	if not exists(select 1=1 from ministryapp.campaign where CongregationNumber = p_CongregationNumber and Startdate between p_Startdate and p_Enddate) then 
	begin 
		SET vCampaignGUID = UUID();      
		INSERT ministryapp.campaign (CampaignGUID,CongregationNumber,CampaignType,Startdate,Enddate) 
							  VALUES(vCampaignGUID,p_CongregationNumber,p_CampaignType,p_Startdate,p_Enddate);
		SELECT 0 'Error','This campaign has been scheduled sucessfully' Message, vCampaignGUID 'CampaignGUID';
	end;
	else
	begin
		SELECT 1 'Error','Cannot schedule campaign inside another existing campaign' Message, '' 'CampaignGUID';
	end;
	end if;                        
end;
else
begin
	SELECT 1 'Error','This schedule already exist' Message,'' 'CampaignGUID';
end;
end if;    
END#

delimiter ;