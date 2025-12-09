/*******************************************
  i2 Documentation Tag Library - i2doctaglib.js
  Must be used with style_sheet_core.css (official i2 application Stylesheet) 
  and style_sheet_doc.css (official i2 documentation Stylesheet) 
  Version 1.0 
			Notice: Stabilized version. Anticipated changes for 1.1 are to add support for image directory locator and code snippet selection container.
	Created Fri, Oct 11, 2002.
	Author: Andy Schubert 
 *******************************************/   
// Editable Values - set these for each project. // 

var prodname="i2 Productname";
var relnum="release number";
var reldate="release date";
var copyrightrange="2000-2004";

// DO NOT EDIT BELOW THIS LINE // 

// Product Name // 
function product()
{ document.write(prodname) }

// Release Number // 
function release()
{ document.write(relnum) }

// Release Date // 
function releasedate()
{ document.write(reldate) }

// Copyright Range // 
function copyrightdate()
{ document.write(copyrightrange) } 


// Tooltip Popup // 

Xoffset= 2;    // modify these values to ... 
Yoffset= 0;    // change the popup position. 

var old,skn,iex=(document.all),yyy=-1000;
var ns4=document.layers
var ns6=document.getElementById&&!document.all
var ie4=document.all

if (ns4)
skn=document.tip
else if (ns6)
skn=document.getElementById("tip").style
else if (ie4)
skn=document.all.tip.style
if(ns4)document.captureEvents(Event.MOUSEMOVE);
else{
skn.visibility="visible"
skn.display="none"
}
document.onmousemove=get_mouse;

function popup(msg){
var content="<div class=tooltip>"+msg+"</div>";
yyy=Yoffset;
 if(ns4){skn.document.write(content);skn.document.close();skn.visibility="visible"}
 if(ns6){document.getElementById("tip").innerHTML=content;skn.display=''}
 if(ie4){document.all("tip").innerHTML=content;skn.display=''}
}

function get_mouse(e){
var x=(ns4||ns6)?e.pageX:event.x+document.body.scrollLeft;
skn.left=x+Xoffset;
var y=(ns4||ns6)?e.pageY:event.y+document.body.scrollTop;
skn.top=y+yyy;
}

function kill(){
yyy=-1000;
if(ns4){skn.visibility="hidden";}
else if (ns6||ie4)
skn.display="none"
}

// Tagline // 
function tagline()
{ document.write("<hr><span class=breadcrumbs>&copy; "+copyrightrange+" i2 Technologies. All Rights Reserved.</span><br><div style=height:100px></div>"); }

// Titleline // 
function titleline()
{ var filetitle='<h1>'+window.document.title+'</h1><hr>'; document.write(filetitle); }

//Alternating Table Rows // 
var class1 = "tablerow1";
var class2 = "tablerow0";
var rownumber = 1;
function togglerow() {
  var currentclass;
  if (rownumber % 2 == 0) {
    currentclass = class1;
  } else {
    currentclass = class2;
  }
  document.write("<tr valign=top class=\"" + currentclass + "\">");
  rownumber = rownumber + 1;
}

//Show/Hide DHTML // 
<!-- Hide script from older browsers
function toggleMenu(currMenu) {
	if (document.all) {
		thisMenu = eval("document.all." + currMenu + ".style")
		if (thisMenu.display == "block") {
			thisMenu.display = "none"
		}
		else {
			thisMenu.display = "block"
		}
		return false
	}
	else {
		return true
	}
}

function alttoggleMenu(currMenu) {
	if (document.all) {
		thisMenu = eval("document.all." + currMenu + ".style")
		if (thisMenu.display == "none") {
			thisMenu.display = "block"
		}
		else {
			thisMenu.display = "none"
		}
		return false
	}
	else {
		return true
	}
}
// End hiding script -->

// Collapse / Expand for TOC, Index Menus // 
<!--
var firstItem = 0 ;
var lastItem ;
if (NS4)
	lastItem = document.layers.length - 1 ;
if (IE4)
	lastItem = document.all.tags ("DIV").length - 1 ;

function onClicked (el) {}
function onExpandAll () {}
function onCollapseAll () {}
//-->

if (window.document.title == "menu")
	var dynLoad= 0 ;
if (window.document.title == "menu2")
	var dynLoad= 1 ;

var showLevel = 0 ;
var imf = "images" ;
var bOpenIcon = false ;
var nDays = 0 ;
var dynPref='menu';
loadHandlers=null;

//Jump To Top Link Script  © Dynamic Drive (www.dynamicdrive.com  For full source code and TOS, visit http://www.dynamicdrive.com // 

//Specify the text to display // 
var displayed="[top]"

///////////////////////////Do not edit below this line//////////// 

var logolink='javascript:window.scrollTo(0,0)'
var ns4=document.layers
var NS4=document.layers
var ie4=document.all
var IE4=document.all
var ns6=document.getElementById&&!document.all

function regenerate(){
window.location.reload()
}
function regenerate2(){
if (ns4)
setTimeout("window.onresize=regenerate",400)
}

if (ie4||ns6)
document.write('<span id="logo" style="position:absolute;top:-300;z-index:100">'+displayed+'</span>')

function createtext(){ //function for NS4
staticimage=new Layer(5)
staticimage.left=-300
staticimage.document.write('<a href="'+logolink+'">'+displayed+'</a>')
staticimage.document.close()
staticimage.visibility="show"
regenerate2()
staticitns()
}

function staticit(){ //function for IE4/ NS6
var w2=ns6? pageXOffset+w : document.body.scrollLeft+w
var h2=ns6? pageYOffset+h : document.body.scrollTop+h
crosslogo.style.left=w2
crosslogo.style.top=h2
}

function staticit2(){ //function for NS4
staticimage.left=pageXOffset+window.innerWidth-staticimage.document.width-28
staticimage.top=pageYOffset+window.innerHeight-staticimage.document.height-10
}

function inserttext(){ //function for IE4/ NS6
if (ie4)
crosslogo=document.all.logo
else if (ns6)
crosslogo=document.getElementById("logo")
crosslogo.innerHTML='<a href="'+logolink+'">'+displayed+'</a>'
w=ns6? window.innerWidth-crosslogo.offsetWidth-20 : document.body.clientWidth-crosslogo.offsetWidth-10
h=ns6? window.innerHeight-crosslogo.offsetHeight-15 : document.body.clientHeight-crosslogo.offsetHeight-10
crosslogo.style.left=w
crosslogo.style.top=h
if (ie4)
window.onscroll=staticit
else if (ns6)
startstatic=setInterval("staticit()",100)
}

if (ie4||ns6){
window.onload=inserttext
window.onresize=new Function("window.location.reload()")
}
else if (ns4)
window.onload=createtext

function staticitns(){ //function for NS4
startstatic=setInterval("staticit2()",90)
}

//end Jump to Top code // 
