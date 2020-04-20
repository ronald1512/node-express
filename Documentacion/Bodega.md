
# GET /bodega/:id_bodega?


Obtiene registros de bodegas.

| Codigo | Descripcion |
|-----------|:-----------:| 
| 404 | No fue posible obtener la bodega solicitada |
| 200 | Registros obtenidos con éxito |
>Responses
>>Response content type: application/json


# POST /bodega


Agrega una nueva bodega en el sistema.
``` js
{
    "nombre": "La sede del norte",
    "direccion": "8 av. 3-48 aldea el Pino",
    "id_sede": 4,
    "encargado": 6
}
```


| Codigo | Descripcion |
|-----------|:-----------:| 
| 404 | Hacen falta parametros|
| 409 | Un encargado puede estar a cargo solo de una bodega a la vez. |
| 201 | Item created |

>Responses
>>Response content type: application/json


# PUT /bodega/:id_bodega


Modifica una bodega.
``` js
{
    "nombre": "La sede del norte",
    "direccion": "8 av. 3-48 aldea el Pino",
    "estado": 'E',
    "id_sede": 4,
    "encargado": 6
}
```


| Codigo | Descripcion |
|-----------|:-----------:| 
| 404 | No se pudo actualizar la bodega|
| 201 | Bodega actualizada con éxito |

>Responses
>>Response content type: application/json