CREATE DATABASE IF NOT EXISTS production;
USE production;


CREATE TABLE users(
    id BINARY(16) PRIMARY KEY,
    username VARCHAR(255) NOT NULL UNIQUE,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    avatar_url VARCHAR(255)
);

CREATE TABLE photos(
    id BINARY(16) PRIMARY KEY,
    path VARCHAR(255) NOT NULL,
    thumbnail_path VARCHAR(255) NOT NULL,
    original_name VARCHAR(255) NOT NULL,
    size BIGINT,
    caption VARCHAR(255),
    creation_date DATETIME NOT NULL,
    upload_date DATETIME NOT NULL,
    modification_date DATETIME,
    user_id BINARY(16) NOT NULL,
    CONSTRAINT FK_photos_to_users FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
);

CREATE TABLE loading_metadata (
    id BINARY(16) NOT NULL,
    loaded TINYINT NOT NULL CHECK (loaded BETWEEN 0 AND 2),
    path VARCHAR(255) NOT NULL,
    photo_id BINARY(16) NOT NULL,
    user_id BINARY(16) NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT FK_loading_metadata_to_photos FOREIGN KEY (photo_id) REFERENCES photos(id) ON DELETE CASCADE,
    CONSTRAINT FK_loading_metadata_to_users FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE metadata (
    photo_id BINARY(16) NOT NULL,
    user_id BINARY(16) NOT NULL,
    source_file VARCHAR(255),
    file_name VARCHAR(255),
    directory VARCHAR(255),
    file_size VARCHAR(255),
    file_modify_date VARCHAR(255),
    file_access_date VARCHAR(255),
    file_type VARCHAR(255),
    mime_type VARCHAR(255),
    make VARCHAR(255),
    model VARCHAR(255),
    x_resolution INT,
    y_resolution INT,
    resolution_unit VARCHAR(255),
    exposure_time VARCHAR(30),
    f_number DOUBLE,
    iso INT,
    date_time_original VARCHAR(255),
    gps_latitude VARCHAR(255),
    gps_longitude VARCHAR(255),
    lens_id VARCHAR(255),
    PRIMARY KEY (photo_id),
    CONSTRAINT FK_metadata_to_photos FOREIGN KEY (photo_id) REFERENCES photos(id) ON DELETE CASCADE,
    CONSTRAINT FK_metadata_to_users FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);




