

#DROP PROCEDURE confirmation;

delimiter #

CREATE PROCEDURE confirmation (

                                in p_Username VARCHAR(10),
                                in p_ConfirmationNumber VARCHAR(120)						
                              )
BEGIN

if (select 1=1 from ministryapp.user_emailconfirmation where username = p_Username and EmailSent = 0) then
begin
    UPDATE ministryapp.user_emailconfirmation SET ConfirmationNumber = p_ConfirmationNumber , EmailSent = 1, DateModified = now() WHERE username = p_Username;
    SELECT 0 'Error', 'Confirmation Successful.' Message;
end;
end if;

if (select 1=1 from ministryapp.user_emailconfirmation where username = p_Username and EmailSent = 1) then
begin
    SELECT 1 'Error', concat('Email already sent for user ',p_Username) Message;
end;
end if;


END#

delimiter ;
