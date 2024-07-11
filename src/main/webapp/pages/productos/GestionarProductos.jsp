<%@page import="Conexion.ConectarBD"%>
<%@page import="java.text.ParseException"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.*"%>
<%@page import="com.mysql.jdbc.Driver"%>
<%@page import="java.util.*" %>
<%@page import="DAO.*" %>
<%@page import="Modelo.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Gestionar Productos </title>
        <script src="node_modules/bootstrap/dist/ js/bootstrap.min.js"></script>
        <script src="../../resources/js/BuscadorTabla.js" type="text/javascript"></script> <!-- Script para buscar -->
        <link href="../../resources/css/RegistroProducto/GestionarProductos.css" rel="stylesheet" type="text/css"/>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet"> <!-- Font Awesome -->
   
        <title>Gestionar Productos</title>

        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    </head>

    <body class="parent-container">      
        <div class="box-Content">
            <div class="Frm-Header">
                <span class="Frm-Title">Gestionar Productos</span>
                <div class="search-box">
                    <input id="searchTerm" type="text" class="search-bar" onkeyup="doSearch()" />
                    <button type="submit" class="search-btn">
                        <img class="search-icon" src="resources/img/icons/search-symbol.png" alt=""/>
                    </button> 
                </div>
            </div>

            <div class="Frm-Table">
                <table id="Table-Productos" class="table">
                    <thead class="table-header">
                        <tr>
                            
                            <th>Nombre</th>
                            <th>Descripcion</th>
                            <th>Vencimiento</th>
                            <th>Precio</th>
                            <th>Stock</th>
                            <th>Categoria</th>
                            <th>Proveedor</th>
                            <th class="text-center">Botones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            ConectarBD cn = new ConectarBD();
                            String sql = "SELECT prod.ID_Prod AS ID, prod.Nombre AS producto, prod.descripcion, "
                                    + "prod.FechaVencimiento, prod.Precio, prod.Stock, "
                                    + "cat.Nombre AS categoria, "
                                    + "prov.RUC AS RUC_Prov, prov.nombre AS proveedor "
                                    + "FROM Productos prod "
                                    + "JOIN Proveedores prov ON prod.RUC_Prov = prov.RUC "
                                    + "JOIN Categorias cat ON prod.ID_categoria = cat.ID_categoria where Stock >= 0";
                            cn.smt = cn.con.createStatement();
                            cn.rs = cn.smt.executeQuery(sql);

                            while (cn.rs.next())
                            {
                        %>
                        <tr>
                            
                            <td><%= cn.rs.getString("producto")%></td>
                            <td><%= cn.rs.getString("descripcion")%></td>
                            <td><%= cn.rs.getDate("FechaVencimiento")%></td>
                            <td><%= cn.rs.getDouble("Precio")%></td>
                            <td><%= cn.rs.getInt("Stock")%></td>
                            <td><%= cn.rs.getString("categoria")%></td>
                            <td><%= cn.rs.getString("proveedor")%></td>
                            <td>
                                <div class="Frm-Btns"> 
                                <a href="/Botica/pages/productos/EditarProductos.jsp?accion=editar&ID=<%= cn.rs.getInt("ID")%>" class="btn btn-success"> <i class="fas fa-edit"></i> </a>
                                <form action="/Botica/SvEliminarProductos" method="post" novalidate>
                                    <input type="hidden" name="eliminar" value="true">
                                    <input type="hidden" name="ID" value="<%= cn.rs.getInt("ID") %>">
                                    <button type="submit" class="btn btn-danger">
                                        <i class="fas fa-trash-alt"></i>
                                    </button>
                                </form>
                            </div>
                            </td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </div>

         


    </body>
    <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js"></script>
</html>