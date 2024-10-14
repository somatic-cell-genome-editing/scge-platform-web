function applyFilters(){
    $('#facetForm').submit()
}
function removeFilters(){
    $.each($('input[type="checkbox"]'), function (){
        var _this=$(this);
        _this.prop('checked', false);
    })
    $('#facetForm').submit()
}
$('input[type="checkbox"]').on('click',function (){
    $('#facetForm').submit()
})

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
    });
    var facets=["status","indication", "sponsor"
        ,"sponsorClass", "therapyType", "vectorType",
        "deliverySystem","routeOfAdministration","drugProductType","editorType",
        "targetGeneOrVariant", "mechanismOfAction", "targetTissueOrCell", "phases","standardAges", "therapyRoute","locations" ]
    $.each(facets, function (i,e){
        var checkbox="\""+e+"\"";
        var collapseId='#collapse'+e
        console.log('e:'+e)
        $.each($('input[name='+checkbox+']'), function(){
            var _this=$(this);
            var val=_this.val();
            _this.prop('checked', false);
            var selectedFacet=json[e]
            console.log("SELECTED Facet :" + json[e]);
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

})