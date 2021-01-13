# SISCOVID - Modelo Metapoblacional
Este tipo de modelos dividen los individuos de una población en varios compartimentos: susceptibles, infectados, recuperados. Cada compartimento representa un número de individuos.
Este modelo asume que la población se encuentra homogéneamente mezclada y se comporta de manera similar. Los personas se pueden agrupar en subgrupos o metapoblaciones que pueden o no estar conectados entre si.

## Objetivos del modelo
El objetivo del modelo es relacionar el crecimiento de la epidemia con las dinámicas de cada ciudad a través de las tendencias de las tasas de contagio y de movilidad.

## Estimación de las tasas de contagio
La variable a ajustar debe ser definida (¿cómo?) ___________________ para luego usarse dentro de la metodología Markov Chain Monte Carlo – Metropolis Hastings (MCMC-MH). 
Se recomienda que las fechas a establecer ofrezcan un número de datos suficiente para para la estimación del parámetro de contagio beta, sugiriendo más de tres semanas (veintiún datos).

### Interpretación de resultados

__________________________________________________

## Evaluación de las tendencias de movilidad
En el archivo [MetaPopCOVID19](https://github.com/SISCOVID/Modelo-Metapoblacional/blob/master/MetaPopCOVID19.m) es posible introducir las amtrices de movilidad de la ciudad a analizar. Estas matrices indican el porcentaje de movimiento entre subpoblaciones y puede definirse en distintas escalas temporales o jornadas (shifts).

## Citación

Felipe Montes, Jose D. Meisel, Pablo Lemoine, Diana R. Higuera, Andrés F. Useche, Sofía del C. Baquero, Juliana Quintero, Diego A. Martínez, Laura Idrobo, Ana M. Jaramillo, Juan D. Umaña, Diana Erazo, Daniel Duque, Andrea Alarcón, Carolina Rojas, Olga L. Sarmiento, Santiago Ortiz, Julián Castro, Gustavo Martínez, Juan Sosa, John K. Giraldo, Fabián C. Peña, Camilo Montes, Juan S. Guerrero & Esperanza Buitrago. SISCOVID: modelos de sistemas complejos para contribuir a disminuir la transmisión de SARS-CoV-2 en contextos urbanos de colombia, 2020
