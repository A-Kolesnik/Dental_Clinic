-- Функции
-- ---------------------------------------------

-- Функция принимает наименование региона в качестве параметра и возвращает его id

DELIMITER //

DROP FUNCTION IF EXISTS get_state_id//
CREATE FUNCTION get_state_id(req_state_name VARCHAR(50))
RETURNS TINYINT DETERMINISTIC
BEGIN
   SET @s_id = (SELECT state_id
   FROM states
   WHERE state_name = req_state_name);
   RETURN @s_id;
END//

-- Функция принимает наименование города в качестве параметра и возвращает его id
DROP FUNCTION IF EXISTS get_city_id;
CREATE FUNCTION get_city_id(req_city_name VARCHAR(50))
RETURNS TINYINT DETERMINISTIC
BEGIN
   SET @c_id = (SELECT city_id
   FROM cities
   WHERE city_name = req_city_name);
   RETURN @c_id;
END//
DELIMITER ;

-- ---------------------------------------------

-- Хранимые процедуры
-- ---------------------------------------------

-- Хранимая процедура позволяет просмотреть всех пациентов лечащего врача
DELIMITER //

DROP PROCEDURE IF EXISTS show_doctors_patients//
CREATE PROCEDURE show_doctors_patients (IN doctor_name VARCHAR(50))
BEGIN
   DECLARE doc_id SMALLINT UNSIGNED DEFAULT 0;
   SET doc_id = (
                SELECT doctor_id
                FROM doctors
                WHERE full_name = doctor_name
                );
   SELECT full_name, born, contact, card
   FROM clients
   JOIN clients_link_doctors
   ON clients.client_id = clients_link_doctors.client_id
   WHERE clients_link_doctors.doctor_id = doc_id;
END //

DELIMITER ;

-- Триггеры
-- ---------------------------------------------
DELIMITER //
CREATE TRIGGER register_change_clients_info AFTER UPDATE
ON clients
FOR EACH ROW
BEGIN
    IF(OLD.full_name != NEW.full_name) THEN
        INSERT INTO clients_change_name_archive VALUES
                                                    (
                                                     DEFAULT,
                                                     NOW(),
                                                     OLD.full_name,
                                                     NEW.full_name
                                                    );
    END IF ;
END//

DELIMITER ;

