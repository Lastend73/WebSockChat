<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

		<html>

		<head>
			<title>Home</title>

			<style>
				#chatArea{
					border: 2px solid black;
					width: 500px;
					padding: 10px;
				}

				.receiveMsg{
					margin-bottom: 3px;
				}
				.SendMsg{
					margin-bottom: 3px;
					text-align: right;
				}
			</style>
		</head>

		<body>
			<h1>
				Hello world!
			</h1>

			<P> The time on the server is ${serverTime}. </P>

			<input type="text" id="sendMsg">
			<button onclick="msgSend()">전송</button>

			<hr>

			<div id="chatArea">
				<div class="receiveMsg">
					<!-- 받은 메세지 -->
					받은 메세지 출력
				</div>
				<div class="SendMsg">
					<!-- 보낸 메세지 -->
					보낸 메세지 출력
				</div>

			</div>


			<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
			
			<script type="text/javascript">
				var sock = new SockJS('chatSocket');

				//메세지 접속했을때
				sock.onopen = function () {
					console.log('open');
					// sock.send('test'); //서버로 메세지 전송
				};

				// 메세지 받을때
				sock.onmessage = function (e) {
					console.log('받은 메세지', e.data);
					// sock.close();
					let receiveMsgDiv = document.createElement('div');
					receiveMsgDiv.classList.add('receiveMsg');
					receiveMsgDiv.innerText = e.data;

					chatAreaDiv.appendChild(receiveMsgDiv);
				};
				
				//닫을때 작동하는 것
				sock.onclose = function () {
					console.log('close');
				};
			</script>

			<script>
				let chatAreaDiv = document.querySelector("#chatArea");

				function msgSend(){
					let msgInput = document.querySelector("#sendMsg");

					// console.log("보낸메세지 : " +msgInput.value); //chat 서버로 메세지 전송

					sock.send(msgInput.value); //send()는 메세지를 전송;
					
					let sendDiv = document.createElement('div');
					sendDiv.classList.add('sendMsg');
					sendDiv.innerText= msgInput.value;
					
					chatAreaDiv.appendChild(sendDiv); // 채팅 화면에 메세지 출력

					msgInput.value = ""; // input태그 초기화
				}
			</script>
		</body>

		</html>