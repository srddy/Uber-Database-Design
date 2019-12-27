CREATE OR REPLACE TRIGGER update_working_hours
  AFTER INSERT ON CompleteRide
  FOR EACH ROW
WHEN (NEW.driver_id > 0)
DECLARE
    DRIVER_ID1 CompleteRide.driver_id%TYPE;
    TOTAL_TIME1 CompleteRide.total_time%TYPE;
BEGIN
    DRIVER_ID1 := :NEW.driver_id;
    TOTAL_TIME1 := :NEW.total_time;
    UPDATE Driver SET working_hours = working_hours + TOTAL_TIME1 WHERE driver_id = DRIVER_ID1;
END;
