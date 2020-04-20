# GET /autorizacion

>Responses
>>Response content type: application/json

Obtiene todas las autorizaciones registradas.

| Codigo | Descripcion |
|-----------|:-----------:| 
| 404 | No fue posible obtener el rol solicitado |
| 200 | Registros obtenidos con éxito |

# POST /autorizacion

>Responses
>>Response content type: application/json

Le asigna un nuevo permiso a determinado usuario.
``` js
{
    "id_usuario": 5,
    "id_permiso": 3
}
```


| Codigo | Descripcion |
|-----------|:-----------:| 
| 404 | Hacen falta parametros |
| 200 | Item created |
