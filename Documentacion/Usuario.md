
# GET /usuario/:id_usuario?


Obtiene registros de usuarios.

| Codigo | Descripcion |
|-----------|:-----------:| 
| 404 | No fue posible obtener el usuario solicitado |
| 200 | Registros obtenidos con éxito |
>Responses
>>Response content type: application/json


# POST /usuario


Le asigna un nuevo permiso a determinado usuario.
``` js
{
    "dpi": 3606169920101,
    "nombre": "Ronald Gabriel Romero González",
    "fecha_nacimiento": "1998-12-15",
    "correo": "example.email@example.com",
    "contraseña": "123456",
    "id_sede": 1||null // puede ser null, en el caso de usuarios admin.
}
```


| Codigo | Descripcion |
|-----------|:-----------:| 
| 404 | Hacen falta parametros|
| 409 | El DPI o correo ya estan asignados a otro usuario |
| 200 | Item created |

>Responses
>>Response content type: application/json