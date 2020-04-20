
# GET /venta/:id_venta?


Obtiene registros de ventas.

| Codigo | Descripcion |
|-----------|:-----------:| 
| 404 | No fue posible obtener la venta solicitada |
| 200 | Registros obtenidos con éxito |
>Responses
>>Response content type: application/json

# GET /venta2/:vendedor


Obtiene registros de ventas de un determinado vendedor.

| Codigo | Descripcion |
|-----------|:-----------:| 
| 404 | No fue posible obtener la venta solicitada |
| 200 | Registros obtenidos con éxito |
>Responses
>>Response content type: application/json


# POST /venta


Agrega una nueva venta en el sistema.
``` js
// Json para agregar una venta a domicilio
{
    "id_cliente": 7,
    "vendedor": 4,
    "repartidor": 1
}
// Json para agregar una venta local
{
    "id_cliente": 7,
    "vendedor": 4
}
```


| Codigo | Descripcion |
|-----------|:-----------:| 
| 404 | Hacen falta parametros|
| 409 | No se pudo crear la venta |
| 201 | Item created |

>Responses
>>Response content type: application/json


# PUT /venta/:id_venta


Modifica los datos de una venta. Solo es necesario espeficicar el id_venta, ya que PUT va a servir unicamente para confirmar la entrega de una venta a domicilio, en ella se llama a un procedimiento almacenado de la base de datos que se encarga de todo.



| Codigo | Descripcion |
|-----------|:-----------:| 
| 404 | No se pudo confirmar la entrega de la venta|
| 201 | Venta entregada con éxito |

>Responses
>>Response content type: application/json