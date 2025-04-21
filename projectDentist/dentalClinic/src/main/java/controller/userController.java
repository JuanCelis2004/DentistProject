/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
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
import model.Rol;
import model.User;
import org.mindrot.jbcrypt.BCrypt;
import persistence.UserJpaController;
import persistence.exceptions.NonexistentEntityException;

@WebServlet(name = "userController", urlPatterns = {"/userController"})
public class userController extends HttpServlet {

    String Message = "";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    UserJpaController userJPA = new UserJpaController();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<User> listUser = listUser();
        HttpSession misession = request.getSession();
        misession.setAttribute("listUser", listUser);

        response.sendRedirect("view/showUser.jsp");

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String passwordRpd = request.getParameter("repwd");

        switch (action) {
            case "signup":
                try {

                    String dni = request.getParameter("dni");
                    String name = request.getParameter("name");
                    String lastName = request.getParameter("lastName");
                    String phoneNumber = request.getParameter("phoneNumber");
                    String address = request.getParameter("address");
                    String userName = request.getParameter("userName");
                    String dateBirthStr = request.getParameter("dateBirth");

                    // Validar que ningún campo esté vacío
                    if (dni == null || name == null || lastName == null || phoneNumber == null
                            || address == null || userName == null || dateBirthStr == null
                            || email == null || password == null || passwordRpd == null
                            || dni.isEmpty() || name.isEmpty() || lastName.isEmpty() || phoneNumber.isEmpty()
                            || address.isEmpty() || userName.isEmpty() || dateBirthStr.isEmpty()
                            || email.isEmpty() || password.isEmpty() || passwordRpd.isEmpty()) {

                        response.sendRedirect("login.jsp?error=Todos los campos son obligatorios.");
                        return;
                    }

                    // Validar que las contraseñas coincidan
                    if (!password.equals(passwordRpd)) {
                        response.sendRedirect("login.jsp?error=Las contraseñas no coinciden.");
                        return;
                    }

                    // Validar que la fecha de nacimiento sea anterior a hoy
                    Date dateBirth = convertDate(dateBirthStr);
                    Date today = new Date();
                    if (dateBirth.after(today)) {
                        response.sendRedirect("login.jsp?error=La fecha de nacimiento debe ser anterior a hoy.");
                        return;
                    }

                 
                    createUser(dni, name, lastName, phoneNumber, address, dateBirthStr, email, userName, password, 1);
                    response.sendRedirect("login.jsp?success=Usuario registrado exitosamente.");

                } catch (IOException ex) {
                    System.out.println(ex);
                    response.sendRedirect("login.jsp?error=Error interno del servidor.");
                }
                break;

            case "login":
                boolean validacion = false;
                List<User> listUser = userJPA.findUserEntities();
                User loggedInUser = null;

                for (User usu : listUser) {
                    if (usu.getEmail().equals(email) && BCrypt.checkpw(password, usu.getPassword())) {
                        loggedInUser = usu;
                        validacion = true;
                        break;
                    }
                }

                if (validacion && loggedInUser != null) {
                    HttpSession misession = request.getSession(true);
                    misession.setAttribute("userSession", loggedInUser); // Guardar el usuario completo
                    response.sendRedirect("view/index.jsp");
                    System.out.println("Si entraste");
                } else {
                    response.sendRedirect("login.jsp?error=true");
                }
                break;

            case "edit":

                try {
                    int id = Integer.parseInt(request.getParameter("id_usuarioEditar"));
                    User user = userJPA.findUser(id);
                    if (user == null) {
                        response.sendRedirect("view/index.jsp?error=Usuario no encontrado.");
                        return;
                    }
                    String dni = request.getParameter("dniEdit");
                    String name = request.getParameter("nameEdit");
                    String lastName = request.getParameter("lastNameEdit");
                    String phoneNumber = request.getParameter("phoneNumberEdit");
                    String address = request.getParameter("addressEdit");
                    String userName = request.getParameter("usernameedit");
                    String dateBirthStr = request.getParameter("dateBirthEdit");
                    String emailEdit = request.getParameter("emailEdit");
                    int rolId = Integer.parseInt(request.getParameter("idrol"));
                    Date dateBirth = convertDate(dateBirthStr);
                    password = hashPassword(password);
                    editUser(id, dni, name, lastName, phoneNumber, address, dateBirth, emailEdit, userName, password, rolId);

                    /*volver a recargar los usuarios*/
                    listUser = userJPA.findUserEntities();

                    HttpSession session = request.getSession();
                    session.setAttribute("listUser", listUser);

                    response.sendRedirect("view/showUser.jsp?success=Usuario editado correctamente.");

                } catch (NumberFormatException | ParseException e) {
                    System.out.println(e);
                    response.sendRedirect("view/index.jsp?error=Error en los datos del usuario.");
                } catch (Exception ex) {
                    System.out.println(ex);
                    response.sendRedirect("view/index.jsp?error=No se pudo editar el usuario.");
                }
                break;
            case "Delete":
                int idDelete = Integer.parseInt(request.getParameter("id_usuarioEliminar"));
                 {
                    try {
                        userJPA.destroy(idDelete);
                        listUser = userJPA.findUserEntities();

                        HttpSession session = request.getSession();
                        session.setAttribute("listUser", listUser);

                        response.sendRedirect("view/showUser.jsp?success=Usuario eliminado correctamente.");
                    } catch (NonexistentEntityException ex) {
                        response.sendRedirect("view/index.jsp?error=No se pudo eliminar el usuario.");
                        Logger.getLogger(userController.class.getName()).log(Level.SEVERE, null, ex);
                    }
                }
                break;

            case "Create":

                try {
                    String dni = request.getParameter("dni");
                    String name = request.getParameter("name");
                    String lastName = request.getParameter("lastName");
                    String phoneNumber = request.getParameter("phoneNumber");
                    String address = request.getParameter("address");
                    String userName = request.getParameter("userName");
                    int rolId = Integer.parseInt(request.getParameter("idrol"));
                    String dateBirthStr = request.getParameter("dateBirth");

                    if (dni == null || name == null || lastName == null || phoneNumber == null
                            || address == null || userName == null || dateBirthStr == null
                            || email == null || password == null
                            || dni.isEmpty() || name.isEmpty() || lastName.isEmpty() || phoneNumber.isEmpty()
                            || address.isEmpty() || userName.isEmpty() || dateBirthStr.isEmpty()
                            || email.isEmpty() || password.isEmpty()) {

                        response.sendRedirect("view/CreateUser.jsp?error=Todos los campos son obligatorios.");
                        return;
                    }

                    // Validar que la fecha de nacimiento sea anterior a hoy
                    SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
                    Date dateBirth = formatter.parse(dateBirthStr);
                    Date today = new Date();

                    if (dateBirth.after(today)) {
                        response.sendRedirect("view/CreateUser.jsp?error=La fecha de nacimiento debe ser anterior a hoy.");
                        return;
                    }
                 
                    createUser(dni, name, lastName, phoneNumber, address, dateBirthStr, email, userName, password, rolId);
                    listUser = userJPA.findUserEntities();
                    HttpSession session = request.getSession();
                    session.setAttribute("listUser", listUser);
                    response.sendRedirect("view/showUser.jsp?success=Usuario registrado exitosamente.");

                } catch (ParseException e) {
                    response.sendRedirect("view/CreateUser.jsp?error=Formato de fecha incorrecto.");
                } catch (IOException | NumberFormatException ex) {
                    response.sendRedirect("view/CreateUser.jsp?error=Error interno del servidor.");
                }
                break;

            default:
                throw new AssertionError();
        }
    }

    public boolean comprobarAcceso(String email, String password) {
        List<User> listUser = new ArrayList<User>();
        listUser = userJPA.findUserEntities();

        for (User usu : listUser) {

            // Compara la contraseña ingresada con el hash almacenado
            boolean isPasswordValid = BCrypt.checkpw(password, usu.getPassword());
            System.out.println(isPasswordValid);

            if (usu.getEmail().equals(email)) {
                if (isPasswordValid) {
                    return true;
                } else {
                    Message = "User or Password Incorrect";
                }
            } else {
                Message = "User or Password Incorrect";
            }
        }
        return false;
    }

    protected void createUser(User user) {
        userJPA.create(user);
    }

    public void logout(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        response.sendRedirect("login.jsp");
    }

    public List<User> listUser() {
        return userJPA.findUserEntities();
    }

  
    public int createUser(String dni, String name, String lastName, String phoneNumber, String address, String dateBirth, String email, String userName, String password, int Rol) {

        /*
            1: Paciente, 
            2: Responsable, 
            3: Dentista, 
            4: secretaria, 
            5: Admin
         */
        //validar que no devuelva Invalid (Falta)
        String passwordHash = hashPassword(password);
        //validar que no devuelva null (Falta)
        Date birthDate = convertDate(dateBirth);

        Rol rol = new Rol();
        rol.setId(Rol);

        try {
            /*10 datos para crear un usuario*/
            User user = new User();
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

            return userJPA.createAndReturnId(user);
        } catch (Error err) {
            System.out.println(err);
            return 0;
        }
    }

    public String hashPassword(String password) {
        try {
            //Encrypt
            String passwordHash = BCrypt.hashpw(password, BCrypt.gensalt());
            return passwordHash;
        } catch (Error err) {
            System.out.println(err);
            return "Invalid";
        }
    }

    public Date convertDate(String date) {
        try {
            // Validar que la fecha de nacimiento sea anterior a hoy
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
            Date dateBirth = formatter.parse(date);
            return dateBirth;
        } catch (ParseException ex) {
            System.out.println(ex);
            return null;
        }
    }

    public boolean editUser(int id, String dni, String name, String lastName, String phoneNumber, String address, Date dateBirth, String email, String userName, String password, int rol) throws Exception {
        try {
            User user = new User();
            Rol rolId = new Rol();
            rolId.setId(rol);

            user.setId(id);
            user.setDni(dni);
            user.setName(name);
            user.setLastName(lastName);
            user.setPhoneNumber(phoneNumber);
            user.setAddress(address);
            user.setUserName(userName);
            user.setDateBirth(dateBirth);
            user.setEmail(email);
            user.setRol(rolId);

            userJPA.edit(user);
            return true;
        } catch (IOException ex) {
            System.out.println("1" + ex);
            return false;
        }

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
