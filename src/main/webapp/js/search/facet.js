// $(function () {
//     $("#breadcrumb").hide();
//     $(".form-check-input").on("change",function () {
//         $('form ').submit();
//     })
//     $.each($('input[name="experimentType"]'), function(){
//
//         var _this=$(this);
//         var val=_this.val();
//         _this.prop('checked', false);
//         if(selectedExperimentType!== typeof undefined) {
//             $.each(selectedExperimentType.split(","), function (i, selected) {
//                 if (selected === val) {
//                     _this.prop('checked', true)
//                 }
//             })
//         }
//     });
//     $.each($('input[name="experimentName"]'), function(){
//
//         var _this=$(this);
//         var val=_this.val();
//         _this.prop('checked', false);
//         if(selectedExperimentName!== typeof undefined) {
//             $.each(selectedExperimentName.split(","), function (i, selected) {
//                 if (selected === val) {
//                     _this.prop('checked', true)
//                 }
//             })
//         }
//     });
//     $.each($('input[name="editorType"]'), function(){
//         var _this=$(this);
//         var val=_this.val();
//         _this.prop('checked', false);
//         console.log("SELECTED EDITOR TYPE:" + selectedEditorType);
//         if(selectedEditorType !== typeof undefined) {
//             $.each(selectedEditorType.split(","), function (i, selected) {
//                 if (selected === val) {
//                     _this.prop('checked', true)
//                 }
//             })
//         }
//     });
//     $.each($('input[name="editorSubType"]'), function(){
//
//         var _this=$(this);
//         var val=_this.val();
//         _this.prop('checked', false);
//         console.log("EDITORS SUB TYPE: "+ selectedEditorSubType)
//         if(selectedEditorSubType!==typeof undefined) {
//             $.each(selectedEditorSubType.split(","), function (i, selected) {
//                 if (selected === val) {
//                     _this.prop('checked', true)
//                 }
//             })
//         }
//     });
//     $.each($('input[name="editorSpecies"]'), function() {
//
//         var _this = $(this);
//         var val = _this.val();
//         _this.prop('checked', false);
//         if (selectedEditorSpecies !== typeof undefined) {
//
//             $.each(selectedEditorSpecies.split(","), function (i, selected) {
//                 if (selected === val) {
//                     _this.prop('checked', true)
//                 }
//             })
//         }
//     });
//     $.each($('input[name="modelType"]'), function(){
//         var _this=$(this);
//         var val=_this.val();
//         if(selectedModelType!==typeof undefined)
//         $.each(selectedModelType.split(","), function (i,selected) {
//             if(selected===val){
//                 _this.prop('checked',true)
//             }
//         })
//     });
//     $.each($('input[name="modelSubtype"]'), function(){
//         var _this=$(this);
//         var val=_this.val();
//         if(selectedModelSubType!==typeof undefined)
//             $.each(selectedModelSubType.split(","), function (i,selected) {
//                 if(selected===val){
//                     _this.prop('checked',true)
//                 }
//             })
//     });
//     $.each($('input[name="species"]'), function(){
//
//         var _this=$(this);
//         var val=_this.val();
//         _this.prop('checked', false);
//         if(selectedSpeciesType!==typeof  undefined)
//         $.each(selectedSpeciesType.split(","), function (i,selected) {
//             if(selected===val){
//                 _this.prop('checked',true)
//             }
//         })
//     });
//     $.each($('input[name="modelOrganism"]'), function(){
//
//         var _this=$(this);
//         var val=_this.val();
//         _this.prop('checked', false);
//         if(selectedModelOrganism!==typeof undefined) {
//             $.each(selectedModelOrganism.split(","), function (i, selected) {
//                 if (selected === val) {
//                     _this.prop('checked', true)
//                 }
//             })
//         }
//     });
//     $.each($('input[name="transgeneReporter"]'), function(){
//
//         var _this=$(this);
//         var val=_this.val();
//         _this.prop('checked', false);
//         if(selectedReporter!==typeof undefined)
//             $.each(selectedReporter.split(","), function (i,selected) {
//                 if(selected===val){
//                     _this.prop('checked',true)
//                 }
//             })
//     });
//     $.each($('input[name="tissueTerm"]'), function(){
//
//         var _this=$(this);
//         var val=_this.val();
//         _this.prop('checked', false);
//     if(selectedTargetTissue!==typeof undefined)
//         $.each(selectedTargetTissue.split(","), function (i,selected) {
//             if(selected===val){
//                 _this.prop('checked',true)
//                 $('#collapsetissueTerm').addClass('show')
//             }
//         })
//     });
//     $.each($('input[name="guideTargetLocus"]'), function(){
//
//         var _this=$(this);
//         var val=_this.val();
//         _this.prop('checked', false);
//         if(selectedGuideTargetLocus!==typeof undefined)
//         $.each(selectedGuideTargetLocus.split(","), function (i,selected) {
//             if(selected===val){
//                 _this.prop('checked',true)
//                 $('#collapseguideTargetLocus').addClass('show')
//
//             }
//         })
//     });
//     $.each($('input[name="guideSpecies"]'), function(){
//
//         var _this=$(this);
//         var val=_this.val();
//         _this.prop('checked', false);
//         if(selectedGuideSpecies!==typeof undefined)
//             $.each(selectedGuideSpecies.split(","), function (i,selected) {
//                 if(selected===val){
//                     _this.prop('checked',true)
//                 }
//             })
//     });
//     $.each($('input[name="guideCompatibility"]'), function(){
//
//         var _this=$(this);
//         var val=_this.val();
//         _this.prop('checked', false);
//         if(selectedGuideCompatibility!==typeof undefined)
//             $.each(selectedGuideCompatibility.split(","), function (i,selected) {
//                 if(selected===val){
//                     _this.prop('checked',true)
//                 }
//             })
//     });
//
//
//     $.each($('input[name="deliveryType"]'), function(){
//
//         var _this=$(this);
//         var val=_this.val();
//         _this.prop('checked', false);
//         if(selectedDsType!== typeof undefined) {
//             $.each(selectedDsType.split(","), function (i, selected) {
//                 if (selected === val) {
//                     _this.prop('checked', true)
//                 }
//             })
//         }
//     });
//
//     $.each($('input[name="deliverySubtype"]'), function(){
//
//         var _this=$(this);
//         var val=_this.val();
//         _this.prop('checked', false);
//         if(selectedDeliverySubtype!== typeof undefined) {
//             $.each(selectedDeliverySubtype.split(","), function (i, selected) {
//                 if (selected === val) {
//                     _this.prop('checked', true)
//                 }
//             })
//         }
//     });
//     $.each($('input[name="vectorName"]'), function(){
//
//         var _this=$(this);
//         var val=_this.val();
//         _this.prop('checked', false);
//         if(selectedVector!==typeof undefined)
//         $.each(selectedVector.split(","), function (i,selected) {
//             if(selected===val){
//                 _this.prop('checked',true)
//             }
//         })
//     });
//     $.each($('input[name="vectorType"]'), function(){
//
//         var _this=$(this);
//         var val=_this.val();
//         _this.prop('checked', false);
//         if(selectedVectorType!==typeof undefined)
//         $.each(selectedVectorType.split(","), function (i,selected) {
//             if(selected===val){
//                 _this.prop('checked',true)
//             }
//         })
//     });
//     $.each($('input[name="vectorSubtype"]'), function(){
//
//         var _this=$(this);
//         var val=_this.val();
//         _this.prop('checked', false);
//         if(selectedVectorSubType!==typeof undefined)
//         $.each(selectedVectorSubType.split(","), function (i,selected) {
//             if(selected===val){
//                 _this.prop('checked',true)
//             }
//         })
//     });
//
//     $.each($('input[name="pi"]'), function(){
//
//         var _this=$(this);
//         var val=_this.val();
//         _this.prop('checked', false);
//         if(selectedPi!==typeof undefined)
//             $.each(selectedPi.split(","), function (i,selected) {
//                 if(selected===val){
//                     _this.prop('checked',true)
//                     $('#collapsepi').addClass('show')
//                 }
//             })
//     });
//     $.each($('input[name="access"]'), function(){
//
//         var _this=$(this);
//         var val=_this.val();
//         _this.prop('checked', false);
//         if(selectedAccess!==typeof undefined)
//             $.each(selectedAccess.split(","), function (i,selected) {
//                 if(selected===val){
//                     _this.prop('checked',true)
//                 }
//             })
//     });
//     $.each($('input[name="status"]'), function(){
//
//         var _this=$(this);
//         var val=_this.val();
//         _this.prop('checked', false);
//         if(selectedStatus!==typeof undefined)
//             $.each(selectedStatus.split(","), function (i,selected) {
//                 if(selected===val){
//                     _this.prop('checked',true)
//                 }
//             })
//     });
//     $.each($('input[name="studyType"]'), function(){
//
//         var _this=$(this);
//         var val=_this.val();
//         _this.prop('checked', false);
//         if(selectedStudyType!==typeof undefined)
//             $.each(selectedStudyType.split(","), function (i,selected) {
//                 if(selected===val){
//                     _this.prop('checked',true)
//                 }
//             })
//     });
//     $.each($('input[name="initiative"]'), function(){
//
//         var _this=$(this);
//         var val=_this.val();
//         _this.prop('checked', false);
//         if(selectedInitiative!==typeof undefined)
//             $.each(selectedInitiative.split(","), function (i,selected) {
//                 if(selected===val){
//                     _this.prop('checked',true)
//                 }
//             })
//     })
// });
// function searchByFilter(category, searchTerm, type, subType) {
//
//     //  var  $contentDiv=$('#results');
//     var  $contentDiv=$('#reloadResults');
//     var  $tmp=$contentDiv.html();
//     var currentURL=window.location.href
//     var url;
//     url="/platform/data/search/results/"+category+"?facetSearch=true&searchTerm="+searchTerm+"&type="+type+"&subType="+subType
//     var breadCrumbList=$("#breadcrumb");
//     breadCrumbList.html(
//         " <ol class=\"breadcrumb\">" +
//         "        <!--li class=\"breadcrumb-item active\" aria-current=\"page\">Home</li-->" +
//         "<!--li class=\"breadcrumb-item active\"><a onclick=\"+searchByFilter('','"+searchTerm+"','', '')\">Categories</a></li-->"+
//         "<li class=\"breadcrumb-item active\"><a href='"+currentURL+"'>Categories</a></li>"+
//         "<li class=\"breadcrumb-item \" aria-current=\"page\"><a onclick=\"+searchByFilter('"+category+"','"+searchTerm+"','"+type+"', '"+subType+"')\">"+category+"</a></li>"+
//         " </ol>"
//
//
//     )
//
//     $.get(url, function (data, status) {
//         if(category!== typeof undefined)
//             breadCrumbList.show();
//         else
//             breadCrumbList.setAttribute('display','none')
//
//         $contentDiv.html(data);
//     })
//
// }
// function applyFacetFilters(){
//     $(this).parentElement().
//    $('form').submit();
// }
// /*$( ":checkbox" ).click(function () {
//     //  alert("HELLo");
//     //   var  $contentDiv=$('#results');
//     var  $contentDiv=$('#reloadResults');
//     var selectedType=   $('input[name="typeBkt"]:checked').map(function () {
//         return this.value;
//     }).get().join(',');
//     var selectedSubtype=   $('input[name="subtypeBkt"]:checked').map(function () {
//         return this.value;
//     }).get().join(',');
//     var selectedEditorType=   $('input[name="editorTypeBkt"]:checked').map(function () {
//         return this.value;
//     }).get().join(',');
//     var selectedEditorSubType=   $('input[name="editorSubTypeBkt"]:checked').map(function () {
//         return this.value;
//     }).get().join(',');
//     var selectedEditorSpecies=   $('input[name="editorSpeciesBkt"]:checked').map(function () {
//         return this.value;
//     }).get().join(',');
//
//     var selectedDsType=   $('input[name="dsTypeBkt"]:checked').map(function () {
//         return this.value;
//     }).get().join(',');
//     var selectedModelType=   $('input[name="modelTypeBkt"]:checked').map(function () {
//         return this.value;
//     }).get().join(',');
//     var selectedModelOrganism=   $('input[name="modelSpeciesBkt"]:checked').map(function () {
//         return this.value;
//     }).get().join(',');
//
//     var selectedReporter=   $('input[name="reporterBkt"]:checked').map(function () {
//         return this.value;
//     }).get().join(',');
//
//     var selectedSpeciesType=   $('input[name="speciesBkt"]:checked').map(function () {
//         return this.value;
//     }).get().join(',');
//     var selectedWithExperiments=   $('input[name="withExperimentsBkt"]:checked').map(function () {
//         return this.value;
//     }).get().join(',');
//     var selectedTarget=   $('input[name="targetBkt"]:checked').map(function () {
//         return this.value;
//     }).get().join(',');
//     var selectedGuideTargetLocus=   $('input[name="guideTargetLocusBkt"]:checked').map(function () {
//         return this.value;
//     }).get().join(',');
//     var selectedVector=   $('input[name="vectorBkt"]:checked').map(function () {
//         return this.value;
//     }).get().join(',');
//     var selectedVectorType=   $('input[name="vectorTypeBkt"]:checked').map(function () {
//         return this.value;
//     }).get().join(',');
//     var selectedVectorSubType=   $('input[name="vectorSubTypeBkt"]:checked').map(function () {
//         return this.value;
//     }).get().join(',');
//
//     var searchTerm=$("#searchTerm")
//     var category=$("#category")
//     var url="/platform/data/search/results/"+category.val()+"?facetSearch=true&searchTerm="+searchTerm.val()+
//         "&type="+selectedType+
//         "&subType="+selectedSubtype +
//         "&editorType="+selectedEditorType +
//         "&editorSubType="+selectedEditorSubType +
//         "&editorSpecies="+selectedEditorSpecies +
//         "&dsType="+selectedDsType+
//         "&modelType="+ selectedModelType+
//         "&modelSpecies="+ selectedModelOrganism+
//         "&reporter="+ selectedReporter+
//         "&speciesType="+ selectedSpeciesType+
//         "&withExperiments="+ selectedWithExperiments+
//         "&target="+ selectedTarget+
//         "&vector="+selectedVector +
//         "&vectorType="+selectedVectorType +
//         "&vectorSubType="+selectedVectorSubType +
//         "&guideTargetLocus="+ selectedGuideTargetLocus;
//
//
//     $.get(url, function (data, status) {
//         $contentDiv.html(data);
//         $.each($('input[name="typeBkt"]'), function(){
//             var _this=$(this);
//             var val=_this.val();
//             $.each(selectedType.split(","), function (i,selected) {
//                 if(selected===val){
//                     _this.prop('checked',true)
//                 }
//             })
//         });
//         $.each($('input[name="subtypeBkt"]'), function(){
//             //    console.log(selectedSubtype+"\tthis.Val="+ $(this).val())
//             var _this=$(this);
//             var val=_this.val();
//             $.each(selectedSubtype.split(","), function (i,selected) {
//                 if(selected===val){
//                     _this.prop('checked',true)
//                 }
//             })
//
//         });
//         $.each($('input[name="editorTypeBkt"]'), function(){
//             var _this=$(this);
//             var val=_this.val();
//             $.each(selectedEditorType.split(","), function (i,selected) {
//                 if(selected===val){
//                     _this.prop('checked',true)
//                 }
//             })
//         });
//         $.each($('input[name="modelTypeBkt"]'), function(){
//             var _this=$(this);
//             var val=_this.val();
//             $.each(selectedModelType.split(","), function (i,selected) {
//                 if(selected===val){
//                     _this.prop('checked',true)
//                 }
//             })
//         });
//         $.each($('input[name="speciesBkt"]'), function(){
//
//             var _this=$(this);
//             var val=_this.val();
//             $.each(selectedSpeciesType.split(","), function (i,selected) {
//                 if(selected===val){
//                     _this.prop('checked',true)
//                 }
//             })
//         });
//
//         $.each($('input[name="targetBkt"]'), function(){
//
//             var _this=$(this);
//             var val=_this.val();
//             $.each(selectedTarget.split(","), function (i,selected) {
//                 if(selected===val){
//                     _this.prop('checked',true)
//                 }
//             })
//         });
//         $.each($('input[name="guideTargetLocusBkt"]'), function(){
//
//             var _this=$(this);
//             var val=_this.val();
//             $.each(selectedGuideTargetLocus.split(","), function (i,selected) {
//                 if(selected===val){
//                     _this.prop('checked',true)
//                 }
//             })
//         });
//         $.each($('input[name="withExperimentsBkt"]'), function(){
//
//             var _this=$(this);
//             var val=_this.val();
//             $.each(selectedWithExperiments.split(","), function (i,selected) {
//                 if(selected===val){
//                     _this.prop('checked',true)
//                 }
//             })
//         });
//         $.each($('input[name="dsTypeBkt"]'), function(){
//
//             var _this=$(this);
//             var val=_this.val();
//             $.each(selectedDsType.split(","), function (i,selected) {
//                 if(selected===val){
//                     _this.prop('checked',true)
//                 }
//             })
//         });
//         $.each($('input[name="editorSubTypeBkt"]'), function(){
//
//             var _this=$(this);
//             var val=_this.val();
//             $.each(selectedEditorSubType.split(","), function (i,selected) {
//                 if(selected===val){
//                     _this.prop('checked',true)
//                 }
//             })
//         });
//         $.each($('input[name="editorSpeciesBkt"]'), function(){
//
//             var _this=$(this);
//             var val=_this.val();
//             $.each(selectedEditorSpecies.split(","), function (i,selected) {
//                 if(selected===val){
//                     _this.prop('checked',true)
//                 }
//             })
//         });
//         $.each($('input[name="modelSpeciesBkt"]'), function(){
//
//             var _this=$(this);
//             var val=_this.val();
//             $.each(selectedModelOrganism.split(","), function (i,selected) {
//                 if(selected===val){
//                     _this.prop('checked',true)
//                 }
//             })
//         });
//         $.each($('input[name="reporterBkt"]'), function(){
//
//             var _this=$(this);
//             var val=_this.val();
//             $.each(selectedReporter.split(","), function (i,selected) {
//                 if(selected===val){
//                     _this.prop('checked',true)
//                 }
//             })
//         });
//         $.each($('input[name="vectorBkt"]'), function(){
//
//             var _this=$(this);
//             var val=_this.val();
//             $.each(selectedVector.split(","), function (i,selected) {
//                 if(selected===val){
//                     _this.prop('checked',true)
//                 }
//             })
//         });
//         $.each($('input[name="vectorTypeBkt"]'), function(){
//
//             var _this=$(this);
//             var val=_this.val();
//             $.each(selectedVectorType.split(","), function (i,selected) {
//                 if(selected===val){
//                     _this.prop('checked',true)
//                 }
//             })
//         });
//         $.each($('input[name="vectorSubTypeBkt"]'), function(){
//
//             var _this=$(this);
//             var val=_this.val();
//             $.each(selectedVectorSubType.split(","), function (i,selected) {
//                 if(selected===val){
//                     _this.prop('checked',true)
//                 }
//             })
//         });
//     })
// })*/
