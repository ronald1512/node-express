
# GET /detalle_venta/:id_venta?


Obtiene registros de la relacion.

| Codigo | Descripcion |
|-----------|:-----------:| 
| 404 | No fue posible obtener el registro solicitado |
| 200 | Registros obtenidos con éxito |
>Responses
>>Response content type: application/json


# POST /detalle_venta


Detalla los productos que se vendieron ya sea local o a domicilio. Si la venta es local entonces los productos de sacan de una vez del inventario, de otro modo, se sacan del inventario cuando el repartidor marca como entregada la venta.
``` js
{
    "id_producto": 1,
    "id_bodega": 1,
    "cantidad": 10000,
    "id_venta": 1,
    "descuento": 0.35
}
```


| Codigo | Descripcion |
|-----------|:-----------:| 
| 404 | El producto ya ha sido detallado previamente en esta venta|
| 201 | Item created |

>Responses
>>Response content type: application/json