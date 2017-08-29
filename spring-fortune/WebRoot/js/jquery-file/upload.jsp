<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/jquery-file/css/jquery.filer.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/jquery-file/css/jquery.filer-dragdropbox-theme.css">



<script src="${pageContext.request.contextPath}/js/jquery-file/js/jquery.filer.min.js" type="text/javascript"></script>


 <script type="text/javascript">
 $(document).ready(function() {
     $('#filer_input').filer({
    	//limit:1,
    	showThumbs:true,
		appendTo:'#img',
		//theme: "dragdropbox",
		templates: {
            box: '<ul class="jFiler-items-list jFiler-items-grid"></ul>',
            item: '<li class="jFiler-item">\
                        <div class="jFiler-item-container">\
                            <div class="jFiler-item-inner">\
                                <div class="jFiler-item-thumb">\
                                    <div class="jFiler-item-status"></div>\
                                    <div class="jFiler-item-info">\
                                        <span class="jFiler-item-title"><b title="{{fi-name}}">{{fi-name | limitTo: 25}}</b></span>\
                                        <span class="jFiler-item-others">{{fi-size2}}</span>\
                                    </div>\
                                    {{fi-image}}\
                                </div>\
                                <div class="jFiler-item-assets jFiler-row">\
                                    <ul class="list-inline pull-left">\
                                        <li>{{fi-progressBar}}</li>\
                                    </ul>\
                                    <ul class="list-inline pull-right">\
                                        <li><a class="icon-jfi-trash jFiler-item-trash-action" onclick="removeFile(this)"></a></li>\
                                    </ul>\
                                </div>\
                            </div>\
                        </div>\
                    </li>',
            progressBar: '<div class="bar"></div>',
            itemAppendToEnd: false,
            removeConfirmation: false,
            _selectors: {
                list: '.jFiler-items-list',
                item: '.jFiler-item',
                progressBar: '.bar',
                remove: '.jFiler-item-trash-action',
                onRemove :null,//
            },
            
        },
	 });       
});
 
function onRemove(){
	alert(22)
}
 </script>