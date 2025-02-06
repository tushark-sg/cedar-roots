<%@tag description="Master shell page" pageEncoding="UTF-8"%>
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
        /* Sidebar */
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
        <!-- Updated pin button to image -->
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
            <a href="<%= request.getContextPath() %>/part">Parts</a>
            <a href="#">Feature Licenses</a>
            <a href="#">Forms</a>
            <a href="#">Grids</a>
            <a href="#">Identities</a>
            <a href="#">Item Types</a>
            <a href="#">Lists</a>
            <a href="#">Methods</a>
            <a href="#">Permissions</a>
            <a href="#">Reports</a>
        </div>

        <!-- Content Area -->
        <div class="content-area" style="flex-grow: 1; ">
                <jsp:doBody></jsp:doBody>
        </div>
            <!-- Icons Grid -->

    </div>

    <script>
        const sidebar = document.getElementById('sidebar');

        function toggleSidebar() {
            sidebar.classList.toggle('unpinned');  // Toggle 'unpinned' class
            if (sidebar.classList.contains('unpinned')) {
                sidebar.style.display = 'none'; // Hide sidebar
            } else {
                sidebar.style.display = 'flex'; // Show sidebar
            }
        }
    </script>
</body>
</html>

