**[Departamento](./Documentacion/Departamento.md)**
---

Entrega información sobre los departamentos de Guatemala.
 - GET


**[Municipio](./Documentacion/Municipio.md)**
---

Entrega información sobre los municipios de Guatemala.
 - GET

**[Rol](./Documentacion/Rol.md)**
---

Entrega información sobre los roles dentro del sistema.
 - GET


**[Permiso](./Documentacion/Permiso.md)**
---

Entrega información sobre los permisos dentro del sistema.
 - GET

 **[Autorización](./Documentacion/Autorizacion.md)**
---

Relaciona usuarios con permisos dentro del sistema.
 - GET
 - POST
 - DELETE


  **[Usuario](./Documentacion/Usuario.md)**
---

Gestiona a los usuarios del sistema.
 - GET
 - POST
 - PUT


 **[Usuario_Rol](./Documentacion/Usuario_Rol.md)**
---

Gestiona los roles de los usuarios del sistema.
 - GET
 - POST


  **[Sede](./Documentacion/Sede.md)**
---

Gestiona las sedes del negocio.
 - GET
 - POST
 - PUT


  **[Bodega](./Documentacion/Bodega.md)**
---

Gestiona las bodegas del negocio.
 - GET
 - POST
 - PUT



**[Producto](./Documentacion/Producto.md)**
---

Gestiona los productos del negocio.
 - GET
 - POST
 - PUT

 **[Categoria](./Documentacion/Categoria.md)**
---

Maneja las categorias asignables a un producto.
 - GET

 **[Detalle de un producto](./Documentacion/Detalle_Producto.md)**
---

Maneja las categorias de un producto.
 - GET
 - POST

 **[Inventario](./Documentacion/Inventario.md)**
---

Administra la cantidad de cierto producto en determinada bodega.
 - GET
 - POST
 - PUT

 **[Log del inventario](./Documentacion/log_inventario.md)**
---

Almacena el historial de cambios en los inventarios. Sus registros se agregan al hacer POST /inventario.
 - GET


**[Cliente](./Documentacion/Cliente.md)**
---

Gestiona a los clientes, propios de cada sede.
 - GET
 - POST
 - PUT

**[Venta](./Documentacion/Venta.md)**
---

Gestiona las ventas que se realizan en determinadas bodegas.
 - GET
 - POST
 - PUT

**[Detalle de los productos de la venta](./Documentacion/Detalle_Venta.md)**
---

Maneja el detalle de los productos vendidos.
 - GET
 - POST

 **[Orden de transferencia](./Documentacion/Orden.md)**
---

Gestiona las ordenes de transferencias internas y externas.
 - GET
 - POST
 - PUT

**[Detalle de los productos a transferir](./Documentacion/Detalle_Orden.md)**
---

Maneja el detalle de los productos a transferir.
 - GET
 - POST