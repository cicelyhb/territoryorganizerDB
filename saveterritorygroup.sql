#DROP PROCEDURE saveterritorygroup;

delimiter #

CREATE PROCEDURE saveterritorygroup (in p_CongregationNumber VARCHAR(10), 
                                     in p_GroupName VARCHAR(100)
                                   )
BEGIN
declare vGroupGUID varchar(150);

if not exists (select 1=1 from ministryapp.territorygroup where CongregationNumber = p_CongregationNumber and GroupName = p_GroupName) then
begin     

		SET vGroupGUID = UUID();      
		INSERT ministryapp.territorygroup (GroupGUID,GroupName,CongregationNumber,ExpiredDate) 
							  VALUES(vGroupGUID,p_GroupName,p_CongregationNumber,'2040-01-01 00:00:00');

		SELECT 0 'Error','Service group has been added' Message, vGroupGUID 'GroupGUID';
                        
end;
else
begin
	SELECT 1 'Error','Service group already exist' Message,'' 'GroupGUID';
end;
end if;    
END#

delimiter ;