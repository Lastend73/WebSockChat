<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <title>채팅 페이지</title>
        <style>
            #chatArea {
                border: 3px solid black;
                width: 500px;
                padding: 10px;
                border-radius: 10px;
                background-color: #9bbbd4;
                height: 500px;
                overflow: scroll;
            }

            #chatArea::-webkit-scrollbar{
                display: none;
            }

            .receiveMsg,
            .receiveid {
                margin-bottom: 3px;
            }

            .msgComment {
                display: inline-block;
                padding: 7px;
                border-radius: 7px;
                max-width: 220px;
            }

            .receiveMsg>.msgComment {
                background-color: #ffffff;
            }

            .SendMsg>.msgComment {
                background-color: #fef01b;
            }

            .connMsg {
                min-width: 300px;
                max-width: 300px;
                margin: 5px auto;
                margin-left: auto;
                ;
                margin-right: auto;
                text-align: center;
                background-color: #556677;
                color: white;
                border-radius: 10px;
                padding: 5px;
            }


            .SendMsg {
                margin-bottom: 3px;
                text-align: right;
            }

            .connMsg {
                font-size: 13px;
                font-weight: bold;
            }

            .receiveMsg,
            .SendMsg {
                margin-bottom: 5px;
            }

            #inputMsg>input{
                width: 100%;
                padding: 5px;
            }
            #inputMsg>button{
                width: 100px;
                padding: 5px;
            }
            #inputMsg{
                display: flex;
                /* box-sizing: border-box; */
                width: 500px;
                padding: 10px;
                border-radius: 10px;
                border: 3px solid black;
            }
        </style>
    </head>

    <body>
        <h1>chatPage.jsp - ${sessionScope.loginId}</h1>

        <hr>
        
        
        <div id="chatArea">
            <div class="receiveMsg">
                <div class="msgId">아이디</div>
                <div class="msgComment">받은메세지</div>
            </div>
            <div class="SendMsg">
                <!-- 보낸 메세지 -->
                <div class="msgComment">보낸메세지</div>
            </div>
            <div class="connMsg"> 접속/접속헤제
                
            </div>
        </div>
        <div id="inputMsg">
            <input type="text" id="sendMsg">
            <button onclick="sendMsg()">전송</button>
        </div>


        <script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
        <script>

            // 시작할때
            var sock = new SockJS('chatPage');
            sock.onopen = function () {
                console.log('open');
                // sock.send('test');
            };

            // 메세지 받을떄
            sock.onmessage = function (e) {
                console.log('message', e.data);

                let msgObj = JSON.parse(e.data);
                // console.log("msgtype :" + msgObj.msgtype);
                // console.log("msgid :" + msgObj.msgid);
                // console.log("msgcomm :" + msgObj.msgcomm);

                let mtype = msgObj.msgtype;
                switch (mtype) {
                    case "m":
                        printMessage(msgObj); //메세지 출력 기능
                        break;
                    case "c": ;
                    case "d":
                        printConnect(msgObj); //접속 정보 출력 기능
                        break;
                }


            };

            // 나갈떄
            sock.onclose = function () {
                console.log('close');
            };





            let chatAreaDiv = document.querySelector("#chatArea");

            //받을때
            function printMessage(msgObj) {

                console.log("메세지 출력 기능")
                let receiveMsgDiv = document.createElement('div');
                receiveMsgDiv.classList.add('receiveMsg');

                let msgIdDiv = document.createElement('div');
                msgIdDiv.classList.add('msgId');
                msgIdDiv.innerText = msgObj.sendid;

                receiveMsgDiv.appendChild(msgIdDiv)
                receiveMsgDiv.setAttribute("tabindex","0");

                let msgCommentDiv = document.createElement('div');

                msgCommentDiv.classList.add('msgComment');
                msgCommentDiv.innerText = msgObj.message;

                receiveMsgDiv.appendChild(msgCommentDiv);

                chatAreaDiv.appendChild(receiveMsgDiv);
                receiveMsgDiv.focus();

            }

            //나갈때
            function printConnect(msgObj) {

                console.log("접속정보 출력 기능");

                let connMsgDiv = document.createElement('div');
                connMsgDiv.classList.add('connMsg');
                connMsgDiv.innerText = msgObj.msgid + "이/가" + msgObj.msgcomm;

                connMsgDiv.setAttribute("tabindex","0");

                chatAreaDiv.appendChild(connMsgDiv);
                connMsgDiv.focus();

            }
            // 보낼때
            function sendMsg() {

                let msgInput = document.querySelector("#sendMsg");

                sock.send(msgInput.value);

                let sendMsgDiv = document.createElement('div');
                sendMsgDiv.classList.add('SendMsg');

                let msgCommDiv = document.createElement('div');
                msgCommDiv.classList.add('msgComment');
                msgCommDiv.innerText = msgInput.value;
                
                sendMsgDiv.setAttribute("tabindex","0");

                sendMsgDiv.appendChild(msgCommDiv);

                chatAreaDiv.appendChild(sendMsgDiv);

                msgInput.value = "";

                sendMsgDiv.focus();

            }
        </script>

    </body>

    </html>