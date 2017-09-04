
#DROP PROCEDURE getterritory;

delimiter #

CREATE PROCEDURE getterritory (in p_CongregationNumber VARCHAR(10))
BEGIN

SELECT  tc.TerritoryNumber,
        Polygon,
        tc.LatLng 'Center',
        IFNULL(bCheckOut, 0) 'CheckOut',
		RequestUsername,
		RequestDate,
		ResponseDate,
		Firstname,
        IFNULL(MiddleInit, '') MiddleInit,
        Lastname,
        IFNULL(GroupName, '') GroupName
FROM ministryapp.territorycard tc  
     LEFT JOIN ministryapp.territorycheckout tco 
     LEFT JOIN ministryapp.user_account usr ON tco.ExpiredDate>now() AND tco.RequestUsername=usr.Username
     LEFT JOIN ministryapp.user_profile prf ON usr.UserID=prf.UserID
     LEFT JOIN ministryapp.territorygroup tgr ON tco.GroupGUID=tgr.GroupGUID
ON tc.CongregationNumber=tco.CongregationNumber AND tc.TerritoryNumber=tco.TerritoryNumber AND tco.bCheckOut = 1 AND tco.ExpiredDate > now()
WHERE tc.CongregationNumber = p_CongregationNumber AND 
      tc.Enabled = 1;
   
END#

delimiter ;