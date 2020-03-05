<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<div>
	<br>
   	<button type="button" class="btn btn-primary" onclick="selAll(1)">全选</button>
	<button type="button" class="btn btn-primary" onclick="selAll(2)">全不选</button>
	<button type="button" class="btn btn-primary" onclick="selAll(3)">反选</button>
   	<button type="button" class="btn btn-danger" onclick="delBatch()">批量删除</button>
   	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
   	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<input id="queryName" value="${queryName}"/>
	<button type="button" class="btn btn-success" onclick="query()">查询 </button><br><br>
   	
</div>



<!-- Modal -->
<div class="modal fade" id="staticBackdrop" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="staticBackdropLabel">添加规格</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
        	
      </div>
      <div class="modal-body">
        	<form id="addspec">
        		 <div class="form-group">
    				<label for="specName">规格名称</label>
    				<input type="text" class="form-control" name="specName" id="specName" aria-describedby="specNamelHelp">
    				<small id="specNamelHelp" class="form-text text-muted">请输入规格名称</small>
  				</div>
  				<button type="button"  class="btn btn-success" onclick="addProp('#addspec')">添加属性</button>
  				<div class="form-group">
    				<label for="inputAddress">属性值</label>
    				<input type="text" name="options[0].optionName" class="form-control" id="inputAddress" placeholder="请输入属性值">
  				</div>
    			
        	</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" onclick="commitSpec()">提交</button>
      </div>
    </div>
  </div>
</div>
<!-- Modal -->
<div class="modal fade" id="staticBackdropUpdate" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="staticBackdropLabel">修改规格</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
        	
      </div>
      <div class="modal-body">
        	<form id="updatespec">
        		 <input type="hidden" name="id" id="upId">
        		 <div class="form-group">
    				<label for="specName">规格名称</label>
    				<input type="text" class="form-control" name="specName" id="upspecName" aria-describedby="specNamelHelp">
    				<small id="specNamelHelp" class="form-text text-muted">请输入规格名称</small>
  				</div>
  				<button type="button"  class="btn btn-success" onclick="addProp('#updatespec')">添加属性</button>
        	</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" onclick="commitUpdateSpec()">提交</button>
      </div>
    </div>
  </div>
</div>



<table class="table">
	<tr> 
		<th>
		<input type="checkbox" id="allSel" onchange="selectedAll()">id  
		</th>
		<th>名称</th>
		<th>详情</th>
		<th>操作
		<button type="button" class="btn btn-dark btn-sm" data-toggle="modal" data-target="#staticBackdrop">添加</button>
		</th>
	</tr>
	<c:forEach items="${pageInfo.list}" var="spec">
		<tr>
			<td><input type="checkbox" name="ids" value="${spec.id}" onchange="selectedOne()">${spec.id}</td>
			<td>${spec.specName}</td>
			<td>
				<c:forEach items="${spec.options}" var="op" >
					${op.optionName}&nbsp;&nbsp; 
				</c:forEach>
			</td>
			<td>
			<button type="button" class="btn btn-warning btn-sm" onclick="openUpdateSpec(${spec.id})">修改</button>
			<button type="button" class="btn btn-danger btn-sm" onclick="delSec(${spec.id})">删除</button>
			</td>
		</tr>
	</c:forEach>
	<tr> 
		<th colspan="100">
			<jsp:include page="/WEB-INF/view/common/page.jsp"></jsp:include>
		</th>
	</tr>
</table>    



