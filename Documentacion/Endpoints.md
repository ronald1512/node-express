**[Departamento](./Departamento.md)**
---

Entrega información sobre los departamentos de Guatemala.
 - GET


**[Municipio](./Municipio.md)**
---

Entrega información sobre los municipios de Guatemala.
 - GET

**[Rol](./Rol.md)**
---

Entrega información sobre los roles dentro del sistema.
 - GET


**[Permiso](./Permiso.md)**
---

Entrega información sobre los permisos dentro del sistema.
 - GET

 **[Autorización](./Autorizacion.md)**
---

Relaciona usuarios con permisos dentro del sistema.
 - GET
 - POST
 - DELETE


  **[Usuario](./Usuario.md)**
---

Gestiona a los usuarios del sistema.
 - GET
 - POST
 - PUT


 **[Usuario_Rol](./Usuario_Rol.md)**
---

Gestiona los roles de los usuarios del sistema.
 - GET
 - POST


  **[Sede](./Sede.md)**
---

Gestiona las sedes del negocio.
 - GET
 - POST
 - PUT


  **[Bodega](./Bodega.md)**
---

Gestiona las bodegas del negocio.
 - GET
 - POST
 - PUT



**[Producto](./Producto.md)**
---

Gestiona los productos del negocio.
 - GET
 - POST
 - PUT

 **[Categoria](./Categoria.md)**
---

Maneja las categorias asignables a un producto.
 - GET

 **[Detalle de un producto](./Detalle_Producto.md)**
---

Maneja las categorias de un producto.
 - GET
 - POST

 **[Inventario](./Inventario.md)**
---

Administra la cantidad de cierto producto en determinada bodega.
 - GET
 - POST
 - PUT

 **[Log del inventario](./log_inventario.md)**
---

Almacena el historial de cambios en los inventarios. Sus registros se agregan al hacer POST /inventario.
 - GET


**[Cliente](./Cliente.md)**
---

Gestiona a los clientes, propios de cada sede.
 - GET
 - POST
 - PUT

**[Venta](./Venta.md)**
---

Gestiona las ventas que se realizan en determinadas bodegas.
 - GET
 - POST
 - PUT

**[Detalle de los productos de la venta](./Detalle_Venta.md)**
---

Maneja el detalle de los productos vendidos.
 - GET
 - POST

 **[Orden de transferencia](./Orden.md)**
---

Gestiona las ordenes de transferencias internas y externas.
 - GET
 - POST
 - PUT

**[Detalle de los productos a transferir](./Detalle_Orden.md)**
---

Maneja el detalle de los productos a transferir.
 - GET
 - POST