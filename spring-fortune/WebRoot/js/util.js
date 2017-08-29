//对Date的扩展，将 Date 转化为指定格式的String   
//月(M)、日(d)、小时(h)、分(m)、秒(s)、季度(q) 可以用 1-2 个占位符，   
//年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字)   
//例子：   
//(new Date()).Format("yyyy-MM-dd hh:mm:ss.S") ==> 2006-07-02 08:09:04.423   
//(new Date()).Format("yyyy-M-d h:m:s.S")      ==> 2006-7-2 8:9:4.18   
Date.prototype.Format = function(fmt){
	if(this.getDate()>0){
		  var o = {   
		    "M+" : this.getMonth()+1,                 //月份   
		    "d+" : this.getDate(),                    //日   
		    "h+" : this.getHours(),                   //小时   
		    "m+" : this.getMinutes(),                 //分   
		    "s+" : this.getSeconds(),                 //秒   
		    "q+" : Math.floor((this.getMonth()+3)/3), //季度   
		    "S"  : this.getMilliseconds()             //毫秒   
		  };   
		  if(/(y+)/.test(fmt))   
		    fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length));   
		  for(var k in o)   
		    if(new RegExp("("+ k +")").test(fmt))   
		  	fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));   
		  	return fmt;   
	}else{
		return '';
	}
};



/**
 * 时间格式转换。
 * @param obj
 * @param format
 * @returns
 */
function jsonDateFormat(obj,format){
	if(obj!=null){
		var date = new Date();
		date.setTime(obj.time);
		date.setHours(obj.hours);
		date.setMinutes(obj.minutes);
		date.setSeconds(obj.seconds);
		return date.Format(format); 
	}else{
		return null;
	}
}


/**
 * 字符串空值转换
 * @param str
 * @returns
 */
function jsonParseStrUtil(str){
	if(str != null){
		return str;
	}else{
		return "";
	}
}

 
/** 
 * 将数值四舍五入(保留2位小数)后格式化成金额形式 
 * 
 * @param num 数值(Number或者String) 
 * @return 金额格式的字符串,如'1,234,567.45' 
 * @type String 
 */  
function formatCurrency(num) {
    num = num.toString().replace(/\$|\,/g,'');  
    if(isNaN(num))  
        num = "0";  
    sign = (num == (num = Math.abs(num)));  
    num = Math.floor(num*100+0.50000000001);  
    cents = num%100;  
    num = Math.floor(num/100).toString();  
    if(cents<10)  
    cents = "0" + cents;  
    for (var i = 0; i < Math.floor((num.length-(1+i))/3); i++)  
    num = num.substring(0,num.length-(4*i+3))+','+  
    num.substring(num.length-(4*i+3));  
    return (((sign)?'':'-') + num + '.' + cents);  
} 

/**
 * 
 * 屏蔽界面上input与textarea为readyonly或disable时的退格键
 * 
 */
function forbiddenBackspace(){
	$(document).keydown(function (e) {  

	    var doPrevent;  
	      
	    // for IE && Firefox  
	    var varkey = (e.keyCode) || (e.which) || (e.charCode);  
	      
	    if (varkey == 8) {  

	        var d = e.srcElement || e.target;   

	        if (d.tagName.toUpperCase() == 'INPUT' || d.tagName.toUpperCase() == 'TEXTAREA') {  

	            doPrevent = d.readOnly || d.disabled;  

	            // for button,radio and checkbox  
	            if (d.type.toUpperCase() == 'SUBMIT'  
	                || d.type.toUpperCase() == 'RADIO'  
	                || d.type.toUpperCase() == 'CHECKBOX'  
	                || d.type.toUpperCase() == 'BUTTON') {  

	                doPrevent = true;  
	            }  
	        }  
	        else {  

	            doPrevent = true;  
	        }  
	    }  
	    else {  

	        doPrevent = false;  
	    }  

	if (doPrevent)  

	    e.preventDefault();  
	});
}

//打开遮罩
function blockWindow(msg, basePath){
	if(msg==null){
		msg = '正在加载请稍等……';
	}
	//var subMsgBox='<div style="text-align:center;color:#666;padding:8px 0px">'+msg+'</div>';
	var subMsgBox='	<div class="lodding" style="height:20px;width:180px "><img src="'+basePath+'/images/lodding.gif" width="20" height="20" /><span>'+msg+'</span></div>';
	$.blockUI({
		 message: subMsgBox, 
         fadeIn: 0, 
         fadeOut: 0, 
         showOverlay: true,
         centerY: true, 
         css: { 
        	 width: '180px',
			 height: '20px',
            // padding: '2px', 
             //'-webkit-border-radius': '5px', 
             //'-moz-border-radius': '5px', 
            // color: '#ddd',
             border: '0px solid #eee',
             left: '50%',
             'margin-left':'-80px'
         },
         overlayCSS:{opacity:.3,backgroundColor:'#eee',cursor:"default"
         }
	});
}
//关闭遮罩
function unblockWindow(){
	$.unblockUI();
}


