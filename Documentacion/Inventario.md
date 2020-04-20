
# GET /inventario/:id_producto?/:id_bodega?


Obtiene registros de la relacion.

| Codigo | Descripcion |
|-----------|:-----------:| 
| 404 | No fue posible obtener el registro solicitado |
| 200 | Registros obtenidos con éxito |
>Responses
>>Response content type: application/json


# GET /inventario2/:id_bodega?


Obtiene registros de productos almacenados en cierta bodega.

| Codigo | Descripcion |
|-----------|:-----------:| 
| 404 | No fue posible obtener el registro solicitado |
| 200 | Registros obtenidos con éxito |
>Responses
>>Response content type: application/json


# POST /inventario


Abastece de un producto a una bodega. Esta solicitud manda a llamar a un
 procedimiento almacenado de la base de datos que, ademas de registrar el
 producto en la bodega, agrega el registro correspondiente en el log del inventario.
``` js
{
    "id_producto": 1,
    "id_bodega": 1,
    "cantidad_nueva": 10000,
    "motivo": "Abastacimiento de bodega",
    "encargado": 1
}
```


| Codigo | Descripcion |
|-----------|:-----------:| 
| 404 | Hacen falta parametros|
| 409 | No se pudo agregar el registro |
| 200 | Item created |

>Responses
>>Response content type: application/json