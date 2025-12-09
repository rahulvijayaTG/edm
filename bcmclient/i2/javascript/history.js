/**
 * History Component 1.0 19990913
 * by Larry Mason
 * Copyright (c) 1999 i2 Technologies
 *
 */

/* 1.1 12/13/99 change invoke_url to invoke_filtered_url */
/* 1.2 01/26/00 change top to container_object to support embedding */
/* 1.3 03/01/00 add getHistoryUnparsedURL to help favorites processing */
/* 1.4 03/24/00 add backup and restore history */
/* 1.5 04/05/00 add support for element's target */
/* 1.6 04/24/00 new display style */
/* 1.7 06/21/00 fixed popHistory for historyyunparsed */
/* 1.8 06/22/00 add support for element's method - post or get */
/* 1.9 06/05/01 appverifyhistory can have history position as arg if signature is myfnc(position)
   i.e. appverifyhistory = "scmtop.myfnc(position)". Note that 'position' is a keyword and
   your function can have any name so any string before '(' will be called.
*/

function History(label, id)
{
  this.version = "1.8 [history.js; History Component; 20000622]";
  this.historyurls     = new Array();
  this.historyunparsed = new Array();
  this.historynames    = new Array();
  this.historytarget   = new Array();
  this.historymethod   = new Array();
  this.savehistoryurls     = new Array();
  this.savehistoryunparsed = new Array();
  this.savehistorynames    = new Array();
  this.savehistorytarget   = new Array();
  this.savehistorymethod   = new Array();
  this.mytarget   = null;

  this.unloadPage = false;
  this.reloadPage = false;
  this.breadCrumbClicked = false;
  this.breadCrumbPageLoaded = false;
  this.breadCrumbPagePosition = -1;
  //this.currentPagePosition = -1;

  this.addHistory       = addHistory;
  this.getHistoryURL    = getHistoryURL;
  this.getHistoryName   = getHistoryName;
  this.getHistoryTarget   = getHistoryTarget;
  this.clearHistory     = clearHistory;
  this.displayHistory   = displayHistory;
  this.invokeHistory    = invokeHistory;
  this.popHistory       = popHistory;
  this.setHistoryTarget = setHistoryTarget;
  this.setSolutionName =  setSolutionName;
  this.getSolutionName =  getSolutionName;

  this.pushHistory = pushHistory;
  this.replaceHistoryAt = replaceHistoryAt;
  this.setUnloadPage = setUnloadPage;
  this.resetUnloadPage = resetUnloadPage;
  this.setReloadPage = setReloadPage;
  this.resetUnloadPage = resetUnloadPage;
  this.popHistoryAfter = popHistoryAfter;
  this.goBack = goBack;

  this.getHistoryCount  = getHistoryCount;
  this.getHistoryChain  = getHistoryChain;
  this.dumpHistory      = dumpHistory;
  this.getHistoryUnparsedURL    = getHistoryUnparsedURL;
  this.backupHistory    = backupHistory;
  this.restoreHistory   = restoreHistory;
  this.clearBackupHistory = clearBackupHistory;

  this.historylabel = label || "History";
  this.historyId = id || "parent.scmHistory";
  this.solutionname = null;
}

function getHistoryCount()
{
  return this.historyurls.length;
}

function getHistoryChain()
{
var chain = "";
var len = this.historyurls.length;

  for (var i=0; i<len; i++)
  {
    chain += this.historynames[i];
    chain += ",";
  }
  return chain;
}

function setUnloadPage() {
  this.unloadPage = true;
}

function resetUnloadPage() {
  this.unloadPage = false;
}

function setReloadPage() {
  this.reloadPage = true;
}

function resetUnloadPage() {
  this.reloadPage = false;
}


function popHistory()
{
var len = this.historyurls.length;

  if (len > 0)
  {
    this.historynames[len-1] = null;
    this.historynames.length--;
    this.historyurls[len-1] = null;
    this.historyurls.length--;
    this.historytarget[len-1] = null;
    this.historytarget.length--;
    this.historyunparsed[len-1] = null;
    this.historyunparsed.length--;
    this.historymethod[len-1] = null;
    this.historymethod.length--;
    this.displayHistory();
  }
}


