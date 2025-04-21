<div class="container-fluid">

    <!-- Page Heading -->
    <h1 class="h3 mb-2 text-gray-800 text-center" style="text-align: center">Create a secretary</h1>
    <form action="../SecretaryController"  method="POST" class="createSForm">
        <div class="row">
            <div class="col-md-6 mb-3">
                <label for="int" class="form-label">Dni</label>
                <input type="number" class="form-control" name="dni" id="int" placeholder="Dni">
            </div>
            <div class="col-md-6 mb-3">
                <label for="name" class="form-label">First name</label>
                <input type="text" class="form-control" name="name" id="name" placeholder="Name">
            </div>

            <div class="col-md-6 mb-3">
                <label for="lastName" class="form-label">Last name</label>
                <input type="text" class="form-control" name="lastName" id="lastName" placeholder="Last Name">
            </div>
            <div class="col-md-6 mb-3">
                <label for="userName" class="form-label">User name</label>
                <input type="text" class="form-control" name="userName" id="userName" placeholder="User name">
            </div>

            <div class="col-md-6 mb-3">
                <label for="number" class="form-label">Phone number</label>
                <input type="number" class="form-control" name="phoneNumber" id="number" placeholder="Phone number">
            </div>
            <div class="col-md-6 mb-3">
                <label for="address" class="form-label">Address</label>
                <input type="text" class="form-control" name="address" id="address" placeholder="Address">
            </div>

            <div class="col-md-6 mb-3">
                <label for="dateBirth" class="form-label">Date Birth</label>
                <input type="date" class="form-control" name="dateBirth" id="dateBirth">
            </div>
            <div class="col-md-6 mb-3">
                <label for="email" class="form-label">Email address</label>
                <input type="email" class="form-control" name="email" id="email" placeholder="Email">
            </div>
        </div>
        <div class="row">
            <div class="col-md-6 mb-3">
                <label for="exampleInput" class="form-label">Zone</label>
                <select class="form-control" id="id" name="zoneSecretary">
                    <option value="Administrative">Administrative</option>
                    <option value="Sanitary">Sanitary</option>
                </select>
            </div>
        </div>
        <div class="d-flex justify-content-center">
            <button type="submit" name="action" value="create" class="btn btn-primary">Send</button>
        </div>

    </form>

</div>
