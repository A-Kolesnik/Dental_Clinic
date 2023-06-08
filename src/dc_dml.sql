-- Регионы, в которых открыты клиники
SET @LABEL_KRASNODAR_TERRITORY = 'Krasnodar Territory';
SET @LABEL_MOSKOVSKAYA_OBLAST  = 'Moskovskaya oblast';
SET @LABEL_KOMI_REPUBLIC       = 'Komi Republic';

-- Города, в которых открыты клиники
SET @LABEL_KRASNODAR = 'Krasnodar';
SET @LABEL_SOCHI     = 'Sochi';
SET @LABEL_MOSCOW    = 'Moscow';
SET @LABEL_USINSK    = 'Usinsk';
SET @LABEL_SYKTYVKAR = 'Syktyvkar';
SET @LABEL_KOLOMNA   = 'Kolomna';

-- Адреса клиник
SET @KRASNODAR_ADDRESS_1 = 'Moskovskaya 79/1';
SET @SOCHI_ADDRESS_1     = 'Karasunskaya 98/21';
SET @MOSCOW_ADDRESS_1    = 'Factory 5';
SET @USINSK_ADDRESS_1    = 'Dzerzhinsky 161';
SET @SYKTYVKAR_ADDRESS_1 = 'Vologda 2';
SET @KOLOMNA_ADDRESS_1   = 'Gagarin 75/4';

-- Телефоны клиник
SET @KRASNODAR_ADDRESS_1_PHONE = '79885896458';
SET @SOCHI_ADDRESS_1_PHONE     = '79286958741';
SET @MOSCOW_ADDRESS_1_PHONE    = '79958365478';
SET @USINSK_ADDRESS_1_PHONE    = '79242365498';
SET @SYKTYVKAR_ADDRESS_1_PHONE = '79245367289';
SET @KOLOMNA_ADDRESS_1_PHONE   = '79615498632';

-- Добавление наименования регионов в таблицу states
INSERT INTO states VALUES
                       (DEFAULT, @LABEL_KRASNODAR_TERRITORY),
                       (DEFAULT, @LABEL_MOSKOVSKAYA_OBLAST),
                       (DEFAULT, @LABEL_KOMI_REPUBLIC);

-- Добавление наименования городов в таблицу cities
INSERT INTO cities VALUES
                       (DEFAULT, @LABEL_KRASNODAR, get_state_id(@LABEL_KRASNODAR_TERRITORY)),
                       (DEFAULT, @LABEL_SOCHI, get_state_id(@LABEL_KRASNODAR_TERRITORY)),
                       (DEFAULT, @LABEL_MOSCOW, get_state_id(@LABEL_MOSKOVSKAYA_OBLAST)),
                       (DEFAULT, @LABEL_SYKTYVKAR, get_state_id(@LABEL_KOMI_REPUBLIC)),
                       (DEFAULT, @LABEL_USINSK, get_state_id(@LABEL_KOMI_REPUBLIC)),
                       (DEFAULT, @LABEL_KOLOMNA, get_state_id(@LABEL_MOSKOVSKAYA_OBLAST));

-- Добавление адресов клиник
INSERT INTO clinic_addresses VALUES
                                 (DEFAULT, get_city_id(@LABEL_KRASNODAR), @KRASNODAR_ADDRESS_1),
                                 (DEFAULT, get_city_id(@LABEL_KOLOMNA), @KOLOMNA_ADDRESS_1),
                                 (DEFAULT, get_city_id(@LABEL_USINSK), @USINSK_ADDRESS_1),
                                 (DEFAULT, get_city_id(@LABEL_SYKTYVKAR), @SYKTYVKAR_ADDRESS_1),
                                 (DEFAULT, get_city_id(@LABEL_MOSCOW), @MOSCOW_ADDRESS_1),
                                 (DEFAULT, get_city_id(@LABEL_SOCHI), @SOCHI_ADDRESS_1);

INSERT INTO clinic_contacts VALUES
                                (DEFAULT, 1, @KRASNODAR_ADDRESS_1_PHONE),
                                (DEFAULT, 2, @SOCHI_ADDRESS_1_PHONE),
                                (DEFAULT, 3, @KOLOMNA_ADDRESS_1_PHONE),
                                (DEFAULT, 4, @MOSCOW_ADDRESS_1_PHONE),
                                (DEFAULT, 5, @SYKTYVKAR_ADDRESS_1_PHONE),
                                (DEFAULT, 6, @USINSK_ADDRESS_1_PHONE);

INSERT INTO gender_person VALUES
                              (DEFAULT, 'men'),
                              (DEFAULT, 'women');

INSERT INTO managers_phones VALUES
                                (DEFAULT, '79882569874'),
                                (DEFAULT, '79284157896'),
                                (DEFAULT, '79618795241');

INSERT INTO managers VALUES
                         (DEFAULT, 'Pirov Alexander Ivanovich', 2, 1),
                         (DEFAULT, 'Rykova Viktoriya Andreevna', 1, 2),
                         (DEFAULT, 'Abasov Pavel Voktorovich', 3, 1);

INSERT INTO clinics VALUES
                        (DEFAULT, 1, 1),
                        (DEFAULT, 6, 1),
                        (DEFAULT, 2, 2),
                        (DEFAULT, 5, 2),
                        (DEFAULT, 3, 3),
                        (DEFAULT, 4, 3);

