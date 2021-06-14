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
	검색: <select id="keyword"></select> <input type="text" id="content" value="${search.content }" > <button id="search_button" onclick="ajax_search()">검색</button>

	<h1>ajax save</h1>
	<form action="/user/save" method="post" id="ajax_user" onsubmit="return false">
		id : <input type="text" name="id" id="ajax_id" placeholder="id" />
		name : <input type="text" name="name" id="ajax_name" placeholder="name" />
		age : <input type="number" name="age" id="ajax_age" placeholder="age" />
		<input type="submit" id="ajaxBtn" value="생성" onclick="ajax_submit()"/>
	</form>
	
	
	<h1>form save</h1>
	<form action="/user/save" method="post">
		id : <input type="text" name="id" placeholder="id" />
		name : <input type="text" name="name" placeholder="name" />
		age : <input type="number" name="age" placeholder="age" />
		<input type="submit" id="fromBtn" value="생성" />
	</form>	

</body>
<script type="text/javascript">
	let search = {
		"keyword" : "",
		"content" : "",
		"page" : 0,
		"perPageNum" : 10
	}

	// href 링크 이동 막기
	// 정의안하면 uri에 #붙음
	$(document).on('click', 'a[href="#"]', function(e){
		e.preventDefault();
	});

	$(document).ready(function () {
		findUserAll();
		init_setting();
	});
	
	// 클릭 이벤트 - 동적할당 가능
	$(document).on("click", "tr[id*=user_detail]", function() {
		let id = $(this).data("id");
		findUser(id);
	});

	$(document).on("click", ".paging", function (){
		let page = $(this).data("page");

		if(page == 'prev') {
			search.page = search.page - 1;
		} else if (page == 'next') {
			search.page = search.page + 1;
		} else {
			search.page = page;
		}

		findUserAll();
 	});
	
	function init_setting(select_keyword) {
		let keyword_list = ["id", "name"];
		
		for (i=0; i < keyword_list.length; i++) {
			if (keyword_list[i] == select_keyword) {
				// TODO: SELECT 설정
				$("#keyword").append("<option>" + keyword_list[i] + "</option>");
			} else {
				$("#keyword").append("<option>" + keyword_list[i] + "</option>");
			}
		}
	}

	function ajax_search() {
		let keyword = $("#keyword option:selected").val();
		let content = $("#content").val();

		search.keyword = keyword;
		search.content = content;
		findUserAll();
		
	}
	
	function ajax_submit() {
		let id = $("#ajax_user #ajax_id").val();
		let name = $("#ajax_user #ajax_name").val();
		let age = $("#ajax_user #ajax_age").val();
		let user = {
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
				let code = xhr.status;
			}
		});
	}
	
	function findUser(id) {
		//$(location).attr("href", "/user/find/id/" + id + "");
		location.href = "/user/find/id/" + id;
	}
	
	function getDate(create_date) {
		let date = new Date(create_date);

		let year = date.getFullYear();
		let month = date.getMonth();
		let day = date.getDate();
		
		return year + "/" + month + "/" + day;
	}
	
	function findUserAll() {
		$.ajax({
			type: 'POST',
			url: '/user/ajax/find/all',
			headers: {
		            "Content-Type": "application/json",
		            "X-HTTP-Method-Override": "POST"
	        },
	        data: JSON.stringify(search),
			success: function(result) {
				let html = "";
				let users = result.users.list;
				let pageInfo = result.users;
				let pageHtml = "";
				
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
				let hasPrev = pageInfo.hasPreviousPage;
				let hasNext = pageInfo.hasNextPage;

				if (hasPrev) {
					pageHtml += "<a href='#' class='paging' data-page='prev'> < </a>"
				}

				for(let i=0; i < pageInfo.pages; i++) {
					pageHtml += "<a href='#' class='paging' data-page='" + pageInfo.navigatepageNums[i] + "'> " + pageInfo.navigatepageNums[i] + " </a>";
				}

				if (hasNext) {
					pageHtml += "<a href='#' class='paging' data-page='next'> > </a>"
				}

				$("#pagination").html(pageHtml);

				$("#ajax_user #ajax_id").val("");
				$("#ajax_user #ajax_name").val("");
				$("#ajax_user #ajax_age").val("");

				search.page = pageInfo.pages;
				search.perPageNum = pageInfo.pageSize;
				search.keyword = result.search.keyword;
				search.content = result.search.content;
			},
			error: function(xhr) {
				let code = xhr.status;
			}
		});
	}
	
</script>
</html>