<%--
  Created by IntelliJ IDEA.
  User: Mac
  Date: 2019/12/11
  Time: 14:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%

  response.setHeader("Expires","0");
  response.setHeader("Cache-Control","no cache");
  response.setHeader("Pragma","no-cache");


%>
<!DOCTYPE html>
send<html mip>

<head>
  <meta http-equiv= "Cache-Control " CONTENT= "no-cache "/>
  <title>Online Chat Website</title>
  <style>
    body {
      background: #24333c;
      font-family: 'Titillium Web', sans-serif;
    }

    .parent {
      height: 100%;
      overflow: hidden;
    }

    .top {
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      height: 80px;
      background: #24333c;
      color: #ffffff;
      box-shadow:0 0 1px #000 inset;
    }

    .middle {
      position: absolute;
      top: 70px;
      left: 0;
      right: 0;
      bottom: 60px;
      background-color: grey;
      overflow: hidden;
    }

    .bottom {
      position: absolute;
      left: 0;
      right: 0;
      bottom: 0;
      height: 0;
      overflow: auto;
      background-color: black;
      color: white
    }

    .button {
      color: #ffffff;
      background-color: #435359;
      text-align: center;
      cursor: pointer;
      line-height: 70px;
      box-shadow: -2px 1px 12px 0px black
    }

    .button2 {
      color: #e0e0e0;
      background-color: #1f2c33;
      text-align: center;
      cursor: pointer;
      line-height: 60px;
      box-shadow: inset -1px -1px 0px 0px #314550;
    }

    .mask {
      display: none;
      position: fixed;
      z-index: 10;
      left: 0;
      top: 0;
      width: 100%;
      height: 100%;
      background: rgba(0, 0, 0, .1);
    }

    .nav {
      position: absolute;
      z-index: 11;
      left: -13rem;
      top: 0;
      width: 150px;
      height: 100%;
      background: #24333c;
    }

    .nav {
      transition: left linear .1s;
    }

    .nav a {
      text-decoration: none;
      display: block;
      font-size: 16px;
      text-align: center;
    }

    .avatar-small {
      position: absolute;
      z-index: 2;
      left: 15px;
      top: 15px;
      width: 40px;
      height: 40px;
    }

    .picture
    {
      vertical-align: middle;
      padding-top: 15px;
      padding-left: 10px;
      width: 35px;
      height: 35px;
      float: left;
    }
    .picture2
    {
      padding: 10px;
      width: 60px;
      height: 60px;
    }
    .picture3
    {
        float: left;
        cursor: pointer;
        width: 30px;
        height: 30px;
        position: absolute;
        bottom: 50px;
        margin:5px;
    }
    .picture4
    {
      width:30px;
      height:30px;
      margin: 5px;
    }
    ul,
    li {
      list-style: none;
      padding: 0;
      margin: 0;
    }
  </style>
  <link rel="stylesheet" href="jquery.contextMenu.min.css">
  <link rel="stylesheet" type="text/css" href="jquery-ui.min.css">
</head>

