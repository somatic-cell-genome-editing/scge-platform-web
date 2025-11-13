<%--
  Created by IntelliJ IDEA.
  User: jthota
  Date: 8/21/2025
  Time: 4:04 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<style>
    /* Filter Sidebar Modern Styling */
    .filter-sidebar {
        background: #ffffff;
        border-radius: 12px;
        padding: 20px;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
        position: sticky;
        top: 20px;
    }

    .filter-sidebar > p {
        font-size: 1rem;
        font-weight: 600;
        color: #003366;
        margin-bottom: 20px;
        padding-bottom: 12px;
        border-bottom: 2px solid #0066cc;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .filter-sidebar > p strong {
        flex: 1;
    }

    .filter-sidebar .btn {
        background: #f8f9fa;
        border: 1px solid #dee2e6;
        color: #495057;
        transition: all 0.3s ease;
        padding: 6px 10px;
        border-radius: 6px;
        margin-left: 10px;
    }

    .filter-sidebar .btn:hover {
        background: #0066cc;
        border-color: #0066cc;
        color: #ffffff;
        transform: rotate(180deg);
    }

    .filter-sidebar .btn i {
        font-size: 0.9rem;
    }

    .filter-sidebar .form-label {
        color: #003366;
        font-weight: 600;
        font-size: 0.95rem;
        margin-bottom: 12px;
    }

    .filter-sidebar .form-check {
        margin-bottom: 10px;
        padding-left: 1.5rem;
        display: flex;
        align-items: center;
    }

    .filter-sidebar .form-check-input {
        width: 18px;
        height: 18px;
        margin-left: -1.5rem;
        margin-right: 0.5rem;
        cursor: pointer;
        border: 2px solid #ced4da;
        transition: all 0.2s ease;
        flex-shrink: 0;
    }

    .filter-sidebar .form-check-input:checked {
        background-color: #0066cc;
        border-color: #0066cc;
    }

    .filter-sidebar .form-check-input:focus {
        box-shadow: 0 0 0 0.2rem rgba(0, 102, 204, 0.25);
    }

    .filter-sidebar .form-check-label {
        font-size: 0.9rem;
        color: #495057;
        cursor: pointer;
        user-select: none;
        transition: color 0.2s ease;
    }

    .filter-sidebar .form-check-label:hover {
        color: #0066cc;
    }

    .filter-sidebar .form-check-label.Yes::before,.Yes::before {
        content: '✓';
        margin-right: 5px;
        color: #28a745;
        font-weight: bold;
    }

    .filter-sidebar .form-check-label.Maybe::before, .Maybe::before {
        content: '?';
        margin-right: 5px;
        color: darkorange;
        font-weight: bold;
        background-color: yellow;
    }

    .filter-sidebar .form-check-label.No::before, .No::before {
        content: '✗';
        margin-right: 5px;
        color: #dc3545;
        font-weight: bold;

    }

    .filter-sidebar .mb-3 {
        margin-bottom: 20px;
        padding-bottom: 15px;
        border-bottom: 1px solid #f1f1f1;
    }

    .filter-sidebar .mb-3:last-child {
        border-bottom: none;
    }

    /* Responsive */
    @media (max-width: 768px) {
        .filter-sidebar {
            position: relative;
            top: 0;
            margin-bottom: 20px;
        }
    }
</style>

