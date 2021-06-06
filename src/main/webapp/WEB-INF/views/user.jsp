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
	<h1>user</h1>
	<form role="form">
		<input type="hidden" name="id" id="id" value="${user.id }">
	</form>
	
	<table>
		<tr>
			<td><c:out value="${user.id }" /></td>
			<td><c:out value="${user.name }" /></td>
			<td><c:out value="${user.age }" /></td>
		</tr>
	</table>
	<button id="delete_${user.id }">삭제</button>
	<button>목록</button>
</body>

<script type="text/javascript">
	$(document).on("click", "button[id*=delete_]", function() {
		var id = this.id.substr('delete_'.length);
		deleteUser(id);
	});
	
	function deleteUserAjax(id) {
		$.ajax({
			type: 'POST',
			url: '/user/ajax/delete',
			header: {
				"Content-Type": "application/json",
	            "X-HTTP-Method-Override": "POST"
			},
			data: {
				"id" : id
			},
			success: function(result) {
			},
			error: function(xhr) {
				var code = xhr.status;
			}
		});

		//$(location).attr("href", "/user/find/all");
		location.href = "/user/find/all";
	}
	
	function deleteUser() {
		var formObj = $("form[role='form']");
		
		formObj.attr("action", "/user/delete");
        formObj.attr("method", "POST");
        formObj.submit();
	}
	
</script>
</html>