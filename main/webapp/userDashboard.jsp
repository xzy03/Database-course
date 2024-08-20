<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    boolean loggedIn = false;
    String loginName = null;
    database.User user = (database.User) session.getAttribute("user");
    dao.UserDAO userDAO = new dao.UserDAO();
    if (user != null) {
        loggedIn = true;
    } else {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("userLogin".equals(cookie.getName())) {
                    loginName = cookie.getValue();
                    break;
                }
            }
        }

        if (loginName != null) {
            user = userDAO.getUserByLoginName(loginName);
            if (user != null) {
                session.setAttribute("user", user);
                loggedIn = true;
            }
        }
    }

    if (!loggedIn) {
        response.sendRedirect("userlogin.jsp");
        return;
    }
//    Boolean dept_flag=false;
//    else{
//        Connection conn =null;
//        PreparedStatement stmt = null;
//        ResultSet rs = null;
//        conn = userDAO.getConnection();
//        String sql = "SELECT * FROM dept WHERE dept_name = ?";
//        stmt = conn.prepareStatement(sql);
//        stmt.setString(1, user.getDepartmentName());
//        rs=stmt.executeQuery();
//        if(rs.next()){
//            dept_flag=rs.getBoolean("appointment_permission");
//        }
//    }
//    System.out.println(dept_flag);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>用户操作界面</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            display: flex;
            height: 100vh;
        }
        .sidebar {
            width: 250px;
            background-color: lightgrey;
            color: white;
            padding: 20px;
            box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
        }
        .sidebar h2 {
            text-align: center;
            font-size: 45px;
        }
        .sidebar ul {
            list-style-type: none;
            padding: 0;
        }
        .sidebar li {
            padding: 10px;
            text-align: center;
            font-weight: bold;
        }
        .sidebar a {
            color: white;
            text-decoration: none;
            display: block;
            font-size: 24px;
        }
        .sidebar a:hover {
            background-color: darkgrey;
        }
        .sidebar a.small-text{
            font-size: 18px;
        }
        .logout-btn {
            margin-top: 20px;
            text-align: center;
        }
        .logout-btn button {
            padding: 10px 20px;
            font-size: 16px;
            background-color: #d9534f;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .logout-btn button.password {
            background-color: blue;
        }
        .content {
            flex: 1;
            padding: 20px;
            background-color: #f4f4f4;
            background-image: url('background2.jpeg'); /* 替换为你的图片路径 */
            background-size: cover; /* 使图片覆盖整个背景 */
            background-position: center; /* 居中显示图片 */
            background-repeat: no-repeat; /* 防止图片重复 */
        }
        .button-group button {
            padding: 10px 20px;
            font-size: 16px;
            margin: 5px;
            cursor: pointer;
        }

        h1 {
            color: #2c3e50;
            font-size: 28px;
            margin-bottom: 10px;
        }

        .simple-form{
            background-color: #ffffff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            max-width: 500px;
            margin: 20px auto;
            text-align: left;
        }

        .user-info {
            background-color: #ffffff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            max-width: 500px;
            margin: 20px auto;
            text-align: center;
        }

        .user-info p {
            font-size: 18px;
            color: #333;
            margin: 10px 0;
        }

        .user-info p span {
            font-weight: bold;
        }

        main.table {
            width: 82vw;
            height: 60vh;
            background-color: #fff5;
            box-shadow: 0 8px 16px #0005;
            border-radius: 16px;
            overflow: hidden;
        }
        .header {
            width: 100%;
            height: 10%;
            background-color: #fff4;
            padding: 0 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .header .input-group {
            width: 35%;
            height: 50%;
            background-color: #fff5;
            padding: 0 20px;
            border-radius: 10px;
            display: flex;
            justify-content: center;
            align-items: center;
            transition: .2s;
            margin-right: 100px;
        }
        .header .input-group:hover {
            width: 45%;
            background-color:#fff8;
            box-shadow:0 5px 40px #0002;
        }
        .header .input-group img {
            width: 20px;
            height: 20px;
        }
        .header .input-group input {
            width: 100%;
            background-color:transparent;
        }
        .header .input-group button {
            width: 120%;
        }
        .shell {
            width: 95%;
            max-height: calc(90% - 25px);
            background-color: #fffb;
            margin: 8px auto;
            border-radius: 10px;
            overflow: auto;
        }
        .shell::-webkit-scrollbar {
            width: 10px;
            height: 10px;
        }
        table {
            width: 100%;
        }

        td img {
            width: 36px;
            height: 36px;
            margin-right: 10px;
            border-radius: 50%;
            vertical-align: middle;
        }

        table,
        th,
        td {
            border-collapse: collapse;
            padding: 20px;
            text-align: left;
        }

        thead th {
            position: sticky;
            top: 0;
            left: 0;
            background-color: #d5d1defe;
            cursor: pointer;
        }

        /*偶数行背景色 */
        tbody tr:nth-child(even){
            background-color:#0000000b;
        }

        tbody tr:hover {
            background-color: #add8e6 !important;
        }

        .button {
            padding: 5px 5px;
            border-radius: 40px;
            text-align: left;
        }
        tr:nth-child(4n) .button {
            background-color:#86e49d;
            color:#006b21;
        }
        tr:nth-child(4n-1) .button {
            background-color:#ebc474;
        }
        tr:nth-child(4n+1) .button {
            background-color:#d893a3;
            color:#b30021;
        }
        tr:nth-child(4n+2) .button {
            background-color:#6fcaea;
        }

        /* 样式表单 */
        form {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
        }

        form input {
            flex: 0 1 calc(25% - 10px);  /*每行四列，间距为10px */
            box-sizing: border-box;
            padding: 10px;
            margin: 0;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        form input.three{
            flex: 0 1 calc(33% - 10px);  /*每行三列，间距为10px */
        }

        form input.two{
            flex: 0 1 calc(50% - 10px);  /*每行两列，间距为10px */
        }

        form input.five{
            flex: 0 1 calc(20% - 10px);  /*每行五列，间距为10px */
        }

        form select {
            flex: 0 1 calc(25% - 10px);  /*每行四列，间距为10px */
            box-sizing: border-box;
            padding: 10px;
            margin: 0;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        form select.three{
            flex: 0 1 calc(33% - 10px);  /*每行三列，间距为10px */
        }

        form select.two{
            flex: 0 1 calc(50% - 10px);  /*每行两列，间距为10px */
        }

        form select.five{
            flex: 0 1 calc(20% - 10px);  /*每行五列，间距为10px */
        }

        form option{
            flex: 0 1 calc(25% - 10px);  /*每行四列，间距为10px */
            box-sizing: border-box;
            padding: 10px;
            margin: 0;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        form option.three{
            flex: 0 1 calc(33% - 10px);  /*每行三列，间距为10px */
        }

        form option.two{
            flex: 0 1 calc(50% - 10px);  /*每行两列，间距为10px */
        }

        form option.five{
            flex: 0 1 calc(20% - 10px);  /*每行五列，间距为10px */
        }

        form button {
            flex: 0 1 100%; /* 按钮占据一整行 */
            padding: 10px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-top: 10px;
        }

        form button.four {
            flex: 0 1 calc(25% - 10px);  /*每行四列，间距为10px */
        }

        button {
            background-color: #4CAF50; /* 绿色背景 */
            border: none;
            color: white;
            padding: 10px 20px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            margin: 4px 2px;
            cursor: pointer;
            border-radius: 4px;
            transition: background-color 0.3s ease;
        }

        button:hover {
            background-color: #45a049; /* 鼠标悬停时的颜色 */
        }
    </style>
</head>
<body>
<div class="sidebar">
    <h2>操作列表</h2>
    <ul>
        <li><a href="#information" onclick="showUserInfo()">用户信息</a></li>
        <c:choose>
            <c:when test="${user.identify == '管理员'}">
                <li><a href="#studentManagement" onclick="showStudentManagement()">学生信息管理</a></li>
                <div id="studentManagement"></div>
                <li><a href="#teacherManagement" onclick="showTeacherManagement()">教师信息管理</a></li>
                <div id="teacherManagement"></div>
                <li><a href="#deptManagement" onclick="showDeptManagement()">专业信息管理</a></li>
                <div id="deptManagement"></div>
                <li><a href="#classManagement" onclick="showClassManagement()">班级信息管理</a></li>
                <div id="classManagement"></div>
                <li><a href="#courseManagement" onclick="showCourseManagement()">课程信息管理</a></li>
                <div id="courseManagement"></div>
                <li><a href="#teachManagement" onclick="showTeachManagement()">授课信息管理</a></li>
                <div id="teachManagement"></div>
                <li><a href="#scoreManagement" onclick="showScoreManagement()">选课信息管理</a></li>
                <div id="scoreManagement"></div>
            </c:when>
            <c:when test="${user.identify == '学生'}">
                <li><a href="#studentInfo" onclick="showStudentInfo()">学生个人信息</a></li>
                <li><a href="#searchCourse" onclick="showSearchCourse()"> 课程信息查询</a></li>
                <li><a href="#searchTeach" onclick="showSearchTeach()"> 授课信息查询</a></li>
                <li><a href="#showStudentScore" onclick="showStudentScoreInfo()"> 个人成绩总览</a></li>
            </c:when>
            <c:when test="${user.identify == '教师'}">
                <li><a href="#teacherInfo" onclick="showTeacherInfo()">教师个人信息</a></li>
                <li><a href="#searchCourse" onclick="showSearchCourse()"> 课程信息查询</a></li>
                <li><a href="#searchTeachAtTeacher" onclick="showSearchTeachAtTeacher()"> 个人授课查询</a></li>
                <li><a href="#showTeacherStudentScore" onclick="showTeacherStudentScoreInfo()"> 学生成绩总览</a></li>
            </c:when>
            <c:otherwise>

            </c:otherwise>
        </c:choose>

    </ul>
    <div class="logout-btn">
        <button type="button" class="password" onclick="changePassword()">修改密码</button>
    </div>
    <div class="logout-btn">
        <form action="userLogout" method="post">
            <button type="submit">退出登录</button>
        </form>
    </div>
</div>
<div class="content" id="content" >
    <div class="user-info">
        <h1>欢迎，<%= user.getAccount() %></h1>
    </div>
</div>
<script>

    function handleSuccess(redirectFunctionName) {
        // 禁用按钮
        const buttons = document.querySelectorAll('button');
        buttons.forEach(button => button.disabled = true);

        // 显示成功提示
        const successMessage = document.createElement('div');
        successMessage.textContent = '操作成功';
        successMessage.style.position = 'fixed';
        successMessage.style.top = '50%';
        successMessage.style.left = '50%';
        successMessage.style.transform = 'translate(-50%, -50%)';
        successMessage.style.backgroundColor = 'rgba(0, 128, 0, 0.8)';
        successMessage.style.color = 'white';
        successMessage.style.padding = '10px';
        successMessage.style.borderRadius = '5px';
        document.body.appendChild(successMessage);

        // 显示2秒后移除提示，并刷新页面或更新页面上的显示
        setTimeout(() => {
            document.body.removeChild(successMessage);

            // 重新启用按钮
            buttons.forEach(button => button.disabled = false);

            // 调用传入的跳转函数
            window[redirectFunctionName]();
        }, 2000);
    }

    function handleFail(redirectFunctionName){
        // 禁用按钮
        const buttons = document.querySelectorAll('button');
        buttons.forEach(button => button.disabled = true);

        // 显示成功提示
        const successMessage = document.createElement('div');
        successMessage.textContent = '操作失败';
        successMessage.style.position = 'fixed';
        successMessage.style.top = '50%';
        successMessage.style.left = '50%';
        successMessage.style.transform = 'translate(-50%, -50%)';
        successMessage.style.backgroundColor = 'rgba(128, 0, 0, 0.8)';
        successMessage.style.color = 'white';
        successMessage.style.padding = '10px';
        successMessage.style.borderRadius = '5px';
        document.body.appendChild(successMessage);

        // 显示2秒后移除提示，并刷新页面或更新页面上的显示
        setTimeout(() => {
            document.body.removeChild(successMessage);

            // 重新启用按钮
            buttons.forEach(button => button.disabled = false);

            // 调用传入的跳转函数
            window[redirectFunctionName]();
        }, 2000);
    }

    function adminClean(){
        let content = document.getElementById('studentManagement');
        content.innerHTML='';
        content = document.getElementById('teacherManagement');
        content.innerHTML='';
        content = document.getElementById('deptManagement');
        content.innerHTML='';
        content = document.getElementById('classManagement');
        content.innerHTML='';
        content = document.getElementById('courseManagement');
        content.innerHTML='';
        content = document.getElementById('teachManagement');
        content.innerHTML='';
        content = document.getElementById('scoreManagement');
        content.innerHTML='';
    }

    function showUserInfo() {
        const content = document.getElementById('content');
        content.innerHTML = `
        <div class="user-info">
            <h1>用户信息</h1>
            <p>账号：<span><%= user.getAccount() %></span></p>
            <p>身份：<span><%= user.getIdentify() %></span></p>
        </div>
    `;
    }

    function showStudentManagement(){
        adminClean();
        let content = document.getElementById('studentManagement');
        content.innerHTML='<li><a onclick="showSearchStudent()" class="small-text">学生信息查询</a></li>'+
            '<li><a onclick="showAddStudent()" class="small-text">添加学生</a></li>'+
            '<li><a onclick="showUpdateStudent()" class="small-text">修改学生信息</a></li>'+
            '<li><a onclick="showDeleteStudent()" class="small-text">删除学生</a></li>'+
            '<li><a onclick="showStatisticStudent()" class="small-text">学生信息统计</a></li>';
    }

    function showTeacherManagement(){
        adminClean();
        let content = document.getElementById('teacherManagement');
        content.innerHTML='<li><a onclick="showSearchTeacher()" class="small-text">教师信息查询</a></li>'+
            '<li><a onclick="showAddTeacher()" class="small-text">添加教师</a></li>'+
            '<li><a onclick="showUpdateTeacher()" class="small-text">修改教师信息</a></li>'+
            '<li><a onclick="showDeleteTeacher()" class="small-text">删除教师</a></li>';
    }

    function showDeptManagement(){
        adminClean();
        let content = document.getElementById('deptManagement');
        content.innerHTML='<li><a onclick="showSearchDept()" class="small-text">专业信息查询</a></li>'+
            '<li><a onclick="showAddDept()" class="small-text">添加专业</a></li>'+
            '<li><a onclick="showUpdateDept()" class="small-text">修改专业信息</a></li>'+
            '<li><a onclick="showDeleteDept()" class="small-text">删除专业</a></li>';
    }

    function showClassManagement(){
        adminClean();
        let content = document.getElementById('classManagement');
        content.innerHTML='<li><a onclick="showSearchClass()" class="small-text">班级信息查询</a></li>'+
            '<li><a onclick="showAddClass()" class="small-text">添加班级</a></li>'+
            '<li><a onclick="showUpdateClass()" class="small-text">修改班级信息</a></li>'+
            '<li><a onclick="showDeleteClass()" class="small-text">删除班级</a></li>';
    }

    function showCourseManagement(){
        adminClean();
        let content = document.getElementById('courseManagement');
        content.innerHTML='<li><a onclick="showSearchCourse()" class="small-text">课程信息查询</a></li>'+
            '<li><a onclick="showAddCourse()" class="small-text">添加课程</a></li>'+
            '<li><a onclick="showUpdateCourse()" class="small-text">修改课程信息</a></li>'+
            '<li><a onclick="showDeleteCourse()" class="small-text">删除课程</a></li>'+
            '<li><a onclick="showStatisticCourse()" class="small-text">课程信息统计</a></li>';
    }

    function showTeachManagement(){
        adminClean();
        let content = document.getElementById('teachManagement');
        content.innerHTML='<li><a onclick="showSearchTeach()" class="small-text">授课信息查询</a></li>'+
            '<li><a onclick="showAddTeach()" class="small-text">添加授课</a></li>'+
            '<li><a onclick="showUpdateTeach()" class="small-text">修改授课信息</a></li>'+
            '<li><a onclick="showDeleteTeach()" class="small-text">删除授课</a></li>';
    }

    function showScoreManagement(){
        adminClean();
        let content = document.getElementById('scoreManagement');
        content.innerHTML='<li><a onclick="showSearchScore()" class="small-text">选课信息查询</a></li>';
    }


    function showSearchStudent(){
        const content = document.getElementById('content');
        content.innerHTML = '<h2>学生信息查询</h2>' +
            '<form id="searchStudentForm">' +
            '<input type="text" name="Sno" placeholder="学生学号">' +
            '<input type="text" name="Clno" placeholder="班级号">' +
            '<input type="text" name="Dno" placeholder="专业号">' +
            '<input type="text" name="Sname" placeholder="学生姓名">' +
            '<select name="Ssex">'+
            '<option value="">性别</option>'+
            '<option value="男">男</option>'+
            '<option value="女">女</option>'+
            '</select>'+
            '<input type="number" name="Sbirth" placeholder="学生出生日期">' +
            '<input type="text" name="Sprovince" placeholder="所属省份">' +
            '<input type="text" name="Scity" placeholder="所属市区">' +
            '<input type="number" name="MinScredit" placeholder="最小已修学分" step="0.01">' +
            '<input type="number" name="MaxScredit" placeholder="最大已修学分" step="0.01">' +
            '<input type="number" name="MinSGPA" placeholder="最小学生绩点" step="0.01">' +
            '<input type="number" name="MaxSGPA" placeholder="最大学生绩点" step="0.01">' +
            '<button type="submit">查询</button>' +
            '</form>' +
            '<div id="searchStudentResult"></div>';


        const searchStudentForm = document.getElementById('searchStudentForm');
        searchStudentForm.addEventListener('submit', function(event) {
            event.preventDefault();
            const formData = new FormData(this);
            const searchParams = new URLSearchParams(formData);
            fetch('searchStudent', {
                method: 'POST',
                body: searchParams
            })
                .then(response => response.json())
                .then(data => {
                    console.log(data);
                    const resultDiv = document.getElementById('searchStudentResult');
                    resultDiv.innerHTML = '';
                    const mainTable = document.createElement('main');
                    mainTable.setAttribute('class', 'table');
                    const headerSection = document.createElement('section');
                    headerSection.setAttribute('class','header');
                    const headTitle =document.createElement('h1');
                    headTitle.textContent='查询结果';
                    headerSection.appendChild(headTitle);
                    const workDiv = document.createElement('div');
                    workDiv.setAttribute('class', 'input-group');


                    const creditInput = document.createElement('input');
                    creditInput.setAttribute('type', 'number');
                    creditInput.setAttribute('name', 'credit');
                    creditInput.setAttribute('step', '0.01');
                    creditInput.setAttribute('required', 'required');
                    creditInput.setAttribute('placeholder', '输入毕业学分');

                    const creditButton = document.createElement('button');
                    creditButton.textContent = '批量处理毕业';
                    creditButton.addEventListener('click', (event) => {
                        event.preventDefault(); // 阻止表单提交
                        // 检查输入框是否为空
                        if (!creditInput.value) {
                            alert('请输入毕业学分');
                            return;
                        }
                        const credit = creditInput.value;
                        // 调用另一个函数并传递参数
                        submitGraduation(credit);
                    });

                    const dropInput = document.createElement('input');
                    dropInput.setAttribute('type', 'number');
                    dropInput.setAttribute('name', 'drop');
                    dropInput.setAttribute('step', '0.01');
                    dropInput.setAttribute('required', 'required');
                    dropInput.setAttribute('placeholder', '输入退学绩点');

                    const dropButton = document.createElement('button');
                    dropButton.textContent = '批量处理退学';
                    dropButton.addEventListener('click', (event) => {
                        event.preventDefault(); // 阻止表单提交
                        // 检查输入框是否为空
                        if (!dropInput.value) {
                            alert('请输入退学绩点');
                            return;
                        }
                        const drop = dropInput.value;
                        // 调用另一个函数并传递参数
                        dropGraduation(drop);
                    });

                    workDiv.appendChild(creditInput);
                    workDiv.appendChild(creditButton);
                    workDiv.appendChild(dropInput);
                    workDiv.appendChild(dropButton);
                    headerSection.appendChild(workDiv);
                    mainTable.appendChild(headerSection);
                    const shellSection = document.createElement('section');
                    shellSection.setAttribute('class','shell');
                    const shellTable = document.createElement('table');
                    const shellThead = document.createElement('thead');
                    const headRow = document.createElement('tr');
                    ['学生学号', '班级号', '专业号', '学生姓名', '学生性别', '学生出生日期', '所属省份', '所属市区', '已修学分', '学生绩点', '操作'].forEach(headerText => {
                        const shellCell = document.createElement('th');
                        shellCell.textContent = headerText;
                        headRow.appendChild(shellCell);
                        shellThead.appendChild(headRow);
                    });
                    shellTable.appendChild(shellThead);
                    const shellTbody = document.createElement('tbody');
                    data.forEach(item => {
                        const row = document.createElement('tr');
                        ['sno', 'clno', 'dno', 'sname', 'ssex', 'sbirth', 'sprovince', 'scity', 'scredit', 'sgpa'].forEach(key => {
                            const cell = document.createElement('td');
                            cell.textContent = item[key];
                            row.appendChild(cell);
                        });
                        const actionCell = document.createElement('td');
                        const updateButton = document.createElement('button');
                        updateButton.setAttribute('class','button');
                        updateButton.textContent = '修改';
                        updateButton.addEventListener('click', () => showUpdateStudentDetails(item['sno']));
                        actionCell.appendChild(updateButton);
                        const deleteButton = document.createElement('button');
                        deleteButton.setAttribute('class','button');
                        deleteButton.textContent = '删除';
                        deleteButton.addEventListener('click', function () {
                            // 调用另一个函数处理事务
                            deleteStudentBySno(item['sno']);
                        });
                        actionCell.appendChild(deleteButton);
                        row.appendChild(actionCell);
                        shellTbody.appendChild(row);
                    });
                    shellTable.appendChild(shellTbody);
                    shellSection.appendChild(shellTable);
                    mainTable.appendChild(shellSection);
                    resultDiv.appendChild(mainTable);
                })
                .catch(error => {
                    console.error('Error:', error);
                });
        });
    }

    function submitGraduation(credit){
        console.log('毕业处理');
        console.log(credit);
        const formData = new FormData();
        formData.append('credit', credit);
        const searchParams = new URLSearchParams(formData);
        fetch('submitGraduation', {
            method: 'POST',
            body: searchParams
        })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    handleSuccess('showSearchStudent');
                }
                else{
                    handleSuccess('showSearchStudent');
                }
            })
            .catch(error => {
                console.error('更新失败:', error);
                handleFail('showSearchStudent');
            });
    }

    function dropGraduation(drop){
        console.log('退学处理');
        console.log(drop);
        const formData = new FormData();
        formData.append('drop', drop);
        const searchParams = new URLSearchParams(formData);
        fetch('dropGraduation', {
            method: 'POST',
            body: searchParams
        })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    handleSuccess('showSearchStudent');
                }
                else{
                    handleSuccess('showSearchStudent');
                }
            })
            .catch(error => {
                console.error('更新失败:', error);
                handleFail('showSearchStudent');
            });
    }

    function deleteStudentBySno(sno){
        const formData = new FormData();
        formData.append('Sno', sno); // 手动添加 sno 到 FormData 对象
        const searchParams = new URLSearchParams(formData);
        fetch('deleteStudent', {
            method: 'POST',
            body: searchParams
        })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    handleSuccess('showSearchStudent');
                }
                else{
                    handleFail('showSearchStudent');
                }
            })
            .catch(error => {
                console.error('更新失败:', error);
                handleFail('showSearchStudent');
            });
    }

    function showAddStudent(){
        const content = document.getElementById('content');
        content.innerHTML = '<h2>添加学生</h2>' +
            '<form id="addStudentForm">' +
            '<input type="text" name="Sno" placeholder="学生学号" required>' +
            '<input type="text" name="Clno" placeholder="班级号" required>' +
            '<input type="text" name="Dno" placeholder="专业号" required>' +
            '<input type="text" name="Sname" placeholder="学生姓名" required>' +
            '<select name="Ssex" required>'+
            '<option value="">请选择性别</option>'+
            '<option value="男">男</option>'+
            '<option value="女">女</option>'+
            '</select>'+
            '<input type="number" name="Sbirth" placeholder="学生出生日期" required>' +
            '<input type="text" name="Sprovince" placeholder="所属省份" required>' +
            '<input type="text" name="Scity" placeholder="所属市区" required>' +
            '<button type="submit">添加</button>' +
            '</form>' +
            '<div id="addStudentResult"></div>';

        const form = document.getElementById('addStudentForm');
        form.addEventListener('submit', function(event) {
            event.preventDefault();
            const formData = new FormData(form);
            const searchParams = new URLSearchParams(formData);
            fetch('addStudent', {
                method: 'POST',
                body: searchParams
            })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        handleSuccess('showAddStudent');
                    } else {
                        handleFail('showAddStudent');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    handleFail('showAddStudent');
                });
        });

    }

    function showUpdateStudent(){
        const content = document.getElementById('content');
        content.innerHTML = '<h2>要修改的学生学号</h2>' +
            '<form id="updateStudentNameForm" class="simple-form">' +
            '<input type="text" name="Sno" placeholder="学生学号" required>' +
            '<button type="submit">进行修改</button>' +
            '</form>' +
            '<div id="updateStudentNameResult"></div>';

        const form = document.getElementById('updateStudentNameForm');
        form.addEventListener('submit', function(event){
            event.preventDefault();
            const sno = form.elements['Sno'].value;
            showUpdateStudentDetails(sno);
        })
    }

    function showUpdateStudentDetails(sno){
        const content = document.getElementById('content');
        content.innerHTML = '<h2>修改学生</h2>' +
            '<form id="updateStudentForm">' +
            '<input type="text" name="Sno" value='+ sno + ' placeholder="学生学号" readonly>' +
            '<input type="text" name="Clno" placeholder="班级号" required>' +
            '<input type="text" name="Dno" placeholder="专业号" required>' +
            '<input type="text" name="Sname" placeholder="学生姓名" required>' +
            '<select name="Ssex" required>'+
            '<option value="">请选择性别</option>'+
            '<option value="男">男</option>'+
            '<option value="女">女</option>'+
            '</select>'+
            '<input type="number" name="Sbirth" placeholder="学生出生日期" required>' +
            '<input type="text" name="Sprovince" placeholder="所属省份" required>' +
            '<input type="text" name="Scity" placeholder="所属市区" required>' +
            '<button type="submit">修改</button>' +
            '</form>' +
            '<div id="updateStudentResult"></div>';

        const form = document.getElementById('updateStudentForm');
        form.addEventListener('submit', function(event) {
            event.preventDefault();
            const formData = new FormData(form);
            const searchParams = new URLSearchParams(formData);
            fetch('updateStudent', {
                method: 'POST',
                body: searchParams
            })
                .then(response => response.json())
                .then(data => {
                    const resultDiv = document.getElementById('updateStudentResult');
                    if (data.success) {
                        handleSuccess('showUpdateStudent');
                    } else {
                        handleFail('showUpdateStudent');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    handleFail('showUpdateStudent');
                });
        });
    }

    function showDeleteStudent(){
        const content = document.getElementById('content');
        content.innerHTML = '<h2>要删除的学生学号</h2>' +
            '<form id="deleteStudentForm" class="simple-form">' +
            '<input type="text" name="Sno" placeholder="学生学号" required>' +
            '<button type="submit">删除</button>' +
            '</form>' +
            '<div id="deleteStudentResult"></div>';

        const form = document.getElementById('deleteStudentForm');
        form.addEventListener('submit', function(event){
            event.preventDefault();
            const formData = new FormData(form);
            const searchParams = new URLSearchParams(formData);
            fetch('deleteStudent', {
                method: 'POST',
                body: searchParams
            })
                .then(response => response.json())
                .then(data => {
                    const resultDiv = document.getElementById('deleteStudentResult');
                    if (data.success) {
                        handleSuccess('showDeleteStudent');
                    } else {
                        handleFail('showDeleteStudent');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    handleFail('showDeleteStudent');
                });


        })
    }

    function showStatisticStudent() {
        const content = document.getElementById('content');
        content.innerHTML = '<h2>操作列表</h2>';
        // 创建并添加按钮
        const buttons = [
            { text: '学生绩点统计', action: showStudentGPA },
            { text: '学生学分统计', action: showStudentCredits },
            { text: '学生个人成绩统计', action: showStudentScores },
            { text: '学生绩点排名', action: showStudentGPARank },
            { text: '学生已修学分排名', action: showStudentCreditRank },
        ];

        buttons.forEach(buttonInfo => {
            const button = document.createElement('button');
            button.textContent = buttonInfo.text;
            button.addEventListener('click', buttonInfo.action);
            content.appendChild(button);
        });
        const showResult = document.createElement('div');
        showResult.setAttribute('id','showResult');
        content.appendChild(showResult);
    }

    function showStudentGPA() {
        console.log('显示学生绩点统计');
        // 添加实际的实现代码
        fetch('showStudentGpa', {
            method: 'POST',
        })
            .then(response => response.json())
            .then(data => {
                console.log(data);
                const resultDiv = document.getElementById('showResult');
                resultDiv.innerHTML = '';
                const mainTable = document.createElement('main');
                mainTable.setAttribute('class', 'table');
                const headerSection = document.createElement('section');
                headerSection.setAttribute('class','header');
                const headTitle =document.createElement('h1');
                headTitle.textContent='学生绩点统计';
                headerSection.appendChild(headTitle);
                mainTable.appendChild(headerSection);
                const shellSection = document.createElement('section');
                shellSection.setAttribute('class','shell');
                const shellTable = document.createElement('table');
                const shellThead = document.createElement('thead');
                const headRow = document.createElement('tr');
                ['最高绩点', '最低绩点', '平均绩点'].forEach(headerText => {
                    const shellCell = document.createElement('th');
                    shellCell.textContent = headerText;
                    headRow.appendChild(shellCell);
                });
                shellThead.appendChild(headRow);
                shellTable.appendChild(shellThead);
                const shellTbody = document.createElement('tbody');
                data.forEach(item => {
                    const row = document.createElement('tr');
                    ['max','min','avg'].forEach(key => {
                        const cell = document.createElement('td');
                        cell.textContent = item[key];
                        row.appendChild(cell);
                    });
                    shellTbody.appendChild(row);
                });
                shellTable.appendChild(shellTbody);
                shellSection.appendChild(shellTable);
                mainTable.appendChild(shellSection);
                resultDiv.appendChild(mainTable);
            })
            .catch(error => {
                console.error('Error:', error);
            });

    }

    function showStudentCredits() {
        console.log('显示学生学分统计');
        // 添加实际的实现代码
        fetch('showStudentCredit', {
            method: 'POST',
        })
            .then(response => response.json())
            .then(data => {
                console.log(data);
                const resultDiv = document.getElementById('showResult');
                resultDiv.innerHTML = '';
                const mainTable = document.createElement('main');
                mainTable.setAttribute('class', 'table');
                const headerSection = document.createElement('section');
                headerSection.setAttribute('class','header');
                const headTitle =document.createElement('h1');
                headTitle.textContent='学生学分统计';
                headerSection.appendChild(headTitle);
                mainTable.appendChild(headerSection);
                const shellSection = document.createElement('section');
                shellSection.setAttribute('class','shell');
                const shellTable = document.createElement('table');
                const shellThead = document.createElement('thead');
                const headRow = document.createElement('tr');
                ['最高学分', '最低学分', '平均学分'].forEach(headerText => {
                    const shellCell = document.createElement('th');
                    shellCell.textContent = headerText;
                    headRow.appendChild(shellCell);
                });
                shellThead.appendChild(headRow);
                shellTable.appendChild(shellThead);
                const shellTbody = document.createElement('tbody');
                data.forEach(item => {
                    const row = document.createElement('tr');
                    ['max','min','avg'].forEach(key => {
                        const cell = document.createElement('td');
                        cell.textContent = item[key];
                        row.appendChild(cell);
                    });
                    shellTbody.appendChild(row);
                });
                shellTable.appendChild(shellTbody);
                shellSection.appendChild(shellTable);
                mainTable.appendChild(shellSection);
                resultDiv.appendChild(mainTable);
            })
            .catch(error => {
                console.error('Error:', error);
            });
    }

    function showStudentScores() {
        console.log('显示学生个人成绩统计');
        // 添加实际的实现代码
        fetch('showStudentEachScore', {
            method: 'POST',
        })
            .then(response => response.json())
            .then(data => {
                console.log(data);
                const resultDiv = document.getElementById('showResult');
                resultDiv.innerHTML = '';
                const mainTable = document.createElement('main');
                mainTable.setAttribute('class', 'table');
                const headerSection = document.createElement('section');
                headerSection.setAttribute('class','header');
                const headTitle =document.createElement('h1');
                headTitle.textContent='学生个人成绩统计';
                headerSection.appendChild(headTitle);
                mainTable.appendChild(headerSection);
                const shellSection = document.createElement('section');
                shellSection.setAttribute('class','shell');
                const shellTable = document.createElement('table');
                const shellThead = document.createElement('thead');
                const headRow = document.createElement('tr');
                ['学生学号', '学生姓名', '最高分', '最低分', '平均分'].forEach(headerText => {
                    const shellCell = document.createElement('th');
                    shellCell.textContent = headerText;
                    headRow.appendChild(shellCell);
                });
                shellThead.appendChild(headRow);
                shellTable.appendChild(shellThead);
                const shellTbody = document.createElement('tbody');
                data.forEach(item => {
                    const row = document.createElement('tr');
                    ['sno', 'sname', 'max','min','avg'].forEach(key => {
                        const cell = document.createElement('td');
                        cell.textContent = item[key];
                        row.appendChild(cell);
                    });
                    shellTbody.appendChild(row);
                });
                shellTable.appendChild(shellTbody);
                shellSection.appendChild(shellTable);
                mainTable.appendChild(shellSection);
                resultDiv.appendChild(mainTable);
            })
            .catch(error => {
                console.error('Error:', error);
            });
    }

    function showStudentGPARank() {
        console.log('显示学生绩点排名');
        // 添加实际的实现代码
        fetch('showStudentGpaRank', {
            method: 'POST',
        })
            .then(response => response.json())
            .then(data => {
                console.log(data);
                const resultDiv = document.getElementById('showResult');
                resultDiv.innerHTML = '';
                const mainTable = document.createElement('main');
                mainTable.setAttribute('class', 'table');
                const headerSection = document.createElement('section');
                headerSection.setAttribute('class','header');
                const headTitle =document.createElement('h1');
                headTitle.textContent='学生绩点排名';
                headerSection.appendChild(headTitle);
                mainTable.appendChild(headerSection);
                const shellSection = document.createElement('section');
                shellSection.setAttribute('class','shell');
                const shellTable = document.createElement('table');
                const shellThead = document.createElement('thead');
                const headRow = document.createElement('tr');
                ['学生学号', '学生姓名', '排名'].forEach(headerText => {
                    const shellCell = document.createElement('th');
                    shellCell.textContent = headerText;
                    headRow.appendChild(shellCell);
                });
                shellThead.appendChild(headRow);
                shellTable.appendChild(shellThead);
                const shellTbody = document.createElement('tbody');
                data.forEach(item => {
                    const row = document.createElement('tr');
                    ['sno', 'sname', 'rank'].forEach(key => {
                        const cell = document.createElement('td');
                        cell.textContent = item[key];
                        row.appendChild(cell);
                    });
                    shellTbody.appendChild(row);
                });
                shellTable.appendChild(shellTbody);
                shellSection.appendChild(shellTable);
                mainTable.appendChild(shellSection);
                resultDiv.appendChild(mainTable);
            })
            .catch(error => {
                console.error('Error:', error);
            });
    }

    function showStudentCreditRank() {
        console.log('显示学生已修学分排名');
        // 添加实际的实现代码
        fetch('showStudentCreditRank', {
            method: 'POST',
        })
            .then(response => response.json())
            .then(data => {
                console.log(data);
                const resultDiv = document.getElementById('showResult');
                resultDiv.innerHTML = '';
                const mainTable = document.createElement('main');
                mainTable.setAttribute('class', 'table');
                const headerSection = document.createElement('section');
                headerSection.setAttribute('class','header');
                const headTitle =document.createElement('h1');
                headTitle.textContent='学生已修学分排名';
                headerSection.appendChild(headTitle);
                mainTable.appendChild(headerSection);
                const shellSection = document.createElement('section');
                shellSection.setAttribute('class','shell');
                const shellTable = document.createElement('table');
                const shellThead = document.createElement('thead');
                const headRow = document.createElement('tr');
                ['学生学号', '学生姓名', '排名'].forEach(headerText => {
                    const shellCell = document.createElement('th');
                    shellCell.textContent = headerText;
                    headRow.appendChild(shellCell);
                });
                shellThead.appendChild(headRow);
                shellTable.appendChild(shellThead);
                const shellTbody = document.createElement('tbody');
                data.forEach(item => {
                    const row = document.createElement('tr');
                    ['sno', 'sname', 'rank'].forEach(key => {
                        const cell = document.createElement('td');
                        cell.textContent = item[key];
                        row.appendChild(cell);
                    });
                    shellTbody.appendChild(row);
                });
                shellTable.appendChild(shellTbody);
                shellSection.appendChild(shellTable);
                mainTable.appendChild(shellSection);
                resultDiv.appendChild(mainTable);
            })
            .catch(error => {
                console.error('Error:', error);
            });
    }



    function showSearchTeacher(){
        const content = document.getElementById('content');
        content.innerHTML = '<h2>教师信息查询</h2>' +
            '<form id="searchTeacherForm">' +
            '<input type="text" name="Tno" placeholder="教师工号" class="three">' +
            '<input type="text" name="Tname" placeholder="教师姓名" class="three">' +
            '<select name="Tsex" class="three">'+
            '<option value="">请选择性别</option>'+
            '<option value="男">男</option>'+
            '<option value="女">女</option>'+
            '</select>'+
            '<input type="number" name="Tbirth" placeholder="教师出生日期" class="three">' +
            '<select name="Tposition" class="three">'+
            '<option value="">教师职称</option>'+
            '<option value="讲师">讲师</option>'+
            '<option value="副教授">副教授</option>'+
            '<option value="教授">教授</option>'+
            '<option value="研究员">研究员</option>'+
            '</select>'+
            '<input type="text" name="Tphone" placeholder="教师电话" class="three">' +
            '<button type="submit">查询</button>' +
            '</form>' +
            '<div id="searchTeacherResult"></div>';

        const searchTeacherForm = document.getElementById('searchTeacherForm');
        searchTeacherForm.addEventListener('submit', function(event) {
            event.preventDefault();
            const formData = new FormData(this);
            const searchParams = new URLSearchParams(formData);
            fetch('searchTeacher', {
                method: 'POST',
                body: searchParams
            })
                .then(response => response.json())
                .then(data => {
                    console.log(data);
                    const resultDiv = document.getElementById('searchTeacherResult');
                    resultDiv.innerHTML = '';
                    const mainTable = document.createElement('main');
                    mainTable.setAttribute('class', 'table');
                    const headerSection = document.createElement('section');
                    headerSection.setAttribute('class','header');
                    const headTitle =document.createElement('h1');
                    headTitle.textContent='查询结果';
                    headerSection.appendChild(headTitle);
                    mainTable.appendChild(headerSection);
                    const shellSection = document.createElement('section');
                    shellSection.setAttribute('class','shell');
                    const shellTable = document.createElement('table');
                    const shellThead = document.createElement('thead');
                    const headRow = document.createElement('tr');
                    ['教师工号', '教师姓名', '教师性别', '教师出生日期', '教师职位', '教师电话', '操作'].forEach(headerText => {
                        const shellCell = document.createElement('th');
                        shellCell.textContent = headerText;
                        headRow.appendChild(shellCell);
                        shellThead.appendChild(headRow);
                    });
                    shellTable.appendChild(shellThead);
                    const shellTbody = document.createElement('tbody');
                    data.forEach(item => {
                        const row = document.createElement('tr');
                        ['tno', 'tname', 'tsex', 'tbirth', 'tposition', 'tphone'].forEach(key => {
                            const cell = document.createElement('td');
                            cell.textContent = item[key];
                            row.appendChild(cell);
                        });
                        const actionCell = document.createElement('td');
                        const updateButton = document.createElement('button');
                        updateButton.setAttribute('class','button');
                        updateButton.textContent = '修改';
                        updateButton.addEventListener('click', () => showUpdateTeacherDetails(item['tno']));
                        actionCell.appendChild(updateButton);
                        const deleteButton = document.createElement('button');
                        deleteButton.setAttribute('class','button');
                        deleteButton.textContent = '删除';
                        deleteButton.addEventListener('click', function () {
                            // 调用另一个函数处理事务
                            deleteTeacherByTno(item['tno']);
                        });
                        actionCell.appendChild(deleteButton);
                        row.appendChild(actionCell);
                        shellTbody.appendChild(row);
                    });
                    shellTable.appendChild(shellTbody);
                    shellSection.appendChild(shellTable);
                    mainTable.appendChild(shellSection);
                    resultDiv.appendChild(mainTable);
                })
                .catch(error => {
                    console.error('Error:', error);
                });
        });
    }

    function deleteTeacherByTno(tno){
        const formData = new FormData();
        formData.append('Tno', tno); // 手动添加 sno 到 FormData 对象
        const searchParams = new URLSearchParams(formData);
        fetch('deleteTeacher', {
            method: 'POST',
            body: searchParams
        })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    handleSuccess('showSearchTeacher');
                }
                else{
                    handleFail('showSearchTeacher');
                }
            })
            .catch(error => {
                console.error('更新失败:', error);
                handleFail('showSearchTeacher');
            });
    }

    function showAddTeacher(){
        const content = document.getElementById('content');
        content.innerHTML = '<h2>添加教师</h2>' +
            '<form id="addTeacherForm">' +
            '<input type="text" name="Tno" placeholder="教师工号" class="three" required>' +
            '<input type="text" name="Tname" placeholder="教师姓名" class="three" required>' +
            '<select name="Tsex" class="three" required>'+
            '<option value="">请选择性别</option>'+
            '<option value="男">男</option>'+
            '<option value="女">女</option>'+
            '</select>'+
            '<input type="number" name="Tbirth" placeholder="教师出生日期" class="three" required>' +
            '<select name="Tposition" class="three" required>'+
            '<option value="">教师职称</option>'+
            '<option value="讲师">讲师</option>'+
            '<option value="副教授">副教授</option>'+
            '<option value="教授">教授</option>'+
            '<option value="研究员">研究员</option>'+
            '</select>'+
            '<input type="text" name="Tphone" placeholder="教师电话" class="three" required>' +
            '<button type="submit">添加</button>' +
            '</form>' +
            '<div id="addTeacherResult"></div>';

        const form = document.getElementById('addTeacherForm');
        form.addEventListener('submit', function(event) {
            event.preventDefault();
            const formData = new FormData(form);
            const searchParams = new URLSearchParams(formData);
            fetch('addTeacher', {
                method: 'POST',
                body: searchParams
            })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        handleSuccess('showAddTeacher');
                    } else {
                        handleFail('showAddTeacher');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    handleFail('showAddTeacher');
                });
        });

    }

    function showUpdateTeacher(){
        const content = document.getElementById('content');
        content.innerHTML = '<h2>要修改的教师工号</h2>' +
            '<form id="updateTeacherNameForm" class="simple-form">' +
            '<input type="text" name="Tno" placeholder="教师工号" required>' +
            '<button type="submit">进行修改</button>' +
            '</form>' +
            '<div id="updateTeacherNameResult"></div>';

        const form = document.getElementById('updateTeacherNameForm');
        form.addEventListener('submit', function(event){
            event.preventDefault();
            const tno = form.elements['Tno'].value;
            showUpdateTeacherDetails(tno);
        })
    }

    function showUpdateTeacherDetails(tno){
        const content = document.getElementById('content');
        content.innerHTML = '<h2>修改教师</h2>' +
            '<form id="updateTeacherForm">' +
            '<input type="text" name="Tno" value='+ tno + ' placeholder="教师工号" class="three" readonly>' +
            '<input type="text" name="Tname" placeholder="教师姓名" class="three" required>' +
            '<select name="Tsex" class="three" required>'+
            '<option value="">请选择性别</option>'+
            '<option value="男">男</option>'+
            '<option value="女">女</option>'+
            '</select>'+
            '<input type="number" name="Tbirth" placeholder="教师出生日期" class="three" required>' +
            '<select name="Tposition" class="three" required>'+
            '<option value="">教师职称</option>'+
            '<option value="讲师">讲师</option>'+
            '<option value="副教授">副教授</option>'+
            '<option value="教授">教授</option>'+
            '<option value="研究员">研究员</option>'+
            '</select>'+
            '<input type="text" name="Tphone" placeholder="教师电话" class="three" required>' +
            '<button type="submit">修改</button>' +
            '</form>' +
            '<div id="updateTeacherResult"></div>';

        const form = document.getElementById('updateTeacherForm');
        form.addEventListener('submit', function(event) {
            event.preventDefault();
            const formData = new FormData(form);
            const searchParams = new URLSearchParams(formData);
            fetch('updateTeacher', {
                method: 'POST',
                body: searchParams
            })
                .then(response => response.json())
                .then(data => {
                    const resultDiv = document.getElementById('updateTeacherResult');
                    if (data.success) {
                        handleSuccess('showUpdateTeacher');
                    } else {
                        handleFail('showUpdateTeacher');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    handleFail('showUpdateTeacher');
                });
        });
    }

    function showDeleteTeacher(){
        const content = document.getElementById('content');
        content.innerHTML = '<h2>要删除的教师工号</h2>' +
            '<form id="deleteTeacherForm" class="simple-form">' +
            '<input type="text" name="Tno" placeholder="教师工号" required>' +
            '<button type="submit">删除</button>' +
            '</form>' +
            '<div id="deleteTeacherResult"></div>';

        const form = document.getElementById('deleteTeacherForm');
        form.addEventListener('submit', function(event){
            event.preventDefault();
            const formData = new FormData(form);
            const searchParams = new URLSearchParams(formData);
            fetch('deleteTeacher', {
                method: 'POST',
                body: searchParams
            })
                .then(response => response.json())
                .then(data => {
                    const resultDiv = document.getElementById('deleteTeacherResult');
                    if (data.success) {
                        handleSuccess('showDeleteTeacher');
                    } else {
                        handleFail('showDeleteTeacher');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    handleFail('showDeleteTeacher');
                });


        })
    }


    function showSearchDept(){
        const content = document.getElementById('content');
        content.innerHTML = '<h2>专业信息查询</h2>' +
            '<form id="searchDeptForm">' +
            '<input type="text" name="Dno" placeholder="专业号" class="three">' +
            '<input type="text" name="Dname" placeholder="专业名称" class="three">' +
            '<input type="number" name="Dnumber" placeholder="专业人数" class="three">' +
            '<button type="submit">查询</button>' +
            '</form>' +
            '<div id="searchDeptResult"></div>';


        const searchDeptForm = document.getElementById('searchDeptForm');
        searchDeptForm.addEventListener('submit', function(event) {
            event.preventDefault();
            const formData = new FormData(this);
            const searchParams = new URLSearchParams(formData);
            fetch('searchDept', {
                method: 'POST',
                body: searchParams
            })
                .then(response => response.json())
                .then(data => {
                    console.log(data);
                    const resultDiv = document.getElementById('searchDeptResult');
                    resultDiv.innerHTML = '';
                    const mainTable = document.createElement('main');
                    mainTable.setAttribute('class', 'table');
                    const headerSection = document.createElement('section');
                    headerSection.setAttribute('class','header');
                    const headTitle =document.createElement('h1');
                    headTitle.textContent='查询结果';
                    headerSection.appendChild(headTitle);
                    mainTable.appendChild(headerSection);
                    const shellSection = document.createElement('section');
                    shellSection.setAttribute('class','shell');
                    const shellTable = document.createElement('table');
                    const shellThead = document.createElement('thead');
                    const headRow = document.createElement('tr');
                    ['专业号', '专业名称', '人数', '操作'].forEach(headerText => {
                        const shellCell = document.createElement('th');
                        shellCell.textContent = headerText;
                        headRow.appendChild(shellCell);
                        shellThead.appendChild(headRow);
                    });
                    shellTable.appendChild(shellThead);
                    const shellTbody = document.createElement('tbody');
                    data.forEach(item => {
                        const row = document.createElement('tr');
                        ['dno', 'dname', 'dnumber'].forEach(key => {
                            const cell = document.createElement('td');
                            cell.textContent = item[key];
                            row.appendChild(cell);
                        });
                        const actionCell = document.createElement('td');
                        const updateButton = document.createElement('button');
                        updateButton.setAttribute('class','button');
                        updateButton.textContent = '修改';
                        updateButton.addEventListener('click', () => showUpdateDeptDetails(item['dno']));
                        actionCell.appendChild(updateButton);
                        const deleteButton = document.createElement('button');
                        deleteButton.setAttribute('class','button');
                        deleteButton.textContent = '删除';
                        deleteButton.addEventListener('click', function () {
                            // 调用另一个函数处理事务
                            deleteDeptByDno(item['dno']);
                        });
                        actionCell.appendChild(deleteButton);
                        row.appendChild(actionCell);
                        shellTbody.appendChild(row);
                    });
                    shellTable.appendChild(shellTbody);
                    shellSection.appendChild(shellTable);
                    mainTable.appendChild(shellSection);
                    resultDiv.appendChild(mainTable);
                })
                .catch(error => {
                    console.error('Error:', error);
                });
        });
    }

    function deleteDeptByDno(dno){
        const formData = new FormData();
        formData.append('Dno', dno); // 手动添加 sno 到 FormData 对象
        const searchParams = new URLSearchParams(formData);
        fetch('deleteDept', {
            method: 'POST',
            body: searchParams
        })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    handleSuccess('showSearchDept');
                }
                else{
                    handleFail('showSearchDept');
                }
            })
            .catch(error => {
                console.error('更新失败:', error);
                handleFail('showSearchDept');
            });
    }

    function showAddDept(){
        const content = document.getElementById('content');
        content.innerHTML = '<h2>添加专业</h2>' +
            '<form id="addDeptForm">' +
            '<input type="text" name="Dno" placeholder="专业号" class="two" required>' +
            '<input type="text" name="Dname" placeholder="专业名称" class="two" required>' +
            '<button type="submit">添加</button>' +
            '</form>' +
            '<div id="addDeptResult"></div>';


        const form = document.getElementById('addDeptForm');
        form.addEventListener('submit', function(event) {
            event.preventDefault();
            const formData = new FormData(form);
            const searchParams = new URLSearchParams(formData);
            fetch('addDept', {
                method: 'POST',
                body: searchParams
            })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        handleSuccess('showAddDept');
                    } else {
                        handleFail('showAddDept');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    handleFail('showAddDept');
                });
        });

    }

    function showUpdateDept(){
        const content = document.getElementById('content');
        content.innerHTML = '<h2>要修改的专业号</h2>' +
            '<form id="updateDeptNameForm" class="simple-form">' +
            '<input type="text" name="Dno" placeholder="专业号" required>' +
            '<button type="submit">进行修改</button>' +
            '</form>' +
            '<div id="updateDeptNameResult"></div>';

        const form = document.getElementById('updateDeptNameForm');
        form.addEventListener('submit', function(event){
            event.preventDefault();
            const dno = form.elements['Dno'].value;
            showUpdateDeptDetails(dno);
        })
    }

    function showUpdateDeptDetails(dno){
        const content = document.getElementById('content');
        content.innerHTML = '<h2>修改专业</h2>' +
            '<form id="updateDeptForm">' +
            '<input type="text" name="Dno" value='+ dno + ' placeholder="专业号" class="two" readonly>' +
            '<input type="text" name="Dname" placeholder="专业名称" class="two" required>' +
            '<button type="submit">修改</button>' +
            '</form>' +
            '<div id="updateDeptResult"></div>';

        const form = document.getElementById('updateDeptForm');
        form.addEventListener('submit', function(event) {
            event.preventDefault();
            const formData = new FormData(form);
            const searchParams = new URLSearchParams(formData);
            fetch('updateDept', {
                method: 'POST',
                body: searchParams
            })
                .then(response => response.json())
                .then(data => {
                    const resultDiv = document.getElementById('updateDeptResult');
                    if (data.success) {
                        handleSuccess('showUpdateDept');
                    } else {
                        handleFail('showUpdateDept');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    handleFail('showUpdateDept');
                });
        });
    }

    function showDeleteDept(){
        const content = document.getElementById('content');
        content.innerHTML = '<h2>要删除的专业号</h2>' +
            '<form id="deleteDeptForm" class="simple-form">' +
            '<input type="text" name="Dno" placeholder="专业号" required>' +
            '<button type="submit">删除</button>' +
            '</form>' +
            '<div id="deleteDeptResult"></div>';

        const form = document.getElementById('deleteDeptForm');
        form.addEventListener('submit', function(event){
            event.preventDefault();
            const formData = new FormData(form);
            const searchParams = new URLSearchParams(formData);
            fetch('deleteDept', {
                method: 'POST',
                body: searchParams
            })
                .then(response => response.json())
                .then(data => {
                    const resultDiv = document.getElementById('deleteDeptResult');
                    if (data.success) {
                        handleSuccess('showDeleteDept');
                    } else {
                        handleFail('showDeleteDept');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    handleFail('showDeleteDept');
                });


        })
    }


    function showSearchClass(){
        const content = document.getElementById('content');
        content.innerHTML = '<h2>班级信息查询</h2>' +
            '<form id="searchClassForm">' +
            '<input type="text" name="Clno" placeholder="班级号">' +
            '<input type="text" name="Clname" placeholder="班级名称">' +
            '<input type="number" name="Clnumber" placeholder="班级人数">' +
            '<input type="text" name="Dno" placeholder="专业号">' +
            '<button type="submit">查询</button>' +
            '</form>' +
            '<div id="searchClassResult"></div>';



        const searchClassForm = document.getElementById('searchClassForm');
        searchClassForm.addEventListener('submit', function(event) {
            event.preventDefault();
            const formData = new FormData(this);
            const searchParams = new URLSearchParams(formData);
            fetch('searchClass', {
                method: 'POST',
                body: searchParams
            })
                .then(response => response.json())
                .then(data => {
                    console.log(data);
                    const resultDiv = document.getElementById('searchClassResult');
                    resultDiv.innerHTML = '';
                    const mainTable = document.createElement('main');
                    mainTable.setAttribute('class', 'table');
                    const headerSection = document.createElement('section');
                    headerSection.setAttribute('class','header');
                    const headTitle =document.createElement('h1');
                    headTitle.textContent='查询结果';
                    headerSection.appendChild(headTitle);
                    mainTable.appendChild(headerSection);
                    const shellSection = document.createElement('section');
                    shellSection.setAttribute('class','shell');
                    const shellTable = document.createElement('table');
                    const shellThead = document.createElement('thead');
                    const headRow = document.createElement('tr');
                    ['班级号', '班级名称', '人数', '专业号', '操作'].forEach(headerText => {
                        const shellCell = document.createElement('th');
                        shellCell.textContent = headerText;
                        headRow.appendChild(shellCell);
                        shellThead.appendChild(headRow);
                    });
                    shellTable.appendChild(shellThead);
                    const shellTbody = document.createElement('tbody');
                    data.forEach(item => {
                        const row = document.createElement('tr');
                        ['clno', 'clname', 'clnumber', 'dno'].forEach(key => {
                            const cell = document.createElement('td');
                            cell.textContent = item[key];
                            row.appendChild(cell);
                        });
                        const actionCell = document.createElement('td');
                        const updateButton = document.createElement('button');
                        updateButton.setAttribute('class','button');
                        updateButton.textContent = '修改';
                        updateButton.addEventListener('click', () => showUpdateClassDetails(item['clno'],item['dno']));
                        actionCell.appendChild(updateButton);
                        const deleteButton = document.createElement('button');
                        deleteButton.setAttribute('class','button');
                        deleteButton.textContent = '删除';
                        deleteButton.addEventListener('click', function () {
                            // 调用另一个函数处理事务
                            deleteClassByClnoAndDno(item['clno'],item['dno']);
                        });
                        actionCell.appendChild(deleteButton);
                        row.appendChild(actionCell);
                        shellTbody.appendChild(row);
                    });
                    shellTable.appendChild(shellTbody);
                    shellSection.appendChild(shellTable);
                    mainTable.appendChild(shellSection);
                    resultDiv.appendChild(mainTable);
                })
                .catch(error => {
                    console.error('Error:', error);
                });
        });
    }

    function deleteClassByClnoAndDno(clno, dno){
        const formData = new FormData();
        formData.append('Clno', clno);
        formData.append('Dno', dno);
        const searchParams = new URLSearchParams(formData);
        fetch('deleteClass', {
            method: 'POST',
            body: searchParams
        })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    handleSuccess('showSearchClass');
                }
                else{
                    handleFail('showSearchClass');
                }
            })
            .catch(error => {
                console.error('更新失败:', error);
                handleFail('showSearchClass');
            });
    }

    function showAddClass(){
        const content = document.getElementById('content');
        content.innerHTML = '<h2>添加班级</h2>' +
            '<form id="addClassForm">' +
            '<input type="text" name="Clno" placeholder="班级号" class="three" required>' +
            '<input type="text" name="Clname" placeholder="班级名称" class="three" required>' +
            '<input type="text" name="Dno" placeholder="专业号" class="three" required>' +
            '<button type="submit">添加</button>' +
            '</form>' +
            '<div id="addClassResult"></div>';


        const form = document.getElementById('addClassForm');
        form.addEventListener('submit', function(event) {
            event.preventDefault();
            const formData = new FormData(form);
            const searchParams = new URLSearchParams(formData);
            fetch('addClass', {
                method: 'POST',
                body: searchParams
            })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        handleSuccess('showAddClass');
                    } else {
                        handleFail('showAddClass');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    handleFail('showAddClass');
                });
        });

    }

    function showUpdateClass(){
        const content = document.getElementById('content');
        content.innerHTML = '<h2>要修改的班级</h2>' +
            '<form id="updateClassNameForm" class="simple-form">' +
            '<input type="text" name="Clno" placeholder="班级号" class="two" required>' +
            '<input type="text" name="Dno" placeholder="专业号" class="two" required>' +
            '<button type="submit">进行修改</button>' +
            '</form>' +
            '<div id="updateClassNameResult"></div>';

        const form = document.getElementById('updateClassNameForm');
        form.addEventListener('submit', function(event){
            event.preventDefault();
            const clno = form.elements['Clno'].value;
            const dno = form.elements['Dno'].value;
            showUpdateClassDetails(clno,dno);
        })
    }

    function showUpdateClassDetails(clno, dno){
        const content = document.getElementById('content');
        content.innerHTML = '<h2>修改班级</h2>' +
            '<form id="updateClassForm">' +
            '<input type="text" name="Clno" value='+ clno + ' placeholder="班级号" class="three" readonly>' +
            '<input type="text" name="Dno" value='+ dno + ' placeholder="专业号" class="three" readonly>' +
            '<input type="text" name="Clname" placeholder="班级名称" class="three" required>' +
            '<button type="submit">修改</button>' +
            '</form>' +
            '<div id="updateClassResult"></div>';

        const form = document.getElementById('updateClassForm');
        form.addEventListener('submit', function(event) {
            event.preventDefault();
            const formData = new FormData(form);
            const searchParams = new URLSearchParams(formData);
            fetch('updateClass', {
                method: 'POST',
                body: searchParams
            })
                .then(response => response.json())
                .then(data => {
                    const resultDiv = document.getElementById('updateClassResult');
                    if (data.success) {
                        handleSuccess('showUpdateClass');
                    } else {
                        handleFail('showUpdateClass');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    handleFail('showUpdateClass');
                });
        });
    }

    function showDeleteClass(){
        const content = document.getElementById('content');
        content.innerHTML = '<h2>要删除的班级</h2>' +
            '<form id="deleteClassForm" class="simple-form">' +
            '<input type="text" name="Clno" placeholder="班级号" class="two" required>' +
            '<input type="text" name="Dno" placeholder="专业号" class="two" required>' +
            '<button type="submit">删除</button>' +
            '</form>' +
            '<div id="deleteClassResult"></div>';

        const form = document.getElementById('deleteClassForm');
        form.addEventListener('submit', function(event){
            event.preventDefault();
            const formData = new FormData(form);
            const searchParams = new URLSearchParams(formData);
            fetch('deleteClass', {
                method: 'POST',
                body: searchParams
            })
                .then(response => response.json())
                .then(data => {
                    const resultDiv = document.getElementById('deleteClassResult');
                    if (data.success) {
                        handleSuccess('showDeleteClass');
                    } else {
                        handleFail('showDeleteClass');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    handleFail('showDeleteClass');
                });


        })
    }


    function showSearchCourse(){
        const content = document.getElementById('content');
        content.innerHTML = '<h2>课程信息查询</h2>' +
            '<form id="searchCourseForm">' +
            '<input type="text" name="Cno" placeholder="课程号">' +
            '<input type="text" name="Cname" placeholder="课程名称">' +
            '<input type="number" name="Cyear" placeholder="课程年份">' +
            '<input type="number" name="Period" placeholder="课程学时">' +
            '<select name="Way">'+
            '<option value="">课程种类</option>'+
            '<option value="必修">必修</option>'+
            '<option value="必选">必选</option>'+
            '<option value="选修">选修</option>'+
            '</select>'+
            '<input type="text" name="Curriculum" placeholder="课程大纲">' +
            '<input type="number" step="0.01" name="Credit" placeholder="课程学分">' +
            '<button type="submit">查询</button>' +
            '</form>' +
            '<div id="searchCourseResult"></div>';


        const searchCourseForm = document.getElementById('searchCourseForm');
        searchCourseForm.addEventListener('submit', function(event) {
            event.preventDefault();
            const formData = new FormData(this);
            const searchParams = new URLSearchParams(formData);
            fetch('searchCourse', {
                method: 'POST',
                body: searchParams
            })
                .then(response => response.json())
                .then(data => {
                    console.log(data);
                    const identify = '<%= user.getIdentify()%>';
                    const resultDiv = document.getElementById('searchCourseResult');
                    resultDiv.innerHTML = '';
                    const mainTable = document.createElement('main');
                    mainTable.setAttribute('class', 'table');
                    const headerSection = document.createElement('section');
                    headerSection.setAttribute('class','header');
                    const headTitle =document.createElement('h1');
                    headTitle.textContent='查询结果';
                    headerSection.appendChild(headTitle);
                    mainTable.appendChild(headerSection);
                    const shellSection = document.createElement('section');
                    shellSection.setAttribute('class','shell');
                    const shellTable = document.createElement('table');
                    const shellThead = document.createElement('thead');
                    const headRow = document.createElement('tr');
                    ['课程号', '课程名称', '课程年份', '开课学期', '课程种类', '课程大纲', '课程学分', '操作'].forEach(headerText => {
                        const shellCell = document.createElement('th');
                        shellCell.textContent = headerText;
                        if(headerText === '操作' && identify !== '管理员') {

                        }
                        else{
                            headRow.appendChild(shellCell);
                        }
                    });
                    shellThead.appendChild(headRow);
                    shellTable.appendChild(shellThead);
                    const shellTbody = document.createElement('tbody');
                    data.forEach(item => {
                        const row = document.createElement('tr');
                        ['cno', 'cname', 'cyear', 'period', 'way', 'curriculum', 'credit'].forEach(key => {
                            const cell = document.createElement('td');
                            cell.textContent = item[key];
                            row.appendChild(cell);
                        });
                        const actionCell = document.createElement('td');
                        const updateButton = document.createElement('button');
                        updateButton.setAttribute('class','button');
                        updateButton.textContent = '修改';
                        updateButton.addEventListener('click', () => showUpdateCourseDetails(item['cno']));
                        actionCell.appendChild(updateButton);
                        const deleteButton = document.createElement('button');
                        deleteButton.setAttribute('class','button');
                        deleteButton.textContent = '删除';
                        deleteButton.addEventListener('click', function () {
                            // 调用另一个函数处理事务
                            deleteCourseByCno(item['cno']);
                        });
                        actionCell.appendChild(deleteButton);
                        if(identify !== '管理员') {

                        }
                        else {
                            row.appendChild(actionCell);
                        }
                        shellTbody.appendChild(row);
                    });
                    shellTable.appendChild(shellTbody);
                    shellSection.appendChild(shellTable);
                    mainTable.appendChild(shellSection);
                    resultDiv.appendChild(mainTable);
                })
                .catch(error => {
                    console.error('Error:', error);
                });
        });
    }

    function deleteCourseByCno(cno){
        const formData = new FormData();
        formData.append('Cno', cno);
        const searchParams = new URLSearchParams(formData);
        fetch('deleteCourse', {
            method: 'POST',
            body: searchParams
        })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    handleSuccess('showSearchCourse');
                }
                else{
                    handleFail('showSearchCourse');
                }
            })
            .catch(error => {
                console.error('更新失败:', error);
                handleFail('showSearchCourse');
            });
    }

    function showAddCourse(){
        const content = document.getElementById('content');
        content.innerHTML = '<h2>添加课程</h2>' +
            '<form id="addCourseForm">' +
            '<input type="text" name="Cno" placeholder="课程号" required>' +
            '<input type="text" name="Cname" placeholder="课程名称" required>' +
            '<input type="number" name="Cyear" placeholder="课程年份" required>' +
            '<input type="number" name="Period" placeholder="课程学时" required>' +
            '<select name="Way" required>'+
            '<option value="">课程种类</option>'+
            '<option value="必修">必修</option>'+
            '<option value="必选">必选</option>'+
            '<option value="选修">选修</option>'+
            '</select>'+
            '<input type="text" name="Curriculum" placeholder="课程大纲" required>' +
            '<input type="number" step="0.01" name="Credit" placeholder="课程学分" required>' +
            '<button type="submit">添加</button>' +
            '</form>' +
            '<div id="addCourseResult"></div>';


        const form = document.getElementById('addCourseForm');
        form.addEventListener('submit', function(event) {
            event.preventDefault();
            const formData = new FormData(form);
            const searchParams = new URLSearchParams(formData);
            fetch('addCourse', {
                method: 'POST',
                body: searchParams
            })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        handleSuccess('showAddCourse');
                    } else {
                        handleFail('showAddCourse');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    handleFail('showAddCourse');
                });
        });

    }

    function showUpdateCourse(){
        const content = document.getElementById('content');
        content.innerHTML = '<h2>要修改的课程号</h2>' +
            '<form id="updateCourseNameForm" class="simple-form">' +
            '<input type="text" name="Cno" placeholder="课程号" required>' +
            '<button type="submit">进行修改</button>' +
            '</form>' +
            '<div id="updateCourseNameResult"></div>';

        const form = document.getElementById('updateCourseNameForm');
        form.addEventListener('submit', function(event){
            event.preventDefault();
            const cno = form.elements['Cno'].value;
            showUpdateCourseDetails(cno);
        })
    }

    function showUpdateCourseDetails(cno){
        const content = document.getElementById('content');
        content.innerHTML = '<h2>修改课程</h2>' +
            '<form id="updateCourseForm">' +
            '<input type="text" name="Cno" value='+ cno + ' placeholder="课程号" readonly>' +
            '<input type="text" name="Cname" placeholder="课程名称" required>' +
            '<input type="number" name="Cyear" placeholder="课程年份" required>' +
            '<input type="number" name="Period" placeholder="课程学时" required>' +
            '<select name="Way" required>'+
            '<option value="">课程种类</option>'+
            '<option value="必修">必修</option>'+
            '<option value="必选">必选</option>'+
            '<option value="选修">选修</option>'+
            '</select>'+
            '<input type="text" name="Curriculum" placeholder="课程大纲" required>' +
            '<input type="number" step="0.01" name="Credit" placeholder="课程学分" required>' +
            '<button type="submit">修改</button>' +
            '</form>' +
            '<div id="updateCourseResult"></div>';

        const form = document.getElementById('updateCourseForm');
        form.addEventListener('submit', function(event) {
            event.preventDefault();
            const formData = new FormData(form);
            const searchParams = new URLSearchParams(formData);
            fetch('updateCourse', {
                method: 'POST',
                body: searchParams
            })
                .then(response => response.json())
                .then(data => {
                    const resultDiv = document.getElementById('updateCourseResult');
                    if (data.success) {
                        handleSuccess('showUpdateCourse');
                    } else {
                        handleFail('showUpdateCourse');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    handleFail('showUpdateCourse');
                });
        });
    }

    function showDeleteCourse(){
        const content = document.getElementById('content');
        content.innerHTML = '<h2>要删除的课程号</h2>' +
            '<form id="deleteCourseForm" class="simple-form">' +
            '<input type="text" name="Cno" placeholder="课程号" required>' +
            '<button type="submit">删除</button>' +
            '</form>' +
            '<div id="deleteCourseResult"></div>';

        const form = document.getElementById('deleteCourseForm');
        form.addEventListener('submit', function(event){
            event.preventDefault();
            const formData = new FormData(form);
            const searchParams = new URLSearchParams(formData);
            fetch('deleteCourse', {
                method: 'POST',
                body: searchParams
            })
                .then(response => response.json())
                .then(data => {
                    const resultDiv = document.getElementById('deleteCourseResult');
                    if (data.success) {
                        handleSuccess('showDeleteCourse');
                    } else {
                        handleFail('showDeleteCourse');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    handleFail('showDeleteCourse');
                });


        })
    }

    function showStatisticCourse(){
        const content = document.getElementById('content');
        content.innerHTML = '<h2>操作列表</h2>';
        // 创建并添加按钮
        const buttons = [
            { text: '课程选课人数统计', action: showCourseChooseNumber },
            { text: '课程成绩统计', action: showCourseScore },
        ];

        buttons.forEach(buttonInfo => {
            const button = document.createElement('button');
            button.textContent = buttonInfo.text;
            button.addEventListener('click', buttonInfo.action);
            content.appendChild(button);
        });
        const showResult = document.createElement('div');
        showResult.setAttribute('id','showResult');
        content.appendChild(showResult);
    }

    function showCourseChooseNumber(){
        fetch('showCourseChooseNumber', {
            method: 'POST',
        })
            .then(response => response.json())
            .then(data => {
                console.log(data);
                const resultDiv = document.getElementById('showResult');
                resultDiv.innerHTML = '';
                const mainTable = document.createElement('main');
                mainTable.setAttribute('class', 'table');
                const headerSection = document.createElement('section');
                headerSection.setAttribute('class','header');
                const headTitle =document.createElement('h1');
                headTitle.textContent='课程成绩统计';
                headerSection.appendChild(headTitle);
                mainTable.appendChild(headerSection);
                const shellSection = document.createElement('section');
                shellSection.setAttribute('class','shell');
                const shellTable = document.createElement('table');
                const shellThead = document.createElement('thead');
                const headRow = document.createElement('tr');
                ['课程号', '课程名称', '选课人数'].forEach(headerText => {
                    const shellCell = document.createElement('th');
                    shellCell.textContent = headerText;
                    headRow.appendChild(shellCell);
                });
                shellThead.appendChild(headRow);
                shellTable.appendChild(shellThead);
                const shellTbody = document.createElement('tbody');
                data.forEach(item => {
                    const row = document.createElement('tr');
                    ['sno', 'sname', 'rank'].forEach(key => {
                        const cell = document.createElement('td');
                        cell.textContent = item[key];
                        row.appendChild(cell);
                    });
                    shellTbody.appendChild(row);
                });
                shellTable.appendChild(shellTbody);
                shellSection.appendChild(shellTable);
                mainTable.appendChild(shellSection);
                resultDiv.appendChild(mainTable);
            })
            .catch(error => {
                console.error('Error:', error);
            });
    }

    function showCourseScore(){
        fetch('showCourseScore', {
            method: 'POST',
        })
            .then(response => response.json())
            .then(data => {
                console.log(data);
                const resultDiv = document.getElementById('showResult');
                resultDiv.innerHTML = '';
                const mainTable = document.createElement('main');
                mainTable.setAttribute('class', 'table');
                const headerSection = document.createElement('section');
                headerSection.setAttribute('class','header');
                const headTitle =document.createElement('h1');
                headTitle.textContent='课程成绩统计';
                headerSection.appendChild(headTitle);
                mainTable.appendChild(headerSection);
                const shellSection = document.createElement('section');
                shellSection.setAttribute('class','shell');
                const shellTable = document.createElement('table');
                const shellThead = document.createElement('thead');
                const headRow = document.createElement('tr');
                ['课程号', '课程名称', '最高分', '最低分', '平均分'].forEach(headerText => {
                    const shellCell = document.createElement('th');
                    shellCell.textContent = headerText;
                    headRow.appendChild(shellCell);
                });
                shellThead.appendChild(headRow);
                shellTable.appendChild(shellThead);
                const shellTbody = document.createElement('tbody');
                data.forEach(item => {
                    const row = document.createElement('tr');
                    ['sno', 'sname', 'max','min','avg'].forEach(key => {
                        const cell = document.createElement('td');
                        cell.textContent = item[key];
                        row.appendChild(cell);
                    });
                    shellTbody.appendChild(row);
                });
                shellTable.appendChild(shellTbody);
                shellSection.appendChild(shellTable);
                mainTable.appendChild(shellSection);
                resultDiv.appendChild(mainTable);
            })
            .catch(error => {
                console.error('Error:', error);
            });
    }


    function showSearchTeach(){
        const content = document.getElementById('content');
        content.innerHTML = '<h2>授课信息查询</h2>' +
            '<form id="searchTeachForm">' +
            '<input type="text" name="Cno" placeholder="课程号" class="five">' +
            '<input type="text" name="Tno" placeholder="教师号" class="five">' +
            '<input type="text" name="time" placeholder="授课时间" class="five">' +
            '<input type="number" name="maxnum" placeholder="最大人数" class="five">' +
            '<input type="number" name="choosenum" placeholder="已选人数" class="five">' +
            '<button type="submit">查询</button>' +
            '</form>' +
            '<div id="searchTeachResult"></div>';



        const searchTeachForm = document.getElementById('searchTeachForm');
        searchTeachForm.addEventListener('submit', function(event) {
            event.preventDefault();
            const formData = new FormData(this);
            const searchParams = new URLSearchParams(formData);
            fetch('searchTeach', {
                method: 'POST',
                body: searchParams
            })
                .then(response => response.json())
                .then(data => {
                    console.log(data);
                    const identify = '<%= user.getIdentify()%>';
                    const sno = '<%= user.getAccount()%>';
                    let cno= '';
                    let tno= '';
                    const resultDiv = document.getElementById('searchTeachResult');
                    resultDiv.innerHTML = '';
                    const mainTable = document.createElement('main');
                    mainTable.setAttribute('class', 'table');
                    const headerSection = document.createElement('section');
                    headerSection.setAttribute('class','header');
                    const headTitle =document.createElement('h1');
                    headTitle.textContent='查询结果';
                    headerSection.appendChild(headTitle);
                    mainTable.appendChild(headerSection);
                    const shellSection = document.createElement('section');
                    shellSection.setAttribute('class','shell');
                    const shellTable = document.createElement('table');
                    const shellThead = document.createElement('thead');
                    const headRow = document.createElement('tr');
                    ['课程号', '教师号', '授课时间', '最大人数', '已选人数', '操作'].forEach(headerText => {
                        const shellCell = document.createElement('th');
                        shellCell.textContent = headerText;
                        headRow.appendChild(shellCell);
                        shellThead.appendChild(headRow);
                    });
                    shellTable.appendChild(shellThead);
                    const shellTbody = document.createElement('tbody');
                    data.forEach(item => {
                        const row = document.createElement('tr');
                        ['cno', 'tno', 'time', 'maxnum', 'choosenum'].forEach(key => {
                            const cell = document.createElement('td');
                            cell.textContent = item[key];
                            row.appendChild(cell);
                        });
                        const actionCell = document.createElement('td');
                        if(identify === '学生') {
                            const stuFormData = new FormData();
                            cno=item['cno'];
                            tno=item['tno'];
                            stuFormData.append('Sno', sno);
                            stuFormData.append('Tno', tno);
                            stuFormData.append('Cno', cno);
                            console.log(stuFormData);
                            const stuSearchParams = new URLSearchParams(stuFormData);
                            fetch('searchScore', {
                                method: 'POST',
                                body: stuSearchParams
                            })
                                .then(response => response.json())
                                .then(data => {
                                    let flag=false;
                                    let status=null;
                                    let grade=null;
                                    console.log(data);
                                    data.forEach(item =>{flag=true;status=item['status'];grade=item['grade']});

                                    let chooseButton = document.createElement('button');
                                    chooseButton.setAttribute('class', 'button');
                                    if (flag) {
                                        if(status === '待审核') {
                                            chooseButton.textContent = '退选';
                                            chooseButton.addEventListener('click', () => {
                                                // 调用退选 API 或相关逻辑
                                                dropCourse(sno, item['cno'], item['tno']);
                                            });
                                            actionCell.appendChild(chooseButton);
                                        }
                                        else if(status === '已选上'){
                                            const chooseText = document.createTextNode('已选上');
                                            actionCell.appendChild(chooseText);
                                        }
                                        else if(status === '已完成'){
                                            if(grade === 0){
                                                chooseButton.textContent = '重修';
                                                chooseButton.addEventListener('click', () => {
                                                    // 调用退选 API 或相关逻辑
                                                    rebuildCourse(sno, item['cno'], item['tno']);
                                                });
                                                actionCell.appendChild(chooseButton);
                                            }
                                            else{
                                                const chooseText = document.createTextNode('绩点:');
                                                const gradeText = document.createTextNode(grade);
                                                actionCell.appendChild(chooseText);
                                                actionCell.appendChild(gradeText);
                                            }
                                        }
                                    } else {
                                        chooseButton.textContent = '选课';
                                        chooseButton.addEventListener('click', () => {
                                            // 调用选课 API 或相关逻辑
                                            chooseCourse(sno, item['cno'], item['tno']);
                                        });
                                        actionCell.appendChild(chooseButton);
                                    }
                                })
                                .catch(error => {
                                    console.error('Error:', error);
                                });
                        }
                        else if(identify === '管理员'){
                            const updateButton = document.createElement('button');
                            updateButton.setAttribute('class','button');
                            updateButton.textContent = '修改';
                            updateButton.addEventListener('click', () => showUpdateTeachDetails(item['cno'],item['tno']));
                            const deleteButton = document.createElement('button');
                            deleteButton.setAttribute('class','button');
                            deleteButton.textContent = '删除';
                            deleteButton.addEventListener('click', function () {
                                // 调用另一个函数处理事务
                                deleteTeachByCnoAndTno(item['cno'],item['tno']);
                            });
                            actionCell.appendChild(updateButton);
                            actionCell.appendChild(deleteButton);
                        }
                        else{

                        }
                        row.appendChild(actionCell);
                        shellTbody.appendChild(row);
                    });
                    shellTable.appendChild(shellTbody);
                    shellSection.appendChild(shellTable);
                    mainTable.appendChild(shellSection);
                    resultDiv.appendChild(mainTable);
                })
                .catch(error => {
                    console.error('Error:', error);
                });
        });
    }

    function deleteTeachByCnoAndTno(cno, tno){
        const formData = new FormData();
        formData.append('Cno', cno);
        formData.append('Tno', tno);
        const searchParams = new URLSearchParams(formData);
        fetch('deleteTeach', {
            method: 'POST',
            body: searchParams
        })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    handleSuccess('showSearchTeach');
                }
                else{
                    handleFail('showSearchTeach');
                }
            })
            .catch(error => {
                console.error('更新失败:', error);
                handleFail('showSearchTeach');
            });
    }

    function showAddTeach(){
        const content = document.getElementById('content');
        content.innerHTML = '<h2>添加授课</h2>' +
            '<form id="addTeachForm">' +
            '<input type="text" name="Cno" placeholder="课程号" required>' +
            '<input type="text" name="Tno" placeholder="教师号" required>' +
            '<input type="text" name="time" placeholder="授课时间" required>' +
            '<input type="number" name="maxnum" placeholder="最大人数" required>' +
            '<button type="submit">添加</button>' +
            '</form>' +
            '<div id="addTeachResult"></div>';


        const form = document.getElementById('addTeachForm');
        form.addEventListener('submit', function(event) {
            event.preventDefault();
            const formData = new FormData(form);
            const searchParams = new URLSearchParams(formData);
            fetch('addTeach', {
                method: 'POST',
                body: searchParams
            })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        handleSuccess('showAddTeach');
                    } else {
                        handleFail('showAddTeach');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    handleFail('showAddTeach');
                });
        });

    }

    function showUpdateTeach(){
        const content = document.getElementById('content');
        content.innerHTML = '<h2>要修改的授课</h2>' +
            '<form id="updateTeachNameForm" class="simple-form">' +
            '<input type="text" name="Cno" placeholder="课程号" class="two" required>' +
            '<input type="text" name="Tno" placeholder="教师工号" class="two" required>' +
            '<button type="submit">进行修改</button>' +
            '</form>' +
            '<div id="updateTeachNameResult"></div>';

        const form = document.getElementById('updateTeachNameForm');
        form.addEventListener('submit', function(event){
            event.preventDefault();
            const cno = form.elements['Cno'].value;
            const tno = form.elements['Tno'].value;
            showUpdateTeachDetails(cno,tno);
        })
    }

    function showUpdateTeachDetails(cno, tno){
        const content = document.getElementById('content');
        content.innerHTML = '<h2>修改授课</h2>' +
            '<form id="updateTeachForm">' +
            '<input type="text" name="Cno" value='+ cno + ' placeholder="课程号" class="three" readonly>' +
            '<input type="text" name="Tno" value='+ tno + ' placeholder="教师工号" class="three" readonly>' +
            '<input type="text" name="time" placeholder="授课时间" class="three" required>' +
            '<button type="submit">修改</button>' +
            '</form>' +
            '<div id="updateTeachResult"></div>';

        const form = document.getElementById('updateTeachForm');
        form.addEventListener('submit', function(event) {
            event.preventDefault();
            const formData = new FormData(form);
            const searchParams = new URLSearchParams(formData);
            fetch('updateTeach', {
                method: 'POST',
                body: searchParams
            })
                .then(response => response.json())
                .then(data => {
                    const resultDiv = document.getElementById('updateTeachResult');
                    if (data.success) {
                        handleSuccess('showUpdateTeach');
                    } else {
                        handleFail('showUpdateTeach');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    handleFail('showUpdateTeach');
                });
        });
    }

    function showDeleteTeach(){
        const content = document.getElementById('content');
        content.innerHTML = '<h2>要删除的授课</h2>' +
            '<form id="deleteTeachForm" class="simple-form">' +
            '<input type="text" name="Cno" placeholder="课程号" class="two" required>' +
            '<input type="text" name="Tno" placeholder="教师工号" class="two" required>' +
            '<button type="submit">删除</button>' +
            '</form>' +
            '<div id="deleteTeachResult"></div>';

        const form = document.getElementById('deleteTeachForm');
        form.addEventListener('submit', function(event){
            event.preventDefault();
            const formData = new FormData(form);
            const searchParams = new URLSearchParams(formData);
            fetch('deleteTeach', {
                method: 'POST',
                body: searchParams
            })
                .then(response => response.json())
                .then(data => {
                    const resultDiv = document.getElementById('deleteTeachResult');
                    if (data.success) {
                        handleSuccess('showDeleteTeach');
                    } else {
                        handleFail('showDeleteTeach');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    handleFail('showDeleteTeach');
                });


        })
    }


    function showSearchScore(){
        const content = document.getElementById('content');
        content.innerHTML = '<h2>选课信息查询</h2>' +
            '<form id="searchScoreForm">' +
            '<input type="text" name="Sno" placeholder="学号" class="three">' +
            '<input type="text" name="Tno" placeholder="教师号" class="three">' +
            '<input type="text" name="Cno" placeholder="课程号" class="three">' +
            '<input type="number" name="score" placeholder="成绩" class="three">' +
            '<input type="number" step="0.01" name="grade" placeholder="绩点" class="three">' +
            '<select name="status" class="three">'+
            '<option value="">状态</option>'+
            '<option value="待审核">待审核</option>'+
            '<option value="已选上">已选上</option>'+
            '<option value="已完成">已完成</option>'+
            '</select>'+
            '<button type="submit">查询</button>' +
            '</form>' +
            '<div id="searchScoreResult"></div>';

        const searchScoreForm = document.getElementById('searchScoreForm');
        searchScoreForm.addEventListener('submit', function(event) {
            event.preventDefault();
            const formData = new FormData(this);
            const searchParams = new URLSearchParams(formData);
            fetch('searchScore', {
                method: 'POST',
                body: searchParams
            })
                .then(response => response.json())
                .then(data => {
                    console.log(data);
                    const resultDiv = document.getElementById('searchScoreResult');
                    resultDiv.innerHTML = '';
                    const mainTable = document.createElement('main');
                    mainTable.setAttribute('class', 'table');
                    const headerSection = document.createElement('section');
                    headerSection.setAttribute('class','header');
                    const headTitle =document.createElement('h1');
                    headTitle.textContent='查询结果';
                    headerSection.appendChild(headTitle);
                    mainTable.appendChild(headerSection);
                    const shellSection = document.createElement('section');
                    shellSection.setAttribute('class','shell');
                    const shellTable = document.createElement('table');
                    const shellThead = document.createElement('thead');
                    const headRow = document.createElement('tr');
                    ['学号', '教师号', '课程号', '成绩', '绩点', '状态', '操作'].forEach(headerText => {
                        const shellCell = document.createElement('th');
                        shellCell.textContent = headerText;
                        headRow.appendChild(shellCell);
                        shellThead.appendChild(headRow);
                    });
                    shellTable.appendChild(shellThead);
                    const shellTbody = document.createElement('tbody');
                    data.forEach(item => {
                        const row = document.createElement('tr');
                        ['sno', 'tno', 'cno', 'score', 'grade', 'status'].forEach(key => {
                            const cell = document.createElement('td');
                            cell.textContent = item[key];
                            row.appendChild(cell);
                        });
                        const actionCell = document.createElement('td');
                        const acceptButton = document.createElement('button');
                        acceptButton.setAttribute('class','button');
                        acceptButton.textContent = '接受';
                        acceptButton.addEventListener('click', () => changeScoreStatus(item['sno'],item['tno'],item['cno'],'accept'));
                        if(item['status']==='待审核') {
                            actionCell.appendChild(acceptButton);
                        }
                        const rejectButton = document.createElement('button');
                        rejectButton.setAttribute('class','button');
                        rejectButton.textContent = '拒绝';
                        rejectButton.addEventListener('click', function () {
                            // 调用另一个函数处理事务
                            changeScoreStatus(item['sno'],item['tno'],item['cno'],'reject');
                        });
                        if(item['status']==='待审核') {
                            actionCell.appendChild(rejectButton);
                        }
                        row.appendChild(actionCell);
                        shellTbody.appendChild(row);
                    });
                    shellTable.appendChild(shellTbody);
                    shellSection.appendChild(shellTable);
                    mainTable.appendChild(shellSection);
                    resultDiv.appendChild(mainTable);
                })
                .catch(error => {
                    console.error('Error:', error);
                });
        });
    }

    function changeScoreStatus(sno,tno,cno,way){
        console.log(way);
        const formData = new FormData();
        formData.append('Sno', sno);
        formData.append('Tno', tno);
        formData.append('Cno', cno);
        formData.append('way', way);
        const searchParams = new URLSearchParams(formData);
        fetch('changeScoreStatus', {
            method: 'POST',
            body: searchParams
        })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    handleSuccess('showSearchScore');
                }
                else{
                    handleFail('showSearchScore');
                }
            })
            .catch(error => {
                console.error('更新失败:', error);
                handleFail('showSearchScore');
            });
    }


    function showStudentInfo(){
        const content = document.getElementById('content');
        content.innerHTML = '<div id="searchStudentResult"></div>';
        const sno = '<%= user.getAccount()%>';
        console.log(sno);
        const formData = new FormData();
        formData.append('Sno', sno);
        const searchParams = new URLSearchParams(formData);
        fetch('searchStudent', {
            method: 'POST',
            body: searchParams
        })
            .then(response => response.json())
            .then(data => {
                console.log(data);
                const resultDiv = document.getElementById('searchStudentResult');
                resultDiv.innerHTML = '';
                const mainTable = document.createElement('main');
                mainTable.setAttribute('class', 'table');
                const headerSection = document.createElement('section');
                headerSection.setAttribute('class','header');
                const headTitle =document.createElement('h1');
                headTitle.textContent='学生个人信息';
                headerSection.appendChild(headTitle);
                mainTable.appendChild(headerSection);
                const shellSection = document.createElement('section');
                shellSection.setAttribute('class','shell');
                const shellTable = document.createElement('table');
                const shellThead = document.createElement('thead');
                const headRow = document.createElement('tr');
                ['学生学号', '班级号', '专业号', '学生姓名', '学生性别', '学生出生日期', '所属省份', '所属市区', '已修学分', '学生绩点'].forEach(headerText => {
                    const shellCell = document.createElement('th');
                    shellCell.textContent = headerText;
                    headRow.appendChild(shellCell);
                    shellThead.appendChild(headRow);
                });
                shellTable.appendChild(shellThead);
                const shellTbody = document.createElement('tbody');
                data.forEach(item => {
                    const row = document.createElement('tr');
                    ['sno', 'clno', 'dno', 'sname', 'ssex', 'sbirth', 'sprovince', 'scity', 'scredit', 'sgpa'].forEach(key => {
                        const cell = document.createElement('td');
                        cell.textContent = item[key];
                        row.appendChild(cell);
                    });
                    shellTbody.appendChild(row);
                });
                shellTable.appendChild(shellTbody);
                shellSection.appendChild(shellTable);
                mainTable.appendChild(shellSection);
                resultDiv.appendChild(mainTable);
            })
            .catch(error => {
                console.error('Error:', error);
            });
    }

    function chooseCourse(sno, cno, tno){
        const formData = new FormData();
        formData.append('Sno', sno);
        formData.append('Cno', cno);
        formData.append('Tno', tno);
        const searchParams = new URLSearchParams(formData);
        fetch('addScore', {
            method: 'POST',
            body: searchParams
        })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    handleSuccess('showSearchTeach');
                }
                else{
                    handleFail('showSearchTeach');
                }
            })
            .catch(error => {
                console.error('更新失败:', error);
                handleFail('showSearchTeach');
            });
    }

    function rebuildCourse(sno, cno, tno){
        const formData = new FormData();
        formData.append('Sno', sno);
        formData.append('Cno', cno);
        formData.append('Tno', tno);
        formData.append('score', '0');
        formData.append('status', '待审核');
        const searchParams = new URLSearchParams(formData);
        fetch('updateScore', {
            method: 'POST',
            body: searchParams
        })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    handleSuccess('showSearchTeach');
                }
                else{
                    handleFail('showSearchTeach');
                }
            })
            .catch(error => {
                console.error('更新失败:', error);
                handleFail('showSearchTeach');
            });
    }

    function dropCourse(sno, cno, tno){
        const formData = new FormData();
        formData.append('Sno', sno);
        formData.append('Cno', cno);
        formData.append('Tno', tno);
        const searchParams = new URLSearchParams(formData);
        fetch('deleteScore', {
            method: 'POST',
            body: searchParams
        })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    handleSuccess('showSearchTeach');
                }
                else{
                    handleFail('showSearchTeach');
                }
            })
            .catch(error => {
                console.error('更新失败:', error);
                handleFail('showSearchTeach');
            });
    }

    function showStudentScoreInfo(){
        const sno = '<%=user.getAccount()%>';
        const content = document.getElementById('content');
        content.innerHTML = '<div id="searchStudentScoreResult"></div>';

        const formData = new FormData();
        formData.append('Sno',sno);
        const searchParams = new URLSearchParams(formData);
        fetch('showStudentScore', {
            method: 'POST',
            body: searchParams
        })
            .then(response => response.json())
            .then(data => {
                console.log(data);
                const resultDiv = document.getElementById('searchStudentScoreResult');
                resultDiv.innerHTML = '';
                const mainTable = document.createElement('main');
                mainTable.setAttribute('class', 'table');
                const headerSection = document.createElement('section');
                headerSection.setAttribute('class','header');
                const headTitle =document.createElement('h1');
                headTitle.textContent='查询结果';
                headerSection.appendChild(headTitle);
                mainTable.appendChild(headerSection);
                const shellSection = document.createElement('section');
                shellSection.setAttribute('class','shell');
                const shellTable = document.createElement('table');
                const shellThead = document.createElement('thead');
                const headRow = document.createElement('tr');
                ['学号', '学生姓名', '专业号', '班级号', '课程号', '课程名称', '学分', '教师姓名', '成绩', '绩点'].forEach(headerText => {
                    const shellCell = document.createElement('th');
                    shellCell.textContent = headerText;
                    headRow.appendChild(shellCell);
                });
                shellThead.appendChild(headRow);
                shellTable.appendChild(shellThead);
                const shellTbody = document.createElement('tbody');
                data.forEach(item => {
                    const row = document.createElement('tr');
                    ['sno', 'sname', 'dno', 'clno', 'cno', 'cname', 'ccredit', 'tname', 'score', 'grade'].forEach(key => {
                        const cell = document.createElement('td');
                        cell.textContent = item[key];
                        row.appendChild(cell);
                    });
                    shellTbody.appendChild(row);
                });
                shellTable.appendChild(shellTbody);
                shellSection.appendChild(shellTable);
                mainTable.appendChild(shellSection);
                resultDiv.appendChild(mainTable);
            })
            .catch(error => {
                console.error('Error:', error);
            });


    }



    function showTeacherInfo(){
        const content = document.getElementById('content');
        content.innerHTML = '<div id="searchTeacherResult"></div>';
        const tno = '<%= user.getAccount()%>';
        const formData = new FormData();
        formData.append('Tno', tno);
        const searchParams = new URLSearchParams(formData);
        fetch('searchTeacher', {
            method: 'POST',
            body: searchParams
        })
            .then(response => response.json())
            .then(data => {
                console.log(data);
                const resultDiv = document.getElementById('searchTeacherResult');
                resultDiv.innerHTML = '';
                const mainTable = document.createElement('main');
                mainTable.setAttribute('class', 'table');
                const headerSection = document.createElement('section');
                headerSection.setAttribute('class','header');
                const headTitle =document.createElement('h1');
                headTitle.textContent='教师个人信息';
                headerSection.appendChild(headTitle);
                mainTable.appendChild(headerSection);
                const shellSection = document.createElement('section');
                shellSection.setAttribute('class','shell');
                const shellTable = document.createElement('table');
                const shellThead = document.createElement('thead');
                const headRow = document.createElement('tr');
                ['教师工号', '教师姓名', '教师性别', '教师出生日期', '教师职位', '教师电话'].forEach(headerText => {
                    const shellCell = document.createElement('th');
                    shellCell.textContent = headerText;
                    headRow.appendChild(shellCell);
                    shellThead.appendChild(headRow);
                });
                shellTable.appendChild(shellThead);
                const shellTbody = document.createElement('tbody');
                data.forEach(item => {
                    const row = document.createElement('tr');
                    ['tno', 'tname', 'tsex', 'tbirth', 'tposition', 'tphone'].forEach(key => {
                        const cell = document.createElement('td');
                        cell.textContent = item[key];
                        row.appendChild(cell);
                    });
                    shellTbody.appendChild(row);
                });
                shellTable.appendChild(shellTbody);
                shellSection.appendChild(shellTable);
                mainTable.appendChild(shellSection);
                resultDiv.appendChild(mainTable);
            })
            .catch(error => {
                console.error('Error:', error);
            });
    }

    function showSearchTeachAtTeacher(){
        const content = document.getElementById('content');
        const tno = '<%= user.getAccount()%>';
        content.innerHTML = '<h2>个人授课查询</h2>' +
            '<form id="searchTeachForm">' +
            '<input type="text" name="Cno" placeholder="课程号">' +
            '<input type="text" name="time" placeholder="授课时间">' +
            '<input type="number" name="maxnum" placeholder="最大人数">' +
            '<input type="number" name="choosenum" placeholder="已选人数">' +
            '<button type="submit">查询</button>' +
            '</form>' +
            '<div id="searchTeachResult"></div>';



        const searchTeachForm = document.getElementById('searchTeachForm');
        searchTeachForm.addEventListener('submit', function(event) {
            event.preventDefault();
            const formData = new FormData(this);
            formData.append('Tno',tno);
            const searchParams = new URLSearchParams(formData);
            fetch('searchTeach', {
                method: 'POST',
                body: searchParams
            })
                .then(response => response.json())
                .then(data => {
                    console.log(data);
                    const identify = '<%= user.getIdentify()%>';
                    const sno = '<%= user.getAccount()%>';
                    let cno= '';
                    let tno= '';
                    const resultDiv = document.getElementById('searchTeachResult');
                    resultDiv.innerHTML = '';
                    const mainTable = document.createElement('main');
                    mainTable.setAttribute('class', 'table');
                    const headerSection = document.createElement('section');
                    headerSection.setAttribute('class','header');
                    const headTitle =document.createElement('h1');
                    headTitle.textContent='查询结果';
                    headerSection.appendChild(headTitle);
                    mainTable.appendChild(headerSection);
                    const shellSection = document.createElement('section');
                    shellSection.setAttribute('class','shell');
                    const shellTable = document.createElement('table');
                    const shellThead = document.createElement('thead');
                    const headRow = document.createElement('tr');
                    ['课程号', '教师号', '授课时间', '最大人数', '已选人数', '操作'].forEach(headerText => {
                        const shellCell = document.createElement('th');
                        shellCell.textContent = headerText;
                        headRow.appendChild(shellCell);
                        shellThead.appendChild(headRow);
                    });
                    shellTable.appendChild(shellThead);
                    const shellTbody = document.createElement('tbody');
                    data.forEach(item => {
                        const row = document.createElement('tr');
                        ['cno', 'tno', 'time', 'maxnum', 'choosenum'].forEach(key => {
                            const cell = document.createElement('td');
                            cell.textContent = item[key];
                            row.appendChild(cell);
                        });
                        const actionCell = document.createElement('td');
                        const detailButton = document.createElement('button');
                        detailButton.setAttribute('class', 'button');
                        detailButton.textContent = '查看详情';
                        detailButton.addEventListener('click', () => {
                            // 调用退选 API 或相关逻辑
                            showTeachScoreDetails(item['cno'], item['tno']);
                        });
                        actionCell.appendChild(detailButton);
                        row.appendChild(actionCell);
                        shellTbody.appendChild(row);
                    });
                    shellTable.appendChild(shellTbody);
                    shellSection.appendChild(shellTable);
                    mainTable.appendChild(shellSection);
                    resultDiv.appendChild(mainTable);
                })
                .catch(error => {
                    console.error('Error:', error);
                });
        });
    }

    function showTeachScoreDetails(cno, tno){
        const content = document.getElementById('content');
        content.innerHTML = '<h2>详细课程信息</h2>' +
            '<form id="searchScoreForm">' +
            '<input type="text" name="Sno" placeholder="学号">' +
            '<input type="number" name="score" placeholder="成绩">' +
            '<input type="number" step="0.01" name="grade" placeholder="绩点">' +
            '<select name="status">'+
            '<option value="">状态</option>'+
            '<option value="待审核">待审核</option>'+
            '<option value="已选上">已选上</option>'+
            '<option value="已完成">已完成</option>'+
            '</select>'+
            '<button type="submit">查询</button>' +
            '</form>' +
            '<div id="searchScoreResult"></div>';

        const searchScoreForm = document.getElementById('searchScoreForm');
        searchScoreForm.addEventListener('submit', function(event) {
            event.preventDefault();
            const formData = new FormData(this);
            formData.append('Cno',cno);
            formData.append('Tno',tno);
            const searchParams = new URLSearchParams(formData);
            fetch('searchScore', {
                method: 'POST',
                body: searchParams
            })
                .then(response => response.json())
                .then(data => {
                    console.log(data);
                    const resultDiv = document.getElementById('searchScoreResult');
                    resultDiv.innerHTML = '';
                    const mainTable = document.createElement('main');
                    mainTable.setAttribute('class', 'table');
                    const headerSection = document.createElement('section');
                    headerSection.setAttribute('class','header');
                    const headTitle =document.createElement('h1');
                    headTitle.textContent='查询结果';
                    headerSection.appendChild(headTitle);
                    mainTable.appendChild(headerSection);
                    const shellSection = document.createElement('section');
                    shellSection.setAttribute('class','shell');
                    const shellTable = document.createElement('table');
                    const shellThead = document.createElement('thead');
                    const headRow = document.createElement('tr');
                    ['学号', '教师号', '课程号', '成绩', '绩点', '状态', '操作'].forEach(headerText => {
                        const shellCell = document.createElement('th');
                        shellCell.textContent = headerText;
                        headRow.appendChild(shellCell);
                        shellThead.appendChild(headRow);
                    });
                    shellTable.appendChild(shellThead);
                    const shellTbody = document.createElement('tbody');
                    data.forEach(item => {
                        const row = document.createElement('tr');
                        ['sno', 'tno', 'cno', 'score', 'grade', 'status'].forEach(key => {
                            const cell = document.createElement('td');
                            cell.textContent = item[key];
                            row.appendChild(cell);
                        });
                        const actionCell = document.createElement('td');
                        if(item['status'] === '已选上'){
                            const scoreForm = document.createElement('form');
                            scoreForm.setAttribute('id', 'scoreForm');

                            // 创建输入数字的 input
                            const scoreInput = document.createElement('input');
                            scoreInput.setAttribute('type', 'number');
                            scoreInput.setAttribute('name', 'score');
                            scoreInput.setAttribute('required', 'required');
                            scoreInput.setAttribute('placeholder', '输入分数');
                            // 创建 '登分' 按钮
                            const scoreButton = document.createElement('button');
                            scoreButton.setAttribute('class','four');
                            scoreButton.textContent = '登分';
                            scoreButton.addEventListener('click', (event) => {
                                event.preventDefault(); // 阻止表单提交
                                // 检查输入框是否为空
                                if (!scoreInput.value) {
                                    alert('请输入分数');
                                    return;
                                }
                                const score = scoreInput.value;
                                // 调用另一个函数并传递参数
                                submitScore(item['sno'], item['cno'], item['tno'], score);
                            });

                            // 将 input 和 button 添加到 form 中
                            scoreForm.appendChild(scoreInput);
                            scoreForm.appendChild(scoreButton);

                            actionCell.appendChild(scoreForm);
                        }
                        row.appendChild(actionCell);
                        shellTbody.appendChild(row);
                    });
                    shellTable.appendChild(shellTbody);
                    shellSection.appendChild(shellTable);
                    mainTable.appendChild(shellSection);
                    resultDiv.appendChild(mainTable);
                })
                .catch(error => {
                    console.error('Error:', error);
                });
        });
    }

    function submitScore(sno, cno, tno, score){
        const formData = new FormData();
        formData.append('Sno', sno);
        formData.append('Cno', cno);
        formData.append('Tno', tno);
        formData.append('score', score);
        formData.append('status', '已完成');
        const searchParams = new URLSearchParams(formData);
        fetch('updateScore', {
            method: 'POST',
            body: searchParams
        })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    handleSuccess('showSearchTeachAtTeacher');
                }
                else{
                    handleFail('showSearchTeachAtTeacher');
                }
            })
            .catch(error => {
                console.error('更新失败:', error);
                handleFail('showSearchTeachAtTeacher');
            });
    }

    function showTeacherStudentScoreInfo(){
        const tno = '<%=user.getAccount()%>';
        const content = document.getElementById('content');
        content.innerHTML = '<div id="searchTeacherStudentScoreResult"></div>';

        const formData = new FormData();
        formData.append('Tno',tno);
        const searchParams = new URLSearchParams(formData);
        fetch('showTeacherStudentScore', {
            method: 'POST',
            body: searchParams
        })
            .then(response => response.json())
            .then(data => {
                console.log(data);
                const resultDiv = document.getElementById('searchTeacherStudentScoreResult');
                resultDiv.innerHTML = '';
                const mainTable = document.createElement('main');
                mainTable.setAttribute('class', 'table');
                const headerSection = document.createElement('section');
                headerSection.setAttribute('class','header');
                const headTitle =document.createElement('h1');
                headTitle.textContent='查询结果';
                headerSection.appendChild(headTitle);
                mainTable.appendChild(headerSection);
                const shellSection = document.createElement('section');
                shellSection.setAttribute('class','shell');
                const shellTable = document.createElement('table');
                const shellThead = document.createElement('thead');
                const headRow = document.createElement('tr');
                ['学号', '学生姓名', '专业号', '班级号', '课程号', '课程名称', '教师工号', '教师姓名', '成绩'].forEach(headerText => {
                    const shellCell = document.createElement('th');
                    shellCell.textContent = headerText;
                    headRow.appendChild(shellCell);
                });
                shellThead.appendChild(headRow);
                shellTable.appendChild(shellThead);
                const shellTbody = document.createElement('tbody');
                data.forEach(item => {
                    const row = document.createElement('tr');
                    ['sno', 'sname', 'dno', 'clno', 'cno', 'cname', 'tno', 'tname', 'score'].forEach(key => {
                        const cell = document.createElement('td');
                        cell.textContent = item[key];
                        row.appendChild(cell);
                    });
                    shellTbody.appendChild(row);
                });
                shellTable.appendChild(shellTbody);
                shellSection.appendChild(shellTable);
                mainTable.appendChild(shellSection);
                resultDiv.appendChild(mainTable);
            })
            .catch(error => {
                console.error('Error:', error);
            });


    }

    function changePassword(){
        const account = '<%= user.getAccount()%>';
        const content = document.getElementById('content');
        content.innerHTML = '<h2>修改密码</h2>' +
            '<form id="changePasswordForm">' +
            '<input type="text" name="Password" placeholder="新密码" required>' +
            '<button type="submit">修改</button>' +
            '</form>';


        const form = document.getElementById('changePasswordForm');
        form.addEventListener('submit', function(event) {
            event.preventDefault();
            const formData = new FormData(form);
            formData.append('account' , account);
            const searchParams = new URLSearchParams(formData);
            fetch('changePassword', {
                method: 'POST',
                body: searchParams
            })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        handleSuccess('showUserInfo');
                    } else {
                        handleFail('showUserInfo');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    handleFail('showUserInfo');
                });
        });

    }


</script>
</body>
</html>
