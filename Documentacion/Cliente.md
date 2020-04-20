
# GET /cliente/:id_cliente?


Obtiene registros de cliente.

| Codigo | Descripcion |
|-----------|:-----------:| 
| 404 | No fue posible obtener el cliente solicitado |
| 200 | Registros obtenidos con éxito |
>Responses
>>Response content type: application/json


# POST /cliente


Agrega una nueva sede en el sistema.
``` js
{
    "nombre": "El siempre puntual",
    "nit": "6748334-K",
    "dpi": 4446212938,
    "direccion": "Casa 23 Aldea La Hermosa. z. 6 de Villa Nueva",
    "id_sede": 6
}
```


| Codigo | Descripcion |
|-----------|:-----------:| 
| 404 | Hacen falta parametros|
| 409 | No se pudo crear el cliente |
| 201 | Item created |

>Responses
>>Response content type: application/json


# PUT /cliente/:id_cliente


Modifica los datos de un cliente.
``` js
{
    "nombre": "El siempre puntual",
    "nit": "6748334-K",
    "dpi": 4446212938,
    "direccion": "Casa 23 Aldea La Hermosa. z. 6 de Villa Nueva",
    "id_sede": 6
}
```


| Codigo | Descripcion |
|-----------|:-----------:| 
| 404 | No se pudo actualizar el cliente|
| 201 | Cliente actualizado con éxito |

>Responses
>>Response content type: application/json