#DROP PROCEDURE setISubmit;

delimiter #

CREATE PROCEDURE setISubmit ()
BEGIN
DECLARE i INT DEFAULT 1;
DECLARE xml text;
DECLARE irow INT;
DECLARE imax INT;
DECLARE irow1 INT;
DECLARE imax1 INT;
DECLARE typedesc varchar(100);
DECLARE vAddressGUID varchar(150);

CREATE TEMPORARY Table IF NOT EXISTS xmlTable
(
rid bigint not null primary key auto_increment,
AddressGUID varchar(150),
xmlDoc text
); 

CREATE TEMPORARY Table IF NOT EXISTS terrType
(
  rid bigint not null primary key auto_increment,
  Type varchar(10),
  TypeDescription varchar(100)
); 

CREATE TEMPORARY Table IF NOT EXISTS NOC
(
AddressGUID varchar(150),
iTotal INT,
typeDescription varchar(150)
); 

INSERT INTO xmlTable(AddressGUID,xmlDoc)
SELECT AddressGUID,Notes
FROM ministryapp.territory
WHERE bTouched = 1 AND
Notes IS NOT NULL AND
Notes LIKE '%Not Home%';

INSERT INTO terrType(Type,TypeDescription)
SELECT Type,TypeDescription
FROM ministryapp.types
WHERE Type NOT IN ('NH','HH');

SET irow = (SELECT min(rid) FROM xmlTable);
SET imax = (SELECT max(rid) FROM xmlTable); 

SET irow1 = (SELECT min(rid) FROM terrType);
SET imax1 = (SELECT max(rid) FROM terrType); 

WHILE(irow <= imax) DO	
	SET xml = (SELECT xmlDoc FROM xmlTable WHERE rid = iRow);
	SET vAddressGUID = (SELECT AddressGUID FROM xmlTable WHERE rid = irow); 
    
     WHILE(irow1 <= imax1) DO
         SET typedesc = (SELECT TypeDescription FROM terrType WHERE rid = irow1);
         SET xml = replace(xml,typedesc,'');
     	 SET irow1 = irow1 + 1;
     END WHILE;
         SET xml = replace(xml,'No Trespassing','');
         SET xml = replace(xml,'Home','!Home');           
         SET xml = replace(xml,'Not !Home','Not@Home@'); 
         SET xml = replace(xml,'!Home','');       
         SET xml = replace(xml,'Phone','');  
         SET xml = replace(xml,'undefined','');         
       
         
	 WHILE i < 2 DO
        INSERT INTO NOC(AddressGUID,iTotal,typeDescription)
		SELECT vAddressGUID, (LENGTH(ExtractValue(xml, '//typedescription[$i]')) - LOCATE('Not@Home@', REVERSE(ExtractValue(xml, '//typedescription[$i]')))+1)/10 , ExtractValue(xml, '//typedescription[$i]');
		SET i = i+1;
	 END WHILE;
     SET i=1;
     
	 UPDATE ministryapp.territory
     SET iSubmit = (SELECT iTotal FROM NOC WHERE AddressGUID = vAddressGUID)
     WHERE  AddressGUID = vAddressGUID;
     
     SET irow1 = (SELECT min(rid) FROM terrType);
	 SET irow = irow + 1;
END WHILE;

DROP TEMPORARY TABLE IF EXISTS xmlTable; 
DROP TEMPORARY TABLE IF EXISTS terrType; 
DROP TEMPORARY TABLE IF EXISTS NOC;  
END#

delimiter ;