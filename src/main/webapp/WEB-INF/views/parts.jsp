<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="t" tagdir="/WEB-INF/tags/" %>


            <style>
                body {
                    font-family: Arial, sans-serif;
                    background-color: #f4f4f4;
                    margin: 0;
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

                th,
                td {
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

                input[type="text"],
                input[type="number"] {
                    padding: 10px;
                    border: 1px solid #ddd;
                    border-radius: 4px;
                    width: calc(100% - 22px);
                    /* Adjust to fit the padding/borders */
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

                }
            </style>

            <script>

                // Filter the table based on the search input
                function filterTable() {
                    var searchQuery = document.getElementById("searchBox").value.toLowerCase();
                    var rows = document.querySelectorAll("#partsTable tbody tr");

                    rows.forEach(function (row) {
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
                const main = () => {
                    console.log("part.jsp loaded");
                    const search_box = document.querySelector("#searchBox")
                    const table_rows = [...document.querySelectorAll("#partsTable tbody tr")]
                    for (let row of table_rows) {
                        row.addEventListener("click", (row_ele) => {
                            // goto new tab
                            row_ele.getAttribute("id")
                            window.location.href = "http://localhost:8082/part/item?id="+ id
                        });

                        const table_header = document.querySelector("#partsTable thead tr");
                        table_header.addEventListener("click", (e) => {
                        });
                    }
                }
                document.addEventListener("DOMContentLoaded", (_e) => {
                    main()
                });
            </script>

            <h1>Parts</h1>

            <!-- Search Box -->
            <div class="search-container">
                <input type="text" id="searchBox" placeholder="Search parts by name..." />
            </div>

            <table id="partsTable">
                <thead>
                    <tr>
                        <th data-sort-by="id">Part ID</th>
                        <th data-sort-by="name">Part Name</th>
                        <th data-sort-by="make_buy">Make/Buy</th>
                        <th data-sort-by="item_number">Part Number</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${parts}" var="part">
                        <tr data-id="${part.id}">
                            <td>${part.id}</td>
                            <td>${part.name}</td>
                            <td>${part.makeBuy}</td>
                            <td>${part.itemNumber}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