function ajaxLoadingBlock(obj, basePath) {
	obj.block({
		message: '<div class="lodding" style="height:20px;width:180px "><img src="'+basePath+'/images/lodding.gif" width="20" height="20" /><span>数据加载中，请稍等...</span></div>', 
		css : {
			 width: '180px',
			 height: '20px',
			 //color: '#000',
			 top: '50%', 
			'margin-top':'5px',
			// '-webkit-border-radius': '5px', 
	          //'-moz-border-radius': '5px', 
	          border: '0px solid #eee'
	        	  
		},
		 overlayCSS:{opacity:.3,backgroundColor:'#eee',cursor:"default"
	     }

	});
}

/*function ajaxLoadingBlock2(obj, basePath) {
	obj.block({
		message: '<div class="lodding" style="height:20px;width:180px "><img src="images/lodding.gif" width="20" height="20" /><span>数据加载中，请稍等...</span></div>', 
		css : {
			 width: '180px',
			 height: '20px',
			 color: '#ddd',
			 //top: '50%',
			 //'margin-top':'300px'
				 //'-webkit-border-radius': '5px', 
	            // '-moz-border-radius': '5px', 
	             border: '0px solid #eee'
	             //left: '50%',
	             //'margin-left':'-150px'
		},
		 overlayCSS:{opacity:.3,backgroundColor:'#eee',cursor:"default"
	     }

	});
}*/

function closeAjaxLoadingBlock(obj) {
	obj.unblock();
}

/**
 * 
 * 检查文件是否是图片格式
 * 
 */
function checkImageFile(obj){
	var extArray = ['jpg','png','bmp','gif','jpeg'];
	var filename = $(obj).val();
    var ext = filename.substring(filename.lastIndexOf(".")+1);
    if(ext==null){
    	return false;
    }
    ext=ext.toLowerCase( );
    var flag = false;
    for(var i=0;i<extArray.length;i++){
    	if(ext==extArray[i]){
    		flag = true;
    	}
    }
    if(!flag){
    	return false;
    }else {
		return true;
	}
}

//============================================

var _modelChange = {
    ary0:["零", "一", "二", "三", "四", "五", "六", "七", "八", "九"],
    ary1:["", "十", "百", "千"],
    ary2:["", "万", "亿", "兆"],
    init:function (name) {
        this.name = name;
    },
    strrev:function () {
        var ary = [];
        for (var i = this.name.length; i >= 0; i--) {
            ary.push(this.name[i]);
        }
        return ary.join("");
    }, //倒转字符串。
    pri_ary:function () {
        var $this = this;
        var ary = this.strrev();
        var zero = "";
        var newary = "";
        var i4 = -1;
        for (var i = 0; i < ary.length; i++) {
            if (i % 4 == 0) { //首先判断万级单位，每隔四个字符就让万级单位数组索引号递增
                i4++;
                newary = this.ary2[i4] + newary; //将万级单位存入该字符的读法中去，它肯定是放在当前字符读法的末尾，所以首先将它叠加入$r中，
                zero = ""; //在万级单位位置的“0”肯定是不用的读的，所以设置零的读法为空

            }
            //关于0的处理与判断。
            if (ary[i] == '0') { //如果读出的字符是“0”，执行如下判断这个“0”是否读作“零”
                switch (i % 4) {
                    case 0:
                        break;
                    //如果位置索引能被4整除，表示它所处位置是万级单位位置，这个位置的0的读法在前面就已经设置好了，所以这里直接跳过
                    case 1:
                    case 2:
                    case 3:
                        if (ary[i - 1] != '0') {
                            zero = "零";
                        }
                        ; //如果不被4整除，那么都执行这段判断代码：如果它的下一位数字（针对当前字符串来说是上一个字符，因为之前执行了反转）也是0，那么跳过，否则读作“零”
                        break;
                }

                newary = zero + newary;
                zero = '';
            }
            else { //如果不是“0”
                newary = this.ary0[parseInt(ary[i])] + this.ary1[i % 4] + newary; //就将该当字符转换成数值型,并作为数组ary0的索引号,以得到与之对应的中文读法，其后再跟上它的的一级单位（空、十、百还是千）最后再加上前面已存入的读法内容。
            }

        }
        if (newary.indexOf("零") == 0) {
            newary = newary.substr(1);
        }//处理前面的0
        if(/^(一十)/.test(newary)){
        	newary = newary.substring(1, newary.length);
         }
        return newary;
    }
};

