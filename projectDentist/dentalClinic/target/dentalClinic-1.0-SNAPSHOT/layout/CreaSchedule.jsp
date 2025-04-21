<%-- 
    Document   : CreaSchedule
    Created on : 6/04/2025, 10:44:21?p.?m.
    Author     : juand
--%>

<div class="container-fluid">

    <div class="row justify-content-center align-items-start" style="min-height: 80vh; padding-top: 60px;">
        <div class="col-md-6 col-lg-4">

            <div class="card shadow mb-4">
                <div class="card-body">

                    <!-- Page Heading -->
                    <h1 class="h3 mb-2 text-gray-800 text-center" style="text-align: center">Crear schedule</h1>



                    <form action="../ScheduleController"  method="POST" class="createSForm">

                        <div class="mb-3">
                            <label for="exampleInputAddress" class="form-label">Start Date</label>
                            <input type="time" class="form-control" name="startTime" id="startTime" placeholder="Start Time">
                        </div>
                        <div class="mb-3">
                            <label for="exampleInputAddress" class="form-label">End Date</label>
                            <input type="time" class="form-control" name="endTime" id="endTime" placeholder="End Time">
                        </div>

                        <div class="d-flex justify-content-center">
                            <button type="submit" name="action" value="Create" class="btn btn-primary">Send</button>
                        </div>

                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
