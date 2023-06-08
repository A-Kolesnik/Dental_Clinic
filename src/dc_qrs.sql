-- Запрос возвращает информацию (имя, телефон, половая принадлежность)
-- о менеджерах женщинах

SELECT full_name, phone_number, gender_value
FROM managers
JOIN managers_phones ON managers.phone = managers_phones.phone_id
JOIN gender_person ON managers.gender = gender_person.gender_id
WHERE gender_value = 'women';

-- Запрос возвращает всех докторов-терапевтов
SELECT full_name, phone
FROM doctors
WHERE speciality = (
    SELECT spec_id
    FROM specialities
    WHERE spec_name = 'Therapy'
    );

-- Запрос возвращает количество докторов для каждой специализации
SELECT spec_name, count_doctors
FROM specialities
JOIN (SELECT speciality, COUNT(speciality) AS count_doctors
FROM doctors
GROUP BY speciality) AS count_doctors_specialities ON spec_id = speciality;

-- Запрос возвращает специализации, для которых выделен только 1 доктор
SELECT spec_name
FROM specialities
JOIN (SELECT speciality, COUNT(speciality) AS count_doctors
FROM doctors
GROUP BY speciality) AS count_doctors_specialities ON spec_id = speciality
WHERE count_doctors = 1;

-- Запрос возвращает специализации, для которых выделен только 1 доктор (Фильтрация с использование HAVING)
SELECT spec_name
FROM specialities
JOIN (SELECT speciality, COUNT(speciality) AS count_doctors
FROM doctors
GROUP BY speciality
HAVING count_doctors = 1) AS count_doctors_specialities ON spec_id = speciality;