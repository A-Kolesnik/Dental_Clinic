DROP TABLE IF EXISTS states;
CREATE TABLE states(

    -- Уникальный идентификатор региона(первичный ключ)
    state_id TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,

    -- Наименование региона
    state_name VARCHAR(50) NOT NULL,

    PRIMARY KEY(state_id)
)COMMENT='Наименования регионов РФ' ENGINE=InnoDB;

DROP TABLE IF EXISTS cities;
CREATE TABLE cities(

    -- Уникальный идентификатор города(первичный ключ)
    city_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,

    -- Наименование города
    city_name VARCHAR(50) NOT NULL,

    -- Регион(внешний ключ). Ссылка на таблицу states
    state TINYINT UNSIGNED NOT NULL,

    PRIMARY KEY(city_id),

    CONSTRAINT fk_state
    FOREIGN KEY (state)
    REFERENCES states(state_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
)COMMENT='Наименование городов РФ' ENGINE=InnoDB;

DROP TABLE IF EXISTS clinic_addresses;
CREATE TABLE clinic_addresses(

    -- Уникальный идентификатор адреса(первичный ключ)
    address_id TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,

    -- Город(внешний ключ). Ссылка на таблицу cities
    city SMALLINT UNSIGNED NOT NULL,

    -- Улица, номер дома, корпус, квартира
    street_address VARCHAR(100) NOT NULL,

    PRIMARY KEY(address_id),

    CONSTRAINT fk_city
    FOREIGN KEY (city)
    REFERENCES cities(city_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
)COMMENT='Территориальное расположение клиник' ENGINE=InnoDB;

DROP TABLE IF EXISTS clinic_contacts;
CREATE TABLE clinic_contacts(

    -- Уникальный идентификатор набора контактов клиники
    contacts_id TINYINT UNSIGNED AUTO_INCREMENT NOT NULL,

    -- Адрес(внешний ключ). Ссылка на таблицу clinic_addresses
    address TINYINT UNSIGNED NOT NULL,

     /*
    Телефонный номер:
    - ограничен 11 символами
    - знак '+' не учтен
    Пример:
        79345678412
    */
    phone VARCHAR(11) NOT NULL,

    CONSTRAINT fk_address
    FOREIGN KEY (address)
    REFERENCES clinic_addresses(address_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

    PRIMARY KEY (contacts_id)
)COMMENT='Контактная информация о клиниках' ENGINE=InnoDB;

DROP TABLE IF EXISTS gender_person;
CREATE TABLE gender_person(

    -- Уникальный идентификатор пола человека
    gender_id TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,

    /*
    Значение пола:
    - Ограничил 5 символами
    - Отказался от использования статических вариантов(m/g).
      Оставил возможность задавать эти значения заказчику самостоятельно,
      например, men/women или m/g
    */
    gender_value VARCHAR(5) NOT NULL UNIQUE,

    PRIMARY KEY(gender_id)
)COMMENT='Половой признак' ENGINE=InnoDB;

DROP TABLE IF EXISTS managers_phones;
CREATE TABLE managers_phones(

    -- Уникальный идентификатор телефонного номера (первичный ключ)
    phone_id     SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,

    /*
    Телефонный номер:
    - ограничен 11 символами
    - знак '+' не учтен
    Пример:
        79345678412
    */
    phone_number VARCHAR(11) NOT NULL,

    PRIMARY KEY(phone_id)
)COMMENT='Мобильные номера управляющих клиник' ENGINE=InnoDB;

DROP TABLE IF EXISTS managers;
CREATE TABLE managers(
    -- Уникальный идентификатор менеджера
    manager_id TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,

    -- Полное имя менеджера (фамилия, имя, отчество)
    full_name VARCHAR(100) UNIQUE,

    -- Телефон менеджера
    phone SMALLINT UNSIGNED NOT NULL,

    -- Пол менеджера
    gender TINYINT UNSIGNED NOT NULL,

    PRIMARY KEY(manager_id),

    CONSTRAINT fk_phone_manager
    FOREIGN KEY (phone)
    REFERENCES managers_phones(phone_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

    CONSTRAINT fk_gender
    FOREIGN KEY (gender)
    REFERENCES gender_person(gender_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
)COMMENT='Менеджеры клиник' ENGINE=InnoDB;

DROP TABLE IF EXISTS clinics;
CREATE TABLE clinics(
    clinic_id TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
    clinic_contact TINYINT UNSIGNED NOT NULL,
    clinic_manager TINYINT UNSIGNED NOT NULL,

    PRIMARY KEY (clinic_id),

    CONSTRAINT fk_clinic_contact
    FOREIGN KEY (clinic_contact)
    REFERENCES clinic_contacts(contacts_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

    CONSTRAINT fk_clinic_manager
    FOREIGN KEY (clinic_manager)
    REFERENCES managers(manager_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
)COMMENT='Информация о клиниках' ENGINE=InnoDB;


DROP TABLE IF EXISTS client_addresses;
CREATE TABLE client_addresses(
    address_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
    state TINYINT UNSIGNED NOT NULL,
    city SMALLINT UNSIGNED NOT NULL,
    address VARCHAR(100),

    PRIMARY KEY (address_id),

    CONSTRAINT fk_state_id
    FOREIGN KEY (state)
    REFERENCES states(state_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE,

    CONSTRAINT fk_city_id
    FOREIGN KEY (city)
    REFERENCES cities(city_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
)COMMENT='Адреса проживания клиентов сети клиник' ENGINE=InnoDB;

DROP TABLE IF EXISTS client_contacts;
CREATE TABLE client_contacts(
    contact_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
    phone_number VARCHAR(11) NOT NULL,
    address SMALLINT UNSIGNED NOT NULL,

    PRIMARY KEY (contact_id),

    CONSTRAINT fk_client_address
    FOREIGN KEY (address)
    REFERENCES client_addresses(address_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
)COMMENT='Контактная информация о клиентах' ENGINE=InnoDB;

DROP TABLE IF EXISTS client_cards;
CREATE TABLE client_cards(
    card_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
    file_name VARCHAR(100),
    created DATETIME DEFAULT NOW(),

    PRIMARY KEY (card_id)

)COMMENT='Информация о медицинских картах клиентов' ENGINE=InnoDB;

DROP TABLE IF EXISTS specialities;
CREATE TABLE specialities(
    -- Уникальный идентификатор медицинской специальности
    spec_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,

    -- Наименование медицинской специальности доктора
    spec_name VARCHAR(100),

    PRIMARY KEY (spec_id)
)COMMENT='Список специализаций докторов' ENGINE=InnoDB;

DROP TABLE IF EXISTS doctors;
CREATE TABLE doctors(
    -- Уникальный идентификатор доктора
    doctor_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,

    -- Полное имя (Фамилия Имя Отчество) доктора
    full_name VARCHAR(50),

     /*
    Телефонный номер:
    - ограничен 11 символами
    - знак '+' не учтен
    Пример:
        79345678412
    */
    phone VARCHAR(11),

    -- Дата рождения
    born DATE NOT NULL,

    -- Специальность доктора
    speciality SMALLINT UNSIGNED NOT NULL,

    PRIMARY KEY (doctor_id),

    CONSTRAINT fk_speciality
    FOREIGN KEY (speciality)
    REFERENCES specialities(spec_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
)COMMENT='Информация о докторах' ENGINE=InnoDB;

DROP TABLE IF EXISTS clients;
CREATE TABLE clients(
    client_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
    full_name VARCHAR(100),
    born DATE NOT NULL,
    contact SMALLINT UNSIGNED NOT NULL,
    card SMALLINT UNSIGNED NOT NULL,

    PRIMARY KEY (client_id),

    CONSTRAINT fk_client
    FOREIGN KEY (contact)
    REFERENCES client_contacts(contact_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

    CONSTRAINT fk_card
    FOREIGN KEY (card)
    REFERENCES client_cards(card_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
)COMMENT='Информация о клиентах' ENGINE=InnoDB;;

DROP TABLE IF EXISTS doctors_link_clinic;
CREATE TABLE doctors_link_clinic(
  doctor_id  SMALLINT UNSIGNED NOT NULL,
  clinic_id TINYINT UNSIGNED,

  CONSTRAINT fk_link_doctor
  FOREIGN KEY (doctor_id)
  REFERENCES doctors(doctor_id)
  ON UPDATE CASCADE
  ON DELETE CASCADE,

  CONSTRAINT fk_link_clinic_doctor
  FOREIGN KEY (clinic_id)
  REFERENCES clinics(clinic_id)
  ON UPDATE CASCADE
  ON DELETE CASCADE
)COMMENT='Таблица связи докторов и клиник, в которых они осуществляют деятельность' ENGINE=InnoDB;

DROP TABLE IF EXISTS clients_link_clinic;
CREATE TABLE clients_link_clinic(
  client_id  SMALLINT UNSIGNED NOT NULL,
  clinic_id TINYINT UNSIGNED,

  CONSTRAINT fk_link_client
  FOREIGN KEY (client_id)
  REFERENCES clients(client_id)
  ON UPDATE CASCADE
  ON DELETE CASCADE,

  CONSTRAINT fk_link_clinic_client
  FOREIGN KEY (clinic_id)
  REFERENCES clinics(clinic_id)
  ON UPDATE CASCADE
  ON DELETE CASCADE
)COMMENT='Таблица связи клиентов и клиник, в которых они проходят лечение' ENGINE=InnoDB;

DROP TABLE IF EXISTS clients_link_doctors;
CREATE TABLE clients_link_doctors(
  client_id  SMALLINT UNSIGNED NOT NULL,
  doctor_id SMALLINT UNSIGNED,

  CONSTRAINT fk_link_client_doctor
  FOREIGN KEY (client_id)
  REFERENCES clients(client_id)
  ON UPDATE CASCADE
  ON DELETE CASCADE,

  CONSTRAINT fk_link_doctor_client
  FOREIGN KEY (doctor_id)
  REFERENCES doctors(doctor_id)
  ON UPDATE CASCADE
  ON DELETE CASCADE
)COMMENT='Таблица связи клиентов и их лечащих врачей' ENGINE=InnoDB;

CREATE TABLE clients_change_name_archive(
    note_id INT NOT NULL AUTO_INCREMENT,
    change_date_time DATETIME,
    old_name VARCHAR(100),
    update_name VARCHAR(100),

    PRIMARY KEY (note_id)
)COMMENT='Таблица содержит зпрегистрированные изменения имени клиента' ENGINE=Archive;

-- Создание индексов
CREATE UNIQUE INDEX state_name ON states(state_name);
CREATE UNIQUE INDEX city_name ON cities(city_name);
CREATE UNIQUE INDEX file_name ON client_cards(file_name);
CREATE INDEX full_name ON clients(full_name);