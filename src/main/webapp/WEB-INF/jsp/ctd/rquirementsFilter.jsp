<%--
  Created by IntelliJ IDEA.
  User: jthota
  Date: 8/21/2025
  Time: 4:04 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<p><strong>Filter By Application Type</strong>&nbsp;<button id="clearFiltersBtn" class="btn btn-sm" title="Clear All Filters"><i class="fa fa-refresh" aria-hidden="true"></i></button></p>
<%--<button id="clearFiltersBtn" class="btn btn-secondary btn-sm mt-2">Clear All Filters</button>--%>
<form>
    <!-- Group 1: Initial IND -->
    <div class="mb-3">
        <label class="form-label d-block"><strong>Initial IND Application</strong></label>

        <div class="form-check">
            <input class="form-check-input filter-checkbox-initial-ind " type="checkbox" value="yes" id="initial-ind-yes">
            <label class="form-check-label Yes" for="initial-ind-yes">Yes</label>
        </div>

        <div class="form-check">
            <input class="form-check-input filter-checkbox-initial-ind" type="checkbox" value="no" id="initial-ind-no">
            <label class="form-check-label  No" for="initial-ind-no">No</label>
        </div>

        <div class="form-check">
            <input class="form-check-input filter-checkbox-initial-ind " type="checkbox" value="maybe" id="initial-ind-maybe">
            <label class="form-check-label Maybe" for="initial-ind-maybe">Maybe</label>
        </div>
    </div>

    <!-- Group 2: Marketing Application -->
    <div class="mb-3">
        <label class="form-label d-block"><strong>Marketing</strong></label>

        <div class="form-check">
            <input class="form-check-input filter-checkbox-marketing" type="checkbox" value="yes" id="marketing-yes">
            <label class="form-check-label Yes" for="marketing-yes">Yes</label>
        </div>

        <div class="form-check">
            <input class="form-check-input filter-checkbox-marketing" type="checkbox" value="no" id="marketing-no">
            <label class="form-check-label No" for="marketing-no">No</label>
        </div>

        <div class="form-check">
            <input class="form-check-input filter-checkbox-marketing" type="checkbox" value="maybe" id="marketing-maybe">
            <label class="form-check-label Maybe" for="marketing-maybe">Maybe</label>
        </div>
    </div>

</form>

<script>
    const initialINDCheckboxes=document.querySelectorAll('.filter-checkbox-initial-ind')
    const marketingCheckboxes=document.querySelectorAll('.filter-checkbox-marketing')
    const initialINDColumnIndex=5;
    const marketingColumnIndex=6;

    function filterAllTables() {
        const initialIndselectedFilters = Array.from(initialINDCheckboxes)
            .filter(cb => cb.checked)
            .map(cb => cb.value.toLowerCase());
        const marketingSelectedFilters = Array.from(marketingCheckboxes)
            .filter(cb => cb.checked)
            .map(cb => cb.value.toLowerCase());

        const tables = document.querySelectorAll('.filterable-table');
        tables.forEach(table => {
            const rows = table.querySelectorAll('tbody tr');
            rows.forEach(row => {
                const indStatus = row.cells[initialINDColumnIndex].textContent.toLowerCase().trim(); // column index 5 = IND
                const marketingStatus = row.cells[marketingColumnIndex].textContent.toLowerCase().trim(); // column index 6 = marketing

                const matchIndStatus=initialIndselectedFilters.includes(indStatus);
                const matchMarketingStatus=marketingSelectedFilters.includes(marketingStatus);
                if(initialIndselectedFilters.length===0 && marketingSelectedFilters.length===0){
                    row.style.display =  '';
                }else {
                    row.style.display = (matchIndStatus || matchMarketingStatus) ? '' : 'none';

                }
            });
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