function popHistoryAfter(position){
  //this.dumpHistory(true);
  var popCount  = this.historyurls.length - position - 1;
  //alert("position = " + position + ", len = " + len + ".Have to pop " + (len - position - 1) + " items");

  for (var i = 0 ; i < popCount ; i++) {
    this.popHistory();
    //this.dumpHistory(true);
  }
}

function invokeHistory(position,target)
{
   var len=this.historyurls.length;

   if(position==-1)
   {
         position=len-1;
   }

  var url=this.historyurls[position];

  this.breadCrumbClicked = true;
  this.breadCrumbPagePosition = position;

  //Try to use the target in the array or use a common fixed target instead of hardcoding it....
  parent.appFrame.location.replace(url);
  //this.popHistory();
}


function addHistory(pageName, pageUrl, pageTarget, pageMethod, firstEntry)
{
  //alert("name = " + pageName + ", URL = " + pageUrl);

  if (!this.breadCrumbClicked && !this.reloadPage && firstEntry) {
    //alert("Clearing history");
    this.clearHistory();
  }

  //Page loaded by clicking on the breadcrumb. Ignore request to add itself.
  if (this.breadCrumbClicked) {
    this.breadCrumbClicked = false;
    this.breadCrumbPageLoaded = true;
    this.displayHistory();
  } else if (this.unloadPage && this.breadCrumbPageLoaded) {
    this.unloadPage = false;
    this.replaceHistoryAt(this.breadCrumbPagePosition - 1, pageName, pageUrl, pageTarget, pageMethod);
  } else if (this.reloadPage && this.breadCrumbPageLoaded) {
    this.reloadPage = false;
    this.replaceHistoryAt(this.breadCrumbPagePosition, pageName, pageUrl, pageTarget, pageMethod);
  } else if (this.breadCrumbPageLoaded) {
    this.breadCrumbPageLoaded = false;
    this.popHistoryAfter(this.breadCrumbPagePosition);
    this.breadCrumbPagePosition = -1;
    this.pushHistory(pageName, pageUrl, pageTarget, pageMethod);
  } else if (this.unloadPage) {
    this.unloadPage = false;
    this.popHistory();
    this.replaceHistoryAt(this.historyurls.length - 1 , pageName, pageUrl, pageTarget, pageMethod);
  } else if (this.reloadPage) {
    this.reloadPage = false;
    this.replaceHistoryAt(this.historyurls.length - 1, pageName, pageUrl, pageTarget, pageMethod);
  } else {
    this.pushHistory(pageName, pageUrl, pageTarget, pageMethod);
   }
  //WIth ALerts
  /*
  if (this.breadCrumbClicked) {
    alert("breadCrumbClicked, addHistory");
    this.breadCrumbClicked = false;
    this.breadCrumbPageLoaded = true;
    this.displayHistory();
  } else if (this.unloadPage && this.breadCrumbPageLoaded) {
    alert("unload and breadcrumbpageLoaded, addHistory");
    this.unloadPage = false;
    this.replaceHistoryAt(this.breadCrumbPagePosition - 1, pageName, pageUrl, pageTarget, pageMethod);
  } else if (this.reloadPage && this.breadCrumbPageLoaded) {
    alert("reload and breadcrumbpageLoaded, addHistory");
    this.reloadPage = false;
    this.replaceHistoryAt(this.breadCrumbPagePosition, pageName, pageUrl, pageTarget, pageMethod);
  } else if (this.breadCrumbPageLoaded) {
    alert("breadcrumbpageLoaded, addHistory");
    this.breadCrumbPageLoaded = false;
    this.popHistoryAfter(this.breadCrumbPagePosition);
    this.breadCrumbPagePosition = -1;
    this.pushHistory(pageName, pageUrl, pageTarget, pageMethod);
  } else if (this.unloadPage) {
    alert("unload, addHistory");
    this.unloadPage = false;
    this.popHistory();
    this.replaceHistoryAt(this.historyurls.length - 1 , pageName, pageUrl, pageTarget, pageMethod);
  } else if (this.reloadPage) {
    alert("reload, addHistory");
    this.reloadPage = false;
    this.replaceHistoryAt(this.historyurls.length - 1, pageName, pageUrl, pageTarget, pageMethod);
  } else {
    alert("normal addHistory");
    this.pushHistory(pageName, pageUrl, pageTarget, pageMethod);
   }
   */
}

