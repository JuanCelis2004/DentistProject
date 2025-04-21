/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Dentist;
import model.Rol;
import model.Schedule;
import model.User;
import org.mindrot.jbcrypt.BCrypt;
import persistence.DentistJpaController;
import persistence.UserJpaController;

/**
 *
 * @author david
 */
@WebServlet(name = "DentistController", urlPatterns = {"/DentistController"})
public class DentistController extends HttpServlet {

    UserJpaController userJPA = new UserJpaController();
    DentistJpaController dentistJPA = new DentistJpaController();
    userController userController = new userController();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("show".equals(action)) {
            List<Dentist> listDentist = dentistJPA.findDentistEntities();
            HttpSession misession = request.getSession();
            misession.setAttribute("list", listDentist);

            response.sendRedirect("view/ShowDentist.jsp");
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
                String dateBirthStr = request.getParameter("dateBirth");
                String email = request.getParameter("email");
                String specialty = request.getParameter("specialty");
                int id_schedule = Integer.parseInt(request.getParameter("Schedule"));
                //validar que el id no sea == 0    
                int id_user = userController.createUser(dni, name, lastName, phoneNumber, address, dateBirthStr, email, userName, dni, 3);

                System.out.println(id_user);

                boolean isCorrect = createDentist(specialty, id_schedule, id_user);

                if (isCorrect) {
                    dentistJPA.findDentistEntities();
                    List<Dentist> listDentist = dentistJPA.findDentistEntities();
                    HttpSession misession = request.getSession();
                    misession.setAttribute("list", listDentist);
                    response.sendRedirect("view/ShowDentist.jsp");
                }
                break;
            case "edit":
                try {
                    /*Data model user*/
                    int idUser = Integer.parseInt(request.getParameter("id_dentistEditar"));
                    String dniEdit = request.getParameter("dniEdit");
                    String nameEdit = request.getParameter("nameEdit");
                    String lastNameEdit = request.getParameter("lastNameEdit");
                    String phoneNumberEdit = request.getParameter("phoneNumberEdit");
                    String addressEdit = request.getParameter("addressEdit");
                    String userNameEdit = request.getParameter("userNameEdit");
                    String dateBirthStrEdit = request.getParameter("dateBirthEdit");
                    String emailEdit = request.getParameter("emailEdit");
                    String passwordEdit = dniEdit;

                    /*Data model dentist*/
                    int id_dentistEdit = Integer.parseInt(request.getParameter("id_dentistEditarM"));
                    int id_scheduleEdit = Integer.parseInt(request.getParameter("scheduleEdit"));

                    String specialtyEdit = request.getParameter("specialtyEdit");

                    /*id, dni, name, lastname, phonenumber,address, datebirth, email, username, password, rol*/
                    boolean isEdit = editUser(idUser, dniEdit, nameEdit, lastNameEdit, phoneNumberEdit, addressEdit, dateBirthStrEdit, emailEdit, userNameEdit, passwordEdit, 3, id_dentistEdit, id_scheduleEdit, specialtyEdit);
                    if (isEdit) {
                        List<Dentist> listDentist = dentistJPA.findDentistEntities();
                        HttpSession misession = request.getSession();
                        misession.setAttribute("list", listDentist);
                        response.sendRedirect("view/ShowDentist.jsp");
                    }
                } catch (Exception ex) {

                }
                break;
            case "delete":

                int idUsuarioD = Integer.parseInt(request.getParameter("id_usuarioEliminar"));
                int idDentistD = Integer.parseInt(request.getParameter("id_dentistEliminar"));

                boolean isDelete = deleteCascading(idUsuarioD, idDentistD);
                if (isDelete) {
                    List<Dentist> listDentist = dentistJPA.findDentistEntities();
                    HttpSession misession = request.getSession();
                    misession.setAttribute("list", listDentist);
                    response.sendRedirect("view/ShowDentist.jsp");
                }
                break;
            default:
                throw new AssertionError();
        }

    }

    protected boolean createDentist(String specialty, int id_schedule, int id_user) {

        Dentist dentist = new Dentist();

        Schedule schedule = new Schedule();
        User user = new User();

        try {
            schedule.setId(id_schedule);
            user.setId(id_user);

            dentist.setSpecialty(specialty);
            dentist.setSchedule(schedule);
            dentist.setUser(user);

            dentistJPA.create(dentist);
            return true;

        } catch (Exception ex) {
            System.out.println(ex);
            return false;
        }

    }

    protected boolean editUser(int id, String dni, String name, String lastName, String phoneNumber, String address, String dateBirth, String email, String userName, String password, int Rol, int id_dentist, int Schedule_id, String specialtyEdit) throws Exception {
        //validar que no devuelva Invalid (Falta)
        String passwordHash = userController.hashPassword(password);
        //validar que no devuelva null (Falta)
        Date birthDate = userController.convertDate(dateBirth);

        Rol rol = new Rol();
        rol.setId(Rol);

        try {
            /*11 datos para editar un usuario*/
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
                /*3 datos para editar un dentista*/
                Schedule schedule = new Schedule();
                schedule.setId(Schedule_id);

                Dentist dentist = new Dentist();

                dentist.setId(id_dentist);
                dentist.setSchedule(schedule);
                dentist.setSpecialty(specialtyEdit);
                dentist.setUser(user);
                dentistJPA.edit(dentist);

            } catch (Error err) {
                System.out.println(err);
                return false;
            }

            return true;
        } catch (Error err) {
            System.out.println(err);
            return false;
        }

    }

    protected boolean deleteCascading(int idUsuario, int idDentist) {
        try {         
            dentistJPA.destroy(idDentist);
            userJPA.destroy(idUsuario);
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
