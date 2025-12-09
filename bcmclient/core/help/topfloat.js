<!--
markW = 10;
markH = 25;
markX = 99;
markY = 99;
markRefresh = 50;

if (!document.all) document.all = document;
if (!document.all.waterMark.style) document.all.waterMark.style = document.all.waterMark;

wMark = document.all.waterMark.style;
wMark.width = markW;
wMark.height = markH;
navDOM = window.innerHeight;
 
function setVals() {
 barW = 0;
 barH = 0;
 if (navDOM) {
  if (document.height > innerHeight) barW = 20;
  if (document.width > innerWidth) barH = 20;
  } else {
  innerWidth = document.body.clientWidth;
  innerHeight = document.body.clientHeight;
  }
 posX = ((innerWidth - markW)-barW) * (markX/100);
 posY = ((innerHeight - markH)-barH) * (markY/100);
 }
function wRefresh() {
 wMark.left = posX + (navDOM?pageXOffset:document.body.scrollLeft);
 wMark.top = posY + (navDOM?pageYOffset:document.body.scrollTop);
 }
function markMe() {
 setVals();
 window.onresize=setVals;
 markID = setInterval ('wRefresh()',markRefresh);
 }
window.onload=markMe;
//-->