function goBack() {
  parent.appFrame.location.replace("something");
}

function pushHistory(pageName, pageUrl, pageTarget, pageMethod) {
  var len = this.historyurls.length;
  this.replaceHistoryAt(len, pageName, pageUrl, pageTarget, pageMethod);
}

function replaceHistoryAt(position, pageName, pageUrl, pageTarget, pageMethod) {
  if (pageMethod == null) {
    pageMethod = 'post';
  }

  this.historyurls[position]      = pageUrl;
  this.historynames[position]     = pageName;
  this.historytarget[position]    = pageTarget;
  this.historymethod[position]    = pageMethod;

  this.displayHistory();
}

/*
function addHistory(name, parsedURL, unparsedURL, target, method)
{
  var len = this.historyurls.length;
  // add actionType  parameter to the url so that products can identify the request is made by clicking the bread crumbs
  this.historyurls[len]      = parsedURL;
  this.historyunparsed[len]  = unparsedURL;
  this.historynames[len]     = name;
  this.historytarget[len]    = target;
  if (method == null)
    method = 'post';
  this.historymethod[len]    = method;
  this.displayHistory();
}
*/
function getHistoryURL(position)
{
var len = this.historyurls.length;

  if (len > 0 && position == -1)
  {
    return this.historyurls[len-1];
  }
  else
  if (position >= 0 && position <= len)
  {
    return this.historyurls[position];
  }
  return null;
}

function getHistoryUnparsedURL(position)
{
var len = this.historyunparsed.length;

  if (len > 0 && position == -1)
  {
    return this.historyunparsed[len-1];
  }
  else
  if (position >= 0 && position <= len)
  {
    return this.historyunparsed[position];
  }
  return null;
}

function getHistoryName(position)
{
var len = this.historyurls.length;

  if (len > 0 && position == -1)
  {
    return this.historynames[len-1];
  }
  else
  if (position >= 0 && position <= len)
  {
    return this.historynames[position];
  }
  return null;
}

function getHistoryTarget(position)
{
var len = this.historytarget.length;
  if (len > 0 && position == -1)
  {
    return this.historytarget[len-1];
  }
  else
  if (position >= 0 && position <= len)
  {
    return this.historytarget[position];
  }
  return null;
}

