/*Desarrollar las siguientes consultas:
1. Mostrar todos los usuarios que no han creado ningún tablero, para dichos usuarios mostrar el nombre completo y correo, utilizar producto cartesiano con el operador (+).*/

SELECT A.NOMBRE||' '||A.APELLIDO, A.CORREO
FROM TBL_USUARIOS A,
    TBL_TABLERO B
WHERE A.CODIGO_USUARIO = B.CODIGO_USUARIO_CREA(+)
AND B.CODIGO_USUARIO_CREA IS NULL;

/*
2. Mostrar la cantidad de usuarios que se han registrado por cada red social, mostrar inclusive la cantidad de usuarios que no están registrados con redes sociales.*/
SELECT NVL(B.NOMBRE_RED_SOCIAL,'Ninguno') AS RED_SOCIAL, COUNT(1) as CANTIDAD_USUARIOS
FROM TBL_USUARIOS A
LEFT JOIN TBL_REDES_SOCIALES B
ON (A.CODIGO_RED_SOCIAL = B.CODIGO_RED_SOCIAL)
GROUP BY NVL(B.NOMBRE_RED_SOCIAL,'Ninguno');


/*
3. Consultar el usuario que ha hecho más comentarios sobre una tarjeta (El más prepotente), para este usuario mostrar el nombre completo, correo, cantidad de comentarios y cantidad de tarjetas a las que ha comentado (pista: una posible solución para este último campo es utilizar count(distinct campo))*/

SELECT B.NOMBRE||' '|| B.APELLIDO AS NOMBRE_COMPLETO, 
      A.CODIGO_USUARIO, CANTIDAD_COMENTARIOS,
      B.CORREO
      CANTIDAD_TARJETAS_DISTINTAS
FROM (
  SELECT CODIGO_USUARIO, 
          COUNT(1) CANTIDAD_COMENTARIOS,
          COUNT(DISTINCT CODIGO_TARJETA) CANTIDAD_TARJETAS_DISTINTAS
  FROM TBL_COMENTARIOS
  GROUP BY CODIGO_USUARIO
  ORDER BY CANTIDAD_COMENTARIOS DESC
) A
LEFT JOIN TBL_USUARIOS B
ON (A.CODIGO_USUARIO = B.CODIGO_USUARIO)
WHERE ROWNUM = 1;



SELECT *
FROM (
  SELECT CODIGO_USUARIO, 
          COUNT(1) CANTIDAD_COMENTARIOS,
          COUNT(DISTINCT CODIGO_TARJETA) CANTIDAD_TARJETAS_DISTINTAS
  FROM TBL_COMENTARIOS
  GROUP BY CODIGO_USUARIO
)
WHERE CANTIDAD_COMENTARIOS = (
  SELECT MAX(CANTIDAD_COMENTARIOS) AS CANTIDAD_COMENTARIOS      
  FROM (
    SELECT CODIGO_USUARIO, 
            COUNT(1) CANTIDAD_COMENTARIOS
    FROM TBL_COMENTARIOS
    GROUP BY CODIGO_USUARIO
  )
);



SELECT ()
FROM ()
WHERE CAMPO IN (select CAMPO FROM TABLA);

/*
4. Mostrar TODOS los usuarios con plan FREE, de dichos usuarios mostrar la siguiente información:
? Nombre completo
? Correo
? Red social (En caso de estar registrado con una)
? Cantidad de organizaciones que ha creado, mostrar 0 si no ha creado ninguna.
5. Mostrar los usuarios que han creado más de 5 tarjetas, para estos usuarios mostrar:
Nombre completo, correo, cantidad de tarjetas creadas
6. Un usuario puede estar suscrito a tableros, listas y tarjetas, de tal forma que si hay algún cambio se le notifica en su teléfono o por teléfono, sabiendo esto, se necesita mostrar los nombres de todos los usuarios con la cantidad de suscripciones de cada tipo, en la consulta se debe mostrar:
? Nombre completo del usuario
? Cantidad de tableros a los cuales está suscrito
? Cantidad de listas a las cuales está suscrito
? Cantidad de tarjetas a las cuales está suscrito
7. Consultar todas las organizaciones con los siguientes datos:
? Nombre de la organización
? Cantidad de usuarios registrados en cada organización
? Cantidad de Tableros por cada organización
? Cantidad de Listas asociadas a cada organización
? Cantidad de Tarjetas asociadas a cada organización
8. Crear una vista materializada con la información de facturación, los campos a incluir son los siguientes:
? Código factura
? Nombre del plan a facturar
? Nombre completo del usuario
? Fecha de pago (Utilizar fecha inicio, mostrarla en formato Día-Mes-Año)
? Año y Mes de pago (basado en la fecha inicio)
? Monto de la factura
? Descuento
? Total neto
9. Crear una tabla dinámica en excel que consulte la información de la vista materializada del inciso anterior, de dicha tabla dinámica crear un gráfico de línea que muestre en el eje X el campo Año/mes de pago y en el eje Y los nombres de los planes, el valor numérico a mostrar en la grafica deberá ser el Total neto.*/




SELECT REPLACE(TO_CHAR(TO_DATE('25/12/2015','DD/MM/YYYY'),'YYYYMM-DD'), '/','#') as fecha
FROM dual;