const database = require('../services/database');

async function listar(context){
    let query  = "SELECT * FROM autorizacion ";
    let binds = [];

    if (context.id_usuario && context.id_permiso) {//verifica si context tiene el atributo id
        binds.push(context.id_usuario);
        binds.push(context.id_permiso);

        query += " WHERE id_usuario=? AND id_permiso=?";
    }else if(context.id_usuario){
        binds.push(context.id_usuario);

        query += " WHERE id_usuario=?";
    }
    else if(context.id_permiso){
        binds.push(context.id_permiso);

        query += " WHERE id_permiso=?";
    }
    const result = await database.executeQuery(query, binds);
    return result;
}



async function create(context){
    let query= "INSERT INTO autorizacion (id_usuario, id_permiso) VALUES (?,?)";
    let binds = [];

    binds.push(context.id_usuario);
    binds.push(context.id_permiso);

    const result = await database.executeQuery(query, binds);
    return result;
}



module.exports.listar = listar;
module.exports.create = create;



async function del(context) {
    let query  = "DELETE from autorizacion ";
    let binds = [];

    if (context.id_usuario && context.id_permiso) {//verifica si context tiene el atributo id
        binds.push(context.id_usuario);
        binds.push(context.id_permiso);

        query += " WHERE id_usuario=? AND id_permiso=?";
    }
    const result = await database.executeQuery(query, binds);
    //console.log(result);
    return result.affectedRows===1;
  }
  
  module.exports.delete = del;