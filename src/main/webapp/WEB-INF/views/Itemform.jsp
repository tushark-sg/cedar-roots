<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
    background-color: #f4f4f4;
    display: flex;
    flex-direction: column;
    height: 100vh;
    padding: 20px;
    text-align: center;
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

/* Modal */
.modal {
    display: flex;
    flex-direction: row;
    height: 90%;
    overflow-y: auto;
    padding: 20px;
}

/* Properties Grid */
.properties-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
    gap: 6px;
}

.property-pair {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 2px;
}

label {
    flex: 1;
    margin-right: 4px;
    font-weight: bold;
}

input[type="text"], input[type="number"], input[type="date"] {
    flex: 1;
    padding: 4px;
    border: 1px solid #aaa;
    border-radius: 4px;
    background-color: #f9f9f9;
}
</style>
</head>

<body>
    <!-- Header -->
    <div class="top-bar">
        <img src="/Image/list.png" alt="Pin Icon" class="pin-button" id="pin-btn"
             style="width: 24px; height: 24px; cursor: pointer; margin-right: 10px;"
             onclick="toggleSidebar()" />
        <div class="logo">
            aras <span>INNOVATOR</span>
        </div>
        <input type="text" class="search-box" placeholder="Search...">
        <div class="user-icon">SU</div>
    </div>

    <!-- Main Content Area -->
    <div id="ItemModal" class="modal">
        <div class="properties-grid" id="propertiesContainer"></div>
    </div>

    <script>
    const properties = [
        { name: "firstName", datatype: "string", label: "First Name", value: "John" },
        { name: "lastName", datatype: "string", label: "Last Name", value: "Doe" },
        { name: "email", datatype: "string", label: "Email Address", value: "john.doe@example.com" },
        { name: "phoneNumber", datatype: "string", label: "Phone Number", value: "+1-234-567-890" },
        { name: "dateOfBirth", datatype: "date", label: "Date of Birth", value: "1990-05-20" },
        { name: "salary", datatype: "decimal", label: "Salary", value: 55000.75 },
        { name: "joiningDate", datatype: "date", label: "Joining Date", value: "2023-08-15" },
        { name: "department", datatype: "string", label: "Department", value: "Engineering" },
        { name: "projectCode", datatype: "string", label: "Project Code", value: "PRJ12345" },
        { name: "budget", datatype: "decimal", label: "Budget", value: 1200000.00 },
        { name: "isActive", datatype: "string", label: "Active Status", value: "true" },
        { name: "firstName", datatype: "string", label: "First Name", value: "John" },
        { name: "lastName", datatype: "string", label: "Last Name", value: "Doe" },
        { name: "email", datatype: "string", label: "Email Address", value: "john.doe@example.com" },
        { name: "phoneNumber", datatype: "string", label: "Phone Number", value: "+1-234-567-890" },
        { name: "dateOfBirth", datatype: "date", label: "Date of Birth", value: "1990-05-20" },
        { name: "salary", datatype: "decimal", label: "Salary", value: 55000.75 },
        { name: "joiningDate", datatype: "date", label: "Joining Date", value: "2023-08-15" },
        { name: "department", datatype: "string", label: "Department", value: "Engineering" },
        { name: "projectCode", datatype: "string", label: "Project Code", value: "PRJ12345" },
        { name: "budget", datatype: "decimal", label: "Budget", value: 1200000.00 },
        { name: "firstName", datatype: "string", label: "First Name", value: "John" },
        { name: "lastName", datatype: "string", label: "Last Name", value: "Doe" },
        { name: "email", datatype: "string", label: "Email Address", value: "john.doe@example.com" },
        { name: "phoneNumber", datatype: "string", label: "Phone Number", value: "+1-234-567-890" },
        { name: "dateOfBirth", datatype: "date", label: "Date of Birth", value: "1990-05-20" },
        { name: "salary", datatype: "decimal", label: "Salary", value: 55000.75 },
        { name: "joiningDate", datatype: "date", label: "Joining Date", value: "2023-08-15" },
        { name: "department", datatype: "string", label: "Department", value: "Engineering" },
        { name: "projectCode", datatype: "string", label: "Project Code", value: "PRJ12345" },
        { name: "budget", datatype: "decimal", label: "Budget", value: 1200000.00 },
        { name: "firstName", datatype: "string", label: "First Name", value: "John" },
        { name: "lastName", datatype: "string", label: "Last Name", value: "Doe" },
        { name: "email", datatype: "string", label: "Email Address", value: "john.doe@example.com" },
        { name: "phoneNumber", datatype: "string", label: "Phone Number", value: "+1-234-567-890" },
        { name: "dateOfBirth", datatype: "date", label: "Date of Birth", value: "1990-05-20" },
        { name: "salary", datatype: "decimal", label: "Salary", value: 55000.75 },
        { name: "joiningDate", datatype: "date", label: "Joining Date", value: "2023-08-15" },
        { name: "department", datatype: "string", label: "Department", value: "Engineering" },
        { name: "projectCode", datatype: "string", label: "Project Code", value: "PRJ12345" },
        { name: "budget", datatype: "decimal", label: "Budget", value: 1200000.00 },
        { name: "firstName", datatype: "string", label: "First Name", value: "John" },
        { name: "lastName", datatype: "string", label: "Last Name", value: "Doe" },
        { name: "email", datatype: "string", label: "Email Address", value: "john.doe@example.com" },
        { name: "phoneNumber", datatype: "string", label: "Phone Number", value: "+1-234-567-890" },
        { name: "dateOfBirth", datatype: "date", label: "Date of Birth", value: "1990-05-20" },
        { name: "salary", datatype: "decimal", label: "Salary", value: 55000.75 },
        { name: "joiningDate", datatype: "date", label: "Joining Date", value: "2023-08-15" },
        { name: "department", datatype: "string", label: "Department", value: "Engineering" },
        { name: "projectCode", datatype: "string", label: "Project Code", value: "PRJ12345" },
        { name: "budget", datatype: "decimal", label: "Budget", value: 1200000.00 },
        { name: "contractEndDate", datatype: "date", label: "Contract End Date", value: "2025-12-31" },
        { name: "performanceScore", datatype: "decimal", label: "Performance Score", value: 4.5 },
        { name: "address", datatype: "string", label: "Address", value: "123 Main St, Springfield" },
        { name: "zipCode", datatype: "string", label: "ZIP Code", value: "12345" }
    ];

    function createPropertyFields() {
        const container = document.getElementById('propertiesContainer');

        properties.forEach((prop, index) => {
            const propertyPair = document.createElement('div');
            propertyPair.className = 'property-pair';

            const label = document.createElement('label');
            label.setAttribute('for', `prop_${index + 1}`);
            label.textContent = prop.label;
            label.style.textAlign ="left" ;

            const input = document.createElement('input');
            input.type = prop.datatype === 'decimal' ? 'number' : (prop.datatype === 'date' ? 'date' : 'text');
            input.id = `prop_${index + 1}_id`;
            input.name = `prop_${index + 1}_value`;
            input.value = prop.value;
            input.readOnly = true;

            propertyPair.appendChild(label);
            propertyPair.appendChild(input);
            container.appendChild(propertyPair);
        });
    }

    document.addEventListener('DOMContentLoaded', createPropertyFields);
    </script>
</body>

</html>