<div class="filter-sidebar">
    <p>Filter By Requirement&nbsp;<button id="clearFiltersBtn" class="btn btn-sm" title="Clear All Filters"><i class="fa fa-refresh" aria-hidden="true"></i></button></p>
    <form>
    <!-- Group 1: Initial IND -->
    <div class="mb-3">
        <label class="form-label d-block"><strong>Initial IND Application</strong></label>

        <div class="form-check">
            <input class="form-check-input filter-checkbox-initial-ind " type="checkbox" value="yes" id="initial-ind-yes" checked>
            <label class="form-check-label Yes" for="initial-ind-yes">Yes</label>
        </div>
        <div class="form-check">
            <input class="form-check-input filter-checkbox-initial-ind " type="checkbox" value="maybe" id="initial-ind-maybe" checked>
            <label class="form-check-label Maybe" for="initial-ind-maybe">Maybe</label>
        </div>
        <div class="form-check">
            <input class="form-check-input filter-checkbox-initial-ind" type="checkbox" value="no" id="initial-ind-no">
            <label class="form-check-label  No" for="initial-ind-no">No</label>
        </div>


    </div>

    <!-- Group 2: Marketing Application -->
    <div class="mb-3">
        <label class="form-label d-block"><strong>Marketing</strong></label>

        <div class="form-check">
            <input class="form-check-input filter-checkbox-marketing" type="checkbox" value="yes" id="marketing-yes">
            <label class="form-check-label Yes" for="marketing-yes">Yes</label>
        </div>

<%--        <div class="form-check">--%>
<%--            <input class="form-check-input filter-checkbox-marketing" type="checkbox" value="no" id="marketing-no">--%>
<%--            <label class="form-check-label No" for="marketing-no">No</label>--%>
<%--        </div>--%>

<%--        <div class="form-check">--%>
<%--            <input class="form-check-input filter-checkbox-marketing" type="checkbox" value="maybe" id="marketing-maybe">--%>
<%--            <label class="form-check-label Maybe" for="marketing-maybe">Maybe</label>--%>
<%--        </div>--%>
    </div>
</form>
</div>

<script>
    $(function () {
        filterAllTables()
    })
    const initialINDCheckboxes=document.querySelectorAll('.filter-checkbox-initial-ind')
    const marketingCheckboxes=document.querySelectorAll('.filter-checkbox-marketing')
    const initialINDColumnIndex=5;
    const marketingColumnIndex=6;
    const moduleLabelColumnIndex=0;

    function filterAllTables() {
        const initialIndSelectedFilters = Array.from(initialINDCheckboxes)
            .filter(cb => cb.checked)
            .map(cb => cb.value.toLowerCase());
        const marketingSelectedFilters = Array.from(marketingCheckboxes)
            .filter(cb => cb.checked)
            .map(cb => cb.value.toLowerCase());

        const tables = document.querySelectorAll('.filterable-table');
        tables.forEach(table => {
            const rows = table.querySelectorAll('tbody tr');
            rows.forEach(row => {
                const labelRowText=row.cells[moduleLabelColumnIndex].textContent;
                console.log("labelRowTExt:"+ labelRowText);
                if(labelRowText==null || labelRowText===""){

                const indStatus = row.cells[initialINDColumnIndex].textContent.toLowerCase().trim(); // column index 5 = IND
                const marketingStatus = row.cells[marketingColumnIndex].textContent.toLowerCase().trim(); // column index 6 = marketing

                const matchIndStatus=initialIndSelectedFilters.includes(indStatus);
                const matchMarketingStatus=marketingSelectedFilters.includes(marketingStatus);
                if(initialIndSelectedFilters.length===0 && marketingSelectedFilters.length===0){
                    row.style.display =  '';
                }else {
                    row.style.display = (matchIndStatus || matchMarketingStatus) ? '' : 'none';

                }
            }});
        });


    }

    // Attach event listeners
    initialINDCheckboxes.forEach(cb => cb.addEventListener('change', filterAllTables));
    marketingCheckboxes.forEach(cb => cb.addEventListener('change', filterAllTables));

    // Clear All Filters
    document.getElementById('clearFiltersBtn').addEventListener('click', function () {
        // Uncheck all filter checkboxes
        document.querySelectorAll('.filter-checkbox-marketing').forEach(cb => cb.checked = false);
        document.querySelectorAll('.filter-checkbox-initial-ind').forEach(cb => cb.checked = false);

        // Show all rows in all tables
        document.querySelectorAll('.filterable-table tbody tr').forEach(row => {
            row.style.display = '';
        });
    });
</script>
