<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    




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
  				<button type="button"  class="btn btn-success" onclick="addProp()">添加属性</button>
  				<div class="form-group">
    				<label for="inputAddress">属性值</label>
    				<input type="text" name="options[0].optionName" class="form-control" id="inputAddress" placeholder="请输入属性值">
    				<button class="btn btn-danger" onclick="$(this).parent().remove()">删除</buttonn>
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

<table class="table">
	
	<tr> 
		<th>id</th>
		<th>名称</th>
		<th>详情</th>
		<th>操作
		<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#staticBackdrop">添加</button>
		</th>
	</tr>
	<c:forEach items="${pageInfo.list}" var="spec">
		<tr>
			<td>${spec.id}</td>
			<td>${spec.specName}</td>
			<td>
				<c:forEach items="${spec.options}" var="op" >
					${op.optionName}&nbsp;&nbsp; 
				</c:forEach>
			</td>
			<td>修改,删除</td>
		</tr>
	</c:forEach>
	<tr> 
		<th colspan="100">
			<nav aria-label="...">
			  <ul class="pagination">
			    <li class="page-item">
			      <a class="page-link" href="#" tabindex="-1" aria-disabled="true" date-toggle="${pageInfo.prePage}" >Previous</a>
			    </li>
			    <li class="page-item"><a class="page-link" href="#" date-toggle="1" >1</a></li>
			    <li class="page-item"><a class="page-link" href="#" date-toggle="2" >2</a></li>
			    <li class="page-item"><a class="page-link" href="#" date-toggle="3" >3</a></li>
			    <li class="page-item">
			      <a class="page-link" href="#"  date-toggle="${pageInfo.nextPage==0?pageInfo.pages:pageInfo.nextPage}">Next</a>
			    </li>
			  </ul>
			</nav>
		</th>
	</tr>
</table>    

<script type="text/javascript">
	//分页
	$(".page-link").click(function(){
		var recUrl=$(this).attr('date-toggle');
		$("#main").load("/spec/list?page="+recUrl);
	})
	
	
	var addindex=1;
	function addProp(){
		$("#addspec").append('<div class="form-group">'+
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
					 $('#staticBackdrop').map(function() {//用id选择器选中要关闭的模态框
					       $(this).modal('hide'); //关闭
					 });
				 }else{
					 alert("添加失败!");
					 $('#staticBackdrop').map(function() {//用id选择器选中要关闭的模态框
					       $(this).modal('hide'); //关闭
					 });
				 }
			  }
			  })
		
	}
</script>