<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Parts List</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
            text-align: center;
        }

        h1 {
            color: #333;
        }

        /* Search Box Container */
        .search-container {
            display: flex;
            justify-content: center;
            margin-bottom: 20px;
        }

        /* Search Box */
        #searchBox {
            padding: 12px;
            border: 1px solid #e8e9e8;
            border-radius: 4px;
            font-size: 16px;
            width: 100%;
            max-width: 400px;
        }

        /* Table Styling */
        table {
            width: 80%;
            margin: 0 auto;
            border-collapse: collapse;
            background: white;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            overflow: hidden;
        }

        th, td {
            padding: 12px;
            border: 1px solid #ddd;
            text-align: left;
        }

        th {
            background: #28a745;
            color: white;
            text-transform: uppercase;
            font-size: 14px;
            cursor: pointer;
        }

        tr:nth-child(even) {
            background: #f8f9fa;
        }

        tr:hover {
            background: #d4edda;
        }

        /* Modal Styling */
        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.8);
            padding-top: 0;
        }

        .modal-content {
            background-color: white;
            padding: 30px;
            box-sizing: border-box;
            width: 300px;
            margin: 100px auto;
            border-radius: 8px;
        }

        .close {
            color: #aaa;
            font-size: 28px;
            font-weight: bold;
            position: absolute;
            top: 10px;
            right: 20px;
        }

        .close:hover,
        .close:focus {
            color: black;
            cursor: pointer;
        }

        /* Form and Button Styling */
        .form-group {
            margin-bottom: 15px;
        }

        label {
            margin-bottom: 5px;
            font-weight: bold;
            display: inline-block;
        }

        input[type="text"], input[type="number"] {
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            width: calc(100% - 22px); /* Adjust to fit the padding/borders */
        }

        button {
            padding: 10px 20px;
            font-size: 16px;
            background-color: #28a745;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        button:hover {
            background-color: #218838;
        }

        /* Responsive Design */
        @media (max-width: 600px) {
            #searchBox {
                font-size: 14px;
            }

            table {
                width: 95%;
            }

            .modal-content {
                width: 90%;
            }
        }
    </style>
</head>
<body>

<h1>Parts</h1>

<!-- Search Box -->
<div class="search-container">
    <input type="text" id="searchBox" placeholder="Search parts by name..." onkeyup="filterTable()"/>
</div>

<table id="partsTable">
    <thead>
        <tr>
            <th onclick="sortTable(0)">Part ID</th>
            <th onclick="sortTable(1)">Part Name</th>
            <th onclick="sortTable(2)">Make/Buy</th>
            <th onclick="sortTable(3)">Part Number</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach items="${parts}" var="part">
        <tr onclick="openModal('${part.id}', '${part.name}', '${part.makeBuy}', '${part.itemNumber}')">
            <td>${part.id}</td>
            <td>${part.name}</td>
            <td>${part.makeBuy}</td>
            <td>${part.itemNumber}</td>
        </tr>
        </c:forEach>
    </tbody>
</table>

<!-- Modal -->
<div id="partModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeModal()">&times;</span>
        <h2>Part Details</h2>
        <div class="form-group">
            <label for="partId">Part ID</label>
            <input type="text" id="partId" name="partId" readonly />
        </div>
        <div class="form-group">
            <label for="partName">Part Name</label>
            <input type="text" id="partName" name="partName" readonly />
        </div>
        <div class="form-group">
            <label for="makeBuy">Make/Buy</label>
            <input type="text" id="makeBuy" name="makeBuy" readonly />
        </div>
        <div class="form-group">
            <label for="partNumber">Part Number</label>
            <input type="text" id="partNumber" name="partNumber" readonly />
        </div>
        <button type="button" onclick="submitForm()">Submit</button>
    </div>
</div>

<script>
    // Function to open modal and populate form
    function openModal(id, name, makeBuy, partNumber) {
        document.getElementById("partId").value = id;
        document.getElementById("partName").value = name;
        document.getElementById("makeBuy").value = makeBuy;
        document.getElementById("partNumber").value = partNumber;

        var modal = document.getElementById("partModal");
        modal.style.display = "block";
    }

    // Function to close modal
    function closeModal() {
        var modal = document.getElementById("partModal");
        modal.style.display = "none";
    }

    // Close modal if user clicks outside the modal
    window.onclick = function(event) {
        var modal = document.getElementById("partModal");
        if (event.target == modal) {
            closeModal();
        }
    }

    // Filter the table based on the search input
    function filterTable() {
        var searchQuery = document.getElementById("searchBox").value.toLowerCase();
        var rows = document.querySelectorAll("#partsTable tbody tr");

        rows.forEach(function(row) {
            var partName = row.cells[1].textContent.toLowerCase();
            row.style.display = partName.indexOf(searchQuery) !== -1 ? "" : "none";
        });
    }

    // Sort the table by a column index
    function sortTable(n) {
        var table = document.getElementById("partsTable");
        var rows = table.rows;
        var switching = true;
        var dir = "asc";
        while (switching) {
            switching = false;
            var shouldSwitch = false;
            for (var i = 1; i < (rows.length - 1); i++) {
                var x = rows[i].cells[n].textContent;
                var y = rows[i + 1].cells[n].textContent;
                if (dir === "asc" && x > y || dir === "desc" && x < y) {
                    shouldSwitch = true;
                    break;
                }
            }
            if (shouldSwitch) {
                rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
                switching = true;
            } else {
                if (dir === "asc") {
                    dir = "desc";
                    switching = true;
                }
            }
        }
    }
</script>

</body>
</html>