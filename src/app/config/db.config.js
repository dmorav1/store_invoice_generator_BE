const dbParameters ={
    connectionLimit:process.env.DB_CONN_LIMIT || 10,
    host: process.env.DB_HOST || 'localhost',
    port: process.env.DB_PORT || '3306',
    user: process.env.DB_USER || 'root',
    password: process.env.DB_PASSWORD || '',
    database: process.env.DB_DATABASE ||'default'

}


module.exports = dbParameters

