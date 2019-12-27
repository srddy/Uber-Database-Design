CREATE PROCEDURE ride_price_calculation6 (RIDE_ID IN CurrRide.ride_id%TYPE) IS
  CURSOR RIDE_DETAILS IS SELECT * FROM CurrRide where CurrRide.ride_id = RIDE_ID;
  RIDE_ID1 CurrRide.ride_id%TYPE;
  PICKUP_LOCATION CurrRide.pickup_location%TYPE;
  DESTINATION CurrRide.destination%TYPE;
  SURGE CurrRide.surge%TYPE;
  ELAPSED_DISTANCE CurrRide.elapsed_distance%TYPE;
  ELAPSED_TIME CurrRide.elapsed_time%TYPE;
  PASSENGER_ID CurrRide.passenger_id%TYPE;
  DRIVER_ID CurrRide.driver_id%TYPE;
  PRICE CompleteRide.price%TYPE;
BEGIN
  OPEN RIDE_DETAILS;
    FETCH RIDE_DETAILS INTO RIDE_ID1, PICKUP_LOCATION, DESTINATION, SURGE, ELAPSED_DISTANCE, ELAPSED_TIME, PASSENGER_ID, DRIVER_ID;
    PRICE := 1.50 + 0.2*ELAPSED_TIME + 1.2*(ELAPSED_DISTANCE) + 2*(surge);
    INSERT INTO CompleteRide (ride_id, pickup_location, destination, surge, total_distance, total_time, passenger_id, driver_id, price) VALUES (RIDE_ID1, PICKUP_LOCATION, DESTINATION, SURGE, ELAPSED_DISTANCE, ELAPSED_TIME, PASSENGER_ID, DRIVER_ID, PRICE);
  CLOSE RIDE_DETAILS;
  DELETE FROM CurrRide WHERE ride_id = RIDE_ID1;
END;