INSERT INTO client_addresses VALUES
                                 (DEFAULT, 1, 2, 'Giacintovaya 20'),
                                 (DEFAULT, 1, 2, 'Lenina 18/2'),
                                 (DEFAULT, 3, 4, 'Suvorova 1'),
                                 (DEFAULT, 1, 1, 'Krasnaya 5/8'),
                                 (DEFAULT, 2, 6, 'Cheshskays 89a'),
                                 (DEFAULT, 2, 3, 'Partizanov 10'),
                                 (DEFAULT, 1, 1, 'Krizhevnaya 85b/3'),
                                 (DEFAULT, 3, 5, 'Krasnaya 178a'),
                                 (DEFAULT, 3, 4, 'Tulpanov 12'),
                                 (DEFAULT, 1, 2, 'Cvetochnaya 26');

INSERT INTO client_contacts VALUES
                                (DEFAULT, '79856987584', 1),
                                (DEFAULT, '79345468789', 2),
                                (DEFAULT, '79881459782', 3),
                                (DEFAULT, '79185641238', 4),
                                (DEFAULT, '79185487985', 5),
                                (DEFAULT, '79611235487', 6),
                                (DEFAULT, '79617854631', 7),
                                (DEFAULT, '79308574693', 8),
                                (DEFAULT, '79859785241', 9),
                                (DEFAULT, '79325648796', 10);

INSERT INTO client_cards VALUES
                             (DEFAULT, 'card_Ivanov.pdf', DEFAULT),
                             (DEFAULT, 'card_Petrov.pdf', DEFAULT),
                             (DEFAULT, 'card_Sidorov.pdf', DEFAULT),
                             (DEFAULT, 'card_Olaev.pdf', DEFAULT),
                             (DEFAULT, 'card_Itaev.pdf', DEFAULT),
                             (DEFAULT, 'card_Anuskin.pdf', DEFAULT),
                             (DEFAULT, 'card_Chertov.pdf', DEFAULT),
                             (DEFAULT, 'card_Pet.pdf', DEFAULT),
                             (DEFAULT, 'card_Aloev.pdf', DEFAULT),
                             (DEFAULT, 'card_Abuzov.pdf', DEFAULT);


INSERT INTO clients VALUES
                        (DEFAULT, 'Ivanov Ilya Viktorovich', '1985-02-10', 7, 1),
                        (DEFAULT, 'Petrov Andrey Alexandrovich', '1999-05-08', 1, 2),
                        (DEFAULT, 'Sidorov Ivan Andreevich', '2010-10-27', 5, 3),
                        (DEFAULT, 'Olaev Eduard Sergeevich', '2005-05-11', 3, 4),
                        (DEFAULT, 'Itaev Fedor Ivanovich', '1985-02-10', 2, 5),
                        (DEFAULT, 'Anuskin Pavel Pavlovich', '1964-08-12', 4, 6),
                        (DEFAULT, 'Chertov Fedor Victorovich', '1987-05-29', 6, 7),
                        (DEFAULT, 'Pet Alexander Vitalevich', '1996-11-29', 9, 8),
                        (DEFAULT, 'Aloev Ivan Fedorovich', '1985-02-10', 10, 9),
                        (DEFAULT, 'Abuzov Hariton Viktorovich', '1999-06-26', 8, 10);

INSERT INTO specialities VALUES
                             (DEFAULT, 'Therapy'),
                             (DEFAULT, 'Surgery'),
                             (DEFAULT, 'Periodontology'),
                             (DEFAULT, 'Implantology'),
                             (DEFAULT, 'Orthodontics');

INSERT INTO doctors VALUES
                        (DEFAULT, 'Kopaev Viktor Genrichovich', '79881112354', '1978-12-30', 3),
                        (DEFAULT, 'Gukov Ivan Andreevich', '79287945634', '1989-07-21', 5),
                        (DEFAULT, 'Ban Ilya Fedorovich', '79612547896', '1999-10-20', 4),
                        (DEFAULT, 'Kidov Andrey Ivanovich', '79182587463', '1954-02-08', 1),
                        (DEFAULT, 'Malysheva Svetlana Viktorovna', '79355647821', '1994-04-01', 2),
                        (DEFAULT, 'Ivanov Viktor Fedorovich', '79856932569', '1985-05-24', 1),
                        (DEFAULT, 'Vanyan Genrich Ashotovich', '79185824763', '1974-04-01', 1),
                        (DEFAULT, 'Firsov Anton Ivanovich', '79632541789', '1970-08-15', 2);

INSERT INTO doctors_link_clinic VALUES
                                    (1,6),
                                    (2,1),
                                    (3,4),
                                    (4,3),
                                    (4,5),
                                    (5,2);

INSERT INTO clients_link_clinic VALUES
                                    (1, 5),
                                    (2, 1),
                                    (3, 5),
                                    (4, 6),
                                    (5, 2),
                                    (6, 2),
                                    (7, 3),
                                    (8, 4),
                                    (9, 2),
                                    (10, 1);

INSERT INTO clients_link_doctors VALUES
                                     (1,4),
                                     (2,2),
                                     (3,4),
                                     (4,1),
                                     (5,5),
                                     (6,5),
                                     (7,4),
                                     (8,3),
                                     (9,5),
                                     (10,2);