<body>
<div class="parent">
  <div class="top" style="text-align: center">
    <img src="menu.png" class="avatar-small" />
    <h2 id="userName"></h2>
  </div>


  <div class="middle">
    <div id="singleChatView" style="width: 100%;height: 100%;visibility: visible;background-color: rgb(193, 210, 220)">
      <div
              style="position: absolute; top: 0; left: 0; right: 0; background-color: snow; height: 50px;text-align: center; line-height:50px;">
      </div>
      <div >
        <div id="ChatCreateDlg" title="Add friend">
          <p class="validateTips">Please enter the friend name</p>
          <div>
            <input type="text" name="newFriend" id="newFriend" value=""
                   class="text ui-widget-content ui-corner-all">
          </div>
        </div>
        <div id="friendList"
             style="position: absolute; width: 150px ;top: 0; left:0; bottom: 0; background-color:#32424c; overflow: auto;text-align: center;z-index: 10;box-shadow: -6px -1px 15px black;">
        </div>
        <div id="targetFriend"
             style="position: absolute; top: 0; left: 140px; height:50px; right: 0;background-color: #3e4d56; overflow: auto;padding:5px;text-align: center; line-height:50px; box-shadow: 8px -2px 14px 0px black;z-index:8;color:white;">
        </div>
        <div id="friendMessage"
             style="position: absolute;top: 50px;left:150px;right:10px;bottom:90px; overflow-y:scroll;overflow-x:hidden;left: 150px; background-color: #2d3b44;width: 100%;">
            </div>
        <div id="emoji"><image src="grinning-face_1f600.png" name="grinning-face_1f600.png" class="picture3" style="left:150px" onclick="sendEmoji(this.name)"/>
          <image src="smiling-face-with-open-mouth-and-tightly-closed-eyes_1f606.png" name="smiling-face-with-open-mouth-and-tightly-closed-eyes_1f606.png" class="picture3" style="left:190px" onclick="sendEmoji(this.name)"/>
          <image src="grinning-face-with-smiling-eyes_1f601.png" name="grinning-face-with-smiling-eyes_1f601.png"style="left:230px" class="picture3" onclick="sendEmoji(this.name)"/>
          <image src="face-throwing-a-kiss_1f618.png" name="face-throwing-a-kiss_1f618.png" class="picture3"style="left:270px"  onclick="sendEmoji(this.name)"/>
          <image src="rolling-on-the-floor-laughing_1f923.png" name="rolling-on-the-floor-laughing_1f923.png" style="left:310px" class="picture3" onclick="sendEmoji(this.name)"/>
          <image src="smiling-face-with-open-mouth-and-cold-sweat_1f605.png" name="smiling-face-with-open-mouth-and-cold-sweat_1f605.png" style="left:350px" class="picture3" onclick="sendEmoji(this.name)"/>
        </div>
        <div id="friendedit"
             style="position: absolute; left: 150px; right: 0; bottom: 0; height: 50px; background-color: white;">
          <div style="position: absolute;  height: 50px;left: 0px; right: 220px; bottom: 0;">
            <input id="friendText" type="text"
                   style="width: 100%;height: 100%;background: whitesmoke;padding-left: 10px;border-width: 0" />
          </div>
        <div style="float:right; width:100px; height:48px;color:white; background-color: #3e4d56 ;text-align: center; line-height:50px; cursor:pointer;border:1px solid #d0d0d0;"
             onclick="addFriend()">New Friend</div>
        <div style="float:right; width:100px; height:48px;color:white; background-color: #3e4d56 ;text-align: center; line-height:50px; cursor:pointer;border:1px solid #d0d0d0;  "
             onclick="sendFriendMessage()">Send</div>
        </div>
      </div>
    </div>


    <div id="groupView" style="width: 100%;height: 100%;visibility: visible; background-color:rgb(193, 210, 220)">
      <div id="groupCreateDlg" title="Creat group">
        <p class="validateTips">Please enter the group name</p>
        <div>
          <input type="text" name="newGroupName" id="newGroupName" value=""
                 class="text ui-widget-content ui-corner-all">
        </div>
      </div>
      <div id="groupMembersDlg" title="Group members">
        <div id="addMembers">
          <p class="validateTips">Please enter the member name to add members</p>
          <input type="text" name="newGroupMembers2" id="newGroupMembers2" value=""
                 class="text ui-widget-content ui-corner-all">
          <div id="addGroupMembers" onclick="addGroupMembers()">Add</div>
        </div>
        <p class="validateTips">Member list.</p>
        <div id="groupMemberList" style="overflow-y: scroll;height:400px;">

        </div>
      </div>
      <div id="groupList"
           style="position: absolute; width: 150px ;top: 0; left:0; bottom: 0; background-color:#32424c; overflow: auto;text-align: center;z-index: 10;box-shadow: -6px -1px 15px black;">
      </div>
      <div id="targetGroupId"
           style="position: absolute; top: 0; left: 140px; height:50px; right: 0;background-color: #3e4d56; overflow: auto;padding:5px;text-align: center; line-height:50px; box-shadow: 8px -2px 14px 0px black;z-index:8;color:white;">
      </div>
      <div id="groupMessage"
           style="position: absolute;top: 50px;left:150px;right:10px;bottom:90px; overflow-y:scroll;overflow-x:hidden;left: 150px; background-color: #2d3b44;width: 100%;">
      </div>
      <div id="emoji2"><image src="grinning-face_1f600.png" name="grinning-face_1f600.png" class="picture3" style="left:150px" onclick="sendEmojigroup(this.name)"/>
        <image src="smiling-face-with-open-mouth-and-tightly-closed-eyes_1f606.png" name="smiling-face-with-open-mouth-and-tightly-closed-eyes_1f606.pnggrinning-face_1f600.png" class="picture3" style="left:190px" onclick="sendEmojigroup(this.name)"/>
        <image src="grinning-face-with-smiling-eyes_1f601.png" name="grinning-face-with-smiling-eyes_1f601.png"style="left:230px" class="picture3" onclick="sendEmojigroup(this.name)"/>
        <image src="face-throwing-a-kiss_1f618.png" name="face-throwing-a-kiss_1f618.png" class="picture3"style="left:270px"  onclick="sendEmojigroup(this.name)"/>
        <image src="rolling-on-the-floor-laughing_1f923.png" name="rolling-on-the-floor-laughing_1f923.png" style="left:310px" class="picture3" onclick="sendEmojigroup(this.name)"/>
        <image src="smiling-face-with-open-mouth-and-cold-sweat_1f605.png" name="smiling-face-with-open-mouth-and-cold-sweat_1f605.png" style="left:350px" class="picture3" onclick="sendEmojigroup(this.name)"/>
      </div>
      <div style="position: absolute; left: 150px; right: 0; bottom: 0; height: 50px; background-color: white;"
           id="groupEdit">
        <div style="position: absolute;  height: 50px;left: 0; right: 330px; bottom: 0;">
          <input id="groupText" type="text"
                 style="width: 100%;height: 100%;background: whitesmoke;padding-left: 10px;border-width: 0" />
        </div>
        <div style="float:right; width:100px; height:48px;color:white; background-color: #3e4d56 ;text-align: center; line-height:50px; cursor:pointer;border:1px solid #d0d0d0;"
             onclick='showGroupMember()'>Member</div>
        <div style="float:right; width:100px; height:48px;color:white; background-color: #3e4d56 ;text-align: center; line-height:50px; cursor:pointer;border:1px solid #d0d0d0;"
             onclick="createNewGroup()">Create</div>
        <div style="float:right; width:100px; height:48px;color:white; background-color: #3e4d56 ;text-align: center; line-height:50px; cursor:pointer;border:1px solid #d0d0d0;  "
             onclick="sendGroupChat()">Send</div>
      </div>
    </div>


    <div id="chatRoomView" style="width: 100%;height: 100%;visibility: visible; background-color: rgb(193, 210, 220)">
      <div id="chatRoomCreateDlg" title="Create chat room">
        <p class="validateTips">Please enter the name.</p>
        <div>
          <input type="text" name="newChatRoomName" id="newChatRoomName" value=""
                 class="text ui-widget-content ui-corner-all">
        </div>
      </div>
      <div id="roomList" style="position: absolute; width: 150px ;top: 0; left:0; bottom: 0; background-color:#32424c; overflow: auto;text-align: center;z-index: 10;box-shadow: -6px -1px 15px black;">
      </div>


      <div id="targetChatRoomId"
           style="position: absolute; top: 0; left: 140px; height:50px; right: 0;background-color: #3e4d56; overflow: auto;padding:5px;text-align: center; line-height:50px; box-shadow: 8px -2px 14px 0px black;z-index:8;color:white;">
      </div>
      <div id="chatRoomMessage"style="position: absolute;overflow-y:scroll;overflow-x:hidden;top: 50px;left:150px;right:10px;bottom:90px; left: 150px; background-color: #2d3b44;width: 100%;">
      </div>

      <div id="emoji3"><image src="grinning-face_1f600.png" name="grinning-face_1f600.png" class="picture3" style="left:150px" onclick="sendEmojichat(this.name)"/>
        <image src="smiling-face-with-open-mouth-and-tightly-closed-eyes_1f606.png" name="grinning-face_1f600.smiling-face-with-open-mouth-and-tightly-closed-eyes_1f606.png" class="picture3" style="left:190px" onclick="sendEmojichat(this.name)"/>
        <image src="grinning-face-with-smiling-eyes_1f601.png" name="grinning-face-with-smiling-eyes_1f601.png"style="left:230px" class="picture3" onclick="sendEmojichat(this.name)"/>
        <image src="face-throwing-a-kiss_1f618.png" name="face-throwing-a-kiss_1f618.png" class="picture3"style="left:270px"  onclick="sendEmojichat(this.name)"/>
        <image src="rolling-on-the-floor-laughing_1f923.png" name="rolling-on-the-floor-laughing_1f923.png" style="left:310px" class="picture3" onclick="sendEmojichat(this.name)"/>
        <image src="smiling-face-with-open-mouth-and-cold-sweat_1f605.png" name="smiling-face-with-open-mouth-and-cold-sweat_1f605.png" style="left:350px" class="picture3" onclick="sendEmojichat(this.name)"/>
      </div>
      <div id="chatRoomedit"
           style="position: absolute; left: 150px; right: 0; bottom: 0; height: 50px; background-color: white;">
        <div style="position: absolute;  height: 50px;left: 0; right: 220px; bottom: 0;">

          <input id="chatRoomText" name="chatRoomText" type="text"
                 style="width: 100%;height: 100%;background: whitesmoke;padding-left: 10px;border-width: 0" />
        </div>
        <div style="float:right; width:100px; height:48px; background-color: #3e4d56 ;color:white;text-align: center; line-height:50px; cursor:pointer;border:1px solid #ffffff;"
             onclick="createNewChat()">Create</div>
        <div style="float:right; width:100px; color:white;height:48px; background-color: #3e4d56 ;text-align: center; line-height:50px; cursor:pointer;;border:1px solid #ffffff;"
             onclick="sendChatMsg()">Send</div>
      </div>

    </div>



  </div>


  <div class="bottom" id="logs"></div>