<script type="text/javascript">
	
	var addindex=1;
	function addProp(fomId){
		$(fomId).append('<div class="form-group form-group-proper">'+
    				'<label for="inputAddress">属性值</label>'+
    				'<input type="text" name="options['+addindex+'].optionName" class="form-control" id="inputAddress" placeholder="请输入属性值">'+
    				'<button class="btn btn-danger" onclick="$(this).parent().remove()">删除</button>'+
    				'</div>')
    	addindex++;
	} 
	
	/**
	  提交数据	
	*/
	function commitSpec(){
		//addspec
		var formData = new FormData($("#addspec")[0]);
		$.ajax({url:"/spec/add",
			  dataType:"json",
			  data:formData,
			  // 让jQuery 不要再提交数据之前进行处理
			  processData : false,
			  // 提交的数据不能加消息头
			  contentType : false,
			  // 提交的方式 
			  type:"post",
			  // 成功后的回调函数
			  success:function(flag){
				 if(flag){
					 alert("添加成功!");
					 $('#staticBackdrop').modal('hide')
				 }else{
					 alert("添加失败!");
				 }
			  }
			  })
		
	}
	
	//查询
	function query(){
		var url="/spec/list?name="+$("#queryName").val();
		$("#main").load(url);
	}
	
	//分页 
	function goPage(pagenum){
		var url="/spec/list?name="+$("#queryName").val()+'&page='+pagenum;
		$("#main").load(url);
	}
	
	//刷新 而且保持查询条件和页码
	function refresh(){
		var url="/spec/list?name=${queryName}"+'&page=${pageInfo.pageNum}';
		$("#main").load(url);
	}
	
	//添加窗口的复位
	function resetAddForm(){
		$(".form-group-proper").each(function(){
			$(this).remove();
		})
		addindex=1;
		$("#specName").val("")	
	}
	
	// 给添加规格模态框增加显示成成功后的事件  
	$('#staticBackdrop').on('shown.bs.modal', function (e) {
		  // do something...
		resetAddForm();
	})
	
	// 给添加规格模态框增加关闭以后的事件  
	$('#staticBackdrop').on('hidden.bs.modal', function (e) {
		  // do something...
		refresh();
	})
	
	// 给修改规格模态框增加关闭以后的事件  
	$('#staticBackdropUpdate').on('hidden.bs.modal', function (e) {
		  // do something...
		refresh();
	})
	
	//点击全选的checkbox
	function selectedAll(){
		var checked = $("#allSel").prop("checked")
		// 让每个checkbox 都等于 总的checkbox
		$("[name=ids]").each(function(){
				$(this).prop("checked",checked)
			}
		)
	}
	
	//修改一个checkbox
	function selectedOne(){
		// 判断是否所有的都被选中了
		var allSelected = $("[name=ids]").length==$("[name=ids]:checked").length;
		//设置全选的框
		$("#allSel").prop("checked",allSelected)
	}
	
	//点击三个按钮
	function selAll(flag){
		
	 	if(flag==1){
			//全选
			$("[name=ids]").each(function(){
				$(this).prop("checked",true)
			}
			)
		}
		
		if(flag==2){
			//全不选
			$("[name=ids]").each(function(){
				$(this).prop("checked",false)
			})
		}
		if(flag==3){
			//反选
			$("[name=ids]").each(function(){
				var ch = !$(this).prop("checked")
				$(this).prop("checked",ch)
			}
			)
		} 
		// 判断是否所有的都被选中了
		var allSelected = $("[name=ids]").length==$("[name=ids]:checked").length;
		//设置全选的框
		$("#allSel").prop("checked",allSelected)
		
	}
	
	//批量删除
	function delBatch(){
		
		if($("[name=ids]:checked").length<=0){
			alert("没有数据被选中，不能删除")
			return;
		}
		// 组织删除的数据
		var delIds  = new Array();
		$("[name=ids]:checked").each(function(){
			delIds.push($(this).val());
		})
		
		
		if(confirm("您确认删除这些数据么？")){
			$.post("/spec/delSpecBatch",{ids:delIds},function(data){
				if(data){
					alert("删除成功")
					refresh();
				}else{
					alert("删除失败")
				}
				
			},"json");
		}else{
			return;
		}
	}
	
	// 删除规格
	function delSec(id){
		if(confirm("您确认删除该条数据么？")){
			$.post("/spec/delSpec",{id:id},function(data){
				if(data){
					alert("删除成功")
					refresh();
				}else{
					alert("删除失败")
				}
				
			},"json");
		}else{
			return;
		}
	}
	
	// 弹出修改的窗口
	function openUpdateSpec(id){
		
		//清空数据
		$(".form-group-proper").each(function(){
			$(this).remove();
		})
		addindex=0;
		$("#upspecName").val("")
		
		
		$.post("/spec/getSpec",{id:id},function(data){
			//规格的id
			$("#upId").val(data.id)
			$("#upspecName").val(data.specName)
			// 添加规格的选项
			addindex=0;
			for(var i=0;i<data.options.length;i++){
				var option=data.options[i];
				$("#updatespec").append('<div class="form-group form-group-proper">'+
	    				'<label for="inputAddress">属性值</label>'+
	    				'<input type="hidden" name="options['+addindex+'].id" value="'+option.id+'">' +
	    				'<input type="text" name="options['+addindex+'].optionName" value="'+option.optionName+'"class="form-control" id="inputAddress" >'+
	    				'<button class="btn btn-danger" onclick="$(this).parent().remove()">删除</button>'+
	    				'</div>')
	    		addindex++;
			}
			
		});
		
		$("#staticBackdropUpdate").modal('show')
	}
	
	// 提交修改
	function commitUpdateSpec(){
		
		//addspec
		var formData = new FormData($("#updatespec")[0]);
		$.ajax({url:"/spec/update",
			  dataType:"json",
			  data:formData,
			  // 让jQuery 不要再提交数据之前进行处理
			  processData : false,
			  // 提交的数据不能加消息头
			  contentType : false,
			  // 提交的方式 
			  type:"post",
			  // 成功后的回调函数
			  success:function(data){
				 if(data){
					 alert("数据提交成功")
					 $('#staticBackdropUpdate').modal('hide')
				 }else{
					 alert("数据保存失败")
				 }
				 
			  }
			  })
		
	}
</script>