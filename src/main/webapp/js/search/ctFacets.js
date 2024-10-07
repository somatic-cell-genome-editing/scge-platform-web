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
    $.each($('input[name="status"]'), function(){
        var _this=$(this);
        var val=_this.val();
        _this.prop('checked', false);
        console.log("SELECTED status :" + statusSelected);
        if(statusSelected !== typeof undefined) {
            $.each(statusSelected, function (i, selected) {
                if (selected === val) {
                    _this.prop('checked', true)
                    $('#collapsestatus').addClass('show')
                }
            })
        }
    });
    $.each($('input[name="sponsor"]'), function(){
        var _this=$(this);
        var val=_this.val();
        _this.prop('checked', false);

        if(orgSelected !== typeof undefined) {
            $.each(orgSelected, function (i, selected) {
                if (selected === val) {
                    _this.prop('checked', true)
                    $('#collapsesponsor').addClass('show')
                }})}});
    $.each($('input[name="indication"]'), function(){
        var _this=$(this);
        var val=_this.val();
        _this.prop('checked', false);

        if(conditionSelected !== typeof undefined) {
            $.each(conditionSelected, function (i, selected) {
                if (selected === val) {
                    _this.prop('checked', true)
                    $('#collapseindication').addClass('show')
                }
            })
        }
    });
    $.each($('input[name="trackerType"]'), function(){
        var _this=$(this);
        var val=_this.val();
        _this.prop('checked', false);

        if(trackerTypeSelected !== typeof undefined) {
            $.each(trackerTypeSelected, function (i, selected) {
                if (selected === val) {
                    _this.prop('checked', true)
                    $('#collapsetrackerType').addClass('show')
                }
            })
        }
    });


    $.each($('input[name="vectorType"]'), function(){
        var _this=$(this);
        var val=_this.val();
        _this.prop('checked', false);

        if(vectorTypeSelected !== typeof undefined) {
            $.each(vectorTypeSelected, function (i, selected) {
                if (selected === val) {
                    _this.prop('checked', true)
                    $('#collapsevectorType').addClass('show')
                }
            })
        }
    });


    $.each($('input[name="editorType"]'), function(){
        var _this=$(this);
        var val=_this.val();
        _this.prop('checked', false);

        if(editorTypeSelected !== typeof undefined) {
            $.each(editorTypeSelected, function (i, selected) {
                if (selected === val) {
                    _this.prop('checked', true)
                    $('#collapseeditorType').addClass('show')
                }
            })
        }
    });


    $.each($('input[name="deliverySystem"]'), function(){
        var _this=$(this);
        var val=_this.val();
        _this.prop('checked', false);

        if(deliverySystemSelected !== typeof undefined) {
            $.each(deliverySystemSelected, function (i, selected) {
                if (selected === val) {
                    _this.prop('checked', true)
                    $('#collapsedeliverySystem').addClass('show')
                }
            })
        }
    });



    $.each($('input[name="drugProductType"]'), function(){
        var _this=$(this);
        var val=_this.val();
        _this.prop('checked', false);

        if(drugProductTypeSelected !== typeof undefined) {
            $.each(drugProductTypeSelected, function (i, selected) {
                if (selected === val) {
                    _this.prop('checked', true)
                    $('#collapsedrugProductType').addClass('show')
                }
            })
        }
    });


    $.each($('input[name="sponsorClass"]'), function(){
        var _this=$(this);
        var val=_this.val();
        _this.prop('checked', false);

        if(sponsorClasssSelected !== typeof undefined) {
            $.each(sponsorClasssSelected, function (i, selected) {
                if (selected === val) {
                    _this.prop('checked', true)
                    $('#collapsesponsorType').addClass('show')
                }
            })
        }
    });


    $.each($('input[name="therapyType"]'), function(){
        var _this=$(this);
        var val=_this.val();
        _this.prop('checked', false);

        if(therapyTypeSelected !== typeof undefined) {
            $.each(therapyTypeSelected, function (i, selected) {
                if (selected === val) {
                    _this.prop('checked', true)
                    $('#collapsetherapyType').addClass('show')
                }
            })
        }
    });

    $.each($('input[name="routeOfAdministration"]'), function(){
        var _this=$(this);
        var val=_this.val();
        _this.prop('checked', false);

        if(routeOfAdministrationSelected !== typeof undefined) {
            $.each(routeOfAdministrationSelected, function (i, selected) {
                if (selected === val) {
                    _this.prop('checked', true)
                    $('#collapserouteOfAdministration').addClass('show')
                }
            })
        }
    });
})