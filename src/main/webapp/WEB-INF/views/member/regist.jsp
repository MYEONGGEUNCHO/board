<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head> 
    <meta charset="utf-8">
    <title></title>
    <META name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, user-scalable=no"> 
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.css" />
    <link rel="stylesheet" href="/css/reset.css"/>
    <link rel="stylesheet" href="/css/style.css"/>
    <link rel="stylesheet" href="/css/contents.css"/>
    <script src="/js/script.js"></script>
    <script>
    	$(function(){
    		$(".email_check").click(function(){
    			if($("#email").val() == '') {
    				alert('이메일을 입력하세요');
    				$("#email").focus();
    			} else {
    				$.ajax({
    					url:'/member/emailCheck.do',
    					data : {email:$("#email").val()},
    					success : function(res) {
    						console.log(res);
    						if (res == '0') {
    							alert('사용 가능한 이메일입니다.');
    						} else {
    							alert('중복된 이메일입니다.\r\n다른 이메일을 입력해 주세요');
    						}
    					}
    				})
    			}
    		})
    	})
    </script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script>
    	$(function(){
    		$(".zipcodeFind, #zipcode").click(function(){
    			new daum.Postcode({
    	            oncomplete: function(data) {
    	                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

    	                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
    	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
    	                var roadAddr = data.roadAddress; // 도로명 주소 변수
    	                var extraRoadAddr = ''; // 참고 항목 변수

    	                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
    	                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
    	                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
    	                    extraRoadAddr += data.bname;
    	                }
    	                // 건물명이 있고, 공동주택일 경우 추가한다.
    	                if(data.buildingName !== '' && data.apartment === 'Y'){
    	                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
    	                }
    	                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
    	                if(extraRoadAddr !== ''){
    	                    extraRoadAddr = ' (' + extraRoadAddr + ')';
    	                }

    	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
    	                //document.getElementById('sample4_postcode').value = data.zonecode;
    	                //document.getElementById("sample4_roadAddress").value = roadAddr;
    	                //document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
    	                $("#zipcode").val(data.zonecode);
    	                $("#addr1").val(roadAddr);
    	            }
    	        }).open();
    		})
    	});
    	
    	function goSave() {
    		if($("#email").val().trim() == '') {
    			alert('이메일을 입력하세요');
    			$("#email").focus();
    			return;
    		}
    		var con = true;
    		$.ajax({
				url:'/member/emailCheck.do',
				data : {email:$("#email").val()},
				async : false,
				success : function(res) {
					console.log(res);
					if (res == '1') {
						alert('중복된 이메일입니다.\r\n다른 이메일을 입력해 주세요');
						con = false;
						return;
					}
				}
			});
    		if (!con) return;
    		if($("#pwd").val().trim() == '') {
    			alert('비밀번호를 입력하세요');
    			$("#pwd").focus();
    			return;
    		}
    		if ($("#pwd").val() != $("#pwd_check").val()) {
    			alert('비밀번호를 확인하세요');
    			return;
    		}
    		var reg = /^(?=.*[a-zA-Z])(?=.*[0-9]).{8,}$/;
    		if ($("#pwd").val().match(reg) == null) {
    			alert('비밀번호는 영문+숫자 조합으로 8자이상 입력하세요');
    			$("#pwd").val('');
    			$("#pwd_check").val('');
    			return;
    		}
    		if ($("#name").val().trim() == '') {
    			alert("이름을 입력하세요");
    			$("#name").focus();
    			return;
    		}
    		$("#frm").submit();
    	}
    </script>
</head> 
<body>
    <div class="wrap">
        <%@ include file="/WEB-INF/views/include/header.jsp" %>
        <div class="sub">
            <div class="size">
                <h3 class="sub_title">회원가입</h3>
                <form name="frm" id="frm" action="insert.do" method="post">
                <table class="board_write">
                    <caption>회원가입</caption>
                    <colgroup>
                        <col width="20%" />
                        <col width="*" />
                    </colgroup>
                    <tbody>
                        <tr>
                            <th>*이메일</th>
                            <td>
                                <input type="text" name="email" id="email" class="inNextBtn" style="float:left;">
                                <span class="email_check"><a href="javascript:;"  class="btn bgGray" style="float:left; width:auto; clear:none;">중복확인</a></span>
                            </td>
                        </tr>
                        <tr>
                            <th>*비밀번호</th>
                            <td><input type="password" name="pwd" id="pwd" style="float:left;"> <span class="ptxt">비밀번호는 숫자, 영문 조합으로 8자 이상으로 입력해주세요.</span> </td>
                        </tr>
                        <tr>
                            <th>*비밀번호<span>확인</span></th>
                            <td><input type="password" id="pwd_check" style="float:left;"></td>
                        </tr>
                        <tr>
                            <th>*이름</th>
                            <td><input type="text" name="name" id="name" style="float:left;"> </td>
                        </tr>
                        <tr>
                            <th>*성별</th>
                            <td>
                            <select name="gender" id="gender">
                            <option value="1">남성</option>
                            <option value="2">여성</option>
                            </select> 
                            </td>
                        </tr>
                        <tr>
                            <th>*생년월일</th>
                            <td><input type="text" name="birthday" id="birth" style="float:left;"> </td>
                        </tr>
                        <tr>
                            <th>*휴대폰 번호</th>
                            <td>
                                <input type="text" name="hp" id="hp" value=""  maxlength="15" style="float:left;">
                            </td>
                        </tr>
                        <tr>
                            <th>우편번호</th>
                            <td>
                                <input type="text" name="zipcode" id="zipcode" class="inNextBtn" style="float:left;" readonly>
                                <span class="zipcodeFind"><a href="javascript:;"  class="btn bgGray" style="float:left; width:auto; clear:none;">우편번호 검색</a></span>
                            </td>
                        </tr>
                        <tr>
                            <th>주소</th>
                            <td>
                                <input type="text" name="addr1" id="addr1" class="inNextBtn" style="float:left;" readonly>
                            </td>
                        </tr>
                        <tr>
                            <th>상세주소</th>
                            <td>
                                <input type="text" name="addr2" id="addr2" class="inNextBtn" style="float:left;">
                            </td>
                        </tr>
                    </tbody>
                </table>
                </form>
                <!-- //write--->
                <div class="btnSet clear">
                    <div><a href="javascript:;" class="btn" onclick="goSave();">가입</a> <a href="javascript:;" class="btn" onclick="history.back();">취소</a></div>
                </div>
            </div>
        </div>
        <%@ include file="/WEB-INF/views/include/footer.jsp" %>
        <div id="quickMenu">
            <div><img src="/img/quick_01.jpg"></div>
            <div><img src="/img/quick_02.jpg"></div>
            <div><img src="/img/quick_03.jpg"></div>
            <div><img src="/img/quick_04.jpg"></div>
            <div><img id="goTop" src="/img/quick_05.jpg"></div>
        </div>
    </div>
</body> 
</html>