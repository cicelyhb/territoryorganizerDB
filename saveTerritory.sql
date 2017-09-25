#DROP PROCEDURE saveTerritory;

delimiter #

CREATE PROCEDURE saveTerritory (p_Type VARCHAR(10),
								p_PhoneType VARCHAR(10),
								p_Language VARCHAR(50),
								p_Notes TEXT,
								p_InitialDate DATETIME,
								p_DateModified DATETIME,
								p_LetterType VARCHAR(10),
								p_AddressGUID VARCHAR(150)
)
BEGIN
DECLARE i INT DEFAULT 1;
DECLARE xml text;
DECLARE irow1 INT;
DECLARE imax1 INT;
DECLARE typedesc varchar(100);
DECLARE iTotal INT;
CREATE TEMPORARY Table IF NOT EXISTS terrType
(
  rid bigint not null primary key auto_increment,
  Type varchar(10),
  TypeDescription varchar(100)
); 

INSERT INTO terrType(Type,TypeDescription)
SELECT Type,TypeDescription
FROM ministryapp.types
WHERE Type NOT IN ('NH','HH');

SET irow1 = (SELECT min(rid) FROM terrType);
SET imax1 = (SELECT max(rid) FROM terrType); 
                  
SET xml = p_Notes;         
     
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
         

		SET iTotal = (SELECT (LENGTH(ExtractValue(xml, '//typedescription[$i]')) - LOCATE('Not@Home@', REVERSE(ExtractValue(xml, '//typedescription[$i]')))+1)/10);
 
   
UPDATE ministryapp.territory 
SET Type = p_Type,
            PhoneType = p_PhoneType,
            Language = p_Language,
            Notes = p_Notes,
            InitialDate = p_InitialDate,
            DateModified = p_DateModified, 
            bTouched = 1,  
            LetterType = p_LetterType            
WHERE AddressGUID = p_AddressGUID;

       
UPDATE ministryapp.territory  
SET iSubmit = iTotal 
WHERE AddressGUID = p_AddressGUID AND Type = 'NH';        
  

DROP TEMPORARY TABLE IF EXISTS terrType;        
END#

delimiter ;        