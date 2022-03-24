-- CREACION DE LA BASE DE DATOS--
CREATE DATABASE Proyectos_MINCYT;

-- CREAR COLUMNA AÑO (SER SI SE PUEDE PARA TODAS EN UNA SOLA SENTENCIA)
ALTER TABLE proyectos_2019
ADD anio int;

--AGREGAR EL AÑO CORRESPONDIENTE A CADA PROYECTO
UPDATE proyectos_2015 SET anio = 2015
UPDATE proyectos_2016 SET anio = 2016
UPDATE proyectos_2017 SET anio = 2017
UPDATE proyectos_2018 SET anio = 2018
UPDATE proyectos_2019 SET anio = 2019

-- GENERAR UNA SOLA TABLA proyectos (uno para cada año agregado, ver si existe formula mas optima)
INSERT INTO dbo.proyectos_2015 (proyecto_id, proyecto_fuente, moneda_id, monto_total_solicitado, monto_total_adjudicado, monto_financiado_solicitado, monto_financiado_adjudicado, tipo_proyecto_id, estado_id, fondo_anpcyt, cantidad_miembros_F, cantidad_miembros_M, sexo_director, anio)
SELECT proyecto_id, proyecto_fuente, moneda_id, monto_total_solicitado, monto_total_adjudicado, monto_financiado_solicitado, monto_financiado_adjudicado, tipo_proyecto_id, estado_id, fondo_anpcyt, cantidad_miembros_F, cantidad_miembros_M, sexo_director, anio
FROM dbo.proyectos_2019

--AGREGAR COLUMNA genero_id
ALTER TABLE proyectos
ADD genero_id int IDENTITY;

-- GENERAR TABLA genero
CREATE TABLE genero (genero_id int IDENTITY PRIMARY KEY,
proyecto_id int,
cantidad_miembros_F int NULL,
cantidad_miembros_M int NULL,
sexo_director varchar(50));

--COPIAR VALORES DE TABLA proyecto A genero
INSERT INTO dbo.genero (proyecto_id, cantidad_miembros_F, cantidad_miembros_M, sexo_director)
SELECT proyecto_id, cantidad_miembros_F, cantidad_miembros_M, sexo_director
FROM dbo.proyectos

SELECT * FROM dbo.genero;

--ELIMINAR COLUMNAS DE genero EN proyectos
ALTER TABLE proyectos
DROP COLUMN cantidad_miembros_F, cantidad_miembros_M, sexo_director

--CREAR TABLA montos
CREATE TABLE montos (monto_id int IDENTITY PRIMARY KEY,
proyecto_id int,
moneda_id int NULL,
monto_total_solicitado varchar(50) NULL,
monto_total_adjudicado varchar(50) NULL,
monto_financiado_solicitado varchar(50) NULL,
monto_financiado_adjudicado varchar(50) NULL);

INSERT INTO dbo.montos (proyecto_id, moneda_id, monto_total_solicitado, monto_total_adjudicado, monto_financiado_solicitado, monto_financiado_adjudicado)
SELECT proyecto_id, moneda_id, monto_total_solicitado, monto_total_adjudicado, monto_financiado_solicitado, monto_financiado_adjudicado
FROM dbo.proyectos

--ELIMINAR DE TABLA proyectos LOS DATOS DE montos
ALTER TABLE proyectos
DROP COLUMN moneda_id, monto_total_solicitado, monto_total_adjudicado, monto_financiado_solicitado, monto_financiado_adjudicado;

-- CREAR TABLA gran_area
CREATE TABLE gran_area (gran_area_codigo int IDENTITY PRIMARY KEY,
gran_area_descripcion varchar(200));

--DAR VALORES A gran_area (repetido para cada una de las 6 areas)
INSERT INTO gran_area (gran_area_descripcion)
VALUES ('HUMANIDADES');
SELECT * FROM gran_area;

--TABLA area_conocimiento
ALTER TABLE area_conocimiento
DROP COLUMN gran_area_descripcion

--AGREGAR ID A LA TABLA proyecto_disciplina
ALTER TABLE proyecto_disciplina
ADD id_tabla_disciplina int IDENTITY PRIMARY KEY;

SELECT * FROM proyecto_disciplina

-- ESTABLECER PK Y FK. Revisar en las tablas alteradas a la planificacion

-- ESTABLECER PK de TABLA proyectos
ALTER TABLE proyectos ALTER COLUMN proyecto_id int;
UPDATE proyectos SET proyecto_id = 0 WHERE proyecto_id IS NULL;
ALTER TABLE proyectos ALTER COLUMN proyecto_id INT NOT NULL;
ALTER TABLE proyectos ADD PRIMARY KEY (proyecto_id);

-- ESTABLECER PK DE TABLA estado_proyecto
ALTER TABLE estado_proyecto ALTER COLUMN estado_id INT NOT NULL;
ALTER TABLE estado_proyecto ADD PRIMARY KEY (estado_id);

-- ESTABLECER PK DE TABLA area_conocimiento
ALTER TABLE area_conocimiento ALTER COLUMN disciplina_id INT NOT NULL;
ALTER TABLE area_conocimiento ADD PRIMARY KEY (disciplina_id);

