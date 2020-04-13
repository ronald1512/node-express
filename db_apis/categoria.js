const database = require('../services/database');

async function listar(context){
    let query  = "SELECT * FROM categoria ";
    const binds = [];

    if (context.id_categoria) {//verifica si context tiene el atributo id
        binds.push(context.id_categoria);

        query += " WHERE id_categoria=?";
    }
    const result = await database.executeQuery(query, binds);
    return result;
}



module.exports.listar = listar;