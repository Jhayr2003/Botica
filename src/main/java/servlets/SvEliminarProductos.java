
package servlets;

import DAO.DAOproductos;
import Modelo.Producto;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class SvEliminarProductos extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
         //CODIGO PARA QUE TE DEJE INSERTAR (Ñ) EN MYSQL
       response.setContentType("text/html;charset=UTF-8");
       request.setCharacterEncoding("UTF-8");

        //ID POR DEFECTO CON EL NÚMERO 0
        int id= Integer.parseInt(request.getParameter("ID"));  //ID 
       Producto prod = new Producto(id, null, null, null, 0.0, 0, 0, null); // Crear un objeto Producto con solo el ID
       DAOproductos prodao= new DAOproductos();
       
       String resultado = prodao.eliminar(prod);
       
        if ("Producto eliminado con éxito".equals(resultado)) {
          response.sendRedirect("/Botica/pages/productos/GestionarProductos.jsp");
        } else {
          // Manejar el error de inserción
            request.setAttribute("mensajeError", resultado);
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
        //response.getWriter().print(result);
        
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
