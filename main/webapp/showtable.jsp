<%--
  Created by IntelliJ IDEA.
  User: ASUS
  Date: 2024/7/5
  Time: 2:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Vertical Header Table</title>
  <style>
    table {
      border-collapse: collapse;
      width: 100%;
    }
    th, td {
      border: 1px solid black;
      padding: 8px;
      text-align: center;
    }
    th {
      background-color: #f2f2f2;
      height: 150px; /* Adjust the height as needed */
      vertical-align: bottom;
      position: relative;
    }
    th div {
      transform: rotate(-90deg);
      transform-origin: left bottom 0;
      white-space: nowrap;
      position: absolute;
      bottom: 0;
      left: 50%;
      margin-left: -50%;
    }
  </style>
</head>
<body>
<table>
  <thead>
  <tr>
    <th><div>课程号</div></th>
    <th><div>教师号</div></th>
    <th><div>学生号</div></th>
    <th><div>成绩</div></th>
    <th><div>评分</div></th>
    <th><div>状态</div></th>
  </tr>
  </thead>
  <tbody>
  <tr>
    <td>C001</td>
    <td>T001</td>
    <td>S001</td>
    <td>85</td>
    <td>4.0</td>
    <td>通过</td>
  </tr>
  <tr>
    <td>C002</td>
    <td>T002</td>
    <td>S002</td>
    <td>90</td>
    <td>4.5</td>
    <td>通过</td>
  </tr>
  <!-- 更多行 -->
  </tbody>
</table>
</body>
</html>
