/*
Представление позволяет получить информацию о лечащих врачах всех клиентов
*/
CREATE VIEW doctors_for_clients (
    client_full_name,
    client_phone,
    doctor_full_name,
    doctor_speciality,
    doctor_phone
    )
AS
SELECT clients.full_name,
       client_contacts.phone_number,
       doctors.full_name,
       specialities.spec_name,
       doctors.phone
FROM
clients_link_doctors JOIN clients ON clients_link_doctors.client_id = clients.client_id
JOIN client_contacts ON clients.contact = client_contacts.contact_id
JOIN doctors ON clients_link_doctors.doctor_id = doctors.doctor_id
JOIN specialities ON doctors.speciality = specialities.spec_id;

/*
Представление позволяет получить информацию о количестве
клиник, которые курирует каждый менеджер
*/
CREATE VIEW manager_count_clinics
    (
        manager_full_name,
        manager_phone,
        count_clinics
        )
AS
SELECT full_name, phone_number, count_clinics
FROM managers JOIN managers_phones ON managers.phone = managers_phones.phone_id
JOIN (
    SELECT clinic_manager, COUNT(clinic_id) as count_clinics
    FROM clinics
    GROUP BY clinic_manager
) AS cnt_clinics ON clinic_manager = managers.manager_id;


/*
Представление позволяет получить информацию и всех клиниках,
территориально расположенных в Краснодарском крае
*/

CREATE VIEW clinics_krasnodar_territory (
    clinic_state,
    clinic_city,
    clinic_address,
    clinic_phone,
    clinic_manager,
    manager_phone
    )
AS
SELECT state_name AS clinic_state
     ,city_name AS clinic_city
     ,street_address AS clinic_address
     ,clinic_contacts.phone AS clinic_phone
     ,managers.full_name AS clinic_manager
     ,managers_phones.phone_number AS manager_phone
FROM states
JOIN cities
ON states.state_id = cities.state
JOIN clinic_addresses
ON cities.city_id = clinic_addresses.city
JOIN clinic_contacts
ON clinic_addresses.address_id = clinic_contacts.address
JOIN clinics
ON clinic_contacts.contacts_id = clinics.clinic_contact
JOIN managers
ON clinics.clinic_manager = managers.manager_id
JOIN managers_phones
ON managers.phone = managers_phones.phone_id
WHERE states.state_id = get_state_id('Krasnodar Territory');