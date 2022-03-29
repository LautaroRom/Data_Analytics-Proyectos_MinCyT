# Proyecto de Data Analytic: Proyectos del Ministerio de Ciencia, Tecnología e Innovación

El presente proyecto tiene como finalidad generar un tablero de información dinámico e interactivo mediante Microsoft Power BI sobre los 6943 proyectos científicos y tecnológicos beneficiarios y/o financiados por el Ministerio de Ciencia, Tecnología e Innovación de la República Argentina entre los años 2015 y 2019, reportando datos relacionados a la cantidad de proyectos presentados en cada año, tipo de proyecto y area de conocimiento en la que estan insertos, cantidades monetarias adjudicadas y financiadas, y la composición en materia de género sobre los equipos de cada proyecto. 

Este trabajo espera ser un aporte a la investigación sobre las políticas públicas en materia de ciencia y tecnologia existentes en nuestro país, facilitando la consulta de información comparativa de manera interactiva, como así tambien ser un complemento a los reportes presentados por el Ministerio de Ciencia, Tecnología e Innovación en su [portal de información estadística](https://datos.mincyt.gob.ar/).

Para dirigirse directamente al tablero hacer click aquí.

A continuación se documenta las distintas etapas realizadas para su realización:

## 1- Extracción y fuente de datos
Los datos se extrajeron de [datasets abiertos del Ministerio de Ciencia, Tecnología e Innovación](https://datasets.datos.mincyt.gob.ar/dataset/proyectos-de-ciencia-tecnologia-e-innovacion). Las tablas específicas usadas en este proyecto se encuentran en la carpeta [Tablas Base](https://github.com/laut-code/Data_Analytics-Proyectos_MinCyT/tree/main/Tablas%20Base) del presente repositorio. Posteriormente
los datos fueron limpiados, transformados y modelados mediante el lenguaje SQL, empleando SQL Server Management Studio.

## 2- Modelado de la base de datos
De las tablas extraídas del dataset mencionado se generó la base de datos compuesta por las tablas descriptas en las siguientes imágenes, indicadas con sus respectivas claves primarias y claves foráneas.

![Descripcion de Tablas ](https://github.com/laut-code/Data_Analytics-Proyectos_MinCyT/blob/main/imagenes_readme/Resumen_tablas.png)

Descripción detallada del contenido de cada tabla:
![Detalle de tablas 1](https://github.com/laut-code/Data_Analytics-Proyectos_MinCyT/blob/main/imagenes_readme/descripcion_tablas1.png)
![Detalle de tablas 2](https://github.com/laut-code/Data_Analytics-Proyectos_MinCyT/blob/main/imagenes_readme/descripcion_tablas2.png)
![Detalle de tablas 3](https://github.com/laut-code/Data_Analytics-Proyectos_MinCyT/blob/main/imagenes_readme/descripcion_tablas3.png)

Por último, a continuación se explicíta el modelo entidad-relación de la base de datos, detallando la cardinalidad y el sentido de relación entre las tablas:

![Modelo E-R](https://github.com/laut-code/Data_Analytics-Proyectos_MinCyT/blob/main/imagenes_readme/Modelo%20Entidad-Relacion.png)


## 3- Procesamiento en SQL
Con el objetivo de limpiar la base de datos de registros y campos innecesarios al objetivo del analisis, y de crear las tablas establecidas en el modelo anterior se procedio mediante SQL Server Management Studio a:

1- Crear la base de datos e importar las "tablas base" indicadas anteriormente.

2- Unificar los datos principales procedientes de las tablas con formato "proyecto_año" en una sola tabla llamada "proyectos", indicando en una columna el año correspondiente a cada proyecto.

3- De la tabla principal "proyectos" derivar las tablas "genero" y "montos" con los campos y registros correspondientes.

4- Crear la tabla "proyecto_disciplina" a partir de la "tabla base" "ref_DISCIPLINA".

5- Limpiar de registros, columnas y tablas excedentes la base de datos.

6- Armonizar los valores de las tablas que se relacionan entre si.

7- Establecer las Primary Keys y Foreign Keys correspondientes a cada tabla.

Las sentencias SQL utilizadas para realizar este conjunto de procesos estan detalladas en el archivo [proceso_SQL.sql](/proceso_SQL.sql) del presente repositorio.


## 4- Transformación y visualización de datos mediante Power BI
Una vez modelada la base de datos se conectó Microsoft Power BI a la misma y se realizaron las siguientes transformaciones:

- Se especificaron las "medidas resumenes" y "no resumenes" a los campos correspondientes

- Se corrigieron las alteraciones de los valores de las tablas que se produjeron en caracteres con acentos y eñes reemplazandolos por valores correspondientes.

En el informe se establecieron 4 solapas: 
 
-"Portada": Titúlo, Autor, índice.

-"Proyectos": Información gráfica de montos solicitados y financiados, y  las cantidades de proyectos con la posibilidad de aplicar varios filtros.

-"Disciplinas": Información gráfica sobre las distribución de los proyectos en relación a las distintas areas disciplinarias y los tipos de proyectos, con la posibilidad de filtrar mediante año y periodos entre años. 

-"Género":  Información gráfica sobre la cantidad de mujeres y varones miembros y directores/as en cada proyecto, con la posibilidad de aplicar varios filtros.

EL PROYECTO SE ENCUENTRA EN ETAPA DE FINALIZACIÓN. DURANTE EL DIA 29/03/2022 SE ACTUALIZARA ESTA SECCIÓN Y EL RESTO DEL REPOSITORIO DE MANERA DEFINITIVA.





