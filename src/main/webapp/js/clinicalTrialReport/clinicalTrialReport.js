
    function updateNavbar() {
        let navbar = document.getElementById("navbar");
        let headings = document.querySelectorAll(".dynamic-heading");
        navbar.innerHTML = ""; // Clear existing links

        headings.forEach(function (heading) {
            let a = document.createElement("a");
            a.href = "#" + heading.id;
            a.textContent = heading.textContent;
            navbar.appendChild(a);
        });
    }
    // Show more functionality here
    document.addEventListener("DOMContentLoaded", function() {
    const toggleLink = document.getElementById("toggleDescription");
    const descriptionText = document.getElementById("descriptionText");

    // Function to check if the Description is overflowing (more than 3 lines)
    function isDescriptionOverflowing(element) {
        const computedStyle = getComputedStyle(element);
        const lineHeight = parseFloat(computedStyle.lineHeight);

        // Fallback if line-height is 'normal' or not set
        if (isNaN(lineHeight)) {
            const fontSize = parseFloat(computedStyle.fontSize);
            return element.scrollHeight > (fontSize * 1.2 * 3); // Approximate line-height
        }

        const maxHeight = lineHeight * 3; // 3 lines
        return element.scrollHeight > maxHeight;
    }

    // Initialize: Check if toggle is needed
    if (isDescriptionOverflowing(descriptionText)) {
        toggleLink.style.display = "inline"; // Show the toggle link
    }

    // Toggle Functionality
    toggleLink.addEventListener("click", function() {
    if (descriptionText.classList.contains("collapsed")) {
        descriptionText.classList.remove("collapsed");
        toggleLink.textContent = "(Show Less)";
    }
    else {
        descriptionText.classList.add("collapsed");
        toggleLink.textContent = "(Show More)";
    }
    });
    });

    //end of show more

    window.onload = function() {
    updateNavbar();
}