function displayHistory()
{
   //var text = '';
   var startorend =   1;
   var startindex =  -1;
   var endindex   =  -1;
   endindex       =   this.historyurls.length -1;

  if(arguments.length >0)
  {
        startorend=arguments[0];
        if(startorend ==0)
                startindex=arguments[1];
        else
                endindex=arguments[1];
   }
  var target = eval(this.mytarget);

  if (target)
  {
        // target.innerWidth=650;
        var wnew=650;
        if (navigator.appName=="Microsoft Internet Explorer")
            wnew = target.document.body.clientWidth + 50;
        else if(navigator.appName=="Netscape")
                wnew=target.innerWidth + 50;

        target.innerWidth=wnew;

    var len = this.historyurls.length;

    var currentPagePosition = -1;

    if (len > 0 ) {
      currentPagePosition  = len - 1;
    }
    if (this.breadCrumbPagePosition != -1) {
      currentPagePosition = this.breadCrumbPagePosition;
    }

    /*
    if (currentPagePosition != -1) {
      alert("Current page at " + currentPagePosition + " = " + this.historynames[currentPagePosition]);
    }*/

    text = '<html><Head><META http-equiv=\'Content-Type\' content=\'text/html; charset=UTF-8\'></Head><body id="historybody" leftmargin="0px" topmargin="3px" rightmargin="0px" bottommargin="0px" ';
    if (len > 0)
      text += 'style="background-color:#E6E6E6;';
    else
      text += 'style="background-color:#E6E6E6;';
    text += 'color:#2B4E9F;font-size:11px;font-weight:bold;';
    text += 'text-decoration:none;';
    text += 'font-family:verdana;"';
    text += 'link="#2B4E9F" alink="#2B4E9F" vlink="#2B4E9F">';
    if(this.solutionname)
    {
      text +=this.solutionname;
      text += ': ';
    }
    var leng='';
    var k = 0;
    if (len > 0)
    {
       //alert("historylen = " + len);
       for (var i=0; i<len; i++)
       {
         leng += this.historynames[i];
         leng += '   ';
       }

       var totlen =  (target.innerWidth/8.7);

       var addlen = 0;
       addlen = this.historynames[len-1].length;
       addlen  = addlen / 15;

      if ( (leng.length + addlen) > totlen )
      {
        var glen = '';
        var maxlen = 0;
        if(this.solutionname)
            maxlen = (totlen -(this.solutionname.length ) );
        else
            maxlen = totlen;

        if(startorend==0)
        {
          for(var i=startindex; i <=len-1;i++)
          {
            glen+= this.historynames[i];
            glen += '   ';

            if ( glen.length > (maxlen))
              break;
            else
              k++;
          }
          endindex = startindex + k - 1;
       }
       else
       {
         for (var i = endindex ; i >= 0 ; i--)
         {
           glen += this.historynames[i];
           glen += '   ';
           if ( glen.length > (maxlen))
             break;
           else
             k++;

         }
         startindex = endindex -k + 1 ;
       }

       var sindex=startindex-1;
       if(sindex<0)
         sindex=0;
       var eindex = endindex+1;
       if(eindex>len-1)
         eindex=len-1;
       if(startindex>0)
       {
         var l=0;
         text += '<a style="font-size:11px;font-weight:normal;color:#B11313;text-decoration:none" href="javascript:'+this.historyId+'.displayHistory('+l+','+sindex+')">';
         text +='&lt;';
         text +='&lt;';
         text += ' ';
         text += '</a>'
       }
       var glen = '';
       if (k >= 1)
       {
         for(var i=startindex; i<=endindex;i++)
         {
           if (i > startindex)
             text += ' &gt; ';
           if (i == currentPagePosition) {
             text += '<b style="font-size:11px">';
             text += this.historynames[i];
             text += '</b>';
           }
         /*
           if (i == len -1)
           {
       alert("displaying last link in when len = " + len);

             text += '<b style="font-size:11px">';
             text += this.historynames[len-1];
             text += '</b>';
           }
             */
           else
           {
             text += '<a style="font-size:11px;font-weight:normal; text-decoration:none" href="javascript:'+this.historyId+'.invokeHistory('+i+')">';
             text += this.historynames[i];
             text += '</a>';
           }
           //text += '&gt; ';
         }

      }
      else
      {
        //text += ' &gt; ';
      }
    }
    else
    {
       for (var i=0; i<len-1; i++)
       {
           if (i == currentPagePosition) {
             text += '<b style="font-size:11px">';
             text += this.historynames[i];
             text += '</b>';
           } else {
             text += '<a style="font-size:11px;font-weight:normal; text-decoration:none" href="javascript:'+this.historyId+'.invokeHistory('+i+')">';
             text += this.historynames[i];
             text += '</a>';
           }
           text += ' &gt; ';
       }
       /* show last as non-link*/
       if (i == currentPagePosition) {
         text += '<b style="font-size:11px">';
         text += this.historynames[i];
         text += '</b>';
       } else {
         text += '<a style="font-size:11px;font-weight:normal; text-decoration:none" href="javascript:'+this.historyId+'.invokeHistory('+(len-1)+')">';
         text += this.historynames[len-1];
         text += '</a>';
       }
         /*
       text += '<b style="font-size:11px">';
       text += this.historynames[len-1];
       text += '</b>';
       */
       //text += '.. ';
     }
     if(endindex<len-1)
     {
        var m = 1;
        text += '<a style="font-size:11px;font-weight:normal;color:#B11313;text-decoration:none" href="javascript:'+this.historyId+'.displayHistory('+m+','+eindex+')">';
        text+= ' ';
        text +='&gt;';
        text +='&gt;';
        text += '</a>';
      }
   }
   text += '</body></html>';
   target.document.open("text/html","replace");
   target.document.writeln(text);
   target.document.close();
 }
}

