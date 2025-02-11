<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>API Caller - Permission & Item Fetch</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        .container {
            width: 50%;
            margin: auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 8px;
            box-shadow: 2px 2px 12px rgba(0, 0, 0, 0.1);
        }
        input, button {
            padding: 8px;
            margin: 5px 0;
            width: 100%;
        }
        button {
            background-color: #28a745;
            color: white;
            border: none;
            cursor: pointer;
        }
        button:hover {
            background-color: #218838;
        }
        #response {
            margin-top: 15px;
            padding: 10px;
            border: 1px solid #ddd;
            background-color: #f9f9f9;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Check User Permission</h2>
    <label for="userId">User ID:</label>
    <input type="text" id="userId" placeholder="Enter User ID">

    <label for="permissionId">Permission ID:</label>
    <input type="text" id="permissionId" placeholder="Enter Permission ID">

    <button onclick="checkPermission()">Check Permission</button>

    <div id="permissionResult"></div>

    <hr>

    <h2>Fetch Item Data</h2>
    <label for="itemType">Item Type Name:</label>
    <input type="text" id="itemType" placeholder="Enter item type (e.g., commandbarmenubutton)">

    <label for="itemId">Item ID:</label>
    <input type="text" id="itemId" placeholder="Enter Item ID">

    <button onclick="fetchItem()">Fetch Item</button>

    <div id="itemResult"></div>
</div>

<script>
    function checkPermission() {
        let userId = $("#userId").val();
        let permissionId = $("#permissionId").val();

        if (!userId || !permissionId) {
            alert("Please enter both User ID and Permission ID.");
            return;
        }

        $.ajax({
            url: "/api/permissions/check",
            type: "GET",
            data: { userId: userId, permissionId: permissionId },
            success: function(response) {
                $("#permissionResult").html("<b>Permission Check:</b> " + (response ? "✅ Granted" : "❌ Denied"));
            },
            error: function() {
                $("#permissionResult").html("<b>Error:</b> Unable to fetch permission data.");
            }
        });
    }

    function fetchItem() {
        let itemType = $("#itemType").val();
        let itemId = $("#itemId").val();

        if (!itemType || !itemId) {
            alert("Please enter both Item Type and Item ID.");
            return;
        }

        $.ajax({
            url: "/api/" + encodeURIComponent(itemType) + "/" + encodeURIComponent(itemId),
            type: "GET",
            success: function(response) {
                $("#itemResult").html("<b>Item Data:</b> " + JSON.stringify(response, null, 2));
            },
            error: function() {
                $("#itemResult").html("<b>Error:</b> Unable to fetch item data.");
            }
        });
    }
</script>

</body>
</html>
