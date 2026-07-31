<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--
  Graphical overview of the ENTIRE result set (not the current page). The
  distributions in `overviewAggs` are computed server-side by
  ClinicalTrialsService.getOverviewDistributions over every document matching
  the current search + filters, so the charts describe all results, not just
  the paginated hits. Included once from resultsview.jsp inside the
  #overviewView tab-pane, so it shares that page's imports plus the `gson` and
  `totalHits` variables already in scope.
--%>
<%!
    // Sort by count desc; keep top n, roll the remainder into "Other".
    private java.util.LinkedHashMap<String,Integer> topN(java.util.Map<String,Integer> m, int n){
        if(m == null) return new java.util.LinkedHashMap<>();
        java.util.List<java.util.Map.Entry<String,Integer>> e = new java.util.ArrayList<>(m.entrySet());
        e.sort((a,b) -> Integer.compare(b.getValue(), a.getValue()));
        java.util.LinkedHashMap<String,Integer> out = new java.util.LinkedHashMap<>();
        int other = 0, i = 0;
        for(java.util.Map.Entry<String,Integer> en : e){
            if(i < n) out.put(en.getKey(), en.getValue());
            else other += en.getValue();
            i++;
        }
        if(other > 0) out.put("Other", other);
        return out;
    }
    private java.util.Map<String,Integer> ovGet(Object aggs, String key){
        if(aggs instanceof java.util.Map){
            Object m = ((java.util.Map<?,?>) aggs).get(key);
            if(m instanceof java.util.Map) return (java.util.Map<String,Integer>) m;
        }
        return new java.util.LinkedHashMap<>();
    }
%>
<%
    Object ovAggs = request.getAttribute("overviewAggs");
    java.util.Map<String,Integer> ovTherapy    = ovGet(ovAggs, "therapy");
    java.util.Map<String,Integer> ovPhase       = ovGet(ovAggs, "phase");
    java.util.Map<String,Integer> ovStatus      = ovGet(ovAggs, "status");
    java.util.Map<String,Integer> ovSponsor     = ovGet(ovAggs, "sponsor");
    java.util.Map<String,Integer> ovVector      = ovGet(ovAggs, "vector");
    java.util.Map<String,Integer> ovIndication  = ovGet(ovAggs, "indication");

    long ovCount = totalHits;
