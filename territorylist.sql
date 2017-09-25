

#DROP PROCEDURE territorylist;

delimiter #

CREATE PROCEDURE territorylist (in p_CongregationNumber VARCHAR(10))
BEGIN
declare startdate datetime;
declare terrCount int;
declare terrChg int;
declare vTerritoryNumber varchar(10);
declare irow int;
declare imax int;

CREATE TEMPORARY Table IF NOT EXISTS listTable1
(
rid bigint not null primary key auto_increment,
TerritoryNumber varchar(10) not null
); 

CREATE TEMPORARY Table IF NOT EXISTS listTable2
(
rid bigint not null primary key auto_increment,
TerritoryNumber varchar(10) not null,
Percentage int not null,
Total int not null
); 

INSERT INTO listTable1(TerritoryNumber) 
SELECT a.TerritoryNumber
FROM ministryapp.territory a
INNER JOIN ministryapp.territorycard b
	ON a.CongregationNumber=b.CongregationNumber AND
       a.TerritoryNumber=b.TerritoryNumber
WHERE a.CongregationNumber=p_CongregationNumber AND b.Enabled = 1
GROUP BY a.TerritoryNumber
ORDER BY b.iSort,a.TerritoryNumber;

SET startdate = CONVERT('2016-01-01',DATETIME);

SET irow = (SELECT min(rid) FROM listTable1);
SET imax = (SELECT max(rid) FROM listTable1);

	WHILE(irow <= imax) DO		
        SET vTerritoryNumber = (SELECT TerritoryNumber FROM listTable1 WHERE RID = irow);
        
        SET terrCount = (SELECT count(1) FROM ministryapp.territory WHERE CongregationNumber=p_CongregationNumber AND territorynumber=vTerritoryNumber);
		SET terrChg = (SELECT count(1) FROM ministryapp.territory WHERE CongregationNumber=p_CongregationNumber AND territorynumber=vTerritoryNumber AND DateModified >= startdate);
        
		INSERT INTO listTable2(TerritoryNumber,Percentage,Total)
		SELECT vTerritoryNumber, CONVERT((terrChg/terrCount)*100,SIGNED),terrCount;
		
		SET irow = irow + 1;
	END WHILE;



SELECT 'Territory' Territory, 
       tc.TerritoryNumber,
       tc.Percentage,
       tc.Total,
       IFNULL(bCheckOut,0) bCheckOut, 
       IFNULL(DNC,0) DNC, 
       IFNULL(cPhone,0) Phone, 
	   RequestUsername,
	   RequestDate,
	   ResponseDate,
	   Firstname,
	   IFNULL(MiddleInit, '') MiddleInit,
	   Lastname,
	   IFNULL(GroupName, '') GroupName,
       IFNULL(cLetter,0) Letter,
       IFNULL(cNH,0) NH      
FROM listTable2 tc 
     INNER JOIN ministryapp.territorycard tcd ON tcd.CongregationNumber=p_CongregationNumber AND tc.TerritoryNumber=tcd.TerritoryNumber
     LEFT JOIN ministryapp.territorycheckout tck ON tc.TerritoryNumber=tck.TerritoryNumber AND tck.CongregationNumber = p_CongregationNumber AND tck.ExpiredDate >=now()
     LEFT JOIN ministryapp.user_account usr ON tck.ExpiredDate>now() AND tck.RequestUsername=usr.Username
     LEFT JOIN ministryapp.user_profile prf ON usr.UserID=prf.UserID
     LEFT JOIN ministryapp.territorygroup tgr ON tck.GroupGUID=tgr.GroupGUID
     LEFT JOIN 
 (
	 SELECT count(1) DNC,
			CongregationNumber,
			TerritoryNumber
	 FROM ministryapp.territory
	 WHERE Type='DNC'
	 GROUP BY   CongregationNumber,
				TerritoryNumber
) t    
 ON tc.TerritoryNumber=t.TerritoryNumber AND t.CongregationNumber  = p_CongregationNumber
      LEFT JOIN 
 (
   SELECT   count(1) cPhone,
   			CongregationNumber,
			TerritoryNumber
   FROM ministryapp.territory
   WHERE bPhone = 1
   GROUP BY   CongregationNumber,
			  TerritoryNumber   
 ) tp
  ON tc.TerritoryNumber=tp.TerritoryNumber AND tp.CongregationNumber  = p_CongregationNumber
      LEFT JOIN 
 (
   SELECT   count(1) cLetter,
   			CongregationNumber,
			TerritoryNumber
   FROM ministryapp.territory
   WHERE Type='WL'
   GROUP BY   CongregationNumber,
			  TerritoryNumber   
 ) tl
  ON tc.TerritoryNumber=tl.TerritoryNumber AND tl.CongregationNumber  = p_CongregationNumber
      LEFT JOIN 
 (
   SELECT   count(1) cNH,
   			CongregationNumber,
			TerritoryNumber
   FROM ministryapp.territory
   WHERE Type='NH' AND bTouched=1
   GROUP BY   CongregationNumber,
			  TerritoryNumber   
 ) tnh
  ON tc.TerritoryNumber=tnh.TerritoryNumber AND tnh.CongregationNumber  = p_CongregationNumber  
  
  ORDER BY tcd.iSort,tcd.TerritoryNumber;  


DROP TEMPORARY TABLE IF EXISTS listTable1;
DROP TEMPORARY TABLE IF EXISTS listTable2;
END#

delimiter ;