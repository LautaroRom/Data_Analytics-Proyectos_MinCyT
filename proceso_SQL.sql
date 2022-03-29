-- CREACIÓN DE LA BASE DE DATOS--
CREATE DATABASE Proyectos_MINCYT;

-- CREAR COLUMNA AÑO PARA CADA TABLA proyecto_año
ALTER TABLE proyectos_2015
ADD anio int;
ALTER TABLE proyectos_2016
ADD anio int;
ALTER TABLE proyectos_2017
ADD anio int;
ALTER TABLE proyectos_2018
ADD anio int;
ALTER TABLE proyectos_2019
ADD anio int;

--AGREGAR UNA COLUMNA CON EL AÑO CORRESPONDIENTE A CADA PROYECTO
UPDATE proyectos_2015 SET anio = 2015
UPDATE proyectos_2016 SET anio = 2016
UPDATE proyectos_2017 SET anio = 2017
UPDATE proyectos_2018 SET anio = 2018
UPDATE proyectos_2019 SET anio = 2019

-- UNIFICACIÓN DE TODAS LAS TABLAS proyecto_año EN LA TABLA proyecto_2015 RENOMBRADA POSTERIORMENTE COMO proyectos
INSERT INTO dbo.proyectos_2015 (proyecto_id, proyecto_fuente, moneda_id, monto_total_solicitado, monto_total_adjudicado, monto_financiado_solicitado, monto_financiado_adjudicado, tipo_proyecto_id, estado_id, fondo_anpcyt, cantidad_miembros_F, cantidad_miembros_M, sexo_director, anio)
SELECT proyecto_id, proyecto_fuente, moneda_id, monto_total_solicitado, monto_total_adjudicado, monto_financiado_solicitado, monto_financiado_adjudicado, tipo_proyecto_id, estado_id, fondo_anpcyt, cantidad_miembros_F, cantidad_miembros_M, sexo_director, anio
FROM dbo.proyectos_2016
INSERT INTO dbo.proyectos_2015 (proyecto_id, proyecto_fuente, moneda_id, monto_total_solicitado, monto_total_adjudicado, monto_financiado_solicitado, monto_financiado_adjudicado, tipo_proyecto_id, estado_id, fondo_anpcyt, cantidad_miembros_F, cantidad_miembros_M, sexo_director, anio)
SELECT proyecto_id, proyecto_fuente, moneda_id, monto_total_solicitado, monto_total_adjudicado, monto_financiado_solicitado, monto_financiado_adjudicado, tipo_proyecto_id, estado_id, fondo_anpcyt, cantidad_miembros_F, cantidad_miembros_M, sexo_director, anio
FROM dbo.proyectos_2017
INSERT INTO dbo.proyectos_2015 (proyecto_id, proyecto_fuente, moneda_id, monto_total_solicitado, monto_total_adjudicado, monto_financiado_solicitado, monto_financiado_adjudicado, tipo_proyecto_id, estado_id, fondo_anpcyt, cantidad_miembros_F, cantidad_miembros_M, sexo_director, anio)
SELECT proyecto_id, proyecto_fuente, moneda_id, monto_total_solicitado, monto_total_adjudicado, monto_financiado_solicitado, monto_financiado_adjudicado, tipo_proyecto_id, estado_id, fondo_anpcyt, cantidad_miembros_F, cantidad_miembros_M, sexo_director, anio
FROM dbo.proyectos_2018
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

--COPIAR VALORES DE TABLA proyectos A genero
INSERT INTO dbo.genero (proyecto_id, cantidad_miembros_F, cantidad_miembros_M, sexo_director)
SELECT proyecto_id, cantidad_miembros_F, cantidad_miembros_M, sexo_director
FROM dbo.proyectos

--ELIMINAR COLUMNAS EN TABLA proyectos QUE FUERON COPIADAS A LA TABLA genero
ALTER TABLE proyectos
DROP COLUMN cantidad_miembros_F, cantidad_miembros_M, sexo_director

--CREAR TABLA montos Y PASARLE DE LA TABLA proyectos LAS COLUMNAS CORRESPONDIENTES
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

--ELIMINAR DE TABLA proyectos LAS COLUMNAS AHORA EN montos
ALTER TABLE proyectos
DROP COLUMN moneda_id, monto_total_solicitado, monto_total_adjudicado, monto_financiado_solicitado, monto_financiado_adjudicado;


--AGREGAR ID A LA TABLA proyecto_disciplina
ALTER TABLE proyecto_disciplina
ADD id_tabla_disciplina int IDENTITY PRIMARY KEY;


-- ESTABLECER LAS PK Y FK PARA CADA TABLA

-- ESTABLECER PK de TABLA proyectos
ALTER TABLE proyectos ALTER COLUMN proyecto_id int;
UPDATE proyectos SET proyecto_id = 0 WHERE proyecto_id IS NULL;
ALTER TABLE proyectos ALTER COLUMN proyecto_id INT NOT NULL;
ALTER TABLE proyectos ADD PRIMARY KEY (proyecto_id);

