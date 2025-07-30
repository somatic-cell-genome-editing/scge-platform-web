    document.addEventListener("DOMContentLoaded", function () {
    document.getElementById("go-to-module1").addEventListener("click", function (e) {
        // e.preventDefault(); // Stop default jump
        const tabButton = document.querySelector('#module1-tab');
        if (tabButton) {
            const tab = new bootstrap.Tab(tabButton);
            tab.show();
            tabButton.focus(); // Optional: move focus to the tab
        }
    });
    document.getElementById("go-to-module2").addEventListener("click", function (e) {
    //  e.preventDefault(); // Stop default jump
    const tabButton = document.querySelector('#module2-tab');
    if (tabButton) {
    const tab = new bootstrap.Tab(tabButton);
    tab.show();
    tabButton.focus(); // Optional: move focus to the tab
}
});
    document.getElementById("go-to-module3").addEventListener("click", function (e) {
    // e.preventDefault(); // Stop default jump
    const tabButton = document.querySelector('#module3-tab');
    if (tabButton) {
    const tab = new bootstrap.Tab(tabButton);
    tab.show();
    tabButton.focus(); // Optional: move focus to the tab
}
});
    document.getElementById("go-to-module4").addEventListener("click", function (e) {
    // e.preventDefault(); // Stop default jump
    const tabButton = document.querySelector('#module4-tab');
    if (tabButton) {
    const tab = new bootstrap.Tab(tabButton);
    tab.show();
    tabButton.focus(); // Optional: move focus to the tab
}
});
    document.getElementById("go-to-module5").addEventListener("click", function (e) {
    // e.preventDefault(); // Stop default jump
    const tabButton = document.querySelector('#module5-tab');
    if (tabButton) {
    const tab = new bootstrap.Tab(tabButton);
    tab.show();
    tabButton.focus(); // Optional: move focus to the tab
}
});
});
