-- CREATE DATABASE jsonwebtoken

CREATE TYPE public."e_gender" AS ENUM (
	'MALE',
	'FEMALE',
	'OTHER');

CREATE TYPE public."e_user_status" AS ENUM (
	'ACTIVE',
	'INACTIVE',
	'NONE');

CREATE TYPE public."e_user_type" AS ENUM (
	'OWNER',
	'ADMIN',
	'USER');

CREATE TABLE public.tbl_user (
	id bigserial NOT NULL,
	first_name varchar(255) NOT NULL,
	last_name varchar(255) NOT NULL,
	date_of_birth date NOT NULL,
	gender public."e_gender" NOT NULL,
	phone varchar(255) NULL,
	email varchar(255) NULL,
	username varchar(255) NOT NULL,
	"password" varchar(255) NOT NULL,
	status public."e_user_status" NOT NULL,
	"type" public."e_user_type" NOT NULL,
	created_at timestamp(6) DEFAULT now() NULL,
	updated_at timestamp(6) DEFAULT now() NULL,
	CONSTRAINT tbl_user_pkey PRIMARY KEY (id)
);

CREATE TABLE public.tbl_address (
	id bigserial NOT NULL,
	apartment_number varchar(255) NULL,
	floor varchar(255) NULL,
	building varchar(255) NULL,
	street_number varchar(255) NULL,
	street varchar(255) NULL,
	city varchar(255) NULL,
	country varchar(255) NULL,
	address_type int4 NULL,
	user_id int8 NULL,
	created_at timestamp(6) DEFAULT now() NULL,
	updated_at timestamp(6) DEFAULT now() NULL,
	CONSTRAINT tbl_address_pkey PRIMARY KEY (id)
);


CREATE TABLE public.tbl_role (
	id bigserial PRIMARY KEY,
	name varchar(255) NOT NULL
);

CREATE TABLE public.tbl_group (
	id bigserial PRIMARY KEY,
	name varchar(255) NOT null,
	role_id bigserial NOT NULL
);

CREATE TABLE public.tbl_permission (
	id bigserial PRIMARY KEY,
	name varchar(255) NOT NULL
);

CREATE TABLE public.tbl_user_has_role (
	user_id bigserial NOT NULL,
	role_id bigserial NOT NULL
);

CREATE TABLE public.tbl_user_has_group (
	user_id bigserial NOT NULL,
	group_id bigserial NOT NULL
);

CREATE TABLE public.tbl_role_has_permission (
	role_id bigserial NOT NULL,
	permission_id bigserial NOT NULL
);

ALTER TABLE public.tbl_address ADD CONSTRAINT fk_address_to_user FOREIGN KEY (user_id) REFERENCES public.tbl_user(id);
ALTER TABLE public.tbl_group ADD CONSTRAINT fk_group_to_role FOREIGN KEY (role_id) REFERENCES public.tbl_role(id);
ALTER TABLE public.tbl_user_has_role ADD CONSTRAINT fk_user_has_role_to_user FOREIGN KEY (user_id) REFERENCES public.tbl_user(id);
ALTER TABLE public.tbl_user_has_role ADD CONSTRAINT fk_user_has_role_to_role FOREIGN KEY (role_id) REFERENCES public.tbl_role(id);
ALTER TABLE public.tbl_role_has_permission ADD CONSTRAINT fk_role_has_permission_to_role FOREIGN KEY (role_id) REFERENCES public.tbl_role(id);
ALTER TABLE public.tbl_role_has_permission ADD CONSTRAINT fk_role_has_permission_to_permission FOREIGN KEY (permission_id) REFERENCES public.tbl_permission(id);
ALTER TABLE public.tbl_user_has_group ADD CONSTRAINT fk_user_has_group_to_user FOREIGN KEY (user_id) REFERENCES public.tbl_user(id);
ALTER TABLE public.tbl_user_has_group ADD CONSTRAINT fk_user_has_group_to_group FOREIGN KEY (group_id) REFERENCES public.tbl_group(id);

INSERT INTO public.tbl_user 
(first_name, last_name, date_of_birth, gender, phone, email, username, password, status, "type")
VALUES
('Nguyen', 'Van A', '1990-01-01', 'MALE', '0123456789', 'nguyenvana@gmail.com', 'nguyenvana', '$2a$12$3WxT2nf7p354pBMxK5m0xuQ.e4yndku1ekoZMrn/vXThTGrzTQ7Sa', 'ACTIVE', 'USER'),
('Tran', 'Thi B', '1992-05-15', 'FEMALE', '0987654321', 'tranthib@gmail.com', 'tranthib', '$2a$12$3WxT2nf7p354pBMxK5m0xuQ.e4yndku1ekoZMrn/vXThTGrzTQ7Sa', 'ACTIVE', 'OWNER'),
('Le', 'Van C', '1985-07-20', 'MALE', '0912345678', 'levanc@gmail.com', 'levanc', '$2a$12$3WxT2nf7p354pBMxK5m0xuQ.e4yndku1ekoZMrn/vXThTGrzTQ7Sa', 'INACTIVE', 'ADMIN');

INSERT INTO public.tbl_role (name) VALUES
('Admin'),
('User'),
('Owner');

INSERT INTO public.tbl_address 
(apartment_number, floor, building, street_number, street, city, country, address_type, user_id)
VALUES
('101', '1', 'Building A', '01', 'Le Loi', 'Ho Chi Minh', 'Vietnam', 1, 1),
('202', '2', 'Building B', '02', 'Tran Hung Dao', 'Ha Noi', 'Vietnam', 2, 2),
('303', '3', 'Building C', '03', 'Hai Ba Trung', 'Da Nang', 'Vietnam', 3, 3);

INSERT INTO public.tbl_group (name, role_id) VALUES
('Group A', 1),
('Group B', 2),
('Group C', 3);

INSERT INTO public.tbl_permission (name) VALUES
('READ'),
('WRITE'),
('DELETE');

INSERT INTO public.tbl_user_has_role (user_id, role_id) VALUES
(1, 2), -- Nguyen Van A -> User
(2, 3), -- Tran Thi B -> Owner
(3, 1); -- Le Van C -> Admin

INSERT INTO public.tbl_user_has_group (user_id, group_id) VALUES
(1, 1), -- Nguyen Van A -> Group A
(2, 2), -- Tran Thi B -> Group B
(3, 3); -- Le Van C -> Group C

INSERT INTO public.tbl_role_has_permission (role_id, permission_id) VALUES
(1, 1), -- Admin -> READ
(1, 2), -- Admin -> WRITE
(2, 1), -- User -> READ
(3, 1), -- Owner -> READ
(3, 2), -- Owner -> WRITE
(3, 3); -- Owner -> DELETE
