<%--
  Created by IntelliJ IDEA.
  User: jthota
  Date: 8/21/2025
  Time: 4:04 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<link href="/platform/css/requirementsFilter.css" rel="stylesheet">

<div class="filter-bar">
    <span class="filter-title">Filter By Requirement</span>
    <div class="filter-groups">
        <div class="filter-group">
            <span class="filter-group-label">Initial IND Application:</span>
            <div class="filter-options">
                <div class="form-check form-check-inline">
                    <input class="form-check-input filter-checkbox-initial-ind" type="checkbox" value="yes" id="initial-ind-yes" checked>
                    <label class="form-check-label Yes" for="initial-ind-yes">Yes</label>
                </div>
                <div class="form-check form-check-inline">
                    <input class="form-check-input filter-checkbox-initial-ind" type="checkbox" value="maybe" id="initial-ind-maybe" checked>
                    <label class="form-check-label Maybe" for="initial-ind-maybe">Maybe</label>
                </div>
                <div class="form-check form-check-inline">
                    <input class="form-check-input filter-checkbox-initial-ind" type="checkbox" value="no" id="initial-ind-no">
                    <label class="form-check-label No" for="initial-ind-no">No</label>
                </div>
            </div>
        </div>
        <div class="filter-group">
            <span class="filter-group-label">Marketing:</span>
            <div class="filter-options">
                <div class="form-check form-check-inline">
                    <input class="form-check-input filter-checkbox-marketing" type="checkbox" value="yes" id="marketing-yes">
                    <label class="form-check-label Yes" for="marketing-yes">Yes</label>
                </div>
            </div>
        </div>
    </div>
    <button id="clearFiltersBtn" class="btn btn-sm btn-clear-filters" title="Clear All Filters"><i class="fa fa-refresh" aria-hidden="true"></i> Clear</button>
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
                // Check if the row contains a labelText element - these rows should be excluded from filtering
                const hasLabelText = row.querySelector('.labelText') !== null;

                if(hasLabelText) {
                    // Always show rows with labelText (section headers)
                    row.style.display = '';
                } else {
                    // Check if the cells have Yes/No/Maybe classes - only filter rows that have these
                    const indCell = row.cells[initialINDColumnIndex];
                    const marketingCell = row.cells[marketingColumnIndex];

                    const hasFilterableClass = (indCell && (indCell.querySelector('.Yes') || indCell.querySelector('.No') || indCell.querySelector('.Maybe'))) ||
                                              (marketingCell && (marketingCell.querySelector('.Yes') || marketingCell.querySelector('.No') || marketingCell.querySelector('.Maybe')));

                    if(!hasFilterableClass) {
                        // Rows without Yes/No/Maybe classes should always be visible
                        row.style.display = '';
                    } else {
                        // Apply filtering logic for rows with Yes/No/Maybe classes
                        const indStatus = indCell.textContent.toLowerCase().trim(); // column index 5 = IND
                        const marketingStatus = marketingCell.textContent.toLowerCase().trim(); // column index 6 = marketing

                        const matchIndStatus=initialIndSelectedFilters.includes(indStatus);
                        const matchMarketingStatus=marketingSelectedFilters.includes(marketingStatus);

                        if(initialIndSelectedFilters.length===0 && marketingSelectedFilters.length===0){
                            row.style.display =  '';
                        }else {
                            row.style.display = (matchIndStatus || matchMarketingStatus) ? '' : 'none';
                        }
                    }
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
