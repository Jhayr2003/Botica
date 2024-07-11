
package Conexion;

public interface Parametros {
    String DRIVER="com.mysql.cj.jdbc.Driver";
    String PORT = "3306";
    String DATABASE = "boticaweb";
    String RUTA="jdbc:mysql://localhost:"+PORT+"/"+DATABASE ;
    String USUARIO="root";
    String CLAVE="";
 
    
    /*
    *********************************
    Para setear el nuevo usuario ejecuta estas 3 lineas en mysql,
    deberia funcinar tmb si usas MyphpAdmin
    ******************************
    
    CREATE USER 'userbdbotica'@'localhost' IDENTIFIED BY 'TodoPor1Sol';
    GRANT ALTER, CREATE, DELETE, DROP, INDEX, INSERT, REFERENCES, SELECT, UPDATE ON bdbotica.* TO 'userbdbotica'@'localhost';
    FLUSH PRIVILEGES;
    
    */
}
