
# GET /orden/:id_orden?


Obtiene registros de orden de transferencia.

| Codigo | Descripcion |
|-----------|:-----------:| 
| 404 | No fue posible obtener la venta solicitada |
| 200 | Registros obtenidos con éxito |
>Responses
>>Response content type: application/json

# GET /orden2/:sede_destino


Obtiene registros de ordenes de transferencia solicitadas a cierta sede.

| Codigo | Descripcion |
|-----------|:-----------:| 
| 404 | No fue posible obtener la orden de transferencia solicitada |
| 200 | Registros obtenidos con éxito |
>Responses
>>Response content type: application/json


# POST /orden


Agrega una nueva orden en el sistema.
``` js
// Json para agregar una orden de transferencia externa
{
    "id_solicitante": 7, // usuario que está solicitando la transferencia.
    "contenido_descripcion": "Necesito de tus productoos!", // descripcion de la solicitud. Puede ser null
    "bodega_entrante": 1, // bodega a la que desea abastecer de productos
    "sede_destino": 1 //sede a la qué sede desea solicitar productos
}
// Json para agregar una orden de transferencia interna
{
    "id_solicitante": 7, // usuario que está solicitando la transferencia.
    "contenido_descripcion": "Por favor, es una venta grande", // descripcion de la solicitud. Puede ser null
}
```


| Codigo | Descripcion |
|-----------|:-----------:| 
| 404 | Hacen falta parametros|
| 409 | No se pudo crear la orden de transferencia |
| 201 | Item created |

>Responses
>>Response content type: application/json


# PUT /orden/:id_orden

Se utiliza para marcar como aceptada o entregada una orden de transferencia, segun el tipo de orden, Interna o Externa. En todos los casos se manda a llamar a un procedimiento almacenado que maneja todas las validaciones.

``` js
// Json para aceptar una orden de transferencia INTERNA
{
    "id_orden": 7, 
    "entrante": 5, //bodega que se abastecerá de productos
    "saliente": 1, //bodega de la que saldran los productos
    "individuo": 1 // usuario que está aceptando la orden
}
// Json para aceptar una orden de transferencia externa
{
    "id_orden": 7, 
    "saliente": 1, //bodega de la que saldran los productos
    "individuo": 1 // usuario que está aceptando la orden
    "repartidor": 1 // repartidor que entregará la orden de transferencia
}
// Json para entregar una orden de transferencia externa
{
    "id_orden": 7,
    "repartidor_id": 1 // repartidor que hizo entrega de la orden de transferencia
}
```




| Codigo | Descripcion |
|-----------|:-----------:| 
| 404 | No se pudo confirmar actualizar la orden de transferencia|
| 200 | Venta entregada con éxito |

>Responses
>>Response content type: application/json