--ESTABLECER PK DE TABLA ref_moneda
ALTER TABLE ref_moneda ALTER COLUMN moneda_id INT NOT NULL;
ALTER TABLE ref_moneda ADD PRIMARY KEY (moneda_id);

--ESTABLECER PK DE TABLA tipo_proyecto
ALTER TABLE tipo_proyecto ALTER COLUMN tipo_proyecto_id INT NOT NULL;
ALTER TABLE tipo_proyecto ADD PRIMARY KEY (tipo_proyecto_id);

-- ESTABLECER FK DE TABLA proyectos
ALTER TABLE proyectos ALTER COLUMN estado_id INT NOT NULL;
ALTER TABLE proyectos ADD FOREIGN KEY (estado_id) REFERENCES estado_proyecto(estado_id);
ALTER TABLE proyectos ALTER COLUMN tipo_proyecto_id INT NOT NULL;

SELECT tipo_proyecto_id FROM proyectos
WHERE tipo_proyecto_id NOT IN
(SELECT tipo_proyecto_id FROM tipo_proyecto)
-- EXISTEN 1941 COLUMNAS EN proyectos CON tipo_proyecto = 0.
INSERT INTO tipo_proyecto (tipo_proyecto_id, sigla, descripcion, tipo_proyecto_cyt_id, tipo_proyecto_cyt_desc)
VALUES (0, 'SIN DATOS', 'SIN DATOS', 'SIN DATOS', 'SIN DATOS')
ALTER TABLE proyectos ADD FOREIGN KEY (tipo_proyecto_id) REFERENCES tipo_proyecto(tipo_proyecto_id);

-- ESTABLECER FK DE TABLA genero
ALTER TABLE genero ALTER COLUMN proyecto_id INT NOT NULL;
ALTER TABLE genero ADD FOREIGN KEY (proyecto_id) REFERENCES proyectos(proyecto_id);

-- ESTABLECER FK DE TABLA montos
ALTER TABLE montos ALTER COLUMN proyecto_id INT NOT NULL;
ALTER TABLE montos ADD FOREIGN KEY (proyecto_id) REFERENCES proyectos(proyecto_id);
ALTER TABLE montos ADD FOREIGN KEY (moneda_id) REFERENCES ref_moneda(moneda_id);

-- ESTABLECER FK DE TABLA proyecto_disciplina
ALTER TABLE proyecto_disciplina ALTER COLUMN proyecto_id INT NOT NULL;
-- proyecto disciplina tiene: 19573 registros. proyectos tiene 6943
DELETE FROM proyecto_disciplina WHERE proyecto_id NOT IN (SELECT proyecto_id FROM proyectos);
--quedaron 5816 registros
ALTER TABLE proyecto_disciplina ADD FOREIGN KEY (proyecto_id) REFERENCES proyectos(proyecto_id);


ALTER TABLE proyecto_disciplina ALTER COLUMN disciplina_id INT NOT NULL;
--CAMBIAR EL VALOR 0 de proyecto_disciplina EN COLUMNA disciplina_id, A -1 ASI CONCUERDA CON LA TABLA area_conocimiento
--EN proyecto_disciplina existen 515 valores en 0.
UPDATE proyecto_disciplina SET disciplina_id = -1  WHERE disciplina_id = 0;
ALTER TABLE proyecto_disciplina ADD FOREIGN KEY (disciplina_id) REFERENCES area_conocimiento(disciplina_id);

-- ESTABLECER FK DE TABLA area_conocimiento
ALTER TABLE area_conocimiento ALTER COLUMN gran_area_codigo INT NOT NULL;
ALTER TABLE area_conocimiento ADD FOREIGN KEY (gran_area_codigo) REFERENCES gran_area(gran_area_codigo);

-- RECREACION TABLA gran_area con valor -1
CREATE TABLE gran_area (gran_area_codigo INT NOT NULL PRIMARY KEY,
gran_area_descripcion VARCHAR(50) NOT NULL);

INSERT INTO gran_area (gran_area_codigo, gran_area_descripcion)
VALUES (2, 'INGENIERIAS Y TECNOLOGIAS'), (3, 'CIENCIAS MEDICAS Y DE LA SALUD'), (4, 'CIENCIAS AGRICOLAS'), (5, 'CIENCIAS SOCIALES'), (6, 'HUMANIDADES')


--FORMULA USADA PARA BUSCAR INCONSISTENCIAS DE VALORES ENTRE TABLAS
SELECT disciplina_id FROM proyecto_disciplina
WHERE disciplina_id NOT IN
(SELECT disciplina_id FROM area_conocimiento)

-- ELIMINAR TABLAS INNECESARIAS proyecto_2016(2017, 2018, 2019)
DROP TABLE proyectos_2016, proyectos_2017, proyectos_2018, proyectos_2019;

--ELIMINAR COLUMNA codigo_identificacion EN proyectos
ALTER TABLE proyectos
DROP COLUMN codigo_identificacion;

--CAMBIAR area_codigo DE area_conocimiento A INT
ALTER TABLE area_conocimiento ALTER COLUMN area_codigo DECIMAL;