function setHistoryTarget(target)
{
  this.mytarget = target;
}

function clearHistory()
{
  this.historyurls     = new Array();
  this.historynames    = new Array();
  this.historyunparsed = new Array();
  this.historytarget   = new Array();
  this.historymethod   = new Array();

  this.unloadPage = false;
  this.reloadPage = false;
  this.breadCrumbClicked = false;
  this.breadCrumbPageLoaded = false;
  this.breadCrumbPagePosition = -1;

  this.displayHistory();
}

function clearBackupHistory()
{
  this.savehistoryurls     = new Array();
  this.savehistorynames    = new Array();
  this.savehistoryunparsed = new Array();
  this.savehistorytarget   = new Array();
  this.savehistorymethod   = new Array();
}

function backupHistory()
{
  this.clearBackupHistory();

  var len = this.historyurls.length;
  if (len > 0)
  {
    for (var i=0; i<len; i++)
    {
      this.savehistoryurls[i]     = this.historyurls[i];
      this.savehistorynames[i]    = this.historynames[i];
      this.savehistoryunparsed[i] = this.historyunparsed[i];
      this.savehistorytarget[i]   = this.historytarget[i];
      this.savehistorymethod[i]   = this.historymethod[i];
    }
  }
}

function restoreHistory()
{
  this.clearHistory();

  var len = this.savehistoryurls.length;
  if (len > 0)
  {
    for (var i=0; i<len; i++)
    {
      this.historyurls[i]     = this.savehistoryurls[i];
      this.historynames[i]    = this.savehistorynames[i];
      this.historyunparsed[i] = this.savehistoryunparsed[i];
      this.historytarget[i]   = this.savehistorytarget[i];
      this.historymethod[i]   = this.savehistorymethod[i];
    }
  }
}

function dumpHistory(alertType)
{
  if (alertType) {
  var len = this.historyurls.length;
  var text = "#history items="+len + "\n";
  for (var i=0; i<len; i++)
  {
    text += i + " = " + this.historynames[i]+"\n";
  }

  alert(text);
  } else {
  history_debug_window = window.open("",
                               "",
                               "status=no,scrollbars=yes,resizable=yes");

  <!-- write each name/value pair into window -->
  history_debug_window.document.open();
  history_debug_window.document.write("<html><title>History Display Window</title>");
  history_debug_window.document.write("<body>");

  history_debug_window.document.write("<br> breadCrumbClicked = " + this.breadCrumbClicked + " at position " +this.breadCrumbPagePosition);
  history_debug_window.document.write("<br> unloadPage "+ this.unloadPage);
  history_debug_window.document.write("<br> reloadPage "+ this.reloadPage);
  history_debug_window.document.write("<br> breadCrumbPageLoaded " + this.breadCrumbPageLoaded);
  history_debug_window.document.write("<br><br>");
  var len = this.historyurls.length;
  history_debug_window.document.write("<br>#history items="+len);
  for (var i=0; i<len; i++)
  {
    history_debug_window.document.write("<br>"+this.historynames[i]+" = "+ this.historyurls[i]);
  }

  <!-- write refresh mechanism into window -->
  //history_debug_window.document.write("<br><a href='javascript:opener.dumpHistory()'>Refresh</a></body></html>");
  history_debug_window.document.write("</body></html>");
  history_debug_window.document.close();
  }
}

function setSolutionName(name)
{
  this.solutionname = name;
}
function getSolutionName()
{
   return this.solutionname;
}

