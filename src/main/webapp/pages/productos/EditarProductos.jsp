<%@page import="java.text.SimpleDateFormat"%>
<%@page import="Conexion.ConectarBD"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@page import="Modelo.*"%>
<%@page import="DAO.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Actualizar Productos</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" 
          rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link href="../../resources/css/RegistroProducto/EditarProductos.css" rel="stylesheet" type="text/css"/>
    <!-- Enlace a la biblioteca de iconos de Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">
</head>
<body>
    <div class="pattern-bg">
        <div class="container mt-5">
            <div class="col-lg-8 offset-lg-2">
                <div class="card">   
                    <div class="card-header">
                        <i class="fa-solid fa-prescription-bottle-medical"></i> Editar Productos <!-- Icono de productos -->
                    </div>
                    <div class="card-body">
                        <%
                            DAOproductos dao = new DAOproductos();
                            String idParam = request.getParameter("ID");
                            if (idParam != null) {
                                int ID = Integer.parseInt(idParam);
                                Producto o = dao.obtenerProductos(ID);
                        %>
                        <form action="/Botica/EditarProductos" method="post" novalidate>
                            <div class="mb-3 form-group">
                                <label for="farm" class="form-label"><i class="fa-solid fa-arrow-up-9-1"></i>ID </label>
                                <input name="ID"  type="number" style="text-align: center"  readonly value="<%= o.getID_Prod()%>">  
                            </div>          
                            <div class="mb-3 form-group">
                                  <label for="farm" class="form-label"><i class="fa-solid fa-syringe"></i> Nombre</label>
                                <input name="nombre"  type="text" style="text-align: center"  value="<%= o.getNombre() %>" required>
                                <small name="nombre" id="nombre-help" style="display: none;">Ingresar nombre</small>   
                            </div>
                            <!--DESCRIPCIÓN-->
                            <div class="mb-3 form-group">
                                <label for="farm" class="form-label"><i class="fa-solid fa-audio-description"></i>Descripción</label>
                                <textarea name="descripcion" rows="4" cols="20" required><%= o.getDescripcion() %></textarea>
                                <small id="descripcion-help" style="display: none;"></small>
                            </div>
                            <!--FECHA DE VENCIMIENTO-->
                           <div class="mb-3 form-group">
                                <label for="farm" class="form-label"><i class="fa-solid fa-calendar-days"></i>Fecha de Vencimiento</label>
                                <input name="fechaVencimiento"  type="date" id="fecha-vencimiento" name="fecha-vencimiento" value="<%= new SimpleDateFormat("yyyy-MM-dd").format(o.getFechaVencimiento()) %>" required>
                                <small id="fecha-help" style="display: none;">Ingresar fecha de vencimiento</small>
                            </div>
                            <!--STOCK-->
                            <div class="mb-3 form-group">
                                <label for="farm" class="form-label"><i class="fa-solid fa-arrow-trend-up"></i>Stock</label>
                                <input name="stock" type="number"  value="<%= o.getStock() %>" min="0" required>
                                <small id="stock-help" style="display: none;">Ingresar stock</small>
                            </div> 
                            <!--PRECIO-->
                             <div class="mb-3 form-group">
                                  <label for="farm" class="form-label"><i class="fa-solid fa-money-bill"></i>Precio</label>
                                <input name="precio" type="number"  value="<%= o.getPrecio() %>" min="0" step="any" required> <!--any para que reciba decimales-->
                                <small id="precio-help" style="display: none;">Ingresar precio</small>
                            </div>
                            <!--PROVEEDORES-->
                            <div class="mb-3 form-group">
                                <label for="farm" class="form-label"><i class="fa-solid fa-truck-field-un"></i>Proveedor</label>
                                <select id="proveedores" name="proveedor" required>
                                    <%
                                        ConectarBD cn = new ConectarBD();

                                        try
                                        {
                                            cn.ConectarBD();
                                            String sql = "select * from proveedores; ";
                                            cn.smt = cn.con.createStatement();
                                            cn.rs = cn.smt.executeQuery(sql);
                                            while (cn.rs.next())
                                            {
                                    %>
                                    <option value="<%=cn.rs.getString(1)%>" <%= cn.rs.getString(1).equals(o.getRuc()) ? "selected" : "" %>><%=cn.rs.getString(2)%></option>
                                    <%
                                            }
                                        } catch (Exception e)
                                        {
                                            out.print(e.toString());
                                        }
                                    %>
                                </select>
                                <small id="proveedor-help" style="display: none;">Ingresar proveedor</small>
                            </div>
                            <!--CATEGORIA-->
                             <div class="mb-3 form-group">
                                <label for="farm" class="form-label"><i class="fa-solid fa-layer-group"></i>Categoria</label>
                                <select id="categoria" name="categoria" required>

                                    <%
                                        try
                                        {
                                            cn.ConectarBD();
                                            String sql = "select * from categorias; ";
                                            cn.smt = cn.con.createStatement();
                                            cn.rs = cn.smt.executeQuery(sql);
                                            while (cn.rs.next())
                                            {
                                    %>
                                    <option value="<%=cn.rs.getInt(1)%>" <%= cn.rs.getInt(1) == o.getID_categoria()? "selected" : "" %>><%=cn.rs.getString(2)%></option>
                                    <%
                                            }
                                        } catch (Exception e)
                                        {
                                            out.print(e.toString());
                                        }
                                    %>
                                </select>
                                <small id="categoria-help" style="display: none;">Ingresar categoria</small>
                            </div>
                             <!-- Botón de actualizar -->
                                <div class="d-grid gap-2">
                                    <button class="btn btn-primary" type="submit" name="accion" value="actualizar">Actualizar</button>
                                </div>
                        </form>
                        <%
                            } else {
                                out.println("ID de producto no proporcionado.");
                            }
                        %>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.7/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz4fnFO9gybBogGz5KpF1R7mx5ddOzwLPlrFltQFf36rap9Z7koG/F2El" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-p9f8q9L4NCjmprljSOdOycA+Xle13AXgZ0V1o1cTsP9sBjmc5GLIcK7uoNf6IjUM" crossorigin="anonymous"></script>
</body>
</html>