</div>


<div class="mask"></div>


<div class="nav" style="left:-150px;">
  <div style="width:100%; height: 70px"></div>
  <div class="button" style="width:100%; " onclick="showFriend()"><img src="friend.png" class="picture" />One to one
  </div>
  <div class="button" style="width:100%; " onclick="showGroup()"><img src="group-icon-png.png" class="picture" />Group
  </div>
  <div class="button" style="width:100%; " onclick="showChatRoom()"><img src="chat-room-icon-png.png" class="picture" />Chat Room
  </div>
  <div><a href="index.html" class="button" style="width:100%; "><img src="puzzle_game.png" class="picture" />Puzzle Game</a></div>
  <div class="button" style="width:100%;"><img src="bird.png" class="picture" />Clumsy Bird</div>
</div>

</body>

<script type="text/javascript" src="jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="jquery-ui.min.js"></script>
<script type="text/javascript" src="jquery.contextMenu.min.js"></script>
<script type="text/javascript" src="jquery.ui.position.min.js"></script>


<script type="text/javascript">
    btn = document.getElementsByClassName('avatar-small')[0];
    mask = document.getElementsByClassName('mask')[0];
    nav = document.getElementsByClassName('nav')[0];
    var chatRoomCreateDialog = null;
    var groupCreateDialog = null;
    var groupMembersDialog = null;
    var addFriendDialog=null
    var ChatLoad=0;
    var chatRoomNo=-1;
    var groupNo=-1;
    var j = new Array();
    var GroupLoad
    var userId = "<%=session.getAttribute("username")%>";
    var g=new Array();
    var d=new Array();
    var friend=-1;

    document.getElementById('userName').innerHTML += userId;
    btn.addEventListener('click', function () {
        mask.style.display = 'block';
        nav.style.left = 0;
    }, false);

    mask.addEventListener('click', function () {
        mask.style.display = 'none';
        nav.style.left = '-150px';
    }, false);

    function showChatRoom() {
        $("#singleChatView").hide();
        $("#chatRoomView").show();
        $("#groupView").hide();
        mask.style.display = 'none';
        nav.style.left = '-150px';
        getChatRoomList();
    }

    function getChatRoomList()
    {
      var p=0;
      var url = "ChatRoomUpdateServlet";
      document.getElementById("roomList").innerHTML="";
      $.ajax({
        type: "POST",
        url: url,
        async: false,
        cache: false,
        success: function (res) {
         $("#res").text(res.length);
          for (p; p <res.length; p++) {
            var name= res[p].RoomName;
            document.getElementById("roomList").innerHTML += "<div class='button2' onclick='joinChatRoom(\"" + name + "\"," + p + ")' >" + name + "<img src=\"chat-room.png\" class=\"picture\" /></div>";
          }
        },
        error: function (error) {
        }
      });
      ChatLoad=p;
    }

    function newChatRoom()
    {
      var chatRoomName = $("#newChatRoomName").val().trim();
      if (chatRoomName == "")
      {
      alert('Name can not be empty');
        return;
      }
      var url="CreateChatRoom";
      $.ajax({
        type:"POST",
        url:url,
        async:false,
        cache:false,
        data:{"Name": chatRoomName,"Author":userId},
        success: function(data){
        },
        error:function (error) {
        }
      });
      chatRoomCreateDialog.dialog("close");
      showChatRoom();
    }

    function joinChatRoom(index,no) {
      j[no]=0;
      var name=index;
      chatRoomNo=no;
      var div2 = document.getElementById('chatRoomMessage');
        var div = document.getElementById('targetChatRoomId');
        div.innerHTML = name;//填充
        div2.innerHTML="";
      var url = "UpdateServlet";
      setInterval(function () {
        $.ajax({
          type: "POST",
          url: url,
          async: true,
          cache: false,
          data: {"RoomNo": chatRoomNo + 1},
          success: function (data) {
            var n=data.length
            for (j[no]; j[no] < n; j[no]++) {
              var src=data[j[no]].Picture;
              //var src="user.png";
              div2.innerHTML+="<table  style=\"background-color: #2d3b44;width: 100%;\">\n" +
                      "        <td style=\"width:60px;\">\n" +
                      "         <img id=\"author\" src=\""+src+"\" class=\"picture2\" />\n" +
                      "       </td>\n" +
                      "     <td>\n" +
                      "     <div  class=\"content-menu\"\n" +
                      "          style=\"top:0px;background-color: #2d3b44;overflow: auto;padding: 5px;color: #d0d0d0;width: 100%;\">\n"+data[j[no]].Author + "<span style=\"color:#6d6d6d; font-size: 10px\">"+"&nbsp;&nbsp;&nbsp;" + data[j[no]].Date + "&nbsp;" + data[j[no]].Time + "</span>"+ "<br/>" + "<span style=\"color:#a2a2a2;line-height: 30px\">"+data[j[no]].content + '<br/><br/>'+
                      "     </div>\n" +
                      "       </td>\n" +
                      "      </table>";
              //div2.innerHTML += data[j[no]].Author + "<span style=\"color:#6d6d6d; font-size: 10px\">"+"&nbsp;&nbsp;&nbsp;" + data[j[no]].Date + "&nbsp;" + data[j[no]].Time + "</span>"+ "<br/>" + "<span style=\"color:#a2a2a2;line-height: 30px\">"+data[j[no]].content + '<br/><br/>';
              div2.scrollTop = div.scrollHeight;
            }
          },
          error: function (error) {
          }
        });
      },1000);
    }

    function setChatMessageInnerHTML(innerHTML) {
      var div = document.getElementById('chatRoomMessage');
      div.innerHTML += innerHTML + '<br/><br/>';
      div.scrollTop = div.scrollHeight;
    }

    function sendChatMsg() {
      var message1 = document.getElementById('chatRoomText').value;
      if (message1 == null || message1 == undefined || message1 == "") {
        alert("Can not be empty");
        return;
      }
      if (chatRoomNo<0)
      {
        alert("Please enter a room.");
        return;
      }
      var url ="MessageServlet";
      $.ajax({
        type:"POST",
        url:url,
        async:false,
        cache:false,
        data:{"content": message1,"No":chatRoomNo+1,"Author":userId},
        dataType : 'JSON',
        success: function(data){
        },
        error:function (XMLHttpRequest, textStatus, errorThrown) {
        }
      });
      $("#chatRoomText").val('');
    }

    function createNewChat() {
      $("#newChatRoomName").val("");
      chatRoomCreateDialog.dialog("open");
    }

    function createNewGroup() {
      $("#newGroupName").val("");
      $("#newGroupMembers").val("");
      groupCreateDialog.dialog("open");
    }
    function addFriend()
    {
      $("#newFriend").val("");
      addFriendDialog.dialog("open");
    }

    function newGroup() {
      var newGroupName = $("#newGroupName").val().trim();
      if (newGroupName == "") {
        alert("Can not be empty");
        return;
      }
      var url="createGroupServlet";
      $.ajax({
        type:"POST",
        url:url,
        async:false,
        cache:false,
        data:{"Name": newGroupName,"Author":userId},
        success: function(data){
        },
        error:function (error) {
        }
      });
      groupCreateDialog.dialog("close");
      showGroup();
    }

    function newFriend(){
      var newFriend = $("#newFriend").val().trim();
      if (newFriend == "") {
        alert("Can not be empty");
        return;
      }
      var url="newFriendServlet";
      $.ajax({
        type:"POST",
        url:url,
        async:false,
        cache:false,
        data:{"Name": newFriend,"Author":userId},
        success: function(data){
        },
        error:function (error) {
        }
      });
      addFriendDialog.dialog("close");
      showFriend();
    }
    function addGroupMembers()
    {
      var newGroupMembers = $("#newGroupMembers2").val().trim();
      var url ="AddMember";
      if (groupNo<0)
      {
        alert("Please enter a group");
      }
      $.ajax({
        type:"POST",
        url:url,
        async:false,
        cache:false,
        data:{"newMember":newGroupMembers,"Group":groupNo},
        dataType : 'JSON',
        success: function(data){
        },
        error:function (XMLHttpRequest, textStatus, errorThrown) {
        }
      });
      groupMembersDialog.dialog("close");
    }

    function showGroup() {
      $("#singleChatView").hide();
      $("#chatRoomView").hide();
      $("#groupView").show();
      mask.style.display = 'none';
      nav.style.left = '-150px';
      getGroupList();
    }
    function showFriend() {
      $("#singleChatView").show();
      $("#chatRoomView").hide();
      $("#groupView").hide();
      mask.style.display = 'none';
      nav.style.left = '-150px';
      getFriendList();
    }
    function getFriendList(){
      var y=0;
      var url = "FriendListServlet";
      document.getElementById("friendList").innerHTML="";
      $.ajax({
        type: "POST",
        url: url,
        async: false,
        cache: false,
        data:{"username":userId},
        success: function (res) {
          $("#res").text(res.length);
          for (y; y <res.length; y++) {
            var name= res[y].Friend;
            var id=res[y].Nu;
            var src=res[y].picture;
            document.getElementById("friendList").innerHTML += "<div class='button2' onclick='openChat(\"" + name + "\"," + id + ")' >" + name +" <img src=\""+src+"\" class=\"picture\" />";
          }
        },
        error: function (error) {
        }
      });
    }
    function openChat(name,r)
    {
      friend=r;
      d[r]=0;
      var div = document.getElementById('targetFriend')
      div.innerHTML = name;
      var div2 = document.getElementById('friendMessage')
      div2.innerHTML = "";
      div2.scrollTop = div2.scrollHeight;
      var url = "UpdateFriendMessage";
      setInterval(function () {
        $.ajax({
          type: "POST",
          url: url,
          async: true,
          cache: false,
          data: {"idf": r},
          success: function (data) {
            var t=data.length;
            for (d[r]; d[r] < t; d[r]++) {
              var src=data[d[r]].Picture;
              div2.innerHTML+="<table  style=\"background-color: #2d3b44;width: 100%;\">\n" +
                      "        <td style=\"width:60px;\">\n" +
                      "         <img id=\"author\" src=\""+src+"\" class=\"picture2\" />\n" +
                      "       </td>\n" +
                      "     <td>\n" +
                      "     <div  class=\"content-menu\"\n" +
                      "          style=\"top:0px;background-color: #2d3b44;overflow: auto;padding: 5px;color: #d0d0d0;width: 100%;\">\n"+data[d[r]].Author + "<span style=\"color:#6d6d6d; font-size: 10px\">"+"&nbsp;&nbsp;&nbsp;" + data[d[r]].Date + "&nbsp;" + data[d[r]].Time + "</span>"+ "<br/>" + "<span style=\"color:#a2a2a2;line-height: 30px\">"+data[d[r]].content + '<br/><br/>'+
                      "     </div>\n" +
                      "       </td>\n" +
                      "      </table>";
              div2.scrollTop = div.scrollHeight;
            }
          },
          error: function (error) {
          }
        });
      },1000)
    }

    function openGroup(index,n) {
      g[n]=0;
      groupNo=index;
      var div = document.getElementById('targetGroupId')
      div.innerHTML = index;
      var div2 = document.getElementById('groupMessage')
      div2.innerHTML = "";
      div2.scrollTop = div2.scrollHeight;
      var url = "UpdateGroupMessageServlet";
      setInterval(function () {
        $.ajax({
          type: "POST",
          url: url,
          async: true,
          cache: false,
          data: {"groupName": index},
          success: function (data) {
            var w=data.length;
            //$("#data").text(data.length);
            for (g[n]; g[n] < w; g[n]++) {
              var src=data[g[n]].Picture;
              div2.innerHTML+="<table  style=\"background-color: #2d3b44;width: 100%;\">\n" +
                      "        <td style=\"width:60px;\">\n" +
                      "         <img id=\"author\" src=\""+src+"\" class=\"picture2\" />\n" +
                      "       </td>\n" +
                      "     <td>\n" +
                      "     <div  class=\"content-menu\"\n" +
                      "          style=\"top:0px;background-color: #2d3b44;overflow: auto;padding: 5px;color: #d0d0d0;width: 100%;\">\n"+data[g[n]].Author + "<span style=\"color:#6d6d6d; font-size: 10px\">"+"&nbsp;&nbsp;&nbsp;" + data[g[n]].Date + "&nbsp;" + data[g[n]].Time + "</span>"+ "<br/>" + "<span style=\"color:#a2a2a2;line-height: 30px\">"+data[g[n]].content + '<br/><br/>'+
                      "     </div>\n" +
                      "       </td>\n" +
                      "      </table>";
              div2.scrollTop = div.scrollHeight;
            }
          },
          error: function (error) {
          }
        });
      },1000)
    }
