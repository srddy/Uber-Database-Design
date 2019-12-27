CREATE OR REPLACE TRIGGER update_availability
  AFTER UPDATE ON Car
  FOR EACH ROW
DECLARE
    condition Car.curr_condition%TYPE;
BEGIN
    condition := :NEW.curr_condition;
    IF condition = 'bad'
    THEN
    UPDATE Driver SET availability = 'No' WHERE license_plate = :NEW.license_plate;
    END IF;
END;
