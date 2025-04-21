let svr = new XMLHttpRequest();
svr.open('GET', '/ScheduleController', true); // URL del servlet
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
        let starttime = $(this).data("starttime");
        let endtime = $(this).data("endtime");
        

        $("#editEmployeeModal input[name='id_horarioEditar']").val(id);
        $("#editEmployeeModal input[name='startTimeEdit']").val(starttime);
        $("#editEmployeeModal input[name='endTimeEdit']").val(endtime);
    });

    // Botón de eliminar usuario
    $(".deleteU").click(function () {
        let id = $(this).data("id");
        $("#deleteEmployeeModal input[name='id_horarioEliminar']").val(id);
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