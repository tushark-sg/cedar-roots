<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>GE Corella LITE</title>
            <link rel="stylesheet" href="/olm12/OAuthServer/css/style.css">
            <style>
                body {
                    line-height: 1.15;
                    -webkit-text-size-adjust: 100%;
                    --rem: 16;
                    margin: 0;
                    font-size: .75em;
                    font-family: Roboto, 'Noto Sans JP', Arial, sans-serif;
                    height: 100%;
                    min-width: 800px;
                    min-height: 480px;
                    background: radial-gradient(circle at 0 10%, #424680 5%, #0b144b 40%);
                    background-size: cover;
                    background-position: bottom right;
                    display: flex;
                    box-sizing: border-box;
                    align-items: center;
                    justify-content: center;
                    background-image: url("https://external.steepgraph.com/olm12/OAuthServer/images/loginBackground.jpg");
                }

                .login-area {
                    background: rgba(255, 255, 255, 0.9);
                    padding: 30px;
                    border-radius: 10px;
                    box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.2);
                    width: 400px;
                    text-align: center;
                    margin-top: 150px;
                }

                .login-area__logo {
                    background-image: url("https://external.steepgraph.com/olm12/OAuthServer/images/arasInnovator.svg");
                    background-size: contain;
                    background-repeat: no-repeat;
                    background-position: center;
                    height: 180px;
                    margin-bottom: -40px;
                    margin-top: -18px;
                }

                .login-area__version-info {
                    font-size: 12px;
                    color: #555;
                    margin-top: 5px;
                }

                .login-area__form {
                    display: flex;
                    flex-direction: column;
                    width: 100%;
                }

                .form-row {
                    display: flex;
                    flex-direction: column;
                    align-items: stretch;
                    margin-bottom: 0px;
                }

                .form-row input,
                .form-row select {
                    width: 95%;
                    padding: 10px;
                    margin: 10px 0;
                    border: 1px solid #ccc;
                    border-radius: 5px;
                }

                .password-container {
                    position: relative;
                    width: 100%;
                }

                .eye-icon {
                    position: absolute;
                    right: 10px;
                    top: 50%;
                    transform: translateY(-50%);
                    cursor: pointer;
                    font-size: 20px;
                    color: #007bff;
                }

                .login-btn-container {
                    display: flex;
                    justify-content: flex-end;
                    margin-top: 20px;
                }

                button {
                    background-color: #007bff;
                    color: white;
                    border: none;
                    padding: 8px 20px;
                    cursor: pointer;
                    border-radius: 5px;
                    font-size: 14px;
                }

                button:hover {
                    background-color: #0056b3;
                }

                .aras-site {
                    margin-top: 20px;
                    text-align: center;
                }

                .aras-site__link {
                    color: #007bff;
                    text-decoration: none;
                    font-size: 14px;
                }

                .eye-icon svg {
                    width: 20px;
                    height: 20px;
                }

                .login-area__error {
                    color: red;
                    margin-top: 10px;
                }
            </style>
        </head>

        <body>
            <div class="login-area" role="main">
                <div class="login-area__logo">
                    <img id="logo" src="/olm12/OAuthServer/images/arasInnovator.svg" hidden="">
                </div>

                <!-- Updated form action -->
                <form class="login-area__form" id="LoginForm" method="POST" action="/auth/login">
                    <div class="form-row">
                        <select id="Database" name="database">
                            <option selected="selected" value="Supplier">Supplier</option>
                            <option value="Client">Client</option>
                        </select>

                        <input type="text" required placeholder="Username" id="Username" name="login_name">

                        <div class="password-container">
                            <input type="password" autocomplete="off" required placeholder="Password" id="Password"
                                name="password">
                            <span class="eye-icon" id="togglePassword">
                                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"
                                    stroke="currentColor" width="24" height="24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                        d="M1 12s3-8 11-8 11 8 11 8-3 8-11 8-11-8-11-8z" />
                                    <circle cx="12" cy="12" r="3" stroke="currentColor" stroke-width="2"
                                        fill="currentColor" />
                                </svg>
                            </span>
                        </div>
                    </div>

                    <div class="login-btn-container">
                        <!-- Submit button -->
                        <button type="submit" id="Login">Login</button>
                    </div>
                </form>

                <!-- Error message display -->
                <div id="AuthError" class="login-area__error">
                    ${error}
                </div>

                <div class="aras-site">
                    <a class="aras-site__link" target="_blank" href="https://www.aras.com">www.aras.com</a>
                </div>

                <div class="login-area__version-info">
                    <span id="login.version_html">GE</span>
                    <span class="version-value">Corella</span>
                    <span id="login.build_html">LITE</span>
                    <span class="build-value">2024</span>
                </div>
            </div>

            <script>
                document.getElementById('togglePassword').addEventListener('click', function () {
                    const passwordField = document.getElementById('Password');
                    passwordField.type = passwordField.type === 'password' ? 'text' : 'password';
                });
                // document.querySelector("form.login-area__form").addEventListener("submit", (e) => {
                //     // e.preventDefault();
                //
                //     fetch("/auth/login", {
                //         method: "POST",
                //         body: JSON.stringify({
                //             password: document.getElementById("Password").value,
                //             login_name: document.getElementById("Username").value,
                //         }),
                //         headers :{
                //             "content-type":"application/json",
                //         }
                //     })
                //
                // })
            </script>

        </body>

        </html>
