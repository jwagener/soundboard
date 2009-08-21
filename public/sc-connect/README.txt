Connect with SoundCloud
-----------------------
= Introduction

Connect with SoundCloud is our approach to make it as easy as possible for you to integrate SoundCloud via OAuth into your Webapp.
We provide all the frontend stuff and a simple specification for the backend OAuth endpoints you need to implement.

= OAuth 

OAuth is an open protocol to allow secure API authorization in a simple and standard method from desktop and web applications.
For more information check http://www.oauth.org

= Workflow

You include a Connect with SoundCloud button somewhere in your webpage.
Once a user clicks this a popup appears with the SoundCloud login dialog, allowing the user to login or even sign up for a new SoundCloud account on-the-fly and then giving your webapp the permission to access his account information and act on his behalf. Once thats done the popup closes and the user returns to your webapp. Your webapp can then use the OAuth access token to access the SoundCloud API and get for example the users private tracks. 

= Usecases

== Optional SoundCloud account
Your existing users have the option to connect their accounts to SoundCloud to get some additional features of your webapp.

== Mandatory SoundCloud account
When users sign up to your webapp they have to connect to SoundCloud to finish the sign up process, so it's almost guaranteed that each of your users has a connected SoundCloud account, but be aware of the fact that users can revoke the access priviledge for your webapp on SoundCloud. In case the user does not have a SoundCloud account, he can easily create one during the OAuth authorization flow.

== Loggin into your app with the SoundCloud account
You can also let your users always login with their SoundCloud accounts each time they visit your webapp. By doing this you don't have to take care about user managment (avatar, user meta-data, forgot password, friendships etc.).

= Backend
You need to implement 2 endpoints:

Request token endpoint:
  - get a request token from SoundCloud
  - store the request token key and secret in a session variable
  - add a "display=popup" request parameter to the SoundCloud authorize URL and redirect to it.
  
Access token endpoint:
  - check if the request token passed in the request parameters matches the one stored in the session variable
  - exchange the request token+secret for an access token+secret
  - store the access_token + secret in your database
  - redirect to /sc-connect/close.html, all query parameters will be passed to the javascript callback as an object.
    For example you could add a username as parameter to display it in the origin page via the javascript callback
    or add a reference id of the stored OAuth token.

= Frontend 
  Include the javascript stuff and the button somewhere in your webapp
  Javascript:
  1:
    <script src="/sc-connect/sc-connect.js"></script>
  2:
    var options = { 
      'request_token_endpoint': '/oauth/request_token',
      'access_token_endpoint': '/oauth/access_token',
      'callback': function(query_obj){}
    };
    SC.Connect.prepareButton($('#sc-connect')[0],options);

  In the options object you can specify the URL of the backend endpoints you implemented and a callback function
  which will be executed after the authorization was successful. This callback will receive an object containing 
  the query parameters you passed to /sc-connect/close.html.
  I.E if the access token endpoint redirects to /sc-connect/close.html?username=joe&oauth_token_id=43
  the callback would get the following object:
  {
    'username':       'joe',
    'oauth_token_id': '43'
  }

  Button code:
    <a href="#" style="border: 0; background: transparent url('/sc-connect/sc-connect.png') top left no-repeat;display: block;
    text-indent: -9999px; width: 242px; height: 31px; margin-bottom: 10px;" id="sc-connect">Connect with SoundCloud</a>
       
= Examples
  Check out our example webapps if you need some inspiration:
  Ruby on Rails: YYY
  PHP: XXXX
  
   
