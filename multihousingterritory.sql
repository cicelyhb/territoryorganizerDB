
#DROP PROCEDURE multihousingterritory;

delimiter #

CREATE PROCEDURE multihousingterritory (in p_CongregationNumber VARCHAR(10), 
                                        in p_TerritoryNumber VARCHAR(10), 
                                        in p_bUnit TINYINT,
                                        in p_bMulti TINYINT)
BEGIN
declare xmldata text;
declare vPlaceID varchar(100);
declare vFormattedAddress varchar(255);
declare irow1 int;
declare imax1 int;
declare irow2 int;
declare imax2 int;

SET xmldata = '<Territory>';

CREATE TEMPORARY Table IF NOT EXISTS xmlTable
(
rid bigint not null primary key auto_increment,
xmlDoc text not null
); 

CREATE TEMPORARY Table IF NOT EXISTS xmlTerritory
(
rid bigint not null primary key auto_increment,
CongregationNumber varchar(10),
TerritoryNumber  varchar(10),
FormattedAddress varchar(255),
PlaceID varchar(100),
xmlDoc text null
); 

if (p_bUnit = 1) then
begin 
INSERT INTO xmlTerritory(CongregationNumber,TerritoryNumber,FormattedAddress,PlaceID)
SELECT CongregationNumber,TerritoryNumber,FormattedAddress,PlaceID
FROM ministryapp.territory
WHERE CongregationNumber = p_CongregationNumber AND 
      TerritoryNumber = p_TerritoryNumber AND
      bUnit = 1
GROUP BY  CongregationNumber,TerritoryNumber,FormattedAddress,PlaceID;   


SET irow1 = (SELECT min(rid) FROM xmlTerritory);
SET imax1 = (SELECT max(rid) FROM xmlTerritory); 

	WHILE(irow1 <= imax1) DO	
	    SET vPlaceID = (SELECT PlaceID FROM xmlTerritory WHERE rid = irow1);
        SET vFormattedAddress = (SELECT FormattedAddress FROM xmlTerritory WHERE rid = irow1);
        
		INSERT INTO xmlTable(xmlDoc)
		SELECT 
			 concat('<Address>'
			,concat('<AddressGUID>',AddressGUID,'</AddressGUID>') 
			,concat('<TerritoryNumber>',TerritoryNumber,'</TerritoryNumber>')
			,concat('<Latitude>',Latitude,'</Latitude>')
			,concat('<Longitude>',Longitude,'</Longitude>')   
			,concat('<FormattedAddress>',FormattedAddress,'</FormattedAddress>')
			,concat('<Type>',Type,'</Type>')
			,concat('<Resident>',COALESCE(Resident,''),'</Resident>')    
			,concat('<PhoneType>',PhoneType,'</PhoneType>')
			,concat('<Language>',Language,'</Language>')
			,concat('<InitialDate>',COALESCE(InitialDate,''),'</InitialDate>') 
			,concat('<Notes>',COALESCE(replace(replace(Notes,'<','&lt;'),'>','&gt;'),''),'</Notes>')    
			,concat('<DateModified>',COALESCE(DateModified,''),'</DateModified>') 
			,concat('<bPhone>',COALESCE(bPhone,''),'</bPhone>')     
			,concat('<Unit>',COALESCE(Unit,''),'</Unit>')    
			,concat('<bMulti>',COALESCE(bMulti,''),'</bMulti>')
			,concat('<bUnit>',COALESCE(bUnit,''),'</bUnit>')    
			,concat('<Phone>',COALESCE(Phone,''),'</Phone>') 
			,concat('<Building>',COALESCE(Building,''),'</Building>') 
			,concat('<bTouched>',COALESCE(bTouched,''),'</bTouched>') 
			,concat('<bLetter>',COALESCE(bLetter,''),'</bLetter>')    
			,concat('<LetterType>',COALESCE(LetterType,''),'</LetterType>')  
			,concat('<iSubmit>',COALESCE(iSubmit,''),'</iSubmit>')              
			,'</Address>') Territory       
		FROM ministryapp.territory 
		WHERE CongregationNumber = p_CongregationNumber AND 
			  TerritoryNumber = p_TerritoryNumber AND
			  PlaceID = vPlaceID AND
              FormattedAddress = vFormattedAddress AND
			  bUnit = 1
		ORDER BY FormattedAddress,Unit;
        
		SET irow2 = (SELECT min(rid) FROM xmlTable);
		SET imax2 = (SELECT max(rid) FROM xmlTable);



			WHILE(irow2 <= imax2) DO		
				SET xmldata = (SELECT concat(xmldata,xmlDoc) FROM xmlTable WHERE rid = irow2);
				
				SET irow2 = irow2 + 1;
			END WHILE;

		SET xmldata = concat(xmldata,'</Territory>');     
        
        UPDATE xmlTerritory
        SET xmlDoc = xmldata
        WHERE rid = irow1;
        
        TRUNCATE TABLE xmlTable;
        
        SET xmldata = '<Territory>';
		
		SET irow1 = irow1 + 1;
	END WHILE;
      

	SELECT 
			 a.TerritoryNumber
			,a.Latitude
			,a.Longitude
			,a.FormattedAddress
			,e.xmlDoc Territory 
			,COALESCE(c.BuildingName,d.BuildingDescription) Building
			,a.PlaceID
	FROM ministryapp.territory a 
	INNER JOIN
		(
			 SELECT Latitude,
					Longitude,
					PlaceID,
					CongregationNumber,
					TerritoryNumber
			 FROM ministryapp.territory 
			 WHERE CongregationNumber= p_CongregationNumber AND
				   TerritoryNumber= p_TerritoryNumber  AND
				   bUnit = 1 
			 GROUP BY Latitude,
					  Longitude,
					  PlaceID,
					  CongregationNumber,
					  TerritoryNumber
			 HAVING Count(*)>1 
		) b  ON   a.CongregationNumber=b.CongregationNumber AND a.TerritoryNumber=b.TerritoryNumber AND a.PlaceID=b.PlaceID
	INNER JOIN ministryapp.building c      
			 ON a.PlaceID=c.PlaceID AND a.CongregationNumber=c.CongregationNumber AND a.TerritoryNumber=c.TerritoryNumber
	INNER JOIN ministryapp.buildingtype d  
			 ON c.BuildingType=d.BuildingType
    INNER JOIN xmlTerritory e
             ON a.CongregationNumber=e.CongregationNumber AND a.TerritoryNumber=e.TerritoryNumber AND a.PlaceID=e.PlaceID AND a.FormattedAddress=e.FormattedAddress
	WHERE a.bUnit = 1 
	GROUP BY 
			 a.TerritoryNumber
			,a.Latitude
			,a.Longitude
			,a.FormattedAddress
			,a.PlaceID
			
	ORDER BY a.Latitude
			,a.Longitude
			,a.FormattedAddress;


    

