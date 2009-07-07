function myPopUpWin() {
	var iMyWidth;
	var iMyHeight;
	//half the screen width minus half the new window width (plus 5 pixel borders).
	iMyWidth = (window.screen.width/2) - (400/2 + 10);
	//half the screen height minus half the new window height (plus title and status bars).
	iMyHeight = (window.screen.height/2) - (500/2 + 50);
	//Open the window.
	var win2 = window.open("sc-connect.html", "Window2", "status=no, height=400, width=500, resizable=yes, left=" + iMyWidth + ",top=" + iMyHeight + ",screenX=" + iMyWidth + ",screenY=" + iMyHeight + ",toolbar=no,menubar=no,scrollbars=no,location=no,directories=no");
	win2.focus();
}