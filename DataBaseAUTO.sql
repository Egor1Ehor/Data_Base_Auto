-- обновление пользователя ГОТОВО!!!!
CREATE OR REPLACE FUNCTION Person_update
RETURN TRIGGER AS $$
BEGIN
    NEW.updated = now();
    RETURN NEW;
END;
$$ language 'plpgsql';

-- обновление объявления ГОТОВО!!!!
CREATE OR REPLACE FUNCTION ads_update
RETURN TRIGGER AS $$
BEGIN
    NEW.updated = now();
    RETURN NEW;
END;
$$ language 'plpgsql';
--Пользователь ГОТОВО!!!!
CREATE TABLE Person IF NOT EXISTS (
    id bigint UNIQUE NOT NULL PRIMARY KEY SERIAL,
    user_id bigint UNIQUE NOT NULL,
    username varchar(30) TEXT NOT NULL,
    email varchar(256) TEXT NOT NULL,
    Phone_number varchar(13) TEXT NOT NULL,
    password text NOT NULL,
    user_info json NOT NULL,
    if_active BOOLEAN NOT NULL DEFAULT FALSE,
    status varchar(1) NOT NULL, 
    CONSTRAINT status_check CHECK (status IN ("T", "B")),
    created TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP 
);

--Категория ГОТОВО!!!!
CREATE TABLE Tipe IF NOT EXISTS (
    id bigint UNIQUE NOT NULL PRIMARY KEY SERIAL,
    Type_id bigint UNIQUE NOT NULL,
    Type varchar(16) NOT NULL,
    info json NOT NULL
);      

--связь категория объявление ГОТОВО!!!!
CREATE TABLE ads_type IF NOT EXISTS (
    ads_id bigint NOT NULL,
    type_id bigint NOT NULL,
    FOREIGN KEY (ads_id) REFERENCES ads(id),
    FOREIGN KEY (type_id) REFERENCES Tipe(id)
);
--персонал ГОТОВО!!!!
CREATE TABLE Personal IF NOT EXISTS (
    id bigint UNIQUE NOT NULL PRIMARY KEY SERIAL,
    user_id bigint UNIQUE NOT NULL,
    if_active BOOLEAN NOT NULL DEFAULT FALSE,
    status varchar(1) NOT NULL,
    CONSTRAINT status_check CHECK (status IN ("M", "A")), 
);

--связь персонал пользователь ГОТОВО!!!!
CREATE TABLE images IF NOT EXISTS (
    id_personal bigint NOT NULL,
    id_person bigint NOT NULL,
    FOREIGN KEY (id_personal) REFERENCES Personal(id),
    FOREIGN KEY (id_person) REFERENCES Person(id)
);

--фото ГОТОВО!!!! 
CREATE TABLE images IF NOT EXISTS (
    id bigint NOT NULL,
    path text NOT NULL
);

-- таблица связка фото ГОТОВО!!!!
CREATE TABLE image_auto IF NOT EXISTS (
    image_id bigint NOT NULL,
    machin_id bigint NOT NULL,
    FOREIGN KEY (image_id) REFERENCES images(id),
    FOREIGN KEY (machin_id) REFERENCES ads(id)
);

--Объявления ГОТОВО????
CREATE TABLE ads IF NOT EXISTS (
    id bigint UNIQUE NOT NULL PRIMARY KEY SERIAL,
    Type_auto bigint NOT NULL,
    name_auto bigint NOT NULL,
    model_auto bigint NOT NULL,
    modification_auto bigint NOT NULL,
    price_auto bigint NOT NULL,
    year_auto bigint NOT NULL,
    getrag bigint NOT NULL,
    motor bigint NOT NULL,
    fuel bigint NOT NULL,
    round bigint NOT NULL,
    trip bigint NOT NULL,
    condition bigint NOT NULL,
    plase bigint NOT NULL,
    created TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP 
);

-- связь пользователь обявление ГОТОВО!!!!
CREATE TABLE ads_connect IF NOT EXISTS (
    preson_id bigint NOT NULL,
    auto_id bigint NOT NULL,
    FOREIGN KEY (preson_id) REFERENCES Person(id),
    FOREIGN KEY (auto_id) REFERENCES ads(id)
);


--скрипт обновы пользователя ГОТОВО!!!!
CREATE TRIGGER users_updated BEFORE UPDATE
ON users FOR EACH ROW
EXECUTE FUNCTION Person_update();

-- скрипт обновы объявы ГОТОВО!!!!
CREATE TRIGGER auto_updated BEFORE UPDATE
ON users FOR EACH ROW
EXECUTE FUNCTION ads_update();


--указание актуального времени заполнения
--created TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP 
-- связка
--FOREIGN KEY (СТРОКА) REFERENCES ТАБЛА(ИМЯ СТРОКИ)