<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, java.util.Map" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Dynamic Table Display</title>
    <style>
        /* Global Styles */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }

        body {
            background-color: #fff;
            padding: 20px;
        }

        .top-bar {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 12px 20px;
            box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.1);
            margin-bottom: 10px;
        }

        .logo {
            font-size: 22px;
            font-weight: bold;
            color: black;
            display: flex;
            align-items: center;
        }

        .logo span {
            color: red;
            margin-left: 3px;
        }

        .search-box {
            flex: 1;
            margin: 0 20px;
            padding: 8px 12px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
        }

        .toolbar {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 10px;
        }

        .toolbar button,
        .toolbar select,
        .toolbar input {
            padding: 8px 12px;
            margin-right: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            cursor: pointer;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.1);
            margin-top: 20px;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: left;
        }

        th {
            background-color: #f4f4f4;
            cursor: pointer;
        }

        th.sortable::after {
            content: " ⬍";
            font-size: 12px;
            color: #888;
            margin-left: 5px;
        }

        tr:nth-child(even) {
            background-color: #fafafa;
        }

        tr:hover {
            background-color: #f0f0f0;
        }

        .overflow-scroll {
            overflow-x: scroll;
        }
    </style>
</head>
<body>
    <div class="top-bar">
        <div class="logo">aras <span>INNOVATOR</span></div>
        <input type="text" class="search-box" placeholder="Search...">
    </div>

    <div class="toolbar">
        <div>
            <button>🔍 Search</button>
            <button>❌ Clear</button>
            <select>
                <option>Simple</option>
                <option>Advanced</option>
            </select>
            <select>
                <option>Current</option>
                <option>All</option>
            </select>
            <input type="text" id="tableSearch" class="search-box" placeholder="Search table..." onkeyup="filterTable()">
        </div>
        <div>
            <button>⚙</button>
        </div>
    </div>

    <div class="overflow-scroll">
        <c:if test="${not empty tableData}">
            <table id="dataTable">
                <tr>
                    <c:forEach var="column" items="${tableData[0].keySet()}">
                        <th class="sortable" onclick="sortTable(this)">${column}</th>
                    </c:forEach>
                </tr>
                <c:forEach var="row" items="${tableData}">
                    <tr>
                        <c:forEach var="column" items="${row.keySet()}">
                            <td>${row[column]}</td>
                        </c:forEach>
                    </tr>
                </c:forEach>
            </table>
        </c:if>

        <c:if test="${empty tableData}">
            <p>No data found for this table.</p>
        </c:if>
    </div>

    <script>
        function filterTable() {
            var searchQuery = document.getElementById("tableSearch").value.toLowerCase();
            var rows = document.querySelectorAll("#dataTable tr");

            rows.forEach(function (row, index) {
                if (index === 0) return; // Skip header row
                var text = row.textContent.toLowerCase();
                row.style.display = text.includes(searchQuery) ? "" : "none";
            });
        }

        function sortTable(header) {
            var table = document.getElementById("dataTable");
            var rows = Array.from(table.rows).slice(1);
            var colIndex = Array.from(header.parentNode.children).indexOf(header);
            var asc = header.dataset.sortOrder !== 'asc';

            rows.sort((rowA, rowB) => {
                let cellA = rowA.cells[colIndex].textContent.trim();
                let cellB = rowB.cells[colIndex].textContent.trim();
                return asc ? cellA.localeCompare(cellB) : cellB.localeCompare(cellA);
            });

            rows.forEach(row => table.appendChild(row));
            header.dataset.sortOrder = asc ? 'asc' : 'desc';
        }
    </script>
</body>
</html>