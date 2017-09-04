#DROP PROCEDURE checkoutRequests;

delimiter #

CREATE PROCEDURE checkoutRequests (in p_CongregationNumber VARCHAR(10))
BEGIN
declare vStartdate datetime;
declare vEnddate datetime;

SET vStartdate = (SELECT Startdate FROM ministryapp.campaign WHERE now() between Startdate and Enddate);
SET vEnddate   = (SELECT Enddate FROM ministryapp.campaign WHERE now() between Startdate and Enddate);

SELECT tco.CongregationNumber,
       tco.TerritoryNumber,
       CheckInGUID,
       RequestUsername,
       RequestDate,
       Firstname,
       IFNULL(MiddleInit, '') MiddleInit,
       Lastname,
       IFNULL(GroupName, '') GroupName
FROM ministryapp.territorycheckout tco 
     INNER JOIN ministryapp.territorycard tcd ON tco.CongregationNumber=tcd.CongregationNumber AND tco.TerritoryNumber=tcd.TerritoryNumber
     INNER JOIN ministryapp.user_account usr ON tco.RequestUsername=usr.Username
     INNER JOIN ministryapp.user_profile prf ON usr.UserID=prf.UserID
     LEFT JOIN  ministryapp.territorygroup tgp ON tco.GroupGUID=tgp.GroupGUID
WHERE  tco.CongregationNumber = p_CongregationNumber AND
       tco.bCheckOut = 0 AND
       RequestDate BETWEEN vStartdate and vEnddate
ORDER BY tcd.iSort,tcd.TerritoryNumber;
       
       
END#       