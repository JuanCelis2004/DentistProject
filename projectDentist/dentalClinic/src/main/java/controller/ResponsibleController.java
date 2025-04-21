/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Responsible;
import model.Rol;
import model.User;
import persistence.ResponsibleJpaController;
import persistence.UserJpaController;
import persistence.exceptions.NonexistentEntityException;

/**
 *
 * @author juand
 */
@WebServlet(name = "ResponsibleController", urlPatterns = {"/ResponsibleController"})
public class ResponsibleController extends HttpServlet {

    ResponsibleJpaController responsibleJPA = new ResponsibleJpaController();
    UserJpaController userJPA = new UserJpaController();
    userController userController = new userController();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if ("show".equals(action)) {
            List<Responsible> listResponsible = responsibleJPA.findResponsibleEntities();
            HttpSession misession = request.getSession();
            misession.setAttribute("list", listResponsible);
            response.sendRedirect("view/ShowResponsible.jsp");
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
                String typeResponsible = request.getParameter("typeResponsible");

                int id_user = userController.createUser(dni, name, lastName, phoneNumber, address, dateBirthStr, email, userName, dni, 2);

                boolean iscorrect = createResponsible(typeResponsible, id_user);

                if (iscorrect) {
                    responsibleJPA.findResponsibleEntities();
                    List<Responsible> listResponsible = responsibleJPA.findResponsibleEntities();
                    HttpSession misession = request.getSession();
                    misession.setAttribute("list", listResponsible);
                    response.sendRedirect("view/ShowResponsible.jsp?success=Responsable registrado exitosamente.");
                }

                break;

            case "edit":
                try {
                    int idUser = Integer.parseInt(request.getParameter("id_responsibleEditar"));

                    String dniEdit = request.getParameter("dniEdit");
                    String nameEdit = request.getParameter("nameEdit");
                    String lastNameEdit = request.getParameter("lastNameEdit");
                    String phoneNumberEdit = request.getParameter("phoneNumberEdit");
                    String addressEdit = request.getParameter("addressEdit");
                    String userNameEdit = request.getParameter("userNameEdit");
                    String emailEdit = request.getParameter("emailEdit");
                    String dateBirthEdit = request.getParameter("dateBirthEdit");
                    String passwordEdit = dniEdit;

                    int id_responsibleEdit = Integer.parseInt(request.getParameter("id_responsibleEditM"));
                    String typeResponsibleEdit = request.getParameter("typeResponsibleEdit");

                    boolean isEdit = editResponsible(idUser, dniEdit, nameEdit, lastNameEdit, phoneNumberEdit, addressEdit, dateBirthEdit, emailEdit, userNameEdit, passwordEdit, 2, typeResponsibleEdit, id_responsibleEdit);

                    if (isEdit) {
                        responsibleJPA.findResponsibleEntities();
                        List<Responsible> listResponsible = responsibleJPA.findResponsibleEntities();
                        HttpSession misession = request.getSession();
                        misession.setAttribute("list", listResponsible);
                        response.sendRedirect("view/ShowResponsible.jsp?success=Responsable Editado exitosamente.");
                    }
                }  catch (Exception ex) {
                    System.out.println(ex);
                    response.sendRedirect("view/ShowResponsible.jsp?error=No se pudo editar el responsable.");
                }

                break;

            case "delete":

                int idUserD = Integer.parseInt(request.getParameter("id_usuarioEliminar"));
                int idResponsibleD = Integer.parseInt(request.getParameter("id_ResponsibleEliminar"));

                boolean isDelete = deleteCascading(idUserD, idResponsibleD);

                if (isDelete) {
                    responsibleJPA.findResponsibleEntities();
                    List<Responsible> listResponsible = responsibleJPA.findResponsibleEntities();
                    HttpSession misession = request.getSession();
                    misession.setAttribute("list", listResponsible);
                    response.sendRedirect("view/ShowResponsible.jsp?success=Responsable eliminado exitosamente.");
                }
                break;
            default:
                throw new AssertionError();
        }

    }

    protected boolean createResponsible(String typeResponsible, int id_user) {

        Responsible responsible = new Responsible();
        User user = new User();

        try {

            user.setId(id_user);
            responsible.setType(typeResponsible);
            responsible.setUser(user);
            responsibleJPA.create(responsible);
            return true;

        } catch (Error err) {
            System.out.println(err);
            return false;
        }

    }

    protected boolean editResponsible(int id, String dni, String name, String lastName, String phoneNumber, String address, String dateBirth, String email, String userName, String password, int Rol, String typeResponsible, int id_responsible) throws Exception {

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
                
                Responsible responsible = new Responsible();

                responsible.setId(id_responsible);
                responsible.setType(typeResponsible);
                responsible.setUser(user);

                responsibleJPA.edit(responsible);

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

    protected boolean deleteCascading(int idUser, int idDentist) {

        try {
            responsibleJPA.destroy(idDentist);
            userJPA.destroy(idUser);
            return true;
        } catch (Exception err) {
            System.out.println(err);
            return false;
        }

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
