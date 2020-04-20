
# GET /producto/:id_producto?


Obtiene registros de productos.

| Codigo | Descripcion |
|-----------|:-----------:| 
| 404 | No fue posible obtener el producto solicitado |
| 200 | Registros obtenidos con éxito |
>Responses
>>Response content type: application/json


# POST /producto


Agrega un nuevo producto en el sistema.
``` js
{
    "nombre": "Sombrero de plaza",
    "descripcion": "Es un producto duradero",
    "precio": 34.99
}
```


| Codigo | Descripcion |
|-----------|:-----------:| 
| 404 | Hacen falta parametros|
| 409 | No se pudo crear el producto |
| 201 | Item created |

>Responses
>>Response content type: application/json


# PUT /producto/:id_producto


Modifica un producto.
``` js
{
    "nombre": "Sombrero de plaza",
    "descripcion": "Es un producto duradero",
    "precio": 34.99
}
```


| Codigo | Descripcion |
|-----------|:-----------:| 
| 404 | No se pudo actualizar el producto|
| 201 | Producto actualizado con éxito |

>Responses
>>Response content type: application/json