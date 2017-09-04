#DROP PROCEDURE removeterritoryaddress;

delimiter #

CREATE PROCEDURE removeterritoryaddress (
                                in p_CongregationNumber VARCHAR(10),                                
                                in p_TerritoryNumber VARCHAR(10),
                                in p_PlaceID VARCHAR(100)
                              )
BEGIN
declare vLanguage varchar(50);
declare vAddressGUID varchar(150);

if (select 1=1 from ministryapp.territory where CongregationNumber = p_CongregationNumber and TerritoryNumber = p_TerritoryNumber and PlaceID = p_PlaceID) then
begin

		DELETE FROM ministryapp.streets
		WHERE AddressGUID IN
		(
		SELECT AddressGUID 
		FROM ministryapp.territory 
		WHERE CongregationNumber = p_CongregationNumber AND 
			  TerritoryNumber = p_TerritoryNumber AND 
			  PlaceID = p_PlaceID
		); 
        
		DELETE FROM ministryapp.territory
		WHERE AddressGUID IN
		(
		SELECT AddressGUID 
		FROM ministryapp.territory 
		WHERE CongregationNumber = p_CongregationNumber AND 
			  TerritoryNumber = p_TerritoryNumber AND 
			  PlaceID = p_PlaceID
		); 

	    SELECT 0 'Error', 'Address has been deleted' Message; 
end;
else
begin        							
        SELECT 1 'Error', 'Address not exist' Message;                                                            
end;
end if;



END#