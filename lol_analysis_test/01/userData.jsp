<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<% request.setCharacterEncoding("UTF-8"); %>

<%
String apiKey = (String)request.getAttribute("apiKey"); 
//String apiKey = "RGAPI-1586E1FD-074E-41A6-8C03-57DEFA2D1491";
%>
<%
String summonerData = (String)request.getAttribute("summonerData");
String userName = (String)request.getAttribute("userName");
%>

<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="../lib/jquery-3.2.0.js"></script>

<meta charset="UTF-8">
<title>User Recently Game</title>
</head>
<body>


<table border="1" id="recentDataTable">
</table>
<br>
 
<table border="1" id="gameDetailTable">
</table>
<table border="1" id="timelineButtonTable">
</table>

<br>
<table border="1" id="timelineDataTable">
</table>	

<br>
<table border="1" id="timelineEventsTable">
</table>


<script type="text/javascript">

	var arrayGameId = new Array();
	var summonerJson = JSON.parse('<%=summonerData%>');
	var gameDetailString = "";
	var gameDetailData;
	
	document.write(summonerJson.<%=userName%>.id);
	//var apiKey ="RGAPI-1586E1FD-074E-41A6-8C03-57DEFA2D1491"
	
	//ready
	$(document).ready(function() {
		var dataLink = "https://kr.api.pvp.net/api/lol/kr/v1.3/game/by-summoner/"+summonerJson.<%=userName%>.id+"/recent?api_key=<%=apiKey%>"
				//console.log(dataLink);
		$.getJSON(dataLink).done(function(gameData) {
			var gamesLength = gameData.games.length;
//			console.log(gamesLength);
			var tableData ="";
			tableData += "<tr>"
			tableData += "<td>gameMode</td>"
			tableData += "<td>gameId</td>"
			tableData += "<td>gameType</td>"
			tableData += "<td>champId</td>"
			tableData += "</tr>"
			
			for(var i=0; i<gamesLength; i++) {
				arrayGameId[i] = gameData.games[i].gameId;
				tableData += "<tr><th>"
				tableData += gameData.games[i].gameMode;
				tableData += "</th><td>";
		        tableData += gameData.games[i].gameId;
		        tableData += "</td><td>";
		        tableData += gameData.games[i].gameType;
		        tableData += "</td><td>";
		        tableData += gameData.games[i].championId;
		        tableData += "</td><td>";
		        tableData += "<button id='"+i+"' onClick='getMatchData(this.id)'>Detail..</button>";
		        tableData += "</td></tr>";
			}
//			console.log(tableData);
	        document.getElementById("recentDataTable").innerHTML = tableData;
			console.log(gameData);

		})
		.fail(function() {console.log('getJSON request Failed!')})
//		console.log(arrayGameId);
	});
	
	// 매치 데이터를 받아오는 값
	function getMatchData(id) {
		//
//		console.log(arrayGameId);
//		alert(arrayGameId[id]);
		
// 		var formData = new FormData();
// 		formData.append("gameId", arrayGameId[id]);
<%-- 		formData.append("apiKey", "<%=apiKey%>"); --%>
// 		formData.action = "matchData.jsp";
// 		$(formData).submit();

/* 		$.ajax({
			url : "matchData.jsp",
			method : "POST",
			data : formData,
			processData : false,
			contentType : false,
			success : function(data) {
				console.log(data);
				alert(arrayGameId[id]);
				$("formData").submit();
			},
			error : function(e) {
				alert(e.responseText);
			}
		}); */
		var dataLink =	"https://kr.api.pvp.net/api/lol/kr/v2.2/match/"+arrayGameId[id]+"?api_key=<%=apiKey%>&includeTimeline=true";

		$.getJSON(dataLink).done(function(gameDetail) {
			//document.write(data.games[0].gameId)
			console.log(gameDetail);
			var timelineLength = gameDetail.timeline.frames.length;
			var tableData = "";
			var timeTableData = "";
			tableData += "<tr>"
			tableData += "<td>게임생성시간</td>"
			tableData += "<td>게임진행시간</td>"
			tableData += "<td>게임종류</td>"
			tableData += "<td>게임형태</td>"
			tableData += "<td>국가</td>"
			tableData += "<td>season</td>"			
			tableData += "</tr>"
			
			tableData += "<tr><td>";			
			tableData += gameDetail.matchCreation;			
	        tableData += "</td><td>";
	        tableData += gameDetail.matchDuration;
	        tableData += "</td><td>";
	        tableData += gameDetail.matchMode;
	        tableData += "</td><td>";
	        tableData += gameDetail.matchType;
	        tableData += "</td><td>";
	        tableData += gameDetail.region;
	        tableData += "</td><td>";
	        tableData += gameDetail.season;
	        tableData += "</td></tr>";
	        
	        document.getElementById("gameDetailTable").innerHTML = tableData;
 	        timeTableData += "<tr>";
	        for(var i=0; i<timelineLength; i++) {
		        timeTableData += "<td>";
		        timeTableData += "<input type='button' id='"+i+"' onClick='getTimelineData(this.id)' value="+(i+1)+":00>";
		        timeTableData += "</td>";
		        if((i+1)%10 == 0) {
		        	timeTableData += "</tr>";
		        }
		        else if(i == timelineLength) {
		        	timeTableData += "</tr>";
		        }
		    }
 	        
 	        document.getElementById("timelineButtonTable").innerHTML = timeTableData;
 	        gameDetailString = JSON.stringify(gameDetail);
 	        gameDetailData = JSON.parse(gameDetailString);
		})
	}
	
	// 선택된 id에 해당하는 타임라인데이터(1분, 2분..)를 받아오는 함수
	function getTimelineData(id) {
//		console.log(gameDetailString);
		
//		console.log(gameDetailData);
		
		
		var timeDetailData = gameDetailData.timeline.frames[id];
		var timeDetailTableData = "";
		var milliSeconds = timeDetailData.timestamp;


		
		console.log(timeDetailData);

		timeDetailTableData += "<tr>";
		
		timeDetailTableData += "<td>유저 번호</td>";
		timeDetailTableData += "<td>레벨</td>";
		timeDetailTableData += "<td>현재 가진 골드</td>";
		timeDetailTableData += "<td>dominionScore</td>";
		timeDetailTableData += "<td>잡은 정글 미니언 수</td>";
		timeDetailTableData += "<td>잡은 미니언 수</td>";
		timeDetailTableData += "<td>상세 위치</td>";
		timeDetailTableData += "<td>팀 스코어</td>";
		timeDetailTableData += "<td>총 획득 골드</td>";
		timeDetailTableData += "<td>획득 경험치</td>";
		timeDetailTableData += "</tr>";

		// timestamp = 1/1000 seconds(milliseconds)
		//participantFrames는 1부터 10까지
		// participantFrames의 속성 목록
		// currentGold : 현재 가진 골드
		// dominionScore : 도미니언 모드에서의 점수(도미니언 모드에서만 유효)
		// jungleMinionsKilled : 잡은 정글 미니언 수
		// level : 캐릭터 레벨
		// minionsKilled : 잡은 미니언 수
		// participantId : 이 게임에서의 유저번호
		// position : 현재 위치(position.x , position.y)
		// teamScore : 팀 전체 킬수
		// totalGold : 총 획득 골드
		// xp : 획득 경험치
		
		
		for(var i=1; i<11; i++) {
			timeDetailTableData += "<tr><td>"

			timeDetailTableData += timeDetailData.participantFrames[i].participantId;
			timeDetailTableData += "</td><td>"
			timeDetailTableData += timeDetailData.participantFrames[i].level;
			timeDetailTableData += "</td><td>"
			timeDetailTableData += timeDetailData.participantFrames[i].currentGold;
			timeDetailTableData += "</td><td>"
			timeDetailTableData += timeDetailData.participantFrames[i].dominionScore;
			timeDetailTableData += "</td><td>"
			timeDetailTableData += timeDetailData.participantFrames[i].jungleMinionsKilled;
			timeDetailTableData += "</td><td>"
			timeDetailTableData += timeDetailData.participantFrames[i].minionsKilled;
			timeDetailTableData += "</td><td>"
			timeDetailTableData += timeDetailData.participantFrames[i].position.x +
				", " + timeDetailData.participantFrames[i].position.y;
			timeDetailTableData += "</td><td>"
			timeDetailTableData += timeDetailData.participantFrames[i].teamScore;
			timeDetailTableData += "</td><td>"
			timeDetailTableData += timeDetailData.participantFrames[i].totalGold;
			timeDetailTableData += "</td><td>"
			timeDetailTableData += timeDetailData.participantFrames[i].xp;
			
			timeDetailTableData += "</td></tr>"
		}
		
			document.getElementById("timelineEventsTable").innerHTML = 
				milliSeconds > 50 ? getTimelineEventsData(timeDetailData.events) : "";
		
//		timeDetailTableData += "<tr>";
//		timeDetailTableData += "<td>";
//		timeDetailTableData += timeDetailData.participantFrames[2].currentGold;
//		timeDetailTableData += "</td>";
//		timeDetailTableData += "</tr>";
		
		document.getElementById("timelineDataTable").innerHTML = timeDetailTableData;
	}
	
	function getTimelineEventsData(timelineEvents) {
		var timeDetailEventsTableData = "";

		var eventsLength = timelineEvents.length;
		
		for(var i=0; i<eventsLength; i++) {
			timeDetailEventsTableData += "<tr><td>"
			
			timeDetailEventsTableData += timelineEvents[i].eventType;
			
			timeDetailEventsTableData += "</td></tr>"
		}		

		return timeDetailEventsTableData;
	}
	
	function getTimeCounter(timestamp) {
	    var t = parseInt(timestamp);
	    var days = parseInt(t / 86400);
	    t = t - (days * 86400);
	    var hours = parseInt(t / 3600);
	    t = t - (hours * 3600);
	    var minutes = parseInt(t / 60);
	    t = t - (minutes * 60);
	    var content = "";
	    if (days) content += days + " days";
	    if (hours || days) {
	        if (content) content += ", ";
	        content += hours + ":";
	    }
	    if (content) content += ", ";
	    content += minutes + ":" + t;
//	    document.getElementById('result4').innerHTML = content;
		return content;
	}
	
	//var gameid = $("span").data("gameid1");
	//$("p").eq(0).text(gameid);
		
</script>

</body>
</html>