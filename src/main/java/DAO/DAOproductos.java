package DAO;

import Conexion.ConectarBD;
import Modelo.Producto;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.swing.JOptionPane;

public class DAOproductos {
    private ConectarBD conectar;

    public DAOproductos() {
        conectar = new ConectarBD();
    }
    
    
    public ArrayList<Producto> ListarProductos() {
    ArrayList<Producto> lista = new ArrayList<>();
    String SQL = "SELECT * FROM productos";

    // Obtener la conexión a la base de datos
    ConectarBD conectarBD = new ConectarBD();
    Connection con = conectarBD.getConnection();
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        // Preparar la consulta SQL
        ps = con.prepareStatement(SQL);
        
        // Ejecutar la consulta y obtener el resultado
        rs = ps.executeQuery();
        
        // Procesar el resultado
        while (rs.next()) {
            Producto producto = new Producto();
            producto.setID_Prod(rs.getInt("ID_Prod"));
            producto.setNombre(rs.getString("Nombre"));
            producto.setDescripcion(rs.getString("descripcion"));
            producto.setFechaVencimiento(rs.getDate("FechaVencimiento"));
            producto.setStock(rs.getInt("Stock"));
            producto.setPrecio(rs.getDouble("Precio"));
            producto.setRuc(rs.getString("RUC_Prov"));
            producto.setID_categoria(rs.getInt("ID_categoria"));
            
            // Agregar el producto a la lista
            lista.add(producto);
        }
    } catch (SQLException ex) {
        JOptionPane.showMessageDialog(null, "ERROR no se puede recuperar los productos: " + ex.getMessage());
    } finally {
        // Cerrar ResultSet, PreparedStatement y Connection en bloques finally
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    return lista;
}
    public String insertarProducto(Producto producto) {
        String sql = "INSERT INTO Productos (Nombre, Descripcion, FechaVencimiento, precio, Stock, ID_categoria, RUC_Prov) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection con = conectar.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, producto.getNombre());
            ps.setString(2, producto.getDescripcion());
            ps.setDate(3, new java.sql.Date(producto.getFechaVencimiento().getTime()));
            ps.setDouble(4, producto.getPrecio());
            ps.setInt(5, producto.getStock());
            ps.setInt(6, producto.getID_categoria());
            ps.setString(7, producto.getRuc());
            
            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                return "Producto insertado con éxito";
            } else {
                return "Error al insertar el producto";
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return "Error al insertar el producto: " + e.getMessage();
        }   
    }  
    //AUN NO FUNCIONA ESTO
     public Producto obtenerProductos(int ID) {
    Producto producto = null;
    ConectarBD conectarBD = new ConectarBD();
    Connection con = conectarBD.getConnection();
    
    try {
        String query = "SELECT * FROM productos WHERE ID_Prod = ?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setInt(1, ID); //DEFAULT PARA QUE FUNCIONE TODO 
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            producto = new Producto();
            producto.setID_Prod(rs.getInt("ID_Prod")); // Asegúrate que el nombre de la columna sea correcto
            producto.setNombre(rs.getString("Nombre")); // Asegúrate que el nombre de la columna sea correcto
            producto.setDescripcion(rs.getString("descripcion")); // Asegúrate que el nombre de la columna sea correcto
            producto.setFechaVencimiento(rs.getDate("FechaVencimiento")); // Asegúrate que el nombre de la columna sea correcto
            producto.setStock(rs.getInt("Stock")); // Asegúrate que el nombre de la columna sea correcto
            producto.setPrecio(rs.getDouble("Precio")); // Asegúrate que el nombre de la columna sea correcto
            producto.setRuc(rs.getString("RUC_Prov")); // Asegúrate que el nombre de la columna sea correcto
            producto.setID_categoria(rs.getInt("ID_categoria")); // Asegúrate que el nombre de la columna sea correcto
        }
        rs.close();
        ps.close();
    } catch (SQLException e) {
        e.printStackTrace(); // Aquí podrías manejar la excepción de otra manera, dependiendo de tu aplicación
    } 
    
    return producto;
} 
    
      //FUNCIONA CON EL TESTEO
    
public String ActualizarProductos(Producto producto) {
    String sql = "UPDATE productos SET Nombre=?, Descripcion=?, FechaVencimiento=?, Precio=?, Stock=?, ID_categoria=?, RUC_Prov=? WHERE ID_Prod=?";
    
    try (Connection con = conectar.getConnection();
          PreparedStatement ps = con.prepareStatement(sql))  {
           ps.setString(1, producto.getNombre());        // Nombre
           ps.setString(2, producto.getDescripcion());   // Descripcion
           ps.setDate(3, new java.sql.Date(producto.getFechaVencimiento().getTime())); // FechaVencimiento
           ps.setDouble(4, producto.getPrecio());        // Precio
           ps.setInt(5, producto.getStock());            // Stock
           ps.setInt(6, producto.getID_categoria());     // ID_categoria
           ps.setString(7, producto.getRuc());           // RUC_Prov
           ps.setInt(8, producto.getID_Prod());          // ID_Prod
            
           int rowsAffected = ps.executeUpdate();
           if (rowsAffected > 0) {
               return "Producto actualizado con éxito";
           } else {
               return "Error al actualizar el producto";
           }
       } catch (SQLException ex) {
           ex.printStackTrace(); // Imprimir la traza del error en la consola
           return "Error al actualizar el producto: " + ex.getMessage();
       }
}
public String eliminar(Producto producto) {
    String sql = "UPDATE Productos SET Stock = -1 WHERE ID_Prod = ?";
    try (Connection con = conectar.getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {
        ps.setInt(1, producto.getID_Prod()); // Configurar el ID del producto

        int rowsAffected = ps.executeUpdate();
        if (rowsAffected > 0) {
            return "Producto eliminado con éxito";
        } else {
            return "No se encontró el producto o error al eliminar";
        }
    } catch (SQLException ex) {
        ex.printStackTrace();
        return "Error al eliminar el producto: " + ex.getMessage();
    }
}

    
    
    
    
    
    
    
}
    

