ALTER TABLE ministryapp.territory ADD bLetter tinyint;

SET SQL_SAFE_UPDATES = 0; 
UPDATE ministryapp.territory
SET bLetter = 0;
SET SQL_SAFE_UPDATES = 0; 

ALTER TABLE ministryapp.territory MODIFY COLUMN bLetter tinyint NOT NULL;


ALTER TABLE ministryapp.territory ADD LetterType VARCHAR(10);

SET SQL_SAFE_UPDATES = 0; 
UPDATE ministryapp.territory
SET LetterType = 'LNS';
SET SQL_SAFE_UPDATES = 0; 

ALTER TABLE ministryapp.territory MODIFY COLUMN LetterType VARCHAR(10) NOT NULL;
