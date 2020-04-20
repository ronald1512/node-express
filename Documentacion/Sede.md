
# GET /sede/:id_sede?


Obtiene registros de usuarios.

| Codigo | Descripcion |
|-----------|:-----------:| 
| 404 | No fue posible obtener la sede solicitada |
| 200 | Registros obtenidos con éxito |
>Responses
>>Response content type: application/json


# POST /sede


Agrega una nueva sede en el sistema.
``` js
{
    "alias": "La sede del norte",
    "direccion": "8 av. 3-48 aldea el Pino",
    "id_mun": 4,
    "encargado": 6
}
```


| Codigo | Descripcion |
|-----------|:-----------:| 
| 404 | Hacen falta parametros|
| 409 | No se pudo crear la sede |
| 201 | Item created |

>Responses
>>Response content type: application/json


# PUT /sede/:id_sede


Modifica una sede.
``` js
{
    "alias": "La sede del norte",
    "direccion": "8 av. 3-48 aldea el Pino",
    "id_mun": 4,
    "encargado": 6
}
```


| Codigo | Descripcion |
|-----------|:-----------:| 
| 404 | No se pudo actualizar la sede|
| 201 | Sede actualizada con éxito |

>Responses
>>Response content type: application/json