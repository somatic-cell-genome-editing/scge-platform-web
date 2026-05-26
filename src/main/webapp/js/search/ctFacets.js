function applyFilters(){
    $('#facetForm').submit()
}
function removeFilters(){
    $.each($('input[type="checkbox"]'), function (){
        var _this=$(this);
        _this.prop('checked', false);
    })
    $('#filtersSelected').val('')
    $('#facetForm').submit()
}
function removeFilter(filter) {
    $.each($('input[type="checkbox"]'), function () {
        var _this = $(this);
        var val = _this.val();
        if ('\''+val+'\'' == filter) {
            _this.prop('checked', false);
            $('#unchecked').val(val);
        }

    });
  $('#facetForm').submit()
}
// Filters are now batched: ticking checkboxes only updates selection in the
// modal. Nothing is submitted until the user clicks "Done" (applyFiltersAndClose).

// Apply all selected filters at once and reload the results page.
function applyFiltersAndClose(){
    var selected=[];
    $('#facetForm input[type="checkbox"]:checked').each(function (){
        selected.push($(this).val());
    });
    // Rebuild the ordered "Remove Filters" chip list from the current selection.
    // (The actual search is driven by the submitted checkbox params server-side.)
    $('#filtersSelected').val(JSON.stringify(selected));
    $('#checked').val('');
    $('#unchecked').val('');
    $('#facetForm').submit();
}

$(function () {
    // Add down arrow icon for collapse element which is open by default
    // $(".collapse.show").each(function(){
    //   $(this).prev(".card-header").find(".fas").addClass("fa-angle-down").removeClass("fa-angle-up");
    // });

    // Toggle right and down arrow icon on show hide of collapse element
    $(".collapse").on('show.bs.collapse', function(){
        $(this).prev(".card-header").find(".fas").removeClass("fa-angle-up").addClass("fa-angle-down");
    }).on('hide.bs.collapse', function(){
        $(this).prev(".card-header").find(".fas").removeClass("fa-angle-down").addClass("fa-angle-up");
    }).on('shown.bs.collapse', function(){
        // Scroll the expanded accordion group into view within the facet container
        var accordionGroup = $(this).closest('.accordion-group');
        var facetForm = $('#facetForm');
        if (accordionGroup.length && facetForm.length) {
            var groupTop = accordionGroup[0].offsetTop;
            var containerScroll = facetForm.scrollTop();
            var containerHeight = facetForm.innerHeight();
            var groupBottom = groupTop + accordionGroup.outerHeight();
            if (groupBottom > containerScroll + containerHeight) {
                facetForm.animate({ scrollTop: groupTop }, 300);
            }
        }
    });
    var facets=allFacets
    // var facets=["status","indication", "sponsor"
    //     ,"sponsorClass", "therapyType", "vectorType",
    //     "deliverySystem","routeOfAdministration","drugProductType","editorType",
    //     "targetGeneOrVariant", "mechanismOfAction", "targetTissueOrCell", "phases","standardAges", "therapyRoute","locations","developmentStatus"]
    $.each(facets, function (i,e){
        var checkbox="\""+e+"\"";
        var collapseId='#collapse'+e
        $.each($('input[name='+checkbox+']'), function(){
            var _this=$(this);
            var val=_this.val();
            _this.prop('checked', false);
            var selectedFacet=json[e]
            if(selectedFacet !== typeof undefined) {
                $.each(selectedFacet, function (i, selected) {
                    if (selected === val) {
                        _this.prop('checked', true)
                        $(collapseId).addClass('show')
                    }
                })
            }
        });
    })
    $('#collapseAll').hide()
    if(expandFilterVal == "true"){
        expandAll()
    }
})

function expandAll(){
    $('.collapse').addClass("show");
    $('#expandAll').hide()
    $('#collapseAll').show()
    $('#expandAllFilters').val("true");
}
function collapseAll(){
    $('.collapse').removeClass("show");
    $('#expandAll').show()
    $('#collapseAll').hide()
    $('#expandAllFilters').val("false");

}

