CREATE TABLE ministryapp.types (
  Type varchar(10) NOT NULL,
  TypeDescription varchar(100) DEFAULT NULL,
  PRIMARY KEY(Type)
);

INSERT INTO ministryapp.types(Type,TypeDescription)
VALUES('DNC','Do Not Call');

INSERT INTO ministryapp.types(Type,TypeDescription)
VALUES('DNS','Danger Not Safe');

INSERT INTO ministryapp.types(Type,TypeDescription)
VALUES('HH','Home');

INSERT INTO ministryapp.types(Type,TypeDescription)
VALUES('NH','Not Home');

INSERT INTO ministryapp.types(Type,TypeDescription)
VALUES('NTR','No Trespassing/Gated');

INSERT INTO ministryapp.types(Type,TypeDescription)
VALUES('PC','Phone Call');

INSERT INTO ministryapp.types(Type,TypeDescription)
VALUES('WL','Write Letter');


INSERT INTO ministryapp.types(Type,TypeDescription)
VALUES('AP','Answered Phone');

INSERT INTO ministryapp.types(Type,TypeDescription)
VALUES('PD','Disconnected');

INSERT INTO ministryapp.types(Type,TypeDescription)
VALUES('NA','No Answer');

INSERT INTO ministryapp.types(Type,TypeDescription)
VALUES('NC','Not Called');

INSERT INTO ministryapp.types(Type,TypeDescription)
VALUES('VM','Voice Message');


INSERT INTO ministryapp.types(Type,TypeDescription)
VALUES('LNS','Letter Not Sent');

INSERT INTO ministryapp.types(Type,TypeDescription)
VALUES('LS','Letter Sent');


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

ALTER TABLE ministryapp.territory ADD iSubmit INT;

SET SQL_SAFE_UPDATES = 0; 
UPDATE ministryapp.territory
SET iSubmit = 0;
SET SQL_SAFE_UPDATES = 0; 

call setISubmit ();
