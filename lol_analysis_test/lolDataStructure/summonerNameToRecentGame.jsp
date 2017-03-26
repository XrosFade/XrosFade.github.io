<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String apiKey="RGAPI-1586E1FD-074E-41A6-8C03-57DEFA2D1491"; %>

<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="../lib/jquery-3.2.0.js"></script>

<meta charset="EUC-KR">
<title>User Recently Game</title>
</head>
<body>
<script type="text/javascript">

	var summonerName = "태고의지식";
	$(document).ready(function() {		
		$.getJSON(
				"https://kr.api.pvp.net/api/lol/kr/v1.4/summoner/by-name/"
				+summonerName+"?api_key=<%=apiKey%>"
				)
				.done(function(userData) {
					console.log(userData);
					$.getJSON(
							"https://kr.api.pvp.net/api/lol/kr/v1.3/game/by-summoner/"
							+userData.id+"/recent?api_key=<%=apiKey%>"
							)
							.done(function(matchData) {
								console.log(matchData)
								for ( var i=0; matchData.games[i].gameId != null; i++) {
									$.getJSON(
											"https://kr.api.pvp.net/api/lol/kr/v2.2/match/"
											+matchData.games[i].gameId+
											"?api_key=<%=apiKey%>&includeTimeline=true"
									)
									.done(function(gameData) {
										console.log(gameData);
									})
								}
							})
				})
	});
	
</script>
</body>
</html>