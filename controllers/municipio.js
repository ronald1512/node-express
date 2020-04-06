const mysql = require('mysql');

const con = mysql.createConnection({
    host: "db-practicas-intermedias.cclpncoggrn9.us-west-1.rds.amazonaws.com",
    user: "admin",
    password: "Practicas_2020.",
    database: "main"
});


async function post(req, res) {
    if (req.query.nombre && req.query.id_dep) {
        console.log('Request received');
        try{
            con.connect(function(err) {
                con.query(`INSERT INTO municipio (nombre, id_dep) VALUES ('${req.query.nombre}', '${req.id_dep}')`, function(err, result, fields) {
                    if (err) res.send(err);
                    if (result) res.send({nombre: req.query.nombre});
                    if (fields) console.log(fields);
                });
            });
        }catch(err){
            console.log(err);
        }finally{
            if (conn) { // conn assignment worked, need to close
                try {
                  await conn.close();
                } catch (err) {
                  console.log(err);
                }
            }
        }
    } else {
        console.log('Missing a parameter');
    }
}
  
module.exports.post = post;




async function get(req, res) {
    con.connect(function(err) {
        con.query(`SELECT * FROM municipio`, function(err, result, fields) {
            if (err) res.send(err);
            if (result) res.send(result);
        });
    });
}
  
module.exports.get = get;