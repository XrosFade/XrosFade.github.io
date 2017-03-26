<%@page import="java.net.URLConnection"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.net.URL"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<% String apiKey="RGAPI-1586E1FD-074E-41A6-8C03-57DEFA2D1491"; %>
<% String userNames = request.getParameter("userName"); %>


<%
	URL url = new URL(
			"https://kr.api.pvp.net/api/lol/kr/v1.4/summoner/by-name/" + userNames + "?api_key=" + apiKey);
	//URL url = new URL("https://kr.api.pvp.net/api/lol/kr/v1.4/summoner/by-name/mush?api_key="+apiKey);
	//URL url = new URL("https://kr.api.pvp.net/api/lol/kr/v2.2/matchlist/by-summoner/1257049?api_key="+apiKey);
	String line = null;
	StringBuffer sb = new StringBuffer();
	//HttpURLConnection connection = (HttpURLConnection) url.openConnection();
	//connection.setRequestMethod("GET");
	//connection.connect();
	if (userNames != null) {
		URLConnection connection = url.openConnection();
		BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
		line = reader.readLine();
		while(line!=null) 
		{ 
			sb.append(line);
			//line=dataScanner.nextLine(); 
			line = reader.readLine();
		}
		//dataScanner.close();
		reader.close();
	}
%>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="../lib/jquery-3.2.0.js"></script>
<meta charset="UTF-8">
<title>Hello summoner</title>

</head>

<body>
<script type="text/javascript">

document.write('<% out.print(sb.toString()); %>');

document.write('<%out.print(sb.length());%>');

<% if(userNames != null) {
	request.setAttribute("userName", userNames);
	request.setAttribute("apiKey", apiKey);
	request.setAttribute("summonerData", sb.toString());
	sb.delete(0, sb.length());

	RequestDispatcher disp = request.getRequestDispatcher("userData.jsp");
	disp.forward(request, response);
	//response.sendRedirect("userData.jsp"); //데이터를 get형식으로만 보낼 수 있으며 페이지 이동만 함
	} else {
		%>document.write('<%out.print("NO Data");%>');<%
	}

%>


</script>
</body>
</html>