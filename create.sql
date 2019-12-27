CREATE TABLE model
(
  model_id           varchar(15)    NOT NULL,
  make               varchar(50)    NOT NULL,
  model_name              varchar(50)    NOT NULL,
  model_year               int            NOT NULL,
  model_type         varchar(50)    NOT NULL,
  PRIMARY KEY(model_id)
);

CREATE TABLE Card
(
  card_number           number(16) NOT NULL,
  exp_date           date   NOT NULL,
  PRIMARY KEY(card_number)
);

CREATE TABLE Car
(
  license_plate      varchar(7)     NOT NULL,
  purchase_date      date           NOT NULL,
  current_condition     varchar(50)    NOT NULL,
  model_id           varchar(15)    NOT NULL,
  PRIMARY KEY(license_plate),
  FOREIGN KEY (model_id) REFERENCES model (model_id)
);

CREATE TABLE Passenger
(
  passenger_id  varchar(15)     NOT NULL,
  first_name         varchar(50)     NOT NULL,
  last_name         varchar(50)     NOT NULL,
  phone_number     varchar(10)     NOT NULL,
  card_number      number(16)      NOT NULL,
  PRIMARY KEY(passenger_id),
  FOREIGN KEY (card_number) REFERENCES Card (card_number)
);

CREATE TABLE Requests
(
  request_id        varchar(15) NOT NULL,
  pickup_location   varchar(50) NOT NULL,
  destination_location      varchar(50) NOT NULL,
  request_time      timestamp   NOT NULL,
  surge             NUMBER(1)     NOT NULL CHECK(surge IN (1,0)),
  passenger_id      varchar(15) NOT NULL,
  PRIMARY KEY(request_id),
  FOREIGN KEY (passenger_id) REFERENCES Passenger (passenger_id)
);

CREATE TABLE Driver
(
  driver_id     varchar(15)      NOT NULL,
  first_name         varchar(50)      NOT NULL,
  last_name         varchar(50)      NOT NULL,
  number_of_hours_worked   decimal(8,2)     NOT NULL,
  license_plate varchar(7)       NOT NULL,
  average_rating    decimal(3,1)     NULL,
  number_of_ratings   int              NOT NULL,
  phone_number     varchar(10)      NOT NULL,
  availability  varchar(3)       NOT NULL,
  PRIMARY KEY(driver_id),
  FOREIGN KEY (license_plate) REFERENCES Car (license_plate) ON DELETE CASCADE
);

CREATE TABLE CurrentRide
(
  ride_id            varchar(15)    NOT NULL,
  pickup_location    varchar(50)    NOT NULL,
  destination_location        varchar(50)    NOT NULL,
  surge             NUMBER(1)     NOT NULL CHECK(surge IN (1,0)),
  elapsed_distance   int            NOT NULL,
  elapsed_time       numeric        NOT NULL,
  passenger_id       varchar(15)    NOT NULL,
  driver_id     varchar(15)      NOT NULL,
  PRIMARY KEY(ride_id),
  FOREIGN KEY (passenger_id) REFERENCES Passenger (passenger_id),
  FOREIGN KEY (driver_id) REFERENCES Driver (driver_id)
);

CREATE TABLE CompleteRide
(
  ride_id            varchar(15)    NOT NULL,
  pickup_location    varchar(50)    NOT NULL,
  destination_location        varchar(50)    NOT NULL,
  surge             NUMBER(1)     NOT NULL CHECK(surge IN (1,0)),
  total_distance     int            NOT NULL,
  total_time         numeric        NOT NULL,
  passenger_id       varchar(15)    NOT NULL,
  driver_id          varchar(15)    NOT NULL,
  price              decimal(8,2)   NOT NULL,
  PRIMARY KEY(ride_id),
  FOREIGN KEY (passenger_id) REFERENCES Passenger (passenger_id),
  FOREIGN KEY (driver_id) REFERENCES Driver (driver_id)
);
