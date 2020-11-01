<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.stream.*"%>
<%@ page import="com.emp.model.*"%>

<%

Map<String, String> chatNames = new HashMap<String, String>();
EmpService es = new EmpService();
List<EmpVO> empList = es.selectAllEmp();
chatNames = empList.stream().collect(Collectors.toMap(EmpVO::getEmpId, EmpVO::getEmpName));
Set<Map.Entry<String, String>> entries = chatNames.entrySet();
Stream<Map.Entry<String, String>> entriesStream = entries.stream();
String theName = entriesStream.filter(name -> name.getKey().equals("EMP00007")).map(Map.Entry::getValue).findFirst().get();
pageContext.setAttribute("theName", theName);

%>

<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="Ansonika">

  <style>


/* The popup chat - hidden by default */
.chat-popup {
  display: none;
  position: fixed;
  bottom: 80px;
  right: 15px;
  border: 3px solid #f1f1f1;
  z-index: 9;
}

/* Add styles to the form container */
.form-container {
  max-width: 300px;
  padding: 10px;
  background-color: white;
  height: 200px
}

/* Full-width textarea */
.form-container messagesArea {
  width: 100%;
  padding: 15px;
  margin: 5px 0 22px 0;
  border: none;
  background: #f1f1f1;
  resize: none;
  min-height: 200px;
}

/* When the textarea gets focus, do something */
.form-container textarea:focus {
  background-color: #ddd;
  outline: none;
}

/* Set a style for the submit/send button */
.form-container .btn {
  border: none;
  cursor: pointer;
  margin-bottom:10px;
  opacity: 0.8;
  
}

/* Add a red background color to the cancel button */
.form-container .cancel {
  background-color: red;
}

/* Add some hover effects to buttons */
.form-container .btn:hover, .open-button:hover {
  opacity: 1;
}


.message-area {
    height: 200px;
    resize: none;
    box-sizing: border-box;
    overflow: auto;
    background-color: #ffffff;
}

.panel {
	border: 2px solid #0078ae;
	border-radius: 5px;
	bottom :0%;
}


<%--
.input-area {
	background: #0078ae;
	box-shadow: inset 0 0 10px #00568c;
}

.input-area input {
	margin: 0.5em 0em 0.5em 0.5em;
}

.text-field {
	border: 1px solid grey;
	padding: 0.2em;
	box-shadow: 0 0 5px #000000;
}

h1.chat {
	font-size: 1.0em;
	padding: 5px;
	margin: 5px;
}


#message {
	min-width: 50%;
	max-width: 60%;
}



.statusOutput {
	background: #0078ae;
	text-align: center;
	color: #ffffff;
	border: 1px solid grey;
	padding: 0.2em;
	box-shadow: 0 0 5px #000000;
	width: 30%;
	margin-top: 10%;
	margin-left: 60%;
}


#row {
	float: left;
	width: 50%;
}

.column {
  float: left;
  width: 50%;
  padding: 5%;
  margin-bottom: 5px;
  background-color: #ffffff;
}


.friend + .me{
  border-bottom-right-radius: 5px;
}

.me + .me{
  border-top-right-radius: 5px;
  border-bottom-right-radius: 5px;
}

.me:last-of-type {
  border-bottom-right-radius: 30px;
}
--%>

h1.chat {
	font-size: 1.0em;
	padding: 5px;
	margin: 5px;
}

#area {
  width: auto;
  display: flex;
  flex-direction: column;
  padding: 10px;
 
    margin-top: 0px;
    margin-bottom: 0px;
}

.message {
  border-radius: 20px;
  padding: 8px 15px;
  margin-top: 5px;
  margin-bottom: 5px;
  display: inline-block;
}

.messages {
  border-radius: 20px;
  padding: 8px 15px;
  margin-top: 5px;
  margin-bottom: 5px;
  display: inline-block;
}

.friend {
  align-items: flex-start;
}

