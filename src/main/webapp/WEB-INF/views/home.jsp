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
            z-index: 1000;
        }

        /* Main Content Area */
        .main-content {
            display: flex;
            flex-grow: 1;
            overflow-y: auto;
        }

        /* Sidebar */
        .sidebar {
            width: 200px;
            background-color: #2c3e50; /* Dark Blue */
            color: white;
            padding: 20px;
            display: flex;
            flex-direction: column;
            gap: 15px;
            transition: transform 0.3s ease, opacity 0.3s ease;
            visibility: visible; /* Default visibility */
            opacity: 1; /* Sidebar is fully visible */
            overflow-y: auto; /* Allow scrolling */
            height: 100vh; /* Ensure sidebar takes full height */
        }

        .sidebar a {
            color: #ecf0f1;
            text-decoration: none;
            font-size: 16px;
            font-weight: bold;
            padding: 8px;
            border-radius: 4px;
            transition: background 0.3s;
        }

        .sidebar a:hover {
            background-color: #34495e; /* Darker hover color */
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
    </style>
</head>

<body>

    <!-- Header -->
    <div class="top-bar">
        <img src="/Image/list.png" alt="Pin Icon" class="pin-button" id="pin-btn"
            style="width: 24px; height: 24px; cursor: pointer; margin-right: 10px;" onclick="toggleSidebar()" />
        <div class="logo">aras <span>INNOVATOR</span></div>
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
 // Store the fetched data
 // Store the fetched data
let apiData = [];

// Function to fetch the data from the API
async function fetchData() {
    try {
        const response = await fetch('/api/commandbarmenubutton/someItemId');
        apiData = await response.json(); // Store the data globally

        // Once data is fetched, call the functions to render sidebar and grid
        renderSidebarItems(apiData);
        renderGridItems(apiData);
    } catch (error) {
        console.error("Error fetching data:", error);
    }
}

// Function to render the sidebar items
function renderSidebarItems(data) {
    const sidebar = document.getElementById('sidebar');
    sidebar.innerHTML = ''; // Clear any existing sidebar items

    // Loop through the data and create sidebar links
    data.forEach(item => {
        // Skip items where image is null
        if (item.image === null) {
            return;
        }
        
        const sidebarLink = document.createElement('a');
        sidebarLink.href = '#'; // You can modify this if you have URLs for each item
        sidebarLink.textContent = item.label; // Set the label from the API as link text
        sidebar.appendChild(sidebarLink);
    });
}

// Function to render the grid items (filtered by additional_data containing tocAccessId and non-null image)
function renderGridItems(data) {
    const gridContainer = document.getElementById('grid-container');
    gridContainer.innerHTML = ''; // Clear any existing content

    // Filter the data for items where additional_data is not null, contains 'tocAccessId' and image is not null
    const filteredData = data.filter(item => {
        return item.additional_data && item.additional_data.includes('tocAccessId') && item.image !== null;
    });

    // Loop through the filtered data and create grid items
    filteredData.forEach(item => {
        const gridItem = document.createElement('div');
        gridItem.classList.add('grid-item');
        
        const iconText = document.createElement('div');
        iconText.classList.add('icon-text');
        iconText.textContent = item.label; // Display the label of the item
        
        gridItem.appendChild(iconText);
        gridContainer.appendChild(gridItem);
    });
}

// Call the fetch function when the page loads
window.onload = function () {
    fetchData(); // Fetch data once and use it for both the sidebar and grid
};

// Function to toggle sidebar visibility
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