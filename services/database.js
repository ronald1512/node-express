const mysql = require('mysql');
const dbconfig = require('../config/database');

const connection = mysql.createConnection(dbconfig.pi_connection);

async function initialize(){
    await connection.connect( err => {
        if(err){
            console.log('Error on Connecting to DB');
            return false;
        }
        console.log('Connected to DB');
        return true;
    });
}

async function close(){
    await connection.end();
}

function executeQuery(query, binds=[]){
    return new Promise(async (resolve, reject) => {
        try{
            await connection.query(query, binds, (err, result, fields) => {
                resolve(result);
            });
            connection.commit(function(err) {
                if (err) { 
                  connection.rollback(function() {
                    throw err;
                  });
                }
            });
        }catch(err){
            //si algo falla le hacemos roll back
            connection.rollback(function() {
                reject(err);
            });
        }
    });
}

module.exports.initialize = initialize;
module.exports.close = close;
module.exports.executeQuery = executeQuery;
