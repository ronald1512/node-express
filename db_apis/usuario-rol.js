const database = require('../services/database');

async function listar(context) {
    let query = "SELECT * FROM usuario_rol ";
    const binds = [];

    if (context.id_rol && context.id_usuario) {//verifica si context tiene el atributo id
        binds.push(context.id_rol);
        binds.push(context.id_usuario);

        query += " WHERE id_rol=? AND id_usuario=?";
    } else if (context.id_rol) {
        binds.push(context.id_rol);

        query += " WHERE id_rol=?";
    }
    else if (context.id_usuario) {
        binds.push(context.id_usuario);
        console.log("prueba");
        query += " WHERE id_usuario=?";
    }
    const result = await database.executeQuery(query, binds);
    return result;
}



async function create(context) {
    //ese proc agrega los roles para un determinado usuario y tambien le agrega los permisos.
    let query = "call proc_add_permisos_n_rol_by_rol(?,?)";
    const binds = [];

    binds.push(context.id_usuario);
    binds.push(context.id_rol);

    const result = await database.executeQuery(query, binds);
    return result;
}



module.exports.listar = listar;
module.exports.create = create;



async function del(id) {
    const binds = {
        employee_id: id,
        rowcount: {
            dir: oracledb.BIND_OUT,
            type: oracledb.NUMBER
        }
    }
    const result = await database.simpleExecute(deleteSql, binds);

    return result.outBinds.rowcount === 1;
}

module.exports.delete = del;








async function listarRepartidores() {
    let query = "SELECT U.id_usuario, (SELECT NOMBRE FROM usuario WHERE ID_USUARIO=U.ID_USUARIO) AS nombre "
        + "FROM usuario_rol U WHERE U.id_rol=3";
    const binds = [];

    const result = await database.executeQuery(query, binds);
    return result;
}

module.exports.listarRepartidores = listarRepartidores;





async function listarVendedores() {
    let query = "SELECT U.id_usuario, (SELECT NOMBRE FROM usuario WHERE ID_USUARIO=U.ID_USUARIO) AS nombre "
        + "FROM usuario_rol U WHERE U.id_rol=1";
    const binds = [];

    const result = await database.executeQuery(query, binds);
    return result;
}

module.exports.listarVendedores = listarVendedores;