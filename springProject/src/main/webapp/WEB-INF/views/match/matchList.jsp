<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/match/matchList.css?v=<%=System.currentTimeMillis()%>">
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
</head>
<body>
<c:if test="${not empty challengeMsg}">
	<script type="text/javascript">
		alert('${challengeMsg}');
	</script>
</c:if>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<div id="container">
	<div id="upperStuff">
		<div id="filter">
			<select id="MatchListFilterDow" onchange="MatchListFilterDow();">
				<option>요일</option>
		        <option value="monday">월요일</option>
		        <option value="tuesday">화요일</option>
		        <option value="wednesday">수요일</option>
		        <option value="thursday">목요일</option>
		        <option value="friday">금요일</option>
		        <option value="saturday">토요일</option>
		        <option value="sunday">일요일</option>
		    </select>
			<select id="MatchListFilterLocation" onchange="MatchListFilterLocation();">
				<option>지역</option>
				<option value="서울">서울</option>
				<option value="경기">경기</option>
				<option value="충청">충청</option>
				<option value="대전">대전</option>
				<option value="강원">강원</option>
				<option value="경상">경상</option>
				<option value="대구">대구</option>
				<option value="부산">부산</option>
				<option value="전라">전라</option>
				<option value="광주">광주</option>
				<option value="제주">제주</option>
			</select>
			<select id="MatchListFilterGender" onchange="MatchListFilterGender();">
				<option>성별</option>
				<option value="M">남자</option>
				<option value="F">여자</option>
			</select>
		</div>
		<div id="search">
			<input id="MatchListFilterNick" type="text" placeholder="닉네임을 검색 해보세요 !">
			<input class="buttonWithSearch" id="searchButton" type="button" value="검색">
		</div>
		<div id="view">
			<input class="buttonWithSearch" type="button" value="전체보기" onclick="location.href='${pageContext.request.contextPath}/match/matchList.ma'">
			<input type="button" value="내등록" onclick="myReg('${loginMember.userId}', '${loginMember.userStatus}');">
			<input type="button" value="내신청" onclick="myChal('${loginMember.userId}', '${loginMember.userStatus}');">
		</div>
		<div id="matchButton">
			<button onclick="redirectToToday();">매치등록</button>
		</div>
	</div>
<div id="game">
	<div id="table">
		<table>
			<thead>
				<tr>
					<th width="10%">날짜</th>
					<th width="10%">시간</th>
					<th width="40%">장소</th>
					<th width="20%">닉네임</th>
					<th width="10%">프로필</th>
					<th width="10%">도전</th>
				</tr>
			</thead>
			<tbody>
				
					<c:forEach var="matchList" items="${matchList}">
						<tr>
							<td>${matchList.matchdatestring}</td>
							<td>${matchList.matchtime}</td>
							<td>${matchList.gymAddress}<br>${matchList.gymDetailaddress}</td>
							<td>${matchList.proNick}</td>
							<td>
								<button onclick="location.href='${pageContext.request.contextPath}/profile/profileDetail.pr?userId=${matchList.userId}'">프로필확인</button>
							</td>
							<td>
								<c:choose>
  <c:when test="${empty loginMember.userId}">
    <button id="challengeButton" onclick="challenge('${matchList.userId}', '${loginMember.userId}', '${loginMember.userStatus}', '${matchList.no}');">매칭도전신청</button>
  </c:when>
  <c:otherwise>
    <c:choose>
      <c:when test="${not empty matchList && matchList.userId1 == loginMember.userId}">
        <button id="challengeButton" onclick="regCancel('${matchList.matchNo}', '${matchList.userId1}', '${loginMember.userId}', '${loginMember.userStatus}');" style="background-color:tomato">매치등록취소</button>
      </c:when>
      <c:when test="${not empty matchList &&
                        (matchList.challenger1 == loginMember.userId ||
                         matchList.challenger2 == loginMember.userId ||
                         matchList.challenger3 == loginMember.userId ||
                         matchList.challenger4 == loginMember.userId ||
                         matchList.challenger5 == loginMember.userId)}">
       <button id="challengeButton" onclick="chalCancel('${matchList.no}', '${loginMember.userId}', '${loginMember.userStatus}');" style="background-color:pink">도전신청취소</button>

      </c:when>
      <c:otherwise>
        <button id="challengeButton" onclick="challenge('${matchList.userId}', '${loginMember.userId}', '${loginMember.userStatus}', '${matchList.no}');">매칭도전신청</button>
      </c:otherwise>
    </c:choose>
  </c:otherwise>
</c:choose>
							</td>
						</tr>
					</c:forEach>
			</tbody>
		</table>
	</div>	
