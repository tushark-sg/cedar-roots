<!DOCTYPE html>
<script src="js/vanilla-js-tabs.js"></script>
<link rel="stylesheet" href="css/vanilla-js-tabs.css">


<div id="tab-master">
    <ul class="js-tabs__header">
    </ul>
    <section>
    </section>
</div>


<script>
    const tab_data = [
        {label: "Search - Parts", endpoint: "/part"},
        {label: "Part - mx-400", endpoint: "/parts"},
        {label: "Home", endpoint: "/home"},

    ];
    const tab_header = document.querySelector("#tab-master ul.js-tabs__header");
    const tab_cnt = document.querySelector("#tab-master > section");
    const await_tabs = []
    for (const [i, tab] of tab_data.entries()) {
        await_tabs.push(
            fetch(tab.endpoint)
                .then(x => x.text())
                .then((x) => {
                    const new_header = document.createElement("li")
                    new_header.innerHTML = `<a href='#' class='js-tabs__title'>\${tab.label}</a>`
                    new_tab = document.createElement("div");
                    new_tab.classList.add("js-tabs__content");
                    new_tab.innerHTML = x;
                    tab_cnt.appendChild(new_tab);
                    tab_header.appendChild(new_header);
                })
        );

    }
    Promise.all(await_tabs).then(
        () => {
            const tabs = new Tabs({
                "elem": "tab-master",
            });
        }
    )

</script>