%>
<style>
    .overview-wrap { padding: 1rem 0.25rem 0.5rem; }
    .overview-caption { color:#64748b; font-size:0.85rem; margin-bottom:1rem; }
    .overview-hint { color:#2563eb; margin-left:0.4rem; }
    .overview-grid {
        display:grid;
        grid-template-columns:repeat(auto-fit, minmax(320px, 1fr));
        gap:1rem;
    }
    .overview-card {
        border:1px solid #e2e8f0;
        border-radius:10px;
        background:#fff;
        padding:0.85rem 1rem 1rem;
        box-shadow:0 1px 2px rgba(0,0,0,0.04);
        min-width:0;
    }
    .overview-card h5 {
        font-size:0.95rem;
        font-weight:600;
        color:#1e293b;
        margin:0 0 0.6rem;
        display:flex;
        align-items:center;
        gap:0.4rem;
    }
    .overview-card .chart-holder { position:relative; height:260px; }
    .overview-empty { color:#94a3b8; font-style:italic; padding:2rem; text-align:center; }
</style>

<div class="overview-wrap">
    <% if(ovCount == 0){ %>
        <div class="overview-empty">No data to visualize.</div>
    <% } else { %>
    <div class="overview-caption">
        <i class="fa fa-info-circle"></i>
        Visual summary of all <strong><%=ovCount%></strong> matching trial<%=ovCount==1?"":"s"%> (across every page).
        <span class="overview-hint"><i class="fa fa-hand-pointer-o"></i> Click a slice or bar to filter the results by it.</span>
    </div>
    <div class="overview-grid">
        <div class="overview-card">
            <h5><i class="fa fa-flask"></i> Therapeutic Modality</h5>
            <div class="chart-holder"><canvas id="ovChartTherapy"></canvas></div>
        </div>
        <div class="overview-card">
            <h5><i class="fa fa-bar-chart"></i> Current Phase</h5>
            <div class="chart-holder"><canvas id="ovChartPhase"></canvas></div>
        </div>
        <div class="overview-card">
            <h5><i class="fa fa-heartbeat"></i> Recruitment Status</h5>
            <div class="chart-holder"><canvas id="ovChartStatus"></canvas></div>
        </div>
        <div class="overview-card">
            <h5><i class="fa fa-university"></i> Funder Type</h5>
            <div class="chart-holder"><canvas id="ovChartSponsor"></canvas></div>
        </div>
        <div class="overview-card">
            <h5><i class="fa fa-cubes"></i> Vector Type</h5>
            <div class="chart-holder"><canvas id="ovChartVector"></canvas></div>
        </div>
        <div class="overview-card">
            <h5><i class="fa fa-stethoscope"></i> Top Indications</h5>
            <div class="chart-holder"><canvas id="ovChartIndication"></canvas></div>
        </div>
    </div>
    <% } %>
</div>

<script>
    // Aggregated distributions for the current page, computed server-side.
    var ovData = {
        therapy:    <%=gson.toJson(topN(ovTherapy, 8))%>,
        phase:      <%=gson.toJson(topN(ovPhase, 10))%>,
        status:     <%=gson.toJson(topN(ovStatus, 8))%>,
        sponsor:    <%=gson.toJson(topN(ovSponsor, 8))%>,
        vector:     <%=gson.toJson(topN(ovVector, 8))%>,
        indication: <%=gson.toJson(topN(ovIndication, 10))%>
    };

    // Chart key -> the facet checkbox name the sidebar submits for that field.
    // Clicking a segment ticks the matching facet and re-runs the search.
    var ovFields = {
        therapy:    'therapyType',
        phase:      'phases',
        status:     'status',
        sponsor:    'sponsorClass',
        vector:     'vectorType',
        indication: 'indications'
    };

    // Apply a value as a facet filter by driving the existing #facetForm, so a
    // chart click behaves exactly like ticking that box in the Filters popup
    // (existing filters are preserved and merged).
    function applyOverviewFilter(field, value){
        if(!field || value == null) return;
        if(value === 'Other') return; // rolled-up bucket, not a single value
        var $form = $('#facetForm');
        if(!$form.length) return;
        var matched = $form.find('input[type="checkbox"][name="' + field + '"]').filter(function(){
            return $(this).val() === value;
        });
        if(matched.length){
            matched.prop('checked', true);
        } else {
            // Value isn't in the current facet list (e.g. differing normalization);
            // still send it to the server via a hidden field.
            $('<input>').attr({ type:'hidden', name:field, value:value }).appendTo($form);
        }
        // Mirror applyFiltersAndClose(): rebuild the ordered selection chip list.
        var selected = [];
        $form.find('input[type="checkbox"]:checked').each(function(){ selected.push($(this).val()); });
        if(matched.length === 0) selected.push(value);
        $('#filtersSelected').val(JSON.stringify(selected));
        $('#checked').val('');
        $('#unchecked').val('');
        $('#page').val('0');
        $form[0].submit();
    }

    (function(){
        var PALETTE = ['#2563eb','#16a34a','#f59e0b','#dc2626','#7c3aed','#0891b2',
                       '#db2777','#65a30d','#ea580c','#0d9488','#4f46e5','#94a3b8'];
        var rendered = false;

        function colorsFor(n){
            var out = [];
            for(var i=0;i<n;i++){ out.push(PALETTE[i % PALETTE.length]); }
            return out;
        }

        function makeChart(canvasId, type, map, opts){
            var el = document.getElementById(canvasId);
            if(!el || typeof Chart === 'undefined') return;
            var labels = Object.keys(map);
            var values = labels.map(function(k){ return map[k]; });
            if(labels.length === 0) return;
            var horizontal = opts && opts.horizontal;
            var field = opts && opts.field;
            new Chart(el.getContext('2d'), {
                type: type,
                data: {
                    labels: labels,
                    datasets: [{
                        data: values,
                        backgroundColor: colorsFor(labels.length),
                        borderColor: (type === 'bar') ? colorsFor(labels.length) : '#fff',
                        borderWidth: (type === 'bar') ? 0 : 1
                    }]
                },
                options: {
                    indexAxis: horizontal ? 'y' : 'x',
                    responsive: true,
                    maintainAspectRatio: false,
                    // Clicking a slice/bar filters the results by that value.
                    onClick: function(evt, elements, chart){
                        if(!field || !elements || !elements.length) return;
                        var label = chart.data.labels[elements[0].index];
                        applyOverviewFilter(field, label);
                    },
                    // Show a pointer cursor over clickable (non-"Other") elements.
                    onHover: function(evt, elements){
                        if(!field){ return; }
                        var clickable = elements.length &&
                            chartLabelAt(this, elements[0].index) !== 'Other';
                        evt.native.target.style.cursor = clickable ? 'pointer' : 'default';
                    },
                    plugins: {
                        legend: {
                            display: (type !== 'bar'),
                            position: 'right',
                            labels: { boxWidth: 12, font: { size: 11 } },
                            // Clicking a legend entry filters instead of toggling visibility.
                            onClick: function(e, legendItem){
                                if(field) applyOverviewFilter(field, legendItem.text);
                            }
                        },
                        tooltip: {
                            callbacks: {
                                label: function(ctx){
                                    var v = (type === 'bar')
                                        ? (horizontal ? ctx.parsed.x : ctx.parsed.y)
                                        : ctx.parsed;
                                    return ' ' + ctx.label + ': ' + v;
                                },
                                footer: function(items){
                                    if(!field || !items.length) return '';
                                    return (items[0].label === 'Other')
                                        ? '' : 'Click to filter by this';
                                }
                            }
                        }
                    },
                    scales: (type === 'bar') ? {
                        x: { beginAtZero: true, ticks: { precision: 0 } },
                        y: { beginAtZero: true, ticks: { precision: 0, autoSkip: false } }
                    } : {}
                }
            });
        }

        function chartLabelAt(chart, idx){
            return chart && chart.data && chart.data.labels ? chart.data.labels[idx] : null;
        }

        function renderOverviewCharts(){
            if(rendered) return;
            if(typeof Chart === 'undefined') return; // library not loaded yet
            rendered = true;
            makeChart('ovChartTherapy',    'doughnut', ovData.therapy,    { field: ovFields.therapy });
            makeChart('ovChartPhase',      'bar',      ovData.phase,      { field: ovFields.phase });
            makeChart('ovChartStatus',     'doughnut', ovData.status,     { field: ovFields.status });
            makeChart('ovChartSponsor',    'pie',      ovData.sponsor,    { field: ovFields.sponsor });
            makeChart('ovChartVector',     'bar',      ovData.vector,     { horizontal: true, field: ovFields.vector });
            makeChart('ovChartIndication', 'bar',      ovData.indication, { horizontal: true, field: ovFields.indication });
        }

        // Canvases have no size while the tab is hidden, so defer drawing until
        // the Overview tab is first shown.
        $(document).on('shown.bs.tab', '#overview-tab', renderOverviewCharts);

        // If the page happens to load with Overview already active, draw now.
        $(function(){
            if($('#overview-tab').hasClass('active')) renderOverviewCharts();
        });
    })();
</script>
