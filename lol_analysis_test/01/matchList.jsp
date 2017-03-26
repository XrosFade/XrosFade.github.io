<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<% request.setCharacterEncoding("UTF-8"); %>
<% String apiKey = (String)request.getAttribute("apiKey"); %>

<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="../lib/jquery-3.2.0.js"></script>

<meta charset="EUC-KR">
<title>User Recently Game</title>
</head>
<body>
<script type="text/javascript">

	//var apiKey ="RGAPI-1586E1FD-074E-41A6-8C03-57DEFA2D1491"
	$(document).ready(function() {
		var dataLink =
			"https://kr.api.pvp.net/api/lol/kr/v2.2/matchlist/by-summoner/1257049?api_key=<%=apiKey%>";
		$.getJSON(dataLink)
		.done(function(data) {
			//document.write(data.games[0].gameId)
			console.log(data);
		})
	});
	
</script>
</body>
</html>