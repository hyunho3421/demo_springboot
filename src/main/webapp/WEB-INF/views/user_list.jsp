<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script
  src="https://code.jquery.com/jquery-3.6.0.js"
  integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
  crossorigin="anonymous"></script>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<h1>user list</h1>
	<table id="user_list">
	</table>

	<div id="pagination">
	</div>

	<br/> 
	�˻�: <select id="keyword"></select> <input type="text" id="content" value="${search.content }" > <button id="search_button" onclick="ajax_search()">�˻�</button>

	<h1>ajax save</h1>
	<form action="/user/save" method="post" id="ajax_user" onsubmit="return false">
		id : <input type="text" name="id" id="ajax_id" placeholder="id" />
		name : <input type="text" name="name" id="ajax_name" placeholder="name" />
		age : <input type="number" name="age" id="ajax_age" placeholder="age" />
		<input type="submit" id="ajaxBtn" value="����" onclick="ajax_submit()"/>
	</form>
	
	
	<h1>form save</h1>
	<form action="/user/save" method="post">
		id : <input type="text" name="id" placeholder="id" />
		name : <input type="text" name="name" placeholder="name" />
		age : <input type="number" name="age" placeholder="age" />
		<input type="submit" id="fromBtn" value="����" />
	</form>	
	
</body>
<script type="text/javascript">
	$(document).ready(function () {
		findUserAll();
		init_setting();
	});
	
	// Ŭ�� �̺�Ʈ - �����Ҵ� ����
	$(document).on("click", "tr[id*=user_detail]", function() {
		var id = $(this).data("id");
		findUser(id);
	});
	
	function init_setting(select_keyword) {
		var keyword_list = ["id", "name"];
		
		for (i=0; i < keyword_list.length; i++) {
			if (keyword_list[i] == select_keyword) {
				// TODO: SELECT ����
				$("#keyword").append("<option>" + keyword_list[i] + "</option>");
			} else {
				$("#keyword").append("<option>" + keyword_list[i] + "</option>");
			}
		}
		
	}
 
	function ajax_search() {
		var keyword = $("#keyword option:selected").val();
		var content = $("#content").val();
		
		var search = {
				"keyword" : keyword,
				"content" : content
		}
		
		console.log("keyword is " + keyword);
		console.log("content is " + content);
		
		$.ajax({
			type: 'POST',
			url: '',
			headers: {
	            "Content-Type": "application/json",
	            "X-HTTP-Method-Override": "POST"
	        },
			data: JSON.stringify(search),
			success: function(result) {
				findUserAll();
			},
			error: function(xhr) {
				var code = xhr.status;
			}
		});
		
	}
	
	function ajax_submit() {
		var id = $("#ajax_user #ajax_id").val();
		var name = $("#ajax_user #ajax_name").val();
		var age = $("#ajax_user #ajax_age").val();
		var user = {
				"id": id,
				"name": name,
				"age": age
		};
		
		$.ajax({
			type: 'POST',
			url: '/user/ajax/save',
			headers: {
		            "Content-Type": "application/json",
		            "X-HTTP-Method-Override": "POST"
	        },
			data: JSON.stringify(user),
			success: function(result) {
				findUserAll();
			},
			error: function(xhr) {
				var code = xhr.status;
			}
		});
	}
	
	function findUser(id) {
		//$(location).attr("href", "/user/find/id/" + id + "");
		location.href = "/user/find/id/" + id;
	}
	
	function getDate(create_date) {
		var date = new Date(create_date);
		
		var year = date.getFullYear();
		var month = date.getMonth();
		var day = date.getDate();
		
		return year + "/" + month + "/" + day;
	}
	
	function findUserAll() {
		var search = {
				"keyword" : "",
				"content" : "",
				"page" : 0,
				"perPageNum" : 10
		}
		
		$.ajax({
			type: 'POST',
			url: '/user/ajax/find/all',
			headers: {
		            "Content-Type": "application/json",
		            "X-HTTP-Method-Override": "POST"
	        },
	        data: JSON.stringify(search),
			success: function(result) {
				var html = "";
				var users = result.users.list;
				var pageHtml = "";
				
				for(var i=0; i < users.length ; i++) {
					
					html += "<tr id='user_detail' data-id='" + users[i].id + "'>";
					html += "<td>" + i + "</td>";
					html += "<td>" + users[i].id + "</td>";
					html += "<td>" + users[i].name + "</td>";
					html += "<td>" + users[i].age + "</td>";
					html += "<td>" + users[i].age + "</td>";
					html += "<td>" + getDate(users[i].create_date) + "</td>";
					
					html += "</tr>";
				}
				
				$("#user_list").html(html);

				// paging
				
				
				
				$("#ajax_user #ajax_id").val("");
				$("#ajax_user #ajax_name").val("");
				$("#ajax_user #ajax_age").val("");
			},
			error: function(xhr) {
				var code = xhr.status;
			}
		});
	}
	
</script>
</html>