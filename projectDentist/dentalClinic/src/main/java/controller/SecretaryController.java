/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Rol;
import model.Secretary;
import model.User;
import persistence.SecretaryJpaController;
import persistence.UserJpaController;

/**
 *
 * @author juand
 */
@WebServlet(name = "SecretaryController", urlPatterns = {"/SecretaryController"})
public class SecretaryController extends HttpServlet {

    SecretaryJpaController secretaryJPA = new SecretaryJpaController();
    userController userController = new userController();
    UserJpaController userJPA = new UserJpaController();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if ("show".equals(action)) {
            List<Secretary> listSecretary = secretaryJPA.findSecretaryEntities();
            HttpSession misession = request.getSession();
            misession.setAttribute("list", listSecretary);
            response.sendRedirect("view/ShowSecretary.jsp");
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        switch (action) {
            case "create":

                String dni = request.getParameter("dni");
                String name = request.getParameter("name");
                String lastName = request.getParameter("lastName");
                String phoneNumber = request.getParameter("phoneNumber");
                String address = request.getParameter("address");
                String userName = request.getParameter("userName");
                String email = request.getParameter("email");
                String dateBirthStr = request.getParameter("dateBirth");
                String zone = request.getParameter("zoneSecretary");

                int id_user = userController.createUser(dni, name, lastName, phoneNumber, address, dateBirthStr, email, userName, lastName, 4);

                boolean iscreate = createSecretary(zone, id_user);

                if (iscreate) {
                    secretaryJPA.findSecretaryEntities();
                    List<Secretary> listSecretary = secretaryJPA.findSecretaryEntities();
                    HttpSession misession = request.getSession();
                    misession.setAttribute("list", listSecretary);
                    response.sendRedirect("view/ShowSecretary.jsp?success=Secretary successfully registered.");
                }

                break;

            case "edit":
                try {
                    int idUser = Integer.parseInt(request.getParameter("id_secretaryEditar"));

                    String dniEdit = request.getParameter("dniEdit");
                    String nameEdit = request.getParameter("nameEdit");
                    String lastNameEdit = request.getParameter("lastNameEdit");
                    String phoneNumberEdit = request.getParameter("phoneNumberEdit");
                    String addressEdit = request.getParameter("addressEdit");
                    String userNameEdit = request.getParameter("userNameEdit");
                    String emailEdit = request.getParameter("emailEdit");
                    String dateBirthEdit = request.getParameter("dateBirthEdit");
                    String passwordEdit = dniEdit;

                    int id_secretaryEdit = Integer.parseInt(request.getParameter("id_secretaryEditM"));
                    String zoneEdit = request.getParameter("zoneSecretaryEdit");

                    boolean isEdit = editSecretary(idUser, dniEdit, nameEdit, lastNameEdit, phoneNumberEdit, addressEdit, dateBirthEdit, emailEdit, userNameEdit, passwordEdit, 4, zoneEdit, id_secretaryEdit);

                    if (isEdit) {
                        secretaryJPA.findSecretaryEntities();
                        List<Secretary> listResponsible = secretaryJPA.findSecretaryEntities();
                        HttpSession misession = request.getSession();
                        misession.setAttribute("list", listResponsible);
                        response.sendRedirect("view/ShowSecretary.jsp?success=Secretary Editado exitosamente.");
                    }
                } catch (Exception ex) {
                    System.out.println(ex);
                    response.sendRedirect("view/ShowSecretary.jsp?error=No se pudo editar el Secretary.");
                }

                break;

            case "delete":

                int idUserD = Integer.parseInt(request.getParameter("id_usuarioEliminar"));
                int idSecretaryD = Integer.parseInt(request.getParameter("id_secretaryEliminar"));

                boolean isDelete = deleteCascading(idUserD, idSecretaryD);

                if (isDelete) {
                    secretaryJPA.findSecretaryEntities();
                    List<Secretary> listResponsible = secretaryJPA.findSecretaryEntities();
                    HttpSession misession = request.getSession();
                    misession.setAttribute("list", listResponsible);
                    response.sendRedirect("view/ShowSecretary.jsp?success=Secretary eliminado exitosamente.");
                }
                break;
            default:
                throw new AssertionError();
        }

    }

    protected boolean createSecretary(String zoneSecretary, int id_user) {

        Secretary secretary = new Secretary();
        User user = new User();

        try {

            user.setId(id_user);
            secretary.setZone(zoneSecretary);
            secretary.setUser(user);
            secretaryJPA.create(secretary);

            return true;
        } catch (Error err) {
            System.out.println(err);
            return false;
        }
    }

    protected boolean editSecretary(int id, String dni, String name, String lastName, String phoneNumber, String address, String dateBirth, String email, String userName, String password, int Rol, String zone, int id_secretary) throws Exception {

        String passwordHash = userController.hashPassword(password);
        Date birthDate = userController.convertDate(dateBirth);

        Rol rol = new Rol();
        rol.setId(Rol);

        try {

            User user = new User();
            user.setId(id);
            user.setDni(dni);
            user.setName(name);
            user.setLastName(lastName);
            user.setPhoneNumber(phoneNumber);
            user.setAddress(address);
            user.setUserName(userName);
            user.setDateBirth(birthDate);
            user.setEmail(email);
            user.setPassword(passwordHash);
            user.setRol(rol);
            userJPA.edit(user);

            try {

                Secretary secretary = new Secretary();

                secretary.setId(id_secretary);
                secretary.setZone(zone);
                secretary.setUser(user);

                secretaryJPA.edit(secretary);

            } catch (Error err) {
                System.out.println(err);
                return false;
            }

            return true;

        } catch (Error err) {
            System.out.println("err");
            return false;
        }

    }
    
    protected boolean deleteCascading(int idUser, int idSecretary) {

        try {
            secretaryJPA.destroy(idSecretary);
            userJPA.destroy(idUser);
            return true;
        } catch (Exception err) {
            System.out.println(err);
            return false;
        }

    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