-- ESTABLECER PK DE TABLA estado_proyecto
ALTER TABLE estado_proyecto ALTER COLUMN estado_id INT NOT NULL;
ALTER TABLE estado_proyecto ADD PRIMARY KEY (estado_id);

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

-- DETECTAR LOS REGISTROS DE LA COLUMNA tipo_proyecto_id QUE NO TIENEN SU EQUIVALENTE EN LA TABLA proyectos Y QUE SON NULOS
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

-- ESTABLECER FK DE TABLA proyecto_disciplina, ELIMINANDO ANTES DE proyecto disciplina LOS 12630 REGISTROS PERTENECIENTES A AÑOS ANTERIORES A 2015
ALTER TABLE proyecto_disciplina ALTER COLUMN proyecto_id INT NOT NULL;
DELETE FROM proyecto_disciplina WHERE proyecto_id NOT IN (SELECT proyecto_id FROM proyectos);
ALTER TABLE proyecto_disciplina ADD FOREIGN KEY (proyecto_id) REFERENCES proyectos(proyecto_id);


-- ELIMINAR TABLAS AHORA INNECESARIAS
DROP TABLE proyectos_2016, proyectos_2017, proyectos_2018, proyectos_2019;

--ELIMINAR COLUMNA codigo_identificacion EN proyectos
ALTER TABLE proyectos
DROP COLUMN codigo_identificacion;

--CAMBIAR IDENTIFICADOR DE disciplina_id IGUALANDOLAS A LOS IDENTIFICADORES DE LOS VALORES DE GRAN AREA DEL CONOCOCIMIENTO CORRESPONDIENTES
UPDATE proyecto_disciplina SET disciplina_id = 1
WHERE disciplina_id >= 2 AND disciplina_id <= 52

UPDATE proyecto_disciplina SET disciplina_id = 2
WHERE disciplina_id >= 53 AND disciplina_id <= 107

UPDATE proyecto_disciplina SET disciplina_id = 3
WHERE disciplina_id >= 108 AND disciplina_id <= 173

UPDATE proyecto_disciplina SET disciplina_id = 4
WHERE disciplina_id >= 174 AND disciplina_id <= 191

UPDATE proyecto_disciplina SET disciplina_id = 5
WHERE disciplina_id >= 192 AND disciplina_id <= 224

UPDATE proyecto_disciplina SET disciplina_id = 6
WHERE disciplina_id >= 225 AND disciplina_id <= 247


--AGREGAR LOS VALORES QUE FALTAN DE proyecto_id DE LA TABLA proyectos A LA TABLA proyecto_disciplina
INSERT INTO proyecto_disciplina (proyecto_id)
SELECT proyecto_id FROM proyectos
WHERE proyecto_id NOT IN
(SELECT proyecto_id FROM proyecto_disciplina)

--AGREGAR -1 A LOS VALORES NULL
UPDATE proyecto_disciplina SET disciplina_id = -1 WHERE disciplina_id IS NULL;


--ENCONTRAR DUPLICADOS EN proyecto_disciplina
WITH C AS
(
SELECT proyecto_id, disciplina_id, id_tabla_disciplina,
ROW_NUMBER() OVER (PARTITION BY
                    proyecto_id ORDER BY proyecto_id) AS DUPLICADO
FROM proyecto_disciplina
)
SELECT * FROM C
WHERE DUPLICADO > 1

-- BORRAR LOS DUPLICADOS
WITH C AS
(
SELECT proyecto_id, disciplina_id, id_tabla_disciplina,
ROW_NUMBER() OVER (PARTITION BY
                    proyecto_id ORDER BY proyecto_id) AS DUPLICADO
FROM proyecto_disciplina
)
DELETE FROM C
WHERE DUPLICADO > 1

-- AGREGAR A PROYECTO_DISCIPLINA COLUMNA DISCIPLINA_DESCRIPCION CON SUS VALORES
ALTER TABLE proyecto_disciplina ADD disciplina_desc VARCHAR(200)

UPDATE proyecto_disciplina SET disciplina_desc = 'SIN DATOS' WHERE disciplina_id = -1
UPDATE proyecto_disciplina SET disciplina_desc = 'CIENCIAS NATURALES Y EXACTAS' WHERE disciplina_id = 1;
UPDATE proyecto_disciplina SET disciplina_desc = 'INGENIERIAS Y TECNOLOGIAS' WHERE disciplina_id = 2;
UPDATE proyecto_disciplina SET disciplina_desc = 'CIENCIAS MEDICAS Y DE LA SALUD' WHERE disciplina_id = 3;
UPDATE proyecto_disciplina SET disciplina_desc = 'CIENCIAS AGRICOLAS' WHERE disciplina_id = 4;
UPDATE proyecto_disciplina SET disciplina_desc = 'CIENCIAS SOCIALES' WHERE disciplina_id = 5;
UPDATE proyecto_disciplina SET disciplina_desc = 'HUMANIDADES' WHERE disciplina_id = 6;
