/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.time.LocalDate;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Schedule;
import persistence.ScheduleJpaController;
import persistence.exceptions.NonexistentEntityException;

/**
 *
 * @author juand
 */
@WebServlet(name = "ScheduleController", urlPatterns = {"/ScheduleController"})
public class ScheduleController extends HttpServlet {

    ScheduleJpaController scheduleJPA = new ScheduleJpaController();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Schedule> listSchedule = listSchedule();
        HttpSession misession = request.getSession();
        misession.setAttribute("listSchedule", listSchedule);

        response.sendRedirect("view/ShowSchedule.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        List<Schedule> listSchedule = scheduleJPA.findScheduleEntities();

        switch (action) {
            case "Create":

                try {
                    String startDateStr = request.getParameter("startTime");
                    String endDateStr = request.getParameter("endTime");

                    Schedule schedule = new Schedule();
                    schedule.setStartTime(startDateStr);
                    schedule.setEndTime(endDateStr);

                    createSchedule(schedule);

                    listSchedule = scheduleJPA.findScheduleEntities();
                    HttpSession session = request.getSession();
                    session.setAttribute("listSchedule", listSchedule);

                    response.sendRedirect("view/ShowSchedule.jsp?success=Usuario registrado exitosamente.");

                } catch (Exception ex) {
                    response.sendRedirect("view/CreateSchedule.jsp?error=Error interno del servidor.");
                }
                break;

            case "Edit":

                try {

                    int id = Integer.parseInt(request.getParameter("id_horarioEditar"));
                    Schedule schedule = getSchedule(id);

                    if (schedule == null) {
                        response.sendRedirect("view/index.jsp?error=Horario no encontrado.");
                        return;
                    }

                    String startDateStr = request.getParameter("startTimeEdit");
                    String endDateStr = request.getParameter("endTimeEdit");

                    schedule.setId(id);
                    schedule.setStartTime(startDateStr);
                    schedule.setEndTime(endDateStr);

                    editSchedule(schedule);

                    listSchedule = scheduleJPA.findScheduleEntities();
                    HttpSession session = request.getSession();
                    session.setAttribute("listSchedule", listSchedule);

                    response.sendRedirect("view/ShowSchedule.jsp?success=Horario Editado exitosamente.");

                } catch (NumberFormatException e) {
                    System.out.println(e);
                    response.sendRedirect("view/ShowSchedule.jsp?error=Error en los datos del Horario.");
                } catch (Exception ex) {
                    System.out.println(ex);
                    response.sendRedirect("view/ShowSchedule.jsp?error=No se pudo editar el Horario.");
                }

                break;

            case "Delete":

                int id = Integer.parseInt(request.getParameter("id_horarioEliminar"));

                deleteSchedule(id);

                listSchedule = scheduleJPA.findScheduleEntities();
                HttpSession session = request.getSession();
                session.setAttribute("listSchedule", listSchedule);
                response.sendRedirect("view/ShowSchedule.jsp?success=Horario Eliminado exitosamente.");

                break;

            default:
                throw new AssertionError();
        }

    }

    public List<Schedule> listSchedule() {
        return scheduleJPA.findScheduleEntities();
    }

    protected void createSchedule(Schedule schedule) {
        scheduleJPA.create(schedule);
    }

    public Schedule getSchedule(int id_editar) {
        return scheduleJPA.findSchedule(id_editar);
    }

    public void editSchedule(Schedule schedule) {
        try {
            scheduleJPA.edit(schedule);
        } catch (Exception ex) {
            Logger.getLogger(ScheduleController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void deleteSchedule(int id_eliminar) {
        try {
            scheduleJPA.destroy(id_eliminar);
        } catch (NonexistentEntityException ex) {
            
            Logger.getLogger(ScheduleController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
