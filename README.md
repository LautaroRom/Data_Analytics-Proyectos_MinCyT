# Proyecto de Data Analytic: Proyectos del Ministerio de Ciencia, Tecnología e Innovación

El presente proyecto tiene como finalidad generar un tablero de información dinámico e interactivo mediante Microsoft Power BI sobre los 6943 proyectos científicos y tecnológicos beneficiarios y/o financiados por el Ministerio de Ciencia, Tecnología e Innovación de la República Argentina entre los años 2015 y 2019, reportando datos relacionados a la cantidad de proyectos presentados en cada año, tipo de proyecto y área de conocimiento en la que estan insertos, cantidades monetarias adjudicadas y financiadas, y la composición en materia de género sobre los equipos de cada proyecto. 

Este trabajo espera ser un aporte a la investigación sobre las políticas públicas en materia de ciencia y tecnología existentes en nuestro país, facilitando la consulta de información comparativa de manera interactiva, como así tambien ser un complemento a los reportes presentados por el Ministerio de Ciencia, Tecnología e Innovación en su [portal de información estadística](https://datos.mincyt.gob.ar/).

Al final de este documento se encontrará el tablero interactivo.

A continuación se documenta las distintas etapas ejecutadas para su realización:

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
Con el objetivo de limpiar la base de datos de registros y campos innecesarios al objetivo del análisis y de crear las tablas establecidas en el modelo anterior, se procedió mediante SQL Server Management Studio a:

1- Crear la base de datos e importar las "tablas base" indicadas anteriormente.

2- Unificar los datos principales procedientes de las tablas con formato "proyecto_año" en una sola tabla llamada "proyectos", indicando en una columna el año correspondiente a cada proyecto.

3- De la tabla principal "proyectos" derivar las tablas "genero" y "montos" con los campos y registros correspondientes.

4- Crear la tabla "proyecto_disciplina" a partir de la "tabla base" "ref_DISCIPLINA".

5- Limpiar de registros, columnas y tablas excedentes la base de datos.

6- Armonizar los valores de las tablas que se relacionan entre sí.

7- Establecer las Primary Keys y Foreign Keys correspondientes a cada tabla.

Las sentencias SQL utilizadas para realizar este conjunto de procesos estan detalladas en el archivo [procesamiento_SQL.sql](/procesamiento_SQL.sql) del presente repositorio.


## 4- Transformación y visualización de datos mediante Power BI
Una vez modelada la base de datos se conectó Microsoft Power BI a la misma y se realizaron las siguientes transformaciones:

- Se especificaron como "medidas resúmenes" y "no resúmenes" los campos correspondientes.

- Se corrigieron las alteraciones de los valores de las tablas que se produjeron en caracteres con acentos y eñes reemplazandolos por los respectivos valores correspondientes.

- Se agregaron varias medidas calculadas y columnas calculadas según los requerido para este informe. Las fórmulas y explicación de las mismas se detallan a continuación:

![Medidas Calculadas 1](https://github.com/laut-code/Data_Analytics-Proyectos_MinCyT/blob/main/imagenes_readme/Medidas1.png)
![Medidas Calculadas 2](https://github.com/laut-code/Data_Analytics-Proyectos_MinCyT/blob/main/imagenes_readme/Medidas2.png)

Cabe aclarar que las columnas calculadas siguientes pertenecen todas a la tabla "genero":
![Columnas calculadas](https://github.com/laut-code/Data_Analytics-Proyectos_MinCyT/blob/main/imagenes_readme/ColumnasCalc.png)

Para el informe se conformaron 4 páginas. A continuación se explicará el contenido y la función de cada una: 
 
- Página "Portada": Titúlo, Autor, índice. El indice esta compuesto por botones que dirigen a las páginas correspondientes del informe.
![Solapa Portada](https://github.com/laut-code/Data_Analytics-Proyectos_MinCyT/blob/main/imagenes_readme/Portada.png)

- Página "Financiamiento":
 
   -Gráfico de columnas agrupadas con el fin de comparar los montos solicitados adjudicados con los montos financiados adjudicados. Gráfico de líneas para ver la evolucion de la cantidad de proyectos a traves de los años.
  
   -3 Tarjetas de indicadores: Sumatoria de los montos totales adjudicados a los proyectos, indicador del porcentaje total financiado a los proyectos, indicador de la cantidad de proyectos. 
  
   -4 Filtros aplicables a los graficos y las tarjetas: Rango de Años, Grupo de tipo de proyectos (Ciencia o Tecnología), Area del conocimiento (Ciencias naturales y exactas, Ciencias de la Salud, Ciencias agríciolas, Humanidades, Ingenieria, Ciencias sociales), Tipo de proyectos (33 tipos de proyectos)
![Solapa Financiamiento](https://github.com/laut-code/Data_Analytics-Proyectos_MinCyT/blob/main/imagenes_readme/Financiamientos.png)


- Página "Disciplinas": 

   - Gráfico Treemap para mostrar la proporción en la cantidad de proyectos para cada disciplina del conocimiento.
  
   - Tabla para indicar la cantidad de proyectos para cada uno de los 33 tipos de proyectos.
  
   - Gráfico de barras agrupadas indicando la cantidad de proyectos que pertenecen a cada tipo de fondo.
  
   - Gráfico de barras agrupadas marcando la cantidad de proyectos que proceden del CONICET (Consejo Nacional de Investigaciones Científicas y Técnicas) o la ANPCYT(Agencia Nacional de Promoción Científica y la Tecnológica)
  
   - 2 Filtros aplicables a todos los gráficos: Rango de años y Año particular.
![Solapa Disciplinas](https://github.com/laut-code/Data_Analytics-Proyectos_MinCyT/blob/main/imagenes_readme/Disciplinas.png)


- Página "Género":  

   - Gráfico circular para mostrar la cantidad y la proporción de miembros varones y mujeres del total de los equipos que componen los proyectos.
  
   - Gráfico de anillos para indicar la cantidad y proporción de los directores varones y mujeres de los proyectos.
   
   - Tarjeta para indicar la cantidad de proyectos que tienen al menos el 50% de sus miembros de género femenino.
   
   - Tarjeta para indicar el porcentaje de proyectos que tienen al menos el 50% de sus miembros de género femenino sobre el total de proyectos.
   
   - KPI: indicador de la variación del porcentaje de mujeres sobre el total de miembros de los proyectos existente en relación al año 2015.
   
   - KPI: indicador de la variación del porcentaje de directoras en relacion al total de directores/as en relación al año 2015.
   
   - 5 filtros aplicables a todos los indicadores, tarjetas y KPIs: Rango de años, selector de año en particular, grupo de tipo de proyectos, area del conocimiento y tipo de proyectos.
![Solapa Genero](https://github.com/laut-code/Data_Analytics-Proyectos_MinCyT/blob/main/imagenes_readme/Genero1.png)

ACTUALMENTE SE ESTÁ GESTIONANDO LA OBTENCIÓN DE UNA CUENTA DE MICROSOFT POWER BI QUE TENGA LOS PERMISOS NECESARIOS PARA PUBLICAR EL TABLERO INTERACTIVO EN ESTA WEB.
POR EL MOMENTO ESTA DISPONIBLE UNA [VERSIÓN INCOMPLETA DESARROLLADA EN TABLEAU](https://public.tableau.com/app/profile/lautaro3759/viz/MinCyT/Cantidadyfinanciamiento).