.friend .message{
  margin-right: 20%;
  background-color: #eee;
  position: relative;
  left: -10px;
}

.friend .message.last:before {
  content: "";
  position: absolute;
  z-index: 0;
  bottom: 0;
  left: -7px;
  height: 20px;
  width: 20px;
  background: #eee;
  border-bottom-right-radius: 15px;
}
.friend .message.last:after {
  content: "";
  position: absolute;
  z-index: 1;
  bottom: 0;
  left: -10px;
  width: 10px;
  height: 20px;
  background: white;
  border-bottom-right-radius: 10px;
}

.me {
  align-items: flex-end;
  }

.me .message {
  color: white;
  margin-left: 20%;
  float: left;
  background: linear-gradient(to bottom, #00D0EA 0%, #0085D1 100%);
  background-attachment: fixed;
  position: relative;
  left: 5%;
  float: right;
}

.time{
    font-size: 0.01em;
	position: relative;
	left: 5%;
	float: right;
}

.me .message.last:before {
  content: "";
  position: absolute;
  z-index: 0;
  bottom: 0;
  right: -8px;
  height: 20px;
  width: 20px;
  background: linear-gradient(to bottom, #00D0EA 0%, #0085D1 100%);
  background-attachment: fixed;
  border-bottom-left-radius: 15px;
}

.me .message.last:after {
  content: "";
  position: absolute;
  z-index: 1;
  bottom: 0;
  right: -10px;
  width: 10px;
  height: 20px;
  background: white;
  border-bottom-left-radius: 10px;
}

#closebtn{
    position: absolute; /*會找父類別位移*/
    right: 0;
    top: 0px;
    /*設定重疊時的前後,數字大在前*/
    z-index: 2;

}



</style>

</head>





<%-- 
<div class="chat-popup" id="myForm">
  <form action="/action_page.php" class="form-container">
    <h1>Chat</h1>
	
    <label for="msg"><b>Message</b></label>
	<div id="messagesArea" class="panel message-area" ></div>
    <input id="message" class="text-field" type="text" placeholder="Message" onkeydown="if (event.keyCode == 13) sendMessage();" /> 
    <button type="button" class="btn cancel" onclick="closeForm()">Close</button>
  </form>
</div>
--%>
<body>
<div class="chat-popup" id="myForm" style="height: 350px; background-color: white;">
  <div class="form-container">
    <h1 class="chat">${loginEmp.empName}</h1>
   	<label for="conv"><b>To: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b></label>
   	<select id="receiver" size="1" class="receiver">
	</select>
    <%-- <h3 id="statusOutput" class="statusOutput"></h3> --%>
	<div id="messagesArea" class="panel message-area" ></div>
	<div class="panel input-area">
		<input id="message" class="text-field" type="text" placeholder="Message" onkeydown="if (event.keyCode == 13) sendChatMessage();" /> 
		<button type="submit" id="sendMessage" class="btn btn-link" onclick="sendChatMessage();">
			<svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-caret-right-fill" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
			  <path d="M12.14 8.753l-5.482 4.796c-.646.566-1.658.106-1.658-.753V3.204a1 1 0 0 1 1.659-.753l5.48 4.796a1 1 0 0 1 0 1.506z"/>
			</svg>
		</button> 
	</div>
	 <button name="delete" type="submit" class="btn btn-link" id="closebtn" onclick="closeForm();">
	 	<svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-x-square-fill" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
			<path fill-rule="evenodd" d="M2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2zm3.354 4.646a.5.5 0 1 0-.708.708L7.293 8l-2.647 2.646a.5.5 0 0 0 .708.708L8 8.707l2.646 2.647a.5.5 0 0 0 .708-.708L8.707 8l2.647-2.646a.5.5 0 0 0-.708-.708L8 7.293 5.354 4.646z"/>
		</svg>
	 </button>
  </div>
</div>

</body>
<script>
	var MyPoint = "/FriendWS/${loginEmp.empId}";
	var host = window.location.host;
	var path = window.location.pathname;
	var webCtx = path.substring(0, path.indexOf('/', 1));
	var endPointURL = "ws://" + window.location.host + webCtx + MyPoint;

	var messagesArea = document.getElementById("messagesArea");
	var self = '${loginEmp.empId}';
	var chatWebSocket;
	
	var array = [];
	var idName;
	
	
	
	function clickToChat(objButton) {
		  document.getElementById("myForm").style.display = "block";
		  
		  var friend = objButton.value;
		  $.when($.ajax({
			    type: 'POST',
			    url: '<%=request.getContextPath()%>/EmpServlet',
			    dataType: "json",
			    data: {
			    	action: 'selectAllEmpIdName',
			    },
			    success: function(data) {
			    },
			})).done(function (data){
				 <%--
				  var datetime = "Last Sync: " + currentdate.getDate() + "/"
		          + (currentdate.getMonth()+1)  + "/" 
		          + currentdate.getFullYear() + " @ "  
		          + currentdate.getHours() + ":"  
		          + currentdate.getMinutes() + ":" 
		          + currentdate.getSeconds();
				  --%>
				  
				  if(array.length === 0){
					  console.log("FUCKK11111")
						array.push(friend);
						let name_array = JSON.stringify(array);
						sessionStorage.setItem('name_array', name_array);
						var option = document.createElement("option");
						option.text = data.map[friend];
						receiver.add(option);
					}else{
						if(!array.includes(friend)){
							console.log("FUCKK22222")
					        array.push(friend);
					        let name_array = JSON.stringify(array);
							sessionStorage.setItem('name_array', name_array);
							var option = document.createElement("option");
							option.text = data.map[friend];
							receiver.add(option);
							$('#receiver > option').each(function() {
								console.log("FUCKK3333355555")
								if(this.value === data.map[friend]){
									console.log("this.value:"+this.value)
									console.log("data.map[friend]:"+data.map[friend])
									this.selected = true;
								}
							})
							
						}else{
							console.log("FUCKK33333")
							$('#receiver > option').each(function() {
								console.log("FUCKK3333355555")
								if(this.value === data.map[friend]){
									console.log("this.value:"+this.value)
									console.log("data.map[friend]:"+data.map[friend])
									this.selected = true;
								}
							})
							console.log("FUCKK44444")
						}
				   	}
				  
				  chatListener();
				  
					// create a websocket
					chatWebSocket = new WebSocket(endPointURL);
					chatWebSocket.onopen = function(event) {
						console.log("ChatConnect Success!");
					};

					chatWebSocket.onmessage = function(event) {
						var jsonObj = JSON.parse(event.data);
						if ("open" === jsonObj.type) {
							
							var jsonObj = {
									"type" : "history",
									"sender" : self,
									"receiver" : friend,
									"message" : "",
									"time" : datetime
								};
							chatWebSocket.send(JSON.stringify(jsonObj));
						} else if ("history" === jsonObj.type) {
							messagesArea.innerHTML = '';
							var ul = document.createElement('ul');
							ul.id = "area";
							messagesArea.appendChild(ul);
							
							// 這行的jsonObj.message是從redis撈出跟好友的歷史訊息，再parse成JSON格式處理
							var messages = JSON.parse(jsonObj.message);
							for (var i = 0; i < messages.length; i++) {
								var historyData = JSON.parse(messages[i]);
								var showMsg = historyData.message;
								var datetime = historyData.time;
								var li = document.createElement('li');
								var div = document.createElement('div');
								var span = document.createElement('span');
								var newContent = historyData.sender === self ? document.createTextNode('我: ' + showMsg) : document.createTextNode(data.map[historyData.sender] + ': ' + showMsg);
								// 根據發送者是自己還是對方來給予不同的class名, 以達到訊息左右區分
								historyData.sender === self ? li.className += 'me messages' : li.className += 'friend messages';
								historyData.sender === self ? div.className += 'me message last' : div.className += 'friend message last';
								ul.appendChild(li);
								li.appendChild(div);
								li.appendChild(span);
								span.innerHTML = datetime;
								div.appendChild(newContent);
							}
							messagesArea.scrollTop = messagesArea.scrollHeight;
						} else if ("chat" === jsonObj.type && friend === jsonObj.sender && self === jsonObj.receiver) {
							var currentdate = new Date(); 
							var datetime = currentdate.getHours()  + ":" + currentdate.getMinutes() + ":" + currentdate.getSeconds();
							var li = document.createElement('li');
							var div = document.createElement('div');
							var span = document.createElement('span');
							div.className  = "message last";
							var newContent = jsonObj.sender === self ? document.createTextNode('我: ' + jsonObj.message) : document.createTextNode(data.map[jsonObj.sender] + ': ' + jsonObj.message);
							jsonObj.sender === self ? li.className += 'me messages' : li.className += 'friend messages';
							console.log(li);
							document.getElementById("area").appendChild(li);
							li.appendChild(div);
							div.appendChild(newContent);
							li.appendChild(span);
							span.innerHTML = datetime;
							messagesArea.scrollTop = messagesArea.scrollHeight;
							
							
							
						} else if ("close" === jsonObj.type) {
							console.log("FUCKKKoff")
						}
						
					};

					chatWebSocket.onclose = function(event) {
						console.log("ChatDisconnected!");
					};
			})
		  
		 
		  
	}

	function sendChatMessage() {
		$.when($.ajax({
		    type: 'POST',
		    url: '<%=request.getContextPath()%>/EmpServlet',
		    dataType: "json",
		    data: {
		    	action: 'selectAllEmpIdNameR',
		    },
		    success: function(data) {
		    },
		})).done(function (data){
			var currentdate = new Date(); 
			var datetime = currentdate.getHours()  + ":" + currentdate.getMinutes() + ":" + currentdate.getSeconds();
			var inputMessage = document.getElementById("message");
			var friend = document.getElementById("receiver").value;
			var selcetId = data.map[friend];
			var message = inputMessage.value.trim();

				var jsonObj = {
					"type" : "chat",
					"sender" : self,
					"receiver" : selcetId,
					"message" : message,
					"time" : datetime
				};
				chatWebSocket.send(JSON.stringify(jsonObj));
				inputMessage.value = "";
				inputMessage.focus();
				
				var li = document.createElement('li');
				var div = document.createElement('div');
				var span = document.createElement('span');
				div.className  = "message last";
				var newContent = document.createTextNode('我: ' + jsonObj.message);
				li.className += 'me messages';
				span.className += 'time';
				document.getElementById("area").appendChild(li);
				li.appendChild(div);
				div.appendChild(newContent);
				li.appendChild(span);
				span.append(datetime);
				messagesArea.scrollTop = messagesArea.scrollHeight;
			
		});
		
		
	}

	// 有好友上線或離線就更新列表

	// 註冊列表點擊事件並抓取好友名字以取得歷史訊息
	
	function chatListener() {
		$.when($.ajax({
		    type: 'POST',
		    url: '<%=request.getContextPath()%>/EmpServlet',
		    dataType: "json",
		    data: {
		    	action: 'selectAllEmpIdNameR',
		    },
		    success: function(data) {
		    },
		})).done(function (data){
			var receiver = document.getElementById("receiver");
			receiver.addEventListener("change", function(e) {
				chatWebSocket = new WebSocket(endPointURL);
				var optionName = e.target.value;
				var selectId = data.map[optionName];
				
				chatWebSocket.onopen = function(event) {
					console.log("ChatListenerConnect Success!");
				};
				chatWebSocket.onmessage = function(event) {
					var jsonObj = JSON.parse(event.data);
					if ("open" === jsonObj.type && chatWebSocket.readyState === 1) {
						
						var jsonObj = {
								"type" : "history",
								"sender" : self,
								"receiver" : selectId,
								"message" : "",
								"time" : ""
							};
						chatWebSocket.send(JSON.stringify(jsonObj));
					} else if ("history" === jsonObj.type) {
						messagesArea.innerHTML = '';
						var ul = document.createElement('ul');
						ul.id = "area";
						messagesArea.appendChild(ul);
						
						// 這行的jsonObj.message是從redis撈出跟好友的歷史訊息，再parse成JSON格式處理
						var messages = JSON.parse(jsonObj.message);
						for (var i = 0; i < messages.length; i++) {
							var historyData = JSON.parse(messages[i]);
							var showMsg = historyData.message;
							var datetime = historyData.time;
							var li = document.createElement('li');
							var div = document.createElement('div');
							var span = document.createElement('span');
							var newContent = historyData.sender === self ? document.createTextNode('我: ' + showMsg) : document.createTextNode(optionName + ': ' + showMsg);
							// 根據發送者是自己還是對方來給予不同的class名, 以達到訊息左右區分
							historyData.sender === self ? li.className += 'me messages' : li.className += 'friend messages';
							historyData.sender === self ? div.className += 'me message last' : div.className += 'friend message last';
							ul.appendChild(li);
							li.appendChild(div);
							div.appendChild(newContent);
							li.appendChild(span);
							span.innerHTML = datetime;
						}
						messagesArea.scrollTop = messagesArea.scrollHeight;
						
					} else if ("chat" === jsonObj.type && selectId === jsonObj.sender && self === jsonObj.receiver) {
						var currentdate = new Date(); 
						var datetime = currentdate.getHours()  + ":" + currentdate.getMinutes() + ":" + currentdate.getSeconds();
						var li = document.createElement('li');
						var div = document.createElement('div');
						var span = document.createElement('span');
						div.className  = "message last";
						var newContent = jsonObj.sender === self ? document.createTextNode('我: ' + jsonObj.message) : document.createTextNode(optionName + ': ' + jsonObj.message);
						jsonObj.sender === self ? li.className += 'me messages' : li.className += 'friend messages';
						document.getElementById("area").appendChild(li);
						li.appendChild(div);
						div.appendChild(newContent);
						li.appendChild(span);
						span.innerHTML = datetime;
						messagesArea.scrollTop = messagesArea.scrollHeight;
						
				        
						
					} else if ("close" === jsonObj.type) {
						console.log("FUCKKKoff")
					}
				}
					
				chatWebSocket.onclose = function(event) {
					console.log("ChatListenerDisconnected!");
				};
			});
		});
	}

	function disconnect() {
		chatWebSocket.close();
	}
	
	
	function closeForm() {
		  document.getElementById("myForm").style.display = "none";
		}
	
	function openChat() {
		$.when($.ajax({
		    type: 'POST',
		    url: '<%=request.getContextPath()%>/EmpServlet',
		    dataType: "json",
		    data: {
		    	action: 'selectAllEmpIdName',
		    },
		    success: function(data) {
		    },
		})).done(function (data){
			var receiver = document.getElementById("receiver");
			
			  if(sessionStorage.getItem("name_array") === null){
				  document.getElementById("myForm").style.display = "block";
			  }else{
				  document.getElementById("myForm").style.display = "block";
				  chatListener();
					$('#receiver > option').each(function() {
							this.remove();
					})
					
				  var name_array = sessionStorage.getItem("name_array");
					array = JSON.parse(name_array);
					array.forEach(function(item){
						var option = document.createElement("option");
						option.text = data.map[item];
						receiver.add(option);
			  		})
			  }
			  
			  var receiverName = document.getElementById("receiver").value;
			  console.log('receiverName:'+receiverName);
			  
				$.when($.ajax({
				    type: 'POST',
				    url: '<%=request.getContextPath()%>/EmpServlet',
				    dataType: "json",
				    data: {
				    	action: 'selectAllEmpIdNameR',
				    },
				    success: function(data) {
				    },
				})).done(function (data){
					var friend = data.map[receiverName];
					console.log('friend:'+friend)
					chatWebSocket = new WebSocket(endPointURL);
					chatWebSocket.onopen = function(event) {
						console.log("ChatConnect Success!");
					};

					chatWebSocket.onmessage = function(event) {
						var jsonObj = JSON.parse(event.data);
						if ("open" === jsonObj.type) {
							
							var jsonObj = {
									"type" : "history",
									"sender" : self,
									"receiver" : friend,
									"message" : "",
									"time" : ""
								};
							chatWebSocket.send(JSON.stringify(jsonObj));
						} else if ("history" === jsonObj.type) {
							$.when($.ajax({
							    type: 'POST',
							    url: '<%=request.getContextPath()%>/EmpServlet',
							    dataType: "json",
							    data: {
							    	action: 'selectAllEmpIdName',
							    },
							    success: function(data) {
							    },
							})).done(function (data){
								messagesArea.innerHTML = '';
								var ul = document.createElement('ul');
								ul.id = "area";
								messagesArea.appendChild(ul);
								
								// 這行的jsonObj.message是從redis撈出跟好友的歷史訊息，再parse成JSON格式處理
								var messages = JSON.parse(jsonObj.message);
								for (var i = 0; i < messages.length; i++) {
									var historyData = JSON.parse(messages[i]);
									console.log('historyData.sender:'+historyData.sender)
									console.log('data.map[historyData.sender]:'+data.map[historyData.sender])
									var showMsg = historyData.message;
									var datetime = historyData.time;
									var li = document.createElement('li');
									var div = document.createElement('div');
									var span = document.createElement('span');
									var newContent = historyData.sender === self ? document.createTextNode('我: ' + showMsg) : document.createTextNode(data.map[historyData.sender] + ': ' + showMsg);
									// 根據發送者是自己還是對方來給予不同的class名, 以達到訊息左右區分
									historyData.sender === self ? li.className += 'me messages' : li.className += 'friend messages';
									historyData.sender === self ? div.className += 'me message last' : div.className += 'friend message last';
									ul.appendChild(li);
									li.appendChild(div);
									li.appendChild(span);
									span.innerHTML = datetime;
									div.appendChild(newContent);
								}
								messagesArea.scrollTop = messagesArea.scrollHeight;
							})

						} else if ("chat" === jsonObj.type && friend === jsonObj.sender && self === jsonObj.receiver) {
							$.when($.ajax({
							    type: 'POST',
							    url: '<%=request.getContextPath()%>/EmpServlet',
							    dataType: "json",
							    data: {
							    	action: 'selectAllEmpIdName',
							    },
							    success: function(data) {
							    },
							})).done(function (data){
								var currentdate = new Date(); 
								var datetime = currentdate.getHours()  + ":" + currentdate.getMinutes() + ":" + currentdate.getSeconds();
								var li = document.createElement('li');
								var div = document.createElement('div');
								var span = document.createElement('span');
								div.className  = "message last";
								var newContent = jsonObj.sender === self ? document.createTextNode('我: ' + jsonObj.message) : document.createTextNode(data.map[jsonObj.sender] + ': ' + jsonObj.message);
								jsonObj.sender === self ? li.className += 'me messages' : li.className += 'friend messages';
								console.log(li);
								document.getElementById("area").appendChild(li);
								li.appendChild(div);
								div.appendChild(newContent);
								li.appendChild(span);
								span.innerHTML = datetime;
								messagesArea.scrollTop = messagesArea.scrollHeight;
							})
							
						} else if ("close" === jsonObj.type) {
							console.log("FUCKKKoff")
						}
						
					};

					chatWebSocket.onclose = function(event) {
						console.log("ChatDisconnected!");
					};
					
				})
			  
		})

	}
	
	
</script>

</html>