function sendEmoji(a){
    document.getElementById('friendText').value+="<img src=\""+a+"\" class=\"picture4\" />";
    sendFriendMessage();
}
    function sendEmojigroup(a){
      document.getElementById('groupText').value+="<img src=\""+a+"\" class=\"picture4\" />";
      sendGroupChat();
    }
    function sendEmojichat(a){
      document.getElementById('chatRoomText').value+="<img src=\""+a+"\" class=\"picture4\" />";
      sendChatMsg();
    }
function getGroupList()
{
  var q=0;
  var url = "GroupListServlet";
  document.getElementById("groupList").innerHTML="";
  $.ajax({
    type: "POST",
    url: url,
    async: false,
    cache: false,
    data:{"username":userId},
    success: function (res) {
      $("#res").text(res.length);
      for (q; q <res.length; q++) {
        var name= res[q].GroupName;
        document.getElementById("groupList").innerHTML += "<div class='button2' onclick='openGroup(\"" + name + "\"," + q + ")' >" + name + "<img src=\"group.png\" class=\"picture\" /></div>";
      }
    },
    error: function (error) {
    }
  });
  GroupLoad=q;
    }
    function sendFriendMessage(){
      if (friend == -1) {
        alert("Please select your friend");
        return;
      }
      var message = document.getElementById('friendText').value;
      var url ="FriendMessageServlet";
      $.ajax({
        type:"POST",
        url:url,
        async:false,
        cache:false,
        data:{"content": message,"No":friend,"Author":userId},
        dataType : 'JSON',
        success: function(data){
        },
        error:function (XMLHttpRequest, textStatus, errorThrown) {
        }
      });
      $("#friendText").val('');
    }
    function sendGroupChat() {
      if (groupNo == null) {
        alert("Please enter a room");
        return;
      }
      var message = document.getElementById('groupText').value;
      var url ="GroupmessageServlet";
      $.ajax({
        type:"POST",
        url:url,
        async:false,
        cache:false,
        data:{"content": message,"No":groupNo,"Author":userId},
        dataType : 'JSON',
        success: function(data){
        },
        error:function (XMLHttpRequest, textStatus, errorThrown) {
        }
      });
      $("#groupText").val('');
    }

    function showSingle() {
      $("#singleChatView").show();
      $("#chatRoomView").hide();
      $("#groupView").hide();
      mask.style.display = 'none';
      nav.style.left = '-130px';
    }

    function setSingleMessageInnerHTML(innerHTML) {
      var div = document.getElementById('sigleMessage')
      div.innerHTML += innerHTML + '<br/><br/>';
      div.scrollTop = div.scrollHeight;
    }

    function showGroupMember() {
      if (groupNo <0) {
        alert("群组ID不能为空");
        return;
      }
      var list = $("#groupMemberList");
      list.html("");
      var url = "groupMember";
        $.ajax({
          type: "POST",
          url: url,
          async: true,
          cache: false,
          data: {"groupName":groupNo},
          success: function (data) {
            var w=data.length;
            //$("#data").text(data.length);
            for (var t=0; t < w; t++) {
              list[0].innerHTML += "<div class=''>" + data[t].Allow + "</div>";
            }
          },
          error: function (error) {
          }
        });
              groupMembersDialog.dialog("open");
    }
  $(function () {

    $.contextMenu({
      selector: '.content-menu',
      callback: function (key, options) {
        //console.log("点击了：" + key);
        var div = document.getElementById('chatRoomMessage')
        div.innerHTML = '';
        var div = document.getElementById('sigleMessage')
        div.innerHTML = '';
      },
      items: {
        //"edit": {name: "编辑", icon: "edit"},
        "delete": { name: "清屏", icon: "delete" },
      }
    });
    chatRoomCreateDialog = $("#chatRoomCreateDlg").dialog({
      autoOpen: false,
      height: 300,
      width: 350,
      modal: true,
      buttons: {
        "Create": newChatRoom,
        "Cancel": function () {
          chatRoomCreateDialog.dialog("close");
        }
      },
    });

    groupCreateDialog = $("#groupCreateDlg").dialog({
      autoOpen: false,
      height: 300,
      width: 350,
      modal: true,
      buttons: {
        "Create": newGroup,
        "Cancel": function () {
          groupCreateDialog.dialog("close");
        }
      },
    });
    addFriendDialog = $("#ChatCreateDlg").dialog({
      autoOpen: false,
      height: 300,
      width: 350,
      modal: true,
      buttons: {
        "Create": newFriend,
        "Cancel": function () {
          addFriendDialog.dialog("close");
        }
      },
    });
    groupMembersDialog = $("#groupMembersDlg").dialog({
      autoOpen: false,
      height: 400,
      width: 400,
      modal: true,
      buttons: {
        //"确定": function () {
          //videoLiveCanvasDlg.dialog("close");
        //},
        "Confirm": function () {
          groupMembersDialog.dialog("close");
        }
      },
    });

    $("#addGroupMembers").button();
    $("#addGroupMembers").bind("click", function (
    ) {
      addGroupMembers();
    });
  });


</script>

</html>