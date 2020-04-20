
# GET /detalle_producto/:id_producto?/:id_categoria?


Obtiene todas las relaciones entre producto y categoria registradas.

| Codigo | Descripcion |
|-----------|:-----------:| 
| 404 | No fue posible obtener el registro solicitado |
| 200 | Registros obtenidos con éxito |
>Responses
>>Response content type: application/json

# GET /detalle_producto2/:id_categoria


Obtiene todos los productos con una determinada caracteristica.

| Codigo | Descripcion |
|-----------|:-----------:| 
| 404 | No fue posible obtener los registros solicitados |
| 200 | Registros obtenidos con éxito |
>Responses
>>Response content type: application/json

# POST /detalle_producto


Le asigna una nueva caracteristica a determinado producto.
``` js
{
    "id_producto": 5,
    "id_caracteristica": 3
}
```


| Codigo | Descripcion |
|-----------|:-----------:| 
| 404 | Hacen falta parametros |
| 200 | Item created |

>Responses
>>Response content type: application/json