end;					
end if;
 
if (p_bMulti = 1) then
begin
INSERT INTO xmlTerritory(CongregationNumber,TerritoryNumber,FormattedAddress,PlaceID)
SELECT CongregationNumber,TerritoryNumber,FormattedXYAddress,PlaceID
FROM ministryapp.territory
WHERE CongregationNumber = p_CongregationNumber AND 
      TerritoryNumber = p_TerritoryNumber AND
      bMulti = 1
GROUP BY  CongregationNumber,TerritoryNumber,FormattedXYAddress,PlaceID;   


SET irow1 = (SELECT min(rid) FROM xmlTerritory);
SET imax1 = (SELECT max(rid) FROM xmlTerritory); 

	WHILE(irow1 <= imax1) DO	
	    SET vPlaceID = (SELECT PlaceID FROM xmlTerritory WHERE rid = irow1);
        SET vFormattedAddress = (SELECT FormattedAddress FROM xmlTerritory WHERE rid = irow1);
        
		INSERT INTO xmlTable(xmlDoc)
		SELECT 
			 concat('<Address>'
			,concat('<AddressGUID>',AddressGUID,'</AddressGUID>') 
			,concat('<TerritoryNumber>',TerritoryNumber,'</TerritoryNumber>')
			,concat('<Latitude>',Latitude,'</Latitude>')
			,concat('<Longitude>',Longitude,'</Longitude>')   
			,concat('<FormattedAddress>',FormattedAddress,'</FormattedAddress>')
			,concat('<Type>',Type,'</Type>')
			,concat('<Resident>',COALESCE(Resident,''),'</Resident>')    
			,concat('<PhoneType>',PhoneType,'</PhoneType>')
			,concat('<Language>',Language,'</Language>')
			,concat('<InitialDate>',COALESCE(InitialDate,''),'</InitialDate>') 
			,concat('<Notes>',COALESCE(replace(replace(Notes,'<','&lt;'),'>','&gt;'),''),'</Notes>')    
			,concat('<DateModified>',COALESCE(DateModified,''),'</DateModified>') 
			,concat('<bPhone>',COALESCE(bPhone,''),'</bPhone>')     
			,concat('<Unit>',COALESCE(Unit,''),'</Unit>')    
			,concat('<bMulti>',COALESCE(bMulti,''),'</bMulti>')
			,concat('<bUnit>',COALESCE(bUnit,''),'</bUnit>')    
			,concat('<Phone>',COALESCE(Phone,''),'</Phone>') 
			,concat('<Building>',COALESCE(Building,''),'</Building>')    
			,concat('<bTouched>',COALESCE(bTouched,''),'</bTouched>')     
			,concat('<bLetter>',COALESCE(bLetter,''),'</bLetter>')    
			,concat('<LetterType>',COALESCE(LetterType,''),'</LetterType>')    
			,concat('<iSubmit>',COALESCE(iSubmit,''),'</iSubmit>')             
			,'</Address>') Territory       
		FROM ministryapp.territory 
		WHERE CongregationNumber = p_CongregationNumber AND 
			  TerritoryNumber = p_TerritoryNumber AND
			  PlaceID = vPlaceID AND
              FormattedXYAddress = vFormattedAddress AND              
			  bMulti = 1
		ORDER BY FormattedAddress;
        
		SET irow2 = (SELECT min(rid) FROM xmlTable);
		SET imax2 = (SELECT max(rid) FROM xmlTable);



			WHILE(irow2 <= imax2) DO		
				SET xmldata = (SELECT concat(xmldata,xmlDoc) FROM xmlTable WHERE rid = irow2);
				
				SET irow2 = irow2 + 1;
			END WHILE;

		SET xmldata = concat(xmldata,'</Territory>');     
        
        UPDATE xmlTerritory
        SET xmlDoc = xmldata
        WHERE rid = irow1;
        
        TRUNCATE TABLE xmlTable;
        
        SET xmldata = '<Territory>';
		
		SET irow1 = irow1 + 1;
	END WHILE;
    
    
    
	SELECT 
			 a.TerritoryNumber
			,a.Latitude
			,a.Longitude
			,a.FormattedXYAddress
			,e.xmlDoc Territory 
			,COALESCE(c.BuildingName,d.BuildingDescription) Building
			,a.PlaceID
	FROM ministryapp.territory a 
	INNER JOIN
		(
			 SELECT Latitude,
					Longitude,
					PlaceID,
					CongregationNumber,
					TerritoryNumber
			 FROM ministryapp.territory 
			 WHERE CongregationNumber= p_CongregationNumber AND
				   TerritoryNumber= p_TerritoryNumber  AND
				   bMulti = 1 
			 GROUP BY Latitude,
					  Longitude,
					  PlaceID,
					  CongregationNumber,
					  TerritoryNumber
			 HAVING Count(*)>1 
		) b  ON   a.CongregationNumber=b.CongregationNumber AND a.TerritoryNumber=b.TerritoryNumber AND a.PlaceID=b.PlaceID
	INNER JOIN ministryapp.building c      
			 ON a.PlaceID=c.PlaceID AND a.CongregationNumber=c.CongregationNumber AND a.TerritoryNumber=c.TerritoryNumber
	INNER JOIN ministryapp.buildingtype d  
			 ON c.BuildingType=d.Buildingtype
    INNER JOIN xmlTerritory e
             ON a.CongregationNumber=e.CongregationNumber AND a.TerritoryNumber=e.TerritoryNumber AND a.PlaceID=e.PlaceID AND a.FormattedXYAddress=e.FormattedAddress
	WHERE a.bMulti = 1 
	GROUP BY 
			 a.TerritoryNumber
			,a.Latitude
			,a.Longitude
			,a.FormattedXYAddress
			,a.PlaceID
			
	ORDER BY a.Latitude
			,a.Longitude
			,a.FormattedXYAddress;    
end;
end if;

DROP TEMPORARY TABLE IF EXISTS xmlTable; 
DROP TEMPORARY TABLE IF EXISTS xmlTerritory; 
END#

delimiter ;