

#DROP PROCEDURE emailverification;

delimiter #

CREATE PROCEDURE emailverification (
                                in p_ConfirmationNumber VARCHAR(120)						
                              )
BEGIN
declare vUsername varchar(10);

if (select 1=1 from ministryapp.user_account ua inner join ministryapp.user_emailconfirmation ue on ua.Username = ue.Username where ConfirmationNumber = p_ConfirmationNumber and EmailVerification=0) then
begin
    SET vUsername = (SELECT Username FROM ministryapp.user_emailconfirmation WHERE ConfirmationNumber = p_ConfirmationNumber);
        
    UPDATE ministryapp.user_account SET EmailVerification = 1 WHERE Username = vUsername;
    
    SELECT 1 'Exist' , 1 'Activate';
end;
end if;
if (select 1=1 from ministryapp.user_account ua inner join ministryapp.user_emailconfirmation ue on ua.Username = ue.Username where ConfirmationNumber = p_ConfirmationNumber and EmailVerification=1) then
begin
    SELECT 1 'Exist' , 0 'Activate';
end; 
end if;   
if not exists(select 1=1 from ministryapp.user_emailconfirmation where ConfirmationNumber = p_ConfirmationNumber) then
begin
    SELECT 0 'Exist' , 0 'Activate';
end;
end if; 

END#

delimiter ;
