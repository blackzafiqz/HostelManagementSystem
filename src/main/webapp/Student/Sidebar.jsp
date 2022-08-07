<aside class="">
    <div class="flex-shrink-0 p-3 bg-grey" style="width: 280px;">
        <a href="/" class="d-flex align-items-center pb-3 mb-3 link-dark text-decoration-none border-bottom">
            <svg class="bi pe-none me-2" width="30" height="24"><use xlink:href="#bootstrap"/></svg>
            <span class="fs-5 fw-semibold">
                <img src="/images/LogoUiTM.png" class="img-fluid">
            </span>
        </a>
        <ul class="list-unstyled ps-0">
            <li class="mb-1">
                <button id="btnRoom" class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed" data-bs-toggle="collapse" data-bs-target="#room-collapse" aria-expanded="false">
                    Room
                </button>
                <div class="collapse" id="room-collapse">
                    <ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
                        <li><a href="<% out.print(request.getContextPath());%>/Student/ListRoom.jsp" class="link-dark d-inline-flex text-decoration-none rounded">List</a></li>
                        <li><a href="<% out.print(request.getContextPath());%>/Student/RegisterRoom.jsp" class="link-dark d-inline-flex text-decoration-none rounded">Register</a></li>
                        <li><a href="<% out.print(request.getContextPath());%>/Student/HistoryRoom.jsp" class="link-dark d-inline-flex text-decoration-none rounded">History</a></li>
                    </ul>
                </div>
            </li>
            <li class="mb-1">
                <button id="btnLeave" class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed" data-bs-toggle="collapse" data-bs-target="#leave-collapse" aria-expanded="false">
                    Leave
                </button>
                <div class="collapse" id="leave-collapse">
                    <ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
                        <li><a href="<% out.print(request.getContextPath());%>/Student/ApplyLeave.jsp" class="link-dark d-inline-flex text-decoration-none rounded">Apply</a></li>
                        <li><a href="<% out.print(request.getContextPath());%>/Student/HistoryLeave.jsp" class="link-dark d-inline-flex text-decoration-none rounded">History</a></li>
                    </ul>
                </div>
            </li>
            
            <li class="border-top my-3"></li>
            <li class="mb-1">
                <button class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed" data-bs-toggle="collapse" data-bs-target="#account-collapse" aria-expanded="false">
                    Account
                </button>
                <div class="collapse" id="account-collapse">
                    <ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
                        <li><a href="<% out.print(request.getContextPath());%>/Student/Settings.jsp" class="link-dark d-inline-flex text-decoration-none rounded">Settings</a></li>
                        <li><a href="/LoginServlet" class="link-dark d-inline-flex text-decoration-none rounded">Sign out</a></li>
                    </ul>
                </div>
            </li>
        </ul>
    </div>
</aside>