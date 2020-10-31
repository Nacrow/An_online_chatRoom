<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%

  response.setHeader("Expires","0");
  response.setHeader("Cache-Control","no cache");
  response.setHeader("Pragma","no-cache");


%>
<!DOCTYPE html>
<html >
<head>
  <meta charset="UTF-8">
  <title>Login Page</title>
  <!--<link rel="stylesheet" href="css/normalize.min.css">
  -->
      <link rel="stylesheet" href="css/style.css">
</head>
<style type="text/css">

  .demo{width:360px;margin:50px auto 10px auto;padding:10px;}
  .demo h3{font-size:1.5em;line-height:1.9em}

  .col{margin-top:20px}
  .opt{height:30px;line-height:24px;}
  .img1{
    height:90px;
    width:90px;
  }
</style>
<style type="text/css">
  @keyframes hover-color {
    from {
      border-color: #c0c0c0;
    }

    to {
      border-color: #3e97eb;
    }
  }
  .magic-radio{
    height:30px;
    width:30px;
  }

  .magic-radio[disabled] {
    cursor: not-allowed;
  }

  .magic-radio + label {
    position: relative;
    display: block;
    padding-left: 30px;
    cursor: pointer;
    vertical-align: middle;
  }

  .magic-radio + label:hover:before {
    animation-duration: 0.4s;
    animation-fill-mode: both;
    animation-name: hover-color;
  }

  .magic-radio + label:before{
    position: absolute;
    top: 0;
    left: 0;
    display: inline-block;
    width: 20px;
    height: 20px;
    content: '';
    border: 1px solid #c0c0c0;
  }
  .magic-radio + label:after {
    position: absolute;
    display: none;
    content: '';
  }
  .magic-radio[disabled] + label {
    cursor: not-allowed;
    color: #e4e4e4;
  }
  .magic-radio[disabled] + label:hover,
  .magic-radio[disabled] + label:before,
  .magic-radio[disabled] + label:after{
    cursor: not-allowed;
  }
  .magic-radio[disabled] + label:hover:before{
    border: 1px solid #e4e4e4;
    animation-name: none;
  }

  .magic-radio[disabled] + label:before{
    border-color: #e4e4e4;
  }

  .magic-radio:checked + label:before{
    animation-name: none;
  }

  .magic-radio:checked + label:after {
    display: block;
  }
  .magic-radio + label:before {
    border-radius: 50%;
  }
  .magic-radio + label:after {
    top: 7px;
    left: 7px;
    width: 8px;
    height: 8px;
    border-radius: 50%;
    background: #3e97eb;
  }
  .magic-radio:checked + label:before {
    border: 1px solid #3e97eb;
  }
  .magic-radio:checked[disabled] + label:before {
    border: 1px solid #c9e2f9;
  }
  .magic-radio:checked[disabled] + label:after {
    background: #c9e2f9;
  }
</style>
<body>

  <div class="form">
      
      <ul class="tab-group">
        <li class="tab active"><a href="#signup">Sign Up</a></li>
        <li class="tab"><a href="#login">Log In</a></li>
      </ul>
      
      <div class="tab-content">
        <div id="signup">   
          <h1>Sign Up for Free</h1>
          <form action="SignupServlet" method="post">
          <div class="field-wrap">
            <label>
              Set A User Name<span class="req">*</span>
            </label>
            <input type="text" name="userName" id="name1" required autocomplete="off"/>
          </div>
          <div class="field-wrap">
            <label>
              Set A Password<span class="req">*</span>
            </label>
            <input type="password" name="setPassword" id="password1" required autocomplete="off"/>
          </div>
            <div id="main">
                    <table>
                      <tr>
                        <td>
                    <input class="magic-radio" type="radio" name="radio" id="r1" value="1.png">
                    <img src="1.png" class="img1" />
                          </td>
                        <td>
                    <input class="magic-radio" type="radio" name="radio" id="r2" value="2.png" >
                          <img src="2.png" class="img1" />
                        <td/>
                        <td>
                          <input class="magic-radio" type="radio" name="radio" id="r3" value="3.png" >
                          <img src="3.png" class="img1" />
                        <td/>
                        <td>
                          <input class="magic-radio" type="radio" name="radio" id="r4" value="4.png" >
                          <img src="4.png" class="img1" />
                        <td/>
                      </tr>
                    </table>
              <div class="field-wrap">
                <label>Select an avatar</label>
              </div>


            </div>
          <button type="submit" class="button button-block"/>Get Started</button>
          
          </form>

        </div>


        <div id="login">   
          <h1>Welcome Back!</h1>
          
          <form action="LoginServlet" method="post" onSubmit="return validate(this)">
          
            <div class="field-wrap">
            <label>
              Username<span class="req">*</span>
            </label>
            <input type="text" id="name" name="name"/>
          </div>
          
          <div class="field-wrap">
            <label>
              Password<span class="req">*</span>
            </label>
            <input type="password" id="password" name="password"/>
          </div>
          
          <button class="button button-block" onclick="sendMessage()"/>Log In</button>
          
          </form>

        </div>
        
      </div><!-- tab-content -->
      
</div> <!-- /form -->
  <script src='js/jquery.min.js'></script>

    <script  src="js/index.js"></script>
</body>
</html>
