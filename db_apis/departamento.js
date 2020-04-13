const database = require('../services/database');

async function listar(context){
    let query  = "SELECT * FROM departamento ";
    const binds = [];

    if (context.id) {//verifica si context tiene el atributo id
        binds.push(context.id);
        query += " WHERE id_dep=?";
    }
    const result = await database.executeQuery(query, binds);
    return result;
}

module.exports.listar = listar;