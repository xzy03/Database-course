<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>用户操作界面</title>
  <style>
    /** {*/
    /*  margin: 0;*/
    /*  padding: 0;*/
    /*  box-sizing: border-box;*/
    /*}*/
    /*body {*/
    /*  min-height: 100vh;*/
    /*  display: flex;*/
    /*  justify-content: center;*/
    /*  align-items: center;*/
    /*}*/

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
      border:none;
      outline: none;
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
<main class="table">
  <section class="header">
    <h1>用户信息</h1>
    <div class="input-group">
      <input type="search" placeholder="Search Data...">
    </div>
  </section>
  <section class="shell">
    <table>
      <thead>
      <tr>
        <th>ID</th>
        <th>姓名</th>
        <th>年龄</th>
        <th>性别</th>
      </tr>
      </thead>
      <tbody>
      <tr>
        <td>001</td>
        <td>张三</td>
        <td>20</td>
        <td>男</td>
      </tr>
      <tr>
        <td>002</td>
        <td>李四</td>
        <td>22</td>
        <td>女</td>
      </tr>
      <tr>
        <td>003</td>
        <td>王五</td>
        <td>21</td>
        <td>男</td>
      </tr>
      <tr>
        <td>001</td>
        <td>张三</td>
        <td>20</td>
        <td>男</td>
      </tr>
      <tr>
        <td>002</td>
        <td>李四</td>
        <td>22</td>
        <td>女</td>
      </tr>
      <tr>
        <td>003</td>
        <td>王五</td>
        <td>21</td>
        <td>男</td>
      </tr>
      <tr>
        <td>001</td>
        <td>张三</td>
        <td>20</td>
        <td>男</td>
      </tr>
      <tr>
        <td>002</td>
        <td>李四</td>
        <td>22</td>
        <td>女</td>
      </tr>
      <tr>
        <td>003</td>
        <td>王五</td>
        <td>21</td>
        <td>男</td>
      </tr>
      </tbody>
    </table>
  </section>
</main>

</body>
</html>
