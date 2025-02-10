
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
    //delete button in ext links section
    function deleteExtLink(linkId) {
        if (confirm('Are you sure you want to delete this link?')) {
            const row = document.getElementById('link-' + linkId);
            const deleteFlag = document.getElementById('deleteFlag-' + linkId);
            deleteFlag.value = linkId;
            deleteFlag.disabled = false;
            row.style.display = 'none';
        }
    }
    //add new link
    let newRowCounter = 0;
    function addNewLink() {
        const tbody = document.querySelector('.ext-links-table tbody');
        const newRow = document.createElement('tr');
        const tempId = `new-${newRowCounter}`;
        newRow.innerHTML = `
        <input type="hidden" name="newLinkId" value="${tempId}">
        <td>     
            <select name="newExtLink_${tempId}" class="form-control">
<!--                <option value="Grant">Grant</option>-->
                <option value="Protocol">Protocol</option>
                <option value="Preclinical Publications">Preclinical Publications</option>
                <option value="News and Press Releases">News and Press Releases</option>
                <option value="Clinical Publications">Clinical Publications</option>
            </select>
        </td>
        <td><textarea name="newLinkName_${tempId}" class="form-control" rows="1"></textarea></td>
        <td><textarea name="newLink_${tempId}" class="form-control" rows="1"></textarea></td>
        <td><button type="button" class="btn btn-danger" onclick="if (confirm('Are you sure you want to delete this link?')){this.closest('tr').remove()}">Delete</button></td>
    `;
        tbody.appendChild(newRow);
        newRowCounter++;
    }

    function validateForm(){
        let formIsValid = true;

        //validate external links
        document.querySelectorAll('.ext-links-table tbody tr').forEach(row => {
            const linkNameField = row.querySelector('textarea[name^="linkName"], textarea[name^="newLinkName_"]');
            if (linkNameField && linkNameField.value.trim() === '') {
                alert('Link Name cannot be empty');
                formIsValid = false;
            }
        });

        //validate patents
        const patents = document.querySelector('textarea[name="patents"]').value.trim();
        if (patents) {
            const patentArray = patents.split(/[,]/).map(p => p.trim()).filter(Boolean);
            if (patentArray.length > 1) {
                alert('Multiple patents should be separated by semicolons (;)');
                formIsValid = false;
            }
        }
        return formIsValid;
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

    //Form input color change
        const textareas = document.querySelectorAll('textarea.form-control,select.form-control');
        textareas.forEach(textarea =>{
            const originalValue = textarea.value;

            textarea.addEventListener('input',function (){
                if(this.value!==originalValue){
                    this.style.backgroundColor = '#fff3e0';
                    this.classList.add('modified');
                }
                else{
                    this.style.backgroundColor = '';
                    this.classList.remove('modified');
                }
            })
        });

    });

    //end of show more

    window.onload = function() {
    updateNavbar();
}
