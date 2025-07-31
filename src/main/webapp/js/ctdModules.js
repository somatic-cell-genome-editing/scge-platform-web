    document.addEventListener("DOMContentLoaded", function () {
        document.getElementById("go-to-module1").addEventListener("click", function (e) {
            tabContent('#module1-tab')});
        document.getElementById("go-to-module2").addEventListener("click", function (e) {
            tabContent('#module2-tab')});
        document.getElementById("go-to-module3").addEventListener("click", function (e) {
            tabContent('#module3-tab')});
        document.getElementById("go-to-module4").addEventListener("click", function (e) {
            tabContent('#module4-tab')});
        document.getElementById("go-to-module5").addEventListener("click", function (e) {
            tabContent('#module5-tab')});
        document.getElementById("module1-map").addEventListener("click", function (e) {
            tabContent('#module1-tab')})
        document.getElementById("module2-map").addEventListener("click", function (e) {
            tabContent('#module2-tab')})
        document.getElementById("module3-map").addEventListener("click", function (e) {
            tabContent('#module3-tab')})
        document.getElementById("module4-map").addEventListener("click", function (e) {
            tabContent('#module4-tab')})
        document.getElementById("module5-map").addEventListener("click", function (e) {
            tabContent('#module5-tab')});
});
function tabContent(module){
    const tabButton = document.querySelector(module);
    if (tabButton) {
        const tab = new bootstrap.Tab(tabButton);
        tab.show();
        tabButton.focus(); // Optional: move focus to the tab
    }
}
