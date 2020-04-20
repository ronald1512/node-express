const database = require('../services/database');

async function listar(context){
    let query= "SELECT * FROM orden_transferencia ";
    const binds = [];

    if(context.id_orden){
        binds.push(context.id_orden);
        query += " WHERE id_orden=?";
    }
    else if(context.sede_destino){
        binds.push(context.sede_destino);
        query += " WHERE sede_destino=?";
    }
    const result = await database.executeQuery(query, binds);
    return result;
}

module.exports.listar = listar;


async function create(context){
    let query;
    let binds = [];
    binds.push(context.id_solicitante);
    binds.push(context.contenido_descripcion);

    if(context.bodega_entrante && context.sede_destino){
      query= "call proc_crear_externa(?,?,?,?)";
      binds.push(context.bodega_entrante);
      binds.push(context.sede_destino);
    }else{
      query= "call proc_crear_interna(?,?)";
    }

    const result = await database.executeQuery(query, binds);
    return result;
}


module.exports.create = create;

async function update(context){
  let query;
  let binds = [];
  if(context.id_orden && context.entrante && context.saliente && context.individuo){ //orden de transferencia INTERNA
    binds.push(context.id_orden);
    binds.push(context.entrante); 
    binds.push(context.saliente);
    binds.push(context.individuo);
    query= "call proc_aceptar_orden_interna (?, ?, ?, ?)";
  }else if (context.id_orden && context.repartidor_id && context.saliente && context.individuo){ //parametros para orden de transferencia EXTERNA
    binds.push(context.id_orden);
    binds.push(context.saliente);
    binds.push(context.individuo);
    binds.push(context.repartidor_id);
    query= "call proc_aceptar_orden_externa (?, ?, ?, ?)";
  }else{ // se trata de una solicitud de marcar una orden EXTERNA como ENTREGADA.
    binds.push(context.id_orden);
    binds.push(context.repartidor_id);
    query= "call proc_entregar_orden_externa (?, ?)";
  }

  const result = await database.executeQuery(query, binds);
  return result;
}


module.exports.update = update;



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