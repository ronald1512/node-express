
# GET /detalle_orden/:id_orden?/:id_producto?


Obtiene registros de la relacion.

| Codigo | Descripcion |
|-----------|:-----------:| 
| 404 | No fue posible obtener el registro solicitado |
| 200 | Registros obtenidos con éxito |
>Responses
>>Response content type: application/json

# GET /detalle_orden2/:id_producto?


Obtiene las ordenes que solicitaron determinado producto.

| Codigo | Descripcion |
|-----------|:-----------:| 
| 404 | No fue posible obtener el registro solicitado |
| 200 | Registros obtenidos con éxito |
>Responses
>>Response content type: application/json


# POST /detalle_orden


Agrega productos al detalle.
``` js
{
    "id_producto": 1,
    "id_orden": 1,
    "cantidad": 10000
}
```


| Codigo | Descripcion |
|-----------|:-----------:| 
| 409 | El producto ya ha sido detallado previamente en esta orden|
| 404 | Hacen falta parametros|
| 201 | Item created |

>Responses
>>Response content type: application/json