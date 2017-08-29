/**
 * 全选按钮
 */
$("table thead tr th label").click(function(){
	if($(this).hasClass("on")){
			$("table label").removeClass("on");
		}else{
			$("table label").addClass("on");
		}
})

/**
 * 单个选择
 */
$("table tbody tr td label").click(function(){
	if($(this).hasClass("on")){
			$(this).removeClass("on");
		}else{
			$(this).addClass("on");
		}
})

/**
 * 全部取消
 */
function removeCheckAll(){
	$("table label").removeClass("on");
}

/**
 * 选择选中
 */
function singleCheck(id){
	$('table label[id='+id+']').addClass("on");
}


/**
 * 选择取消
 */
function removeCheck(id){
	$('table label[id='+id+']').removeClass("on");
}

function activeCheckBox(){
	$("table tbody tr td label").click(function(){
		if($(this).hasClass("on")){
				$(this).removeClass("on");
			}else{
				$(this).addClass("on");
			}
	})
}














 
