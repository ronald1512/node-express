
# GET /usuario_rol/:id_usuario?/:id_rol?


Obtiene todas las relaciones entre usuario y rol registradas.

| Codigo | Descripcion |
|-----------|:-----------:| 
| 404 | No fue posible obtener el registro solicitado |
| 200 | Registros obtenidos con éxito |
>Responses
>>Response content type: application/json

# GET /usuario_rol2/:id_rol


Obtiene todos los usuarios con un determinado rol.

| Codigo | Descripcion |
|-----------|:-----------:| 
| 404 | No fue posible obtener los registros solicitados |
| 200 | Registros obtenidos con éxito |
>Responses
>>Response content type: application/json

# POST /usuario_rol


Le asigna un nuevo rol a determinado usuario.
``` js
{
    "id_usuario": 5,
    "id_rol": 3
}
```


| Codigo | Descripcion |
|-----------|:-----------:| 
| 404 | Hacen falta parametros |
| 200 | Item created |

>Responses
>>Response content type: application/json