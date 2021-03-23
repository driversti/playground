CREATE TABLE IF NOT EXISTS brand
(
    id      INT     NOT NULL,
    name    VARCHAR NOT NULL UNIQUE,
    country VARCHAR,
    founded date,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS model
(
    id          INT     NOT NULL,
    name        VARCHAR NOT NULL UNIQUE,
    description VARCHAR,
    brand_id    INT,
    PRIMARY KEY (id),
    CONSTRAINT fk_brand FOREIGN KEY (brand_id) REFERENCES brand
);

CREATE TYPE EngineConfiguration AS ENUM ('R4', 'R6', 'V6', 'V8', 'V10', 'V12', 'VR6', 'W12');

CREATE TYPE FuelType AS ENUM ('Diesel', 'Petrol');

CREATE TABLE IF NOT EXISTS engine
(
    id                   INT                 NOT NULL,
    family               VARCHAR             NOT NULL,
    model                VARCHAR             NOT NULL,
    engine_configuration EngineConfiguration NOT NULL,
    fuel_type            FuelType            NOT NULL,
    displacement         NUMERIC(4, 2)       NOT NULL,
    brand_id             INT,
    PRIMARY KEY (id),
    CONSTRAINT fk_brand FOREIGN KEY (brand_id) REFERENCES brand
);

INSERT INTO brand VALUES (1, 'Tesla', 'Germany', '2003-07-01');
INSERT INTO brand VALUES (2, 'Audi', 'USA', '1909-07-16');
INSERT INTO brand VALUES (3, 'KIA', 'South Korea', '1944-12-01');
INSERT INTO brand VALUES (4, 'Toyota', 'Japan', '1937-08-28');
INSERT INTO brand VALUES (5, 'Mercedes-Benz', 'Germany', '1926-06-28');
INSERT INTO brand VALUES (6, 'Volkswagen', 'Germany', '1900-01-01');
INSERT INTO brand VALUES (7, 'BMW', 'Germany', '1900-01-01');

INSERT INTO model VALUES (1, 'Model S', 'Full-size luxury car (E)', 1);
INSERT INTO model VALUES (2, 'Camry', 'Compact car: 1982–1998, Mid-size car: since 1991', 4);
INSERT INTO model VALUES (3, 'Prius', 'A full hybrid electric automobile', 4);
INSERT INTO model VALUES (4, 'New Model', 'A brand-new model', null);
INSERT INTO model VALUES (5, 'Model X', 'Mid-size luxury crossover SUV', 1);
INSERT INTO model VALUES (6, 'Model 3', 'Compact executive car (D)', 1);
INSERT INTO model VALUES (7, 'A7', 'A five-door executive car (D), liftback', 2);
INSERT INTO model VALUES (8, 'A3', 'A small family executive car', 2);

INSERT INTO engine VALUES (1, 'OM604', '915', 'R4', 'Diesel', 2.0, 5);
INSERT INTO engine VALUES (2, 'OM604', '910', 'R4', 'Diesel', 2.2, 5);
INSERT INTO engine VALUES (3, 'M104', '995', 'R6', 'Petrol', 3.2, 5);
INSERT INTO engine VALUES (4, 'EA113', 'TSI/TFSI', 'R4', 'Petrol', 2.0, 6);
INSERT INTO engine VALUES (5, 'EA888', 'Gen 1 TSI', 'R4', 'Petrol', 2.0, 6);
INSERT INTO engine VALUES (6, 'EA888', 'Gen 2 TSI', 'R4', 'Petrol', 2.0, 6);
INSERT INTO engine VALUES (7, 'EA888', 'Gen 3 TSI', 'R4', 'Petrol', 2.0, 6);
INSERT INTO engine VALUES (8, 'B48', 'Turbo', 'R4', 'Petrol', 2.0, 7);
INSERT INTO engine VALUES (9, 'S54', '', 'R6', 'Petrol', 3.2, 7);
INSERT INTO engine VALUES (10, 'N54', '', 'R6', 'Petrol', 3.0, 7);
INSERT INTO engine VALUES (11, 'N63', 'Turbo', 'V8', 'Petrol', 4.4, 7);
INSERT INTO engine VALUES (12, 'S63', 'Turbo', 'V8', 'Petrol', 4.4, 7);