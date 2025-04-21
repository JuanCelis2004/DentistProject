let svr = new XMLHttpRequest();
svr.open('GET', '/ediUser', true); // URL del servlet
svr.onload = function () {
    if (svr.status === 200) {
        console.log(svr.responseText); // Mostrar la respuesta en la consola
    } else {
        console.error('Error:', svr.statusText);
    }
};
svr.onerror = function () {
    console.error('Error en la solicitud');
};
svr.send();

$(document).ready(function () {
    // Activate tooltip
    $('[data-toggle="tooltip"]').tooltip();

    // Select/Deselect checkboxes
    var checkbox = $('table tbody input[type="checkbox"]');
    $("#selectAll").click(function () {
        if (this.checked) {
            checkbox.each(function () {
                this.checked = true;
            });
        } else {
            checkbox.each(function () {
                this.checked = false;
            });
        }
    });
    checkbox.click(function () {
        if (!this.checked) {
            $("#selectAll").prop("checked", false);
        }
    });
});

$(document).ready(function () {
    // Botón de editar usuario
    $(".editU").click(function () {
        let id = $(this).data("id");
        let dni = $(this).data("dni");
        let username = $(this).data("username");
        let name = $(this).data("name");
        let lastname = $(this).data("lastname");
        let phonenumber = $(this).data("phonenumber");
        let address = $(this).data("address");
        let email = $(this).data("email");
        let datebirth = $(this).data("datebirth");
        let rol = $(this).data("rol");

        $("#editEmployeeModal input[name='id_usuarioEditar']").val(id);
        $("#editEmployeeModal input[name='dniEdit']").val(dni);
        $("#editEmployeeModal input[name='usernameedit']").val(username);
        $("#editEmployeeModal input[name='nameEdit']").val(name);
        $("#editEmployeeModal input[name='lastNameEdit']").val(lastname);
        $("#editEmployeeModal input[name='phoneNumberEdit']").val(phonenumber);
        $("#editEmployeeModal input[name='addressEdit']").val(address);
        $("#editEmployeeModal input[name='emailEdit']").val(email);
        $("#editEmployeeModal input[name='dateBirthEdit']").val(datebirth);
        $("#editEmployeeModal select[name='idrol']").val(rol);
    });

    // Botón de eliminar usuario
    $(".deleteU").click(function () {
        let id = $(this).data("id");
        $("#deleteEmployeeModal input[name='id_usuarioEliminar']").val(id);
    });

    // Envío de formulario de edición
    $("#editEmployeeForm").submit(function (event) {
        event.preventDefault(); // Evita el envío normal del formulario

        let data = $(this).serialize(); // Serializa los datos del formulario
        sendRequest("edit", data);
    });

    // Envío de formulario de eliminación
    $("#deleteEmployeeForm").submit(function (event) {
        event.preventDefault();

        let data = $(this).serialize();
        sendRequest("delete", data);
    });
});