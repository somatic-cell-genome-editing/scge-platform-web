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
$('input[type="checkbox"]').on('click',function (){
    // var name=this.getAttribute("name");
    if ($(this).is(":checked")) {

        $('#checked').val($(this).val());
        // $('#checkedName').val(name)
    }else{
        $('#unchecked').val($(this).val());
        // $('#uncheckedName').val(name)
    }
    $('#facetForm').submit();})

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

