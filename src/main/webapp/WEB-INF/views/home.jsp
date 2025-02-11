<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Aras Innovator</title>
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
            
        }

      /* Sidebar should have its own scrollbar */
.sidebar {
    width: 200px;
    background-color: #2c3e50;
    color: white;
    padding: 20px;
    display: flex;
    flex-direction: column;
    gap: 15px;
    height: 100vh; /* Full height */
    overflow-y: auto; /* Scrollbar for sidebar */
}

/* Ensure content area scrolls independently */
.content-area {
    flex-grow: 1;
    padding: 20px;
    height: 100vh; /* Full height */
    overflow-y: auto; /* Scroll only within content area */
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
        .sidebar ul {
            list-style: none;
        }
        .sidebar ul li {
            padding: 10px;
            cursor: pointer;
            border-bottom: 1px solid rgba(255,255,255,0.1);
            position: relative;
        }
        .sidebar ul li:hover {
            background-color: #34495e;
        }
        .submenu {
            display: none;
            padding-left: 15px;
        }
        
        .expand-icon {
            position: absolute;
            right: 10px;
            cursor: pointer;
        }
        
        .expanded > .submenu {
            display: block;
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

  let validChildIds = new Set(); // Store valid child IDs from the sidebar
  let menuTree = [];

//Function to fetch the sidebar items from the API and populate them
async function fetchSidebarItems() {
   try {
       console.log("Fetching sidebar data...");

       const response = await fetch('/api/commandbarmenubutton/someItemId');
       const firstJson = await response.json();
       console.log("commandbarmenubutton Data:", firstJson);

       const response1 = await fetch('/api/commandbarmenu/someItemId');
       const secondJson = await response1.json();
       console.log("commandbarmenu Data:", secondJson);

       if (!firstJson.length && !secondJson.length) {
           console.error("No sidebar data received!");
           return;
       }

       menuTree = buildTree(secondJson, firstJson);
       console.log("Generated menu tree:", menuTree);

       // Extract valid child IDs
       extractValidChildIds(menuTree);

       // Call fetchItems after sidebar is ready
       fetchItems();

       const menuContainer = document.getElementById("sidebar");
       menuContainer.innerHTML = "";
       generateMenu(menuTree, menuContainer);
   } catch (error) {
       console.error("Error fetching sidebar items:", error);
   }
}
function mapJsonById(json1, json2) {
    // Convert json2 into a Set for quick lookup
    const idSet = new Set(json2.map(item => item.id));
    
    // Filter json1 to keep only those elements whose id exists in json2
    const matchedData = json1.filter(item => idSet.has(item.id));
    
    return matchedData;
}
function getExtremeChildNodes(jsonData) {
    let extremeChildren = [];
    
    function traverse(node) {
        if (!node.children || node.children.length === 0) {
            extremeChildren.push({
                "id": node.id,
                "name": node.label,               
            });
        } else {
            node.children.forEach(child => traverse(child));
        }
    }
    
    jsonData.forEach(node => traverse(node));
    
    console.log("extremeChildren", extremeChildren);
    
    return extremeChildren;
}
  
  
//Function to extract valid child IDs from the tree
function extractValidChildIds(tree) {
   tree.forEach(parent => {
       parent.children.forEach(child => {
           validChildIds.add(child.id); // Store the child's ID
           if (child.children.length > 0) {
               extractValidChildIds([child]); // Recursive call for deeper levels
           }
       });
   });
}

async function fetchItems() {
    try {
        const response = await fetch('/api/commandbarmenubutton/someItemId');
        const data = await response.json();

        const gridContainer = document.getElementById('grid-container');
        gridContainer.innerHTML = ''; // Clear existing content

   

        // Filter items that are valid children in the sidebar
        // const filteredData = data.filter(item => validChildIds.has(item.id));
        let filteredData = getExtremeChildNodes(menuTree);
		filteredData = mapJsonById(data, filteredData);
		console.log("filteredData", filteredData);
        
        // Loop through filtered data and create grid items (only if not already added)
        let counter = 0;
        filteredData.forEach(item => {
        		
                const gridWrapper = document.createElement('div'); // Wrapper for item and label
                gridWrapper.style.textAlign = 'center'; // Center alignment

                const gridItem = document.createElement('div');
                gridItem.classList.add('grid-item');

                const link = document.createElement('a');
               
                    console.log("counter", counter++);
                    
                    if(item.additionalData) {
                    	console.log("counter-in", counter);
	                    let jsonObject = JSON.parse(item.additionalData);
	                    let itemTypeId = jsonObject.itemTypeId;
	
	                    // Store the base path from JSP safely
	                    let basePath = "<%= request.getContextPath() %>";
	
	                    // Make an API call to get the table name dynamically
	                    fetch(basePath + "/getTableNameByItemtypeId?itemtypeId=" + encodeURIComponent(itemTypeId))
	                        .then(response => response.text())  // Expecting plain text response
	                        .then(tableName => {
	                        	
	                        	debugger;
	                        	console.log("tableName", tableName);
	                            // Ensure proper encoding in JavaScript
	                            let encodedTableName = encodeURIComponent(tableName.trim().replace(/\s+/g, "_"));
	
	                            // Set the href dynamically
	                            link.href = basePath + "/displayTable?tableName=" + encodedTableName;
	                        })
	                        .catch(error => {
	                            console.error("Error fetching table name:", error);
	                            link.href = "#"; // Fallback if there's an error
	                        });
                    }
                


                


                let imageName = 'DefaultItemType.svg'; // Default image fallback
                if (item.image) {
                    imageName = item.image.split('/').pop(); // Extract last part after '/'
                }

                const img = document.createElement('img');
                img.src = "/Image/" + imageName;
                img.alt = item.label + " Icon";
                img.style.width = '50px';
                img.style.display = 'block';
                img.style.margin = '0 auto';

                link.appendChild(img);
                gridItem.appendChild(link);

                const iconText = document.createElement('div');
                iconText.classList.add('icon-text');
                iconText.textContent = item.label;
                iconText.style.marginTop = '5px';

                gridWrapper.appendChild(gridItem);
                gridWrapper.appendChild(iconText);
                gridContainer.appendChild(gridWrapper);
            
        });

    } catch (error) {
        console.error("Error fetching data:", error);
    }
}

function hyperlinkGenerator() {
	const link = document.createElement('a');
	
    let basePath = "<%= request.getContextPath() %>";
}


//Function to build a tree from parent and child elements (sorted alphabetically)
function buildTree(parents, children) {
   let lookup = {};
   let tree = [];

   // Initialize lookup table for parents
   parents.forEach(item => {
       lookup[item.id] = { 
           id: item.id, 
           label: item.keyedName || item.label, 
           additionalData: item.additionalData,
           children: [] 
       };
   });

   // Organize parents into a tree structure
   parents.forEach(item => {
       if (item.parent_menu !== null && lookup[item.parent_menu]) {
           lookup[item.parent_menu].children.push(lookup[item.id]);
       } else {
           tree.push(lookup[item.id]);
       }
   });

   // Attach children to their respective parent nodes
   children.forEach(item => {
       if (item.parent_menu !== null && lookup[item.parent_menu]) {
           lookup[item.parent_menu].children.push({ 
               id: item.id, 
               label: item.keyedName || item.label, 
               additionalData: item.additionalData,
               children: [] 
           });
       }
   });

   // Remove parent menus that don't have children
   tree = tree.filter(parent => parent.children.length > 0);

   // Sort the tree alphabetically
   function sortTree(nodeArray) {
       nodeArray.sort((a, b) => a.label.localeCompare(b.label));
       nodeArray.forEach(node => {
           if (node.children.length > 0) {
               sortTree(node.children);
           }
       });
   }
   sortTree(tree);

   return tree;
}


function generateMenu(tree, parentElement) {
    let ul = document.createElement("ul");
    parentElement.appendChild(ul);

    tree.forEach(item => {
        let li = document.createElement("li");
        li.style.listStyleType = "none"; // Remove dots for parent menus

        const link = document.createElement("a");
        link.textContent = item.label;
        link.href = "#"; // Default href to prevent broken links

        if (item.additionalData) {
            try {
                let jsonObject = JSON.parse(item.additionalData);
                let itemTypeId = jsonObject.itemTypeId;

                // Store the base path from JSP safely
                let basePath = "<%= request.getContextPath() %>";

                // Make an API call to get the table name dynamically
                fetch(basePath + "/getTableNameByItemtypeId?itemtypeId=" + encodeURIComponent(itemTypeId))
                    .then(response => response.text()) // Expecting plain text response
                    .then(tableName => {
                        console.log("Fetched Table Name:", tableName);
                        
                        let encodedTableName = encodeURIComponent(tableName.trim().replace(/\s+/g, "_"));
                        link.href = basePath + "/displayTable?tableName=" + encodedTableName;
                    })
                    .catch(error => {
                        console.error("Error fetching table name:", error);
                    });
            } catch (err) {
                console.error("Invalid JSON in additionalData:", err);
            }
        }

        li.appendChild(link); // Append the link inside the li

        if (item.children && item.children.length > 0) {
            let expandIcon = document.createElement("span");
            expandIcon.textContent = "+";
            expandIcon.classList.add("expand-icon");
            li.prepend(expandIcon);

            let submenu = document.createElement("ul");
            submenu.classList.add("submenu");
            generateMenu(item.children, submenu);
            li.appendChild(submenu);

            // Toggle expand/collapse behavior
            li.addEventListener("click", function (e) {
                e.stopPropagation();
                li.classList.toggle("expanded");
                expandIcon.textContent = li.classList.contains("expanded") ? "−" : "+";
            });
        }

        ul.appendChild(li); // Append li to ul
    });
}


//Function to toggle sidebar visibility
function toggleSidebar() {
   const sidebar = document.getElementById('sidebar');
   sidebar.classList.toggle('unpinned');

   // Toggle visibility and opacity for a smooth transition
   if (sidebar.classList.contains('unpinned')) {
       sidebar.style.display = 'none'; // Hide sidebar
   } else {
       sidebar.style.display = 'block'; // Show sidebar
   }
}

//Call fetchSidebarItems first, then fetchItems
window.onload = function () {
   fetchSidebarItems(); // Fetch sidebar items
};

</script>

</body>
</html>