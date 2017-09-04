use ministryapp;
#DROP PROCEDURE searchcongregations;

delimiter #

CREATE PROCEDURE searchcongregations (in p_ZipCode VARCHAR(5))
BEGIN
SELECT CongregationNumber,CongregationName
FROM ministryapp.congregation
WHERE ZipCode = p_ZipCode;
END#

delimiter ;