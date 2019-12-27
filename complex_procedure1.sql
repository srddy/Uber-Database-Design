CREATE PROCEDURE rating_drivers5 (DRIVER_ID IN Driver.driver_id%TYPE, RATING IN Driver.avg_rating%TYPE) IS
  CURSOR DRIVER_DETAILS IS SELECT Driver.avg_rating, Driver.num_ratings FROM Driver where Driver.driver_id = DRIVER_ID;
  AVG_RATINGS Driver.avg_rating%TYPE;
  NUM_RATINGS Driver.num_ratings%TYPE;
BEGIN
  UPDATE Driver SET Driver.num_ratings = NUM_RATINGS + 1 WHERE Driver.driver_id = DRIVER_ID;
  OPEN DRIVER_DETAILS;
  LOOP
    FETCH DRIVER_DETAILS INTO AVG_RATINGS, NUM_RATINGS;
    EXIT WHEN (DRIVER_DETAILS % NOTFOUND);
    UPDATE Driver SET Driver.avg_rating = (AVG_RATINGS*Driver.num_ratings + RATING)/(Driver.num_ratings + 1) WHERE Driver.driver_id = DRIVER_ID;
  END LOOP;
  CLOSE DRIVER_DETAILS;
END;
