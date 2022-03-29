# Proyecto de Data Analytic: Proyectos del Ministerio de Ciencia, Tecnología e Innovación

El presente proyecto tiene como finalidad generar un tablero de información dinámico e interactivo mediante Microsoft Power BI sobre los 6943 proyectos científicos y tecnológicos beneficiarios y/o financiados por el Ministerio de Ciencia, Tecnología e Innovación de la República Argentina entre los años 2015 y 2019, reportando datos relacionados a la cantidad de proyectos presentados en cada año, tipo de proyecto y area de conocimiento en la que estan insertos, cantidades monetarias adjudicadas y financiadas, y la composición en materia de género sobre los equipos de cada proyecto. 

Este trabajo espera ser un aporte a la investigación sobre las políticas públicas en materia de ciencia y tecnologia existentes en nuestro país, facilitando la consulta de información comparativa de manera interactiva, como así tambien ser un complemento a los reportes presentados por el Ministerio de Ciencia, Tecnología e Innovación en su [portal de información estadística](https://datos.mincyt.gob.ar/).

Para dirigirse directamente al tablero hacer click aquí.

A continuación se documenta las distintas etapas realizadas para su realización:

## 1- Extracción y fuente de datos
Los datos se extrajeron de [datasets abiertos del Ministerio de Ciencia y Tecnologia](https://datasets.datos.mincyt.gob.ar/dataset/proyectos-de-ciencia-tecnologia-e-innovacion). Las tablas especificas usadas en este proyecto se encuentran en la carpeta [Tablas Base](https://github.com/laut-code/Data_Analytics-Proyectos_MinCyT/tree/main/Tablas%20Base) del presente repositorio. Posteriormente
los datos fueron transformados, limpiados y modelados mediante SQL, empleando SQL Server Management Studio.

## 2- Modelado de la base de datos
De las tablas extraidas del dataset mencionado se generó la base de datos compuesta por las tablas descriptas en las siguientes imágenes, indicadas con sus respectivas claves primarias y claves foraneas.

![Descripcion de Tablas ](https://github.com/laut-code/Data_Analytics-Proyectos_MinCyT/blob/main/imagenes_readme/Resumen_tablas.png)

Descripción detallada del contenido de cada tabla:
![Detalle de tablas 1](https://github.com/laut-code/Data_Analytics-Proyectos_MinCyT/blob/main/imagenes_readme/descripcion_tablas1.png)
![Detalle de tablas 2](https://github.com/laut-code/Data_Analytics-Proyectos_MinCyT/blob/main/imagenes_readme/descripcion_tablas2.png)
![Detalle de tablas 3](https://github.com/laut-code/Data_Analytics-Proyectos_MinCyT/blob/main/imagenes_readme/descripcion_tablas3.png)

Por último a continuación se explicíta el modelo entidad-relación de la base de datos, detallando la cardinalidad y el sentido de relación entre las tablas:

![Modelo E-R](https://github.com/laut-code/Data_Analytics-Proyectos_MinCyT/blob/main/imagenes_readme/Modelo%20Entidad-Relacion.png)


## 3- Procesamiento de datos en SQL
Las sentencias utilizadas para procesar las tablas base estan detalladas en el archivo [proceso_SQL.sql](/proceso_SQL.sql) del presente repositorio.

EL PROYECTO SE ENCUENTRA EN ETAPA DE FINALIZACIÓN. ENTRE LOS DIAS 25/03/2022 y 28/03/2022 SE ACTUALIZARA ESTA SECCIÓN Y EL RESTO DEL REPOSITORIO DE MANERA DEFINITIVA

## 4- Transformación y visualizacion de datos mediante Power BI
EL PROYECTO SE ENCUENTRA EN ETAPA DE FINALIZACIÓN. ENTRE LOS DIAS 25/03/2022 y 28/03/2022 SE ACTUALIZARA ESTA SECCIÓN Y EL RESTO DEL REPOSITORIO DE MANERA DEFINITIVA





