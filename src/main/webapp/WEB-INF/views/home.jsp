<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Aras Innovator UI</title>
            <style>
                /* Global Styles */
                * {
                    margin: 0;
                    padding: 0;
                    box-sizing: border-box;
                    font-family: Arial, sans-serif;
                }

                body {
                    background-color: #ffffff;
                    display: flex;
                    height: 100vh;
                    flex-direction: column;
                    /* Stack elements vertically */
                }

                /* Header */
                .header {
                    background-color: #ededee;
                    color: black;
                    text-align: center;
                    padding: 15px 0;
                    font-size: 24px;
                    font-weight: bold;
                    width: 100%;
                    /* Full width */
                    z-index: 1000;
                    /* Ensure it is above other content */
                }

                /* Main Content Area */
                .main-content {
                    display: flex;
                    /* Use flexbox for sidebar and content */
                    flex-grow: 1;
                    overflow-y: auto;
                }
                
                /* Sidebar */
                .sidebar {
                    width: 200px;
                    background-color: #2c3e50;
                    /* Dark Blue */
                    color: white;
                    padding: 20px;
                    display: flex;
                    flex-direction: column;
                    gap: 15px;
                    transition: left 0.3s ease;
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

                /* Top Navigation Bar */
                .top-bar {
                    display: flex;
                    align-items: center;
                    justify-content: space-between;
                    padding: 12px 20px;
                    box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.1);
                  
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

                /* Grid Container */
                .grid-container {
                    display: grid;
                    grid-template-columns: repeat(auto-fit, minmax(100px, 1fr));
                    gap: 15px;
                    padding: 20px;
                    max-width: 90%;
                    margin: auto;
                    text-align: center;
                    
                }

                /* Tile (Icon Container) */
                .grid-item {
                    background-color: rgb(247, 247, 247);
                    width: 100px;
                    height: 100px;
                    border-radius: 8px;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.2);
                    transition: 0.3s;
                    margin: auto;
                }

                .grid-item:hover {
                    background-color: #f0f0f0;
                }

                /* Name (Text) BELOW the Tile */
                .icon-text {
                    margin-top: 8px;
                    font-size: 14px;
                    font-weight: bold;
                    color: black;
                }

                /* Initials Styling */
                .initials {
                    font-size: 24px;
                    color: white;
                    font-weight: bold;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    width: 50px;
                    height: 50px;
                    background-color: #007BFF;
                    border-radius: 50%;
                }
                
                .content-area{
                overflow-y:scroll;
                }
            </style>
        </head>

        <body>

            <div class="top-bar">
		        <img src="/Image/list.png" alt="Pin Icon" class="pin-button" id="pin-btn"
		            style="width: 24px; height: 24px; cursor: pointer; margin-right: 10px;" onclick="toggleSidebar()" />
		        <div class="logo"><img class="logo-img" src="/Image/steepgraph-logo-black.png" alt="Logo"></img></div>
		        <input type="text" class="search-box" placeholder="Search...">
		        <div class="user-section">
		            <div class="user-icon">SU</div>
		        </div>
    		</div>

    <!-- Main Content Area -->
    <div class="main-content">
        <!-- Sidebar -->
        <div class="sidebar" id="sidebar">
            <!-- Sidebar items will be populated here by JavaScript -->
        </div>

        <!-- Content Area -->
        <div class="content-area" style="flex-grow: 1; padding: 20px;">
            <!-- Icons Grid -->
            <div class="grid-container" id="grid-container">
                <!-- Items will be populated here via JavaScript -->
            </div>
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
                    sidebarLink.href = '#'; // You can modify this if you have URLs for each item
                    sidebarLink.textContent = item.label; // Set the label from the API as link text
                    sidebar.appendChild(sidebarLink);
                });
            } catch (error) {
                console.error("Error fetching sidebar items:", error);
            }
        }

        // Function to fetch the items for "commandbarmenubutton" type and render them in the grid
        async function fetchItems() {
            try {
                const response = await fetch('/api/commandbarmenubutton/someItemId');
                const data = await response.json();

                const gridContainer = document.getElementById('grid-container');
                gridContainer.innerHTML = ''; // Clear any existing content

             // Loop through the data and create grid items
                data.forEach(item => {
                    const gridWrapper = document.createElement('div'); // Wrapper to group grid item and label
                    gridWrapper.style.textAlign = 'center'; // Center alignment for better UI

                    const gridItem = document.createElement('div');
                    gridItem.classList.add('grid-item');

                    // Create the link element (assuming each item has a URL)
                    const link = document.createElement('a');
                    link.href = '/part'; // Modify if you have specific URLs

                    // Check if item.image exists before using split
                    let imageName = 'DefaultItemType.svg 	'; // Fallback image in case item.image is null or undefined
                    if (item.image) {
                        imageName = item.image.split('/').pop(); // Extract last part after the last slash
                    }

                    // Create the image element
                    const img = document.createElement('img');
                    img.src = "/Image/" + imageName; // Use only the extracted file name
                    img.alt = item.label+ "Icon"; // Improve accessibility
                    img.style.width = '50px'; // Adjust size as needed
                    img.style.display = 'block'; // Ensures proper alignment
                    img.style.margin = '0 auto'; // Centers image in the grid item

                    // Append the image inside the link
                    link.appendChild(img);
                    gridItem.appendChild(link);

                    // Create text element (outside the grid item, below it)
                    const iconText = document.createElement('div');
                    iconText.classList.add('icon-text');
                    iconText.textContent = item.label; // Display the label
                    iconText.style.marginTop = '5px'; // Add spacing between grid and text

                    // Append grid item and text separately inside the wrapper
                    gridWrapper.appendChild(gridItem);
                    gridWrapper.appendChild(iconText); // Label is now outside and below the grid item

                    // Append the wrapper to the container
                    gridContainer.appendChild(gridWrapper);
                });
            } catch (error) {
                console.error("Error fetching data:", error);
            }
        }

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