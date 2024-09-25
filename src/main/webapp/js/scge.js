$(function() {
    $('.tablesorter').tablesorter({
        theme: 'blue',
        showProcessing: true,
        headerTemplate : '',
        widgets: [  'zebra',  'scroller' ],
        widgetOptions : {
            scroller_height : 600,
            // scroll tbody to top after sorting
            scroller_upAfterSort: true,
            // pop table header into view while scrolling up the page
            scroller_jumpToHeader: true,
            // In tablesorter v2.19.0 the scroll bar width is auto-detected
            // add a value here to override the auto-detected setting
            scroller_barWidth : null
            // scroll_idPrefix was removed in v2.18.0
            // scroller_idPrefix : 's_'
        }
    });
    $("#myTable").tablesorter({
        // widthFixed : true,
        theme : 'blue',
        headerTemplate : '',
        showProcessing: true,
        widgets: ['zebra','scroller'],
        widgetOptions: {
            // jQuery selector or object to attach sticky header to
            // stickyHeaders_attachTo: $('.table-wrapper'),
            scroller_height : 600,
            // scroll tbody to top after sorting
            scroller_upAfterSort: true,
            // pop table header into view while scrolling up the page
            scroller_jumpToHeader: true,

            scroller_fixedColumns : '1',
            // In tablesorter v2.19.0 the scroll bar width is auto-detected
            // add a value here to override the auto-detected setting
            scroller_barWidth : null,
            // scroll_idPrefix was removed in v2.18.0
            // scroller_idPrefix : 's_',

            scroller_addFixedOverlay : false,
            // add hover highlighting to the fixed column (disable if it causes slowing)
            scroller_rowHighlight : 'hover',

        }
    });
    // var toggler = document.getElementsByClassName("caret");
    // var i;
    //
    // for (i = 0; i < toggler.length; i++) {
    //     toggler[i].addEventListener("click", function() {
    //         this.parentElement.querySelector(".nested").classList.toggle("active");
    //         this.classList.toggle("caret-down");
    //     });
    // }
    $( 'table' ).trigger( 'setFixedColumnSize', 1 );
    $(window).trigger('resize');
});
function signOut() {
    var auth2 = gapi.auth2.getAuthInstance();
    auth2.signOut().then(function () {
        console.log('User signed out.');
    });
    

    var redirectURL='/scge/home';
    var form = $('<form action="' + redirectURL + '">');
    $('body').append(form);
    form.submit();
}

