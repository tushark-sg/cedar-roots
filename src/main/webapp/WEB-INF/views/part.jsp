<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Parts List</title>
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
                   
                }
                
                 .main-content {
                    display: flex;
                    /* Use flexbox for sidebar and content */
                  
                    overflow-y: auto;
                }

                /* Sidebar */
                 .sidebar {
			        width: 200px;
			        background-color: #2c3e50;
			        color: white;
			        padding: 10px;
			        display: flex;
			        flex-direction: column;
			        gap: 15px;
			        transition: left 0.3s ease;
			        margin-right: 20px; /* Add margin to the right */
			        overflow-y: scroll;
			    }
                .sidebar a {
                    color: #ecf0f1;
                    /* Lighter color for links */
                    text-decoration: none;
                    font-size: 16px;
                    font-weight: bold;
                    padding: 8px;
                    border-radius: 4px;
                    transition: background 0.3s;
                }

                .sidebar a:hover {
                    background-color: #34495e;
                    /* Darker hover color */
                }
                
                /* Adjust grid view to take full width when sidebar is hidden */
				    .grid-view {
				        flex: 1; /* Allow grid view to take remaining space */
				        transition: margin-left 0.3s ease; /* Smooth transition */
   						margin-right: 20px;
				        
				    }
				
				    /* When sidebar is unpinned, adjust grid view */
				    .sidebar.unpinned + .grid-view {
				        margin-left: 0; /* Remove margin when sidebar is hidden */
				    }

                /* Top Navigation Bar */
                .top-bar {
                    display: flex;
                    align-items: center;
                    justify-content: space-between;
                    padding: 12px 20px;
                    box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.1);
                    margin-bottom: 10px;
                }

               .logo {
                    color: black;
                    display: flex;
                    align-items: center;
                }
                
                .logo-img{
                  width: 140px;
                }
               
                .search-box {
                    flex: 1;
                    margin: 0 20px;
                    padding: 8px 12px;
                    border: 1px solid #ccc;
                    border-radius: 4px;
                    font-size: 14px;
                }

                .user-section {
                    display: flex;
                    align-items: center;
                }

                .user-icon {
                    width: 35px;
                    height: 35px;
                    background-color: #ccc;
                    border-radius: 50%;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    font-weight: bold;
                }


                /* Toolbar Styles */
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

                .search-box {
                    padding: 8px 12px;
                    width: 200px;
                    border: 1px solid #ccc;
                    border-radius: 4px;
                }

                /* Table Styles */
                table {
                    width: 100%;
                    border-collapse: collapse;
                    box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.1);
                }

                th,
                td {
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

                tr.selected {
                    background-color: #fffae5;
                }

                tr:nth-child(even) {
                    background-color: #fafafa;
                }

                tr:hover {
                    background-color: #f0f0f0;
                }

                /* Row Details Form */
                .row-details {
                    display: none;
                    margin-top: 20px;
                    background-color: #fafafa;
                    padding: 10px;
                    border: 1px solid #ddd;
                    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
                    position: relative;
                    
                }

                .row-details button {
                    background-color: #ff5c5c;
                    color: white;
                    padding: 8px 12px;
                    border: none;
                    border-radius: 4px;
                    cursor: pointer;
                }

                .row-details button:hover {
                    background-color: #f44336;
                }

                .close-btn {
                    position: absolute;
                    top: 10px;
                    right: 10px;
                    background: none;
                    border: none;
                    color: #ff5c5c;
                    font-size: 10px;
                    cursor: pointer;
                }

                /* Hide grid when form is shown */
                .no-grid {
                    display: none;
                }

                .no-toolbar {
                    display: none;
                }
                
                .form-row {
				    display: flex;
				    justify-content: space-between; /* Space between labels */
				    margin-bottom: 10px; /* Space between rows */
				}
				
				.form-row label {
				    flex: 1; /* Allow labels to take equal space */
				    margin-right: 10px; /* Space between labels */
				}
				
				.form-row label:last-child {
				    margin-right: 0; /* Remove margin for the last label */
				}
				
				.button-group {
				    display: flex;
				    justify-content: flex-end; /* Align buttons to the right */
				    margin-top: 20px; /* Space above buttons */
				    margin-bottom: 10px;
				}
				
				.button-group a,
				.button-group button {
				    margin-left: 5px; /* Space between buttons */
				    padding: 8px 12px; /* Button padding */
				    border: none; /* Remove default border */
				    border-radius: 4px; /* Button border radius */
				    cursor: pointer; /* Pointer cursor on hover */
				    text-decoration: none; /* Remove underline from anchor */
				    color: white; /* White text color */
				    display: inline-block; /* Ensure it behaves like a button */
				}

				
				.button-group button:hover {
				    background-color: #f0f0f0; /* Button hover effect */
				}
            </style>
        </head>

        <body>

            <!-- Toolbar (Search, Filters, Actions) -->

             <div class="top-bar">
		        <img src="/Image/list.png" alt="Pin Icon" class="pin-button" id="pin-btn"
		            style="width: 24px; height: 24px; cursor: pointer; margin-right: 10px;" onclick="toggleSidebar()" />
		        <div class="logo"><img class="logo-img" src="/Image/steepgraph-logo-black.png" alt="Logo"></img></div>
		        <input type="text" class="search-box" placeholder="Search...">
		        <div class="user-section">
		            <div class="user-icon">SU</div>
		        </div>
    		</div>
    		 <div class="toolbar" id="toolbar">
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
                    <input type="text" id="searchBox" class="search-box" placeholder="Search parts by name..."
                        onkeyup="filterTable()">
                </div>
                <div>
                    <button>⚙</button>
                </div>
            </div>
    		
    		<div class="main-content">
		       <div class="sidebar" id="sidebar"></div>
            <!-- Parts Table -->
            <div id="grid-view" class="grid-view">
                <table id="partsTable">
                    <thead>
                        <tr>  
                            <th class="sortable" onclick="sortTable(0)">Keyed Name</th>
                            <th class="sortable" onclick="sortTable(1)">Part Name</th>
                            <th class="sortable" onclick="sortTable(2)">Make/Buy</th>
                            <th class="sortable" onclick="sortTable(3)">Part Number</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${parts}" var="part">
                            <tr class="part-row" data-id="${part.id}" data-name="${part.name}"
                                data-makebuy="${part.makeBuy}" data-partnumber="${part.itemNumber}"
                                ondblclick="openDetailsForm(this)">
                                <td><a href="http://localhost/InnovatorServerRelease31/?StartItem=part:${part.id}" target="_blank">${part.keyedName}</a></td>
                                <td>${part.name}</td>
                                <td>${part.makeBuy}</td>
                                <td>${part.itemNumber}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <!-- Row Details Form -->
            <div id="row-details" class="row-details">
			    <button class="close-btn" id="close-btn">✖</button>
			    
			    <h3>Part Details</h3>
			    <div class="button-group">
			        <button type="button" id="edit-btn" onclick="openEditPage(document.getElementById('detail-id').value)">Edit</button>
			        <button type="button" id="delete-btn">Delete</button>
			    </div>
			    <form>
			        <div class="form-row">
			            <label>ID: <input type="text" id="detail-id" disabled></label>
			            <label>Name: <input type="text" id="detail-name" disabled></label>
			        </div>
			        <div class="form-row">
			            <label>Make/Buy: <input type="text" id="detail-makebuy" disabled></label>
			            <label>Part Number: <input type="text" id="detail-partnumber" disabled></label>
			        </div>
			        
			    </form>
			</div>
		  </div>
            <script>
            // Function to fetch the sidebar items from the API and populate them
            async function fetchSidebarItems() {
                try {
                    // Replace this URL with the actual API endpoint for the items
                    const response = await fetch('/api/commandbarmenubutton/someItemId');
                    const data = await response.json();

                    const sidebar = document.getElementById('sidebar');
                    sidebar.innerHTML = ''; // Clear any existing sidebar items

                    // Loop through the API data and create sidebar links
                    data.forEach(item => {
                        const sidebarLink = document.createElement('a');
                        sidebarLink.href = '/part'; // You can modify this if you have URLs for each item
                        sidebarLink.textContent = item.label; // Set the label from the API as link text
                        sidebar.appendChild(sidebarLink);
                    });
                } catch (error) {
                    console.error("Error fetching sidebar items:", error);
                }
            }
            
            function openEditPage(partId) {
            	const itemURL = "http://localhost/InnovatorServerRelease31?StartItem=part" + ":"+ partId;
                window.open(itemURL, '_blank');
            }
            
            
                function openDetailsForm(row) {
                    document.getElementById('detail-id').value = row.dataset.id;
                    document.getElementById('detail-name').value = row.dataset.name;
                    document.getElementById('detail-makebuy').value = row.dataset.makebuy;
                    document.getElementById('detail-partnumber').value = row.dataset.partnumber;

                    document.getElementById('grid-view').classList.add('no-grid');
                    document.getElementById('toolbar').classList.add('no-toolbar');
                    document.getElementById('row-details').style.display = 'block';
                }

                document.getElementById('close-btn').addEventListener('click', function () {
                    document.getElementById('row-details').style.display = 'none';
                    document.getElementById('grid-view').classList.remove('no-grid');
                    document.getElementById('toolbar').classList.remove('no-toolbar');
                });

                function filterTable() {
                    var searchQuery = document.getElementById("searchBox").value.toLowerCase();
                    var rows = document.querySelectorAll("#partsTable tbody tr");

                    rows.forEach(function (row) {
                        var partName = row.cells[1].textContent.toLowerCase();
                        row.style.display = partName.includes(searchQuery) ? "" : "none";
                    });
                }

                function sortTable(n) {
                    var table = document.getElementById("partsTable");
                    var rows = Array.from(table.rows).slice(1);
                    var asc = table.dataset.sortOrder !== 'asc';

                    rows.sort((rowA, rowB) => {
                        let cellA = rowA.cells[n].textContent.trim();
                        let cellB = rowB.cells[n].textContent.trim();
                        return asc ? cellA.localeCompare(cellB) : cellB.localeCompare(cellA);
                    });

                    rows.forEach(row => table.appendChild(row));
                    table.dataset.sortOrder = asc ? 'asc' : 'desc';
                }
                
                // This Fuction is for toggling 
                // Call the fetch functions when the page loads
        window.onload = function () {
            fetchSidebarItems(); // Fetch sidebar items
            fetchItems(); // Fetch items for the grid
        };
        const sidebar = document.getElementById('sidebar');

        function toggleSidebar() {
            sidebar.classList.toggle('unpinned');

            // Toggle visibility and opacity for smooth transition
            if (sidebar.classList.contains('unpinned')) {
                sidebar.style.visibility = 'hidden'; // Hide sidebar
                sidebar.style.opacity = '0'; // Make sidebar transparent
            } else {
                sidebar.style.visibility = 'visible'; // Show sidebar
                sidebar.style.opacity = '1'; // Make sidebar fully opaque
            }
        }
            </script>

        </body>

        </html>