//创建class类
function itemChange() {
    this.init.apply(this, arguments);
}
itemChange.prototype = _modelChange;

function jqNumToMoney(n) {  
	var fraction = ['角','分'];  
	var digit = ['零','壹','贰','叁','肆','伍','陆','柒','捌','玖'];  
	var unit = [['元','万','亿'],['','拾','佰','仟']];  
	var head = n < 0?'欠':'';  
	n = Math.abs(n);  
	var s = '';  
	for (var i = 0; i < fraction.length; i++) {  
		s += (digit[Math.floor(n * 10 * Math.pow(10, i)) % 10] + fraction[i]).replace(/零./, '');  
	}  
	s = s || '整';  
	n = Math.floor(n);  
	for (var i = 0; i < unit[0].length && n > 0; i++) {  
		var p = '';  
		for (var j = 0; j < unit[1].length && n > 0; j++) {  
			p = digit[n % 10] + unit[1][j] + p;  
			n = Math.floor(n / 10);  
		}  
		s = p.replace(/(零.)*零$/, '').replace(/^$/, '零') + unit[0][i] + s;  
	}  
	return head + s.replace(/(零.)*零元/,'元').replace(/(零.)+/g, '零').replace(/^整$/, '零元整');  
}

/**
 * 计算两个日期之间的天数
 */
//计算天数差的函数，通用  
function  DateDiff(sDate1,  sDate2){    //sDate1和sDate2是2006-12-18格式  
    var  aDate,  oDate1,  oDate2,  iDays  
    aDate  =  sDate1.split("-")  
    oDate1  =  new  Date(aDate[1]  +  '-'  +  aDate[2]  +  '-'  +  aDate[0])    //转换为12-18-2006格式  
    aDate  =  sDate2.split("-")  
    oDate2  =  new  Date(aDate[1]  +  '-'  +  aDate[2]  +  '-'  +  aDate[0])  
    iDays  =  parseInt(Math.abs(oDate1  -  oDate2)  /  1000  /  60  /  60  /24)    //把相差的毫秒数转换为天数  
    return  iDays  
}    




//==================================================================
/**
 * 时间戳转化
 */
function timeStamp(time){
	var date = new Date(time);
	Y = date.getFullYear() + '-';
	M = (date.getMonth()+1 < 10 ? '0'+(date.getMonth()+1) : date.getMonth()+1) + '-';
	D = date.getDate() + ' ';
	h = date.getHours() + ':';
	m = date.getMinutes();
	s = date.getSeconds(); 
	return Y+M+D+h+m
}

/**
 * 千位符
 * @param num
 * @returns
 */
function toThousands(num) {
	 return num && (num.toString().indexOf('.') != -1 ? num.toString().replace(/(\d)(?=(\d{3})+\.)/g, function($0, $1) {
		      return $1 + ",";
		    }) : num.toString().replace(/(\d)(?=(\d{3}))/g, function($0, $1) {
		      return $1 + ",";
	 }));
}

/**
 * 保留N位小数    四舍五入  num  0 ~ 20 
 */

function rounded(value,num){
	var value = parseFloat(value);
	value = value.toFixed(num);
	return value;
}

/**
 * Datatables时间转化
 * @param {} data
 * @return {}
 */
function getDatatTableTimeFormat(data){
	var year = parseInt(data.year)+1900;
	var month = parseInt(data.month)+1;
	var date =  data.date;
	var h = parseInt(data.hours);
	if(h<10){
		h = "0"+h;
	}
	var m = parseInt(data.minutes);
	if(m<10){
		m = "0"+m;
	}
	
	var s = parseInt(data.seconds);
	if(s<10){
		s = "0"+s;
	}
	
	var str = year+"-"+month+"-"+date+"  "+h+":"+m+":"+s;
	return str; 
}

/**
 * 分页加载
 */
function pageLoading(){
	layer.load(0, {shade: 0,time:500});
}

/**
 * 时间格式转换。
 * @param obj
 * @param format
 * @returns
 */
function jsonDateFormat(obj,format){
	if(obj!=null){
		var date = new Date();
		date.setTime(obj.time);
		date.setHours(obj.hours);
		date.setMinutes(obj.minutes);
		date.setSeconds(obj.seconds);
		return date.Format(format); 
	}else{
		return null;
	}
}



