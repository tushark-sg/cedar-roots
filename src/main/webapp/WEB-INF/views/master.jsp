<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

            <t:master>
    <style>
        iframe {
            width: 100%;
            height: 100%;

        }

        #tab-master {
            height: 100%;
        }
        #tab-master > section {
            height: 100%;
        }
    </style>
                <script src="js/vanilla-js-tabs.js"></script>
                <link rel="stylesheet" href="css/vanilla-js-tabs.css">


                <div id="tab-master">
                    <ul class="js-tabs__header"> </ul>
                    <section>
                    </section>
                </div>


                <script>
                    const executeScripts = (container) => {
                        const scripts = container.querySelectorAll("script");
                        scripts.forEach(oldScript => {
                            const newScript = document.createElement("script");
                            if (oldScript.src) {
                                newScript.src = oldScript.src;
                                newScript.async = true; // Ensure async loading
                            } else {
                                newScript.textContent = oldScript.textContent;
                            }
                            document.body.appendChild(newScript); // Append to execute
                            oldScript.remove(); // Remove original script
                        });
                    };
                    const tab_data = [
                        {label: "Search - Parts", endpoint: "/part"},
                        {label: "Part - mx-400", endpoint: "/"},
                        {label: "Home", endpoint: "/home"},

                    ];
                    const tab_header = document.querySelector("#tab-master ul.js-tabs__header");
                    const tab_cnt = document.querySelector("#tab-master > section");

                    const await_tabs = [];
                    for (const [i, tab] of tab_data.entries()) {
                        const new_header = document.createElement("li");
                        new_header.innerHTML = `<a href='#' class='js-tabs__title'>\${tab.label}</a>`;
                        const new_tab = document.createElement("iframe");
                        new_tab.classList.add("js-tabs__content");
                        new_tab.src = tab.endpoint;
                        tab_cnt.appendChild(new_tab);
                        tab_header.appendChild(new_header);
                    }

                    const tabs = new Tabs({
                        "elem": "tab-master",
                    });

                </script>
            </t:master>
