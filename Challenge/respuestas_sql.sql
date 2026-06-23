/*3.1. Debug de un query*/

/*Un compañero te pasa el siguiente query y dice 'me da resultados raros para Bilbao y Sevilla,
no entiendo por qué'.
SELECT c.ciudad,
 AVG(p.monto) AS gasto_promedio,
 COUNT(p.id_pedido) AS n_pedidos
FROM clientes c
LEFT JOIN pedidos p ON c.id_cliente = p.id_cliente
WHERE p.estado = 'completado'
 AND p.monto > 0
GROUP BY c.ciudad
ORDER BY gasto_promedio DESC;

Pregunta: ¿hay un bug? Si lo hay, explicá con tus palabras qué está haciendo mal el query,
mostrá el query corregido y explicá por qué tu versión es correcta.
*/


/*Query corregida*/

SELECT c.ciudad,
 AVG(p.monto) AS gasto_promedio,
 COUNT(p.id_pedido) AS n_pedidos
FROM clientes c
LEFT JOIN pedidos p
  ON c.id_cliente = p.id_cliente
  AND p.estado = 'completado'
  AND p.monto > 0
GROUP BY c.ciudad
ORDER BY gasto_promedio DESC;

/*Si, hay bug. El problema es que en la query original estas haciendo 
WHERE p.estado = 'completado' después del left join y esto genera el 
comportamiento de un inner join. La query original incluye en el resultado
las ciudades que no tienen pedidos completados, pero al hacer el where esas
ciudades se filtran y desaparecen. Para que eso no pase no hay que filtrar
con where, sino que hay que colocar ON c.id_cliente = p.id_cliente
AND p.estado = 'completado'  AND p.monto > 0. De esta manera, el left join
mostrará las ciudades que no tienen pedidos.*/