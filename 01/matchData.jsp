<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
	
	String apiKey = request.getParameter("apiKey");
	String gameId = (String)request.getAttribute("gameId");

	%>

<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="../lib/jquery-3.2.0.js"></script>

<meta charset="EUC-KR">
<title>User Recently Game</title>
</head>
<body>
<script type="text/javascript">

//	var apiKey ="RGAPI-1586E1FD-074E-41A6-8C03-57DEFA2D1491"
	$(document).ready(function() {
//		var dataLink =	"https://kr.api.pvp.net/api/lol/kr/v2.2/match/2764046886?api_key="+apiKey+"&includeTimeline=true";
		var dataLink =	"https://kr.api.pvp.net/api/lol/kr/v2.2/match/<%=gameId%>?api_key=<%=apiKey%>&includeTimeline=true";
		$.getJSON(dataLink)
		.done(function(gameData) {
			//document.write(data.games[0].gameId)
			console.log(gameData);
		})
	});
	
</script>
</body>
</html>