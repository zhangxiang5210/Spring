var uploadTmp = function() {
	
	this.imgUpload = function (fileListId,pickerId,imgId) {
		
		var $ = jQuery,
	 	$list = $('#'+fileListId),
	 // 优化retina, 在retina下这个值是2
	 ratio = window.devicePixelRatio || 1,

	 // 缩略图大小
	 thumbnailWidth = 100 * ratio,
	 thumbnailHeight = 100 * ratio;
	 
	var uploader = WebUploader.create({
		auto: true,
	    // swf文件路径
	    swf: swf,

	    // 文件接收服务端。
	    server: imgServer,

	    // 选择文件的按钮。可选。
	    // 内部根据当前运行是创建，可能是input元素，也可能是flash.
	    pick: {
	    	id : '#'+pickerId
	    },

	    // 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
	    resize: false,
	    
	    fileVal: 'Filedata',

	    // 只允许选择图片文件。
	    accept: {
	        title: 'Images',
	        extensions: 'gif,jpg,jpeg,bmp,png',
	        mimeTypes: 'image/gif,image/jpg,image/jpeg,image/bmp,image/png'
	    },
	    
	    fileSingleSizeLimit :10485760
	});
	
	uploader.on('beforeFileQueued',function(file){
		if (file.size > 10485760) {
			top.tip.error(file.name+"文件大小超过10M不允许上传");
		}
	});

	// 当有文件添加进来的时候
	 uploader.on( 'fileQueued', function( file ) {
		 var $li = $(
	                '<div id="' + file.id + '" class="file-item thumbnail">' +
	                    '<img class="timg">' +
	                '</div>'
	                ),
	            $img = $li.find('img');

	        $list.append( $li );

	        // 创建缩略图
	        uploader.makeThumb( file, function( error, src ) {
	            if ( error ) {
	                $img.replaceWith('<span>不能预览</span>');
	                return;
	            }

	            $img.attr( 'src', src );
	        }, thumbnailWidth, thumbnailHeight );
	        
	 		var $del = $('<img title="点击删除"  do="del" style="left: 85px; top: 0px; width: 15px; height: 15px; position: absolute; cursor: pointer;" src="'+deleteIcon+'" />');
	        
	        $( '#'+file.id ).append($del);
	 });

	 // 文件上传过程中创建进度条实时显示。
	 uploader.on( 'uploadProgress', function( file, percentage ) {
	     var $li = $( '#'+file.id ),
	         $percent = $li.find('.progress span');

	     // 避免重复创建
	     if ( !$percent.length ) {
	         $percent = $('<p class="progress"><span></span></p>')
	                 .appendTo( $li )
	                 .find('span');
	     }

	     $percent.css( 'width', percentage * 100 + '%' );
	 });

	 // 文件上传成功，给item添加成功class, 用样式标记上传成功。
	 uploader.on( 'uploadSuccess', function( file,response ) {
	     $( '#'+file.id ).addClass('upload-state-done');
	     var $imgValue = $('<input type="hidden" name="'+imgId+'" value="'+response.filePath+'">');
	     $( '#'+file.id ).append($imgValue);
	     $img = $( '#'+file.id ).find('.timg');
	     $img.attr("style","height:100px;width:100px");
	     $( '#'+file.id ).find("img[do='del']").on('click',function(){
	    	 delImg(file.id,response.filePath);
	     })
	     
	     
	     $img.bind('click',function(){
	     	showImage(response.filePath);
	     });
	 });

	 // 文件上传失败，现实上传出错。
	 uploader.on( 'uploadError', function( file,reason  ) {
	     var $li = $( '#'+file.id ),
	         $error = $li.find('div.error');

	     // 避免重复创建
	     if ( !$error.length ) {
	         $error = $('<div class="error"></div>').appendTo( $li );
	     }

	     $error.text('上传失败');
	 });

	 // 完成上传完了，成功或者失败，先删除进度条。
	 uploader.on( 'uploadComplete', function( file ) {
	     $( '#'+file.id ).find('.progress').remove();
	     });
		
	 return uploader;
	 
	}
	
	
	this.fileUpload = function (fileListId,pickerId,fileId) {
		var $ = jQuery,
	 	$list = $('#'+fileListId);
	     
		var uploader = WebUploader.create({
	 		auto: true,
	 	
	 	    // swf文件路径
	 	    swf: swf,
	 	
	 	    // 文件接收服务端。
	 	    server: fileServer,
	 	
	 	    // 选择文件的按钮。可选。
	 	    // 内部根据当前运行是创建，可能是input元素，也可能是flash.
	 	    pick: {
	 	    	id : '#'+pickerId
	 	    },
	 	
	 	    // 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
	 	    resize: false,
	 	    
	 	    fileVal: 'Filedata',
	 	    
	 	   fileSingleSizeLimit :10485760

	 	});
	 	
	 	uploader.on('beforeFileQueued',function(file){
			if (file.size > 10485760) {
				top.tip.error(file.name+"文件大小超过10M不允许上传");
			}
		});
	 	
	 	// 当有文件添加进来的时候
	     uploader.on( 'fileQueued', function( file ) {
	    	 var $li = $(
  	                '<div id="' + file.id + '"><div class="uploadify-queue-item">' +
  	                    '<div class="cancel"><a href="javascript:void(0)" id="delFile">X</a></div>' +
  	                    '<span class="fileName">' + file.name + '('+ (file.size/1024/1024).toFixed(2) +'M)</span>' +
  	                    '<span class="data"> - 0%</span>' +
  	                    '<div class="uploadify-progress">' +
  	                    '<div class="uploadify-progress-bar" style="width: 0%;"></div>' +
  	                '</div></div></div>'
  	                );
	  		$list.append( $li );
	  		
	     });

	     // 文件上传过程中创建进度条实时显示。
	     uploader.on( 'uploadProgress', function( file, percentage ) {
	         var $li = $( '#'+file.id ),
	         $percent = $li.find('div.uploadify-progress-bar');
	         $percent.css( 'width', percentage * 100 + '%' );
	         $percentData = $li.find('span.data');
	         $percentData.html(' - '+ percentage * 100 + '%');
	         
	     });

	     // 文件上传成功，给item添加成功class, 用样式标记上传成功。
	     uploader.on( 'uploadSuccess', function( file,response ) {
	         $( '#'+file.id ).addClass('upload-state-done');
	         var html = "";
	         html += "    <li class=\'myli\'>";  
	         html += "	 <input type='hidden' name='"+fileId+"' value="+response.filePath+">";  
	         html += "    <img src="+fjIcon+" style='width:21px; height:21px;') /> "; 
	         html += " 	 <span >"+ response.fileName +"</span>"; 
	        /* html += "    <img title=\"点击删除\" style='cursor: pointer;' src="+deleteIcon+" id='delFile2' />"; */
	         html += '<img title="点击删除" style="cursor: pointer;" src="'+deleteIcon+'" onclick="delFile(\''+file.id+'\',\''+response.filePath+'\')">'
	         html += "    </li>";
	         
	         
	         $( '#'+file.id ).append(html);
	         $( '#'+file.id ).find('.uploadify-queue-item').fadeOut('1000',function(){
	         });
	       
	     });

	     // 文件上传失败，现实上传出错。
	     uploader.on( 'uploadError', function( file,reason  ) {
	         var $li = $( '#'+file.id );
	         var $percentData = $li.find('span.data');
	         $percentData.html(' - 上传失败');
	         $percentData.css('color','#FF0000');
	     });
		
		return uploader;
	}
	
	this.delFile = function (id, filePath) {
		top.layer.confirm('您确定删除该附件吗？', {
			  btn: ['确定','取消'] //按钮
			}, function(index){
				$.getJSON(delFilePath,{filePath:filePath},function(data){
				});
				$('#'+id).remove();
	        	top.layer.close(index);
	        	top.tip.success('删除成功！');
	        	
			}, function(){
				return;
			});
	}
	
	this.delImg = function (id, filePath) {
		top.layer.confirm('您确定删除该图片吗？', {
			  btn: ['确定','取消'] //按钮
			}, function(index){
				$.getJSON(delFilePath,{filePath:filePath},function(data){
				});
				$('#'+id).remove();
	        	top.layer.close(index);
	        	top.tip.success('删除成功！');
			}, function(){
				return;
			});
	}
	
	
	this.showImage  = function (path) {
		var imgPath =basePath+'/'+path;
		var img = new Image();
		img.src=imgPath;
		img.onload=function(){
			 var width = img.width;
			var height = img.height;
			var data = dealImg(width,height);
			top.layer.open({
				  type: 1,
				  title: false,
				  closeBtn: 2,
				  id :'imgContain',
				  area:  [data[0]+'px', data[1] + 'px'],
				  shadeClose: true,
				  content: '<img src="'+imgPath+'" id="img"  heigth="'+data[1]+'" width="'+data[0]+'"  >'
				});
		 };  
		
	}
	
	this.dealImg  = function (width,height) {
		var maxWidth = document.body.offsetWidth-50;
		var maxHeight = window.screen.availHeight-100;
		
		var showWidth = 0;  //图片显示宽度
		var showHeight = 0;  //图片显示高度
		
		//根据图片实际的框和高，调整页面图片显示大小
		if (width <= maxWidth && height <= maxHeight) {
			showWidth = width;
			showHeight = height;
		}
		
		if (width <= maxWidth && height > maxHeight) {
			showHeight = maxHeight;
			showWidth = maxHeight*width/height;		
		}
		if (width > maxWidth && height < maxHeight) {
			showWidth = maxWidth;
			showHeight = height*maxWidth/width;
		}
		if (width > maxWidth && height > maxHeight) {
			if (width*maxHeight == height* maxWidth) {
				showWidth = maxWidth;
				showHeight = maxHeight;
			}
			if (width*maxHeight > height* maxWidth) {
				showWidth = maxWidth;
				showHeight = height*maxWidth/width;
			}
			if (width*maxHeight < height* maxWidth) {
				showHeight = maxHeight;
				showWidth = maxHeight*width/height;
			}
		}
		var data = [showWidth,showHeight];
		return data;
	}
	
	this.isUploadSuccess = function (uploader) {
		var stats = uploader.getStats();
		return stats.progressNum > 0?false:true
		
	}
	
	return this;
}();