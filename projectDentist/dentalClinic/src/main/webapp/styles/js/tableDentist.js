$(document).ready(function () {
    // Activar tooltip
    $('[data-toggle="tooltip"]').tooltip();

    // Seleccionar/deseleccionar checkboxes
    var checkbox = $('table tbody input[type="checkbox"]');
    $("#selectAll").click(function () {
        checkbox.prop("checked", this.checked);
    });
    checkbox.click(function () {
        if (!this.checked) {
            $("#selectAll").prop("checked", false);
        }
    });

    // Botón de editar dentist
    $(".editD").click(function () {
        let id = $(this).data("id");
        let idD = $(this).data("iddentist");
        let dni = $(this).data("dni");
        let name = $(this).data("name");
        let lastname = $(this).data("lastname");
         let username = $(this).data("username");
        let phonenumber = $(this).data("phonenumber");
        let address = $(this).data("address");
        let email = $(this).data("email");
        let datebirth = $(this).data("datebirth");
        let specialty = $(this).data("specialty"); 
        let schedule = $(this).data("schedule"); 
        
        $("#editDentistModal input[name='id_dentistEditar']").val(id);
        $("#editDentistModal input[name='dniEdit']").val(dni);
        $("#editDentistModal input[name='nameEdit']").val(name);
        $("#editDentistModal input[name='lastNameEdit']").val(lastname);
        $("#editDentistModal input[name='userNameEdit']").val(username);
        $("#editDentistModal input[name='phoneNumberEdit']").val(phonenumber);
        $("#editDentistModal input[name='addressEdit']").val(address);
        $("#editDentistModal input[name='emailEdit']").val(email);
        $("#editDentistModal input[name='dateBirthEdit']").val(datebirth);
        $("#editDentistModal select[name='specialtyEdit']").val(specialty);
        $("#editDentistModal select[name='scheduleEdit']").val(schedule);
        $("#editDentistModal input[name='id_dentistEditarM']").val(idD);
    });

    // Botón de eliminar dentist
    $(".deleteD").click(function () {
        let idu = $(this).data("idu");
        let idd = $(this).data("idd");
        
        $("#deleteDentistModal input[name='id_usuarioEliminar']").val(idu);
        $("#deleteDentistModal input[name='id_dentistEliminar']").val(idd);
    });

    // Envío de formulario de edición
    $("#editDentistForm").submit(function (event) {
        event.preventDefault();
        let data = $(this).serialize();
        sendRequest("edit", data);
    });

    // Envío de formulario de eliminación
    $("#deleteDentistForm").submit(function (event) {
        event.preventDefault();
        let data = $(this).serialize();
        sendRequest("delete", data);
    });

    function sendRequest(action, data) {
        $.ajax({
            url: '../DentistController',
            method: 'POST',
            data: data + "&action=" + action.charAt(0).toUpperCase() + action.slice(1),
            success: function (response) {
                console.log("Success:", response);
                location.reload(); // Recargar página después de acción
            },
            error: function (xhr, status, error) {
                console.error("Error:", status, error);
            }
        });
    }
});