</div>
	<nav aria-label="Page navigation example">
		<ul class="pagination justify-content-center">
			<c:if test="${pi.nowPage ne 1}">
				<li class="page-item">
					<a class="page-link" href="${pageContext.request.contextPath}/match/matchList.ma?nowPage=${pi.nowPage-1}" >Previous&emsp;</a>
				</li>
			</c:if>
			<c:forEach var="p" begin="${pi.startPage}" end="${pi.endPage}">
				<c:choose>
					<c:when test="${p eq pi.nowPage}">
						<li class="page-item active">
							<a class="page-link" href="${pageContext.request.contextPath}/match/matchList.ma?nowPage=${p}">&emsp;${p}&emsp;</a>
						</li>
					</c:when>
					<c:otherwise>
						<li class="page-item">
							<a class="page-link" href="${pageContext.request.contextPath}/match/matchList.ma?nowPage=${p}">&emsp;${p}&emsp;</a>
						</li>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<c:if test="${ pi.nowPage ne pi.totalPage }">
				<li class="page-item">
					<a class="page-link" href="${pageContext.request.contextPath}/match/matchList.ma?nowPage=${pi.nowPage+1}">Next</a>
				</li>
			</c:if>
		</ul>
	</nav>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
<script>
function redirectToToday() {
    var url = "${pageContext.request.contextPath}/match/matchReg.ma?userId=${loginMember.userId}&day=";
    
    window.location.href = url;
 }
	function MatchListFilterDow() {
		const dowFromSelect = document.getElementById("MatchListFilterDow").value;
		const url = "${pageContext.request.contextPath}/match/matchList.ma?dowFromSelect=" + dowFromSelect;
	    location.href = url;
	}
	function MatchListFilterGender() {
		const gender = document.getElementById("MatchListFilterGender").value;
		console.log(gender);
		const url = "${pageContext.request.contextPath}/match/matchList.ma?gender=" + gender
	    location.href = url;
	}
	function MatchListFilterLocation() {
		const locations = document.getElementById("MatchListFilterLocation").value;
		const url = "${pageContext.request.contextPath}/match/matchList.ma?locations=" + locations
	    location.href = url;
	}
	$("#searchButton").click(function() {
    	const searchInput = document.getElementById("MatchListFilterNick").value;
    	const url = "${pageContext.request.contextPath}/match/matchList.ma?searchInput=" + searchInput
    	location.href = url;
    });
	
	function challenge(userId1, userId2, userStatus, no) {
	    if(userId2 === "") {
	        alert("로그인을 먼저 하시고, 매치도전을 해주세요");
	    } else if(userStatus != 2) {
	    	alert("프로필을 먼저 등록 하시고, 매치도전을 해주세요");
	    } else if(userId1 === userId2) {
	    	alert("매치를 등록한 사람은, 본인 경기에 도전 할 수 없습니다");
	    } else {
	    	if (!confirm("신청하시겠습니까?")) {
	    		alert("취소를 누르셨습니다.");
	    	} else {
	    		const url = "${pageContext.request.contextPath}/match/challengerAdd.ma?no=" + no + "&userId2=" + userId2
		    	location.href = url;
	    	}
	     }
	    
	}
	
	function myReg(userId, userStatus) {
		if(userId === "") {
			alert("로그인을 먼저 하시고, 내등록을 클릭해주세요");
		} else if(userStatus != 2) {
	    	alert("프로필을 먼저 등록 하시고, 내등록을 클릭해주세요");
	    } else {
	    	const userId1 = userId;
	    	const url = "${pageContext.request.contextPath}/match/matchList.ma?userId1=" + userId1
	    	location.href = url;
	    }
	}
	
	function myChal(userId, userStatus) {
		if(userId === "") {
			alert("로그인을 먼저 하시고, 내신청을 클릭해주세요");
		} else if(userStatus != 2) {
	    	alert("프로필을 먼저 등록 하시고, 내신청을 클릭해주세요");
	    } else {
			const userId2 = userId;
	    	const url = "${pageContext.request.contextPath}/match/matchList.ma?userId2=" + userId2
	    	location.href = url;
		}
	}
	
	function regCancel(matchNo, userId1, userId, userStatus) {
		if(userId === "") {
			alert("로그인을 먼저 하시고, 등록취소를 클릭해주세요");
		} else if(userStatus != 2) {
	    	alert("프로필을 먼저 등록 하시고, 등록취소를 클릭해주세요");
	    } else if(userId1 != userId) {
	    	alert("해당 매치의 등록자가 아니면 취소 할 수 없습니다");
	    } else {
	    	const url = "${pageContext.request.contextPath}/match/regCancel.ma?matchNo=" + matchNo + "&userId1=" + userId1
	    	location.href = url;
		}
	}
	
	function chalCancel(no, userId, userStatus) {
		console.log(no)
		console.log(userId);
		console.log(userStatus);
		if(userId === "") {
			alert("로그인을 먼저 하시고, 도전취소를 클릭해주세요");
		} else if(userStatus != 2) {
	    	alert("프로필을 먼저 등록 하시고, 도전취소를 클릭해주세요");
	    } else {
	    	let userId2 = userId;
	    	const url = "${pageContext.request.contextPath}/match/chalCancel.ma?no=" + no + "&userId2=" + userId2
	    	location.href = url;
	    	console.log(url);
		}
	}
</script>
</html>