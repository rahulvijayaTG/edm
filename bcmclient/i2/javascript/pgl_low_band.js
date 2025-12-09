/* pgl controls low bandwidth js */

    // Page.xsl js - Start::
    function initFrameToggleGif(path)
    {
      if(window == null ) return;
      if(window.frameElement == null ) return;
      if(window.frameElement.parentNode == null ) return;
      var frameCol = window.frameElement.parentNode.cols;
      if ( frameCol.charAt(0) == "0")
      {
        if (document.all)
        {
          toggle.title = "Show Navigation Frame";
          toggle.innerText = ">";
        }
      }
      else
      {
        if (document.all)
        {
          toggle.title = "Hide Navigation Frame";
          toggle.innerText = "<";
        }
      }
    }

    function togglenav(path)
    {
      if(window == null ) return;
      if(window.frameElement == null ) return;
      if(window.frameElement.parentNode == null ) return;
      var frameCol = window.frameElement.parentNode.cols;
      if ( frameCol.charAt(0) == "0")
      {
        if (document.all)
        {
          toggle.title = "Hide Navigation Frame";
          toggle.innerText = "<";
          window.frameElement.parentNode.cols="170,*";
          tabShow = 0;
          return;
        }
      }
      else
      {
        if (document.all)
        {
          toggle.title = "Show Navigation Frame";
          toggle.innerText = ">";
          window.frameElement.parentNode.cols="0%,100%";
          tabShow = 1;
        }
      }
    }
    // Page.xsl js - End::  

function tabsetScrollerButtons( cells, lt, endScroll )
{
  var cl = cells.length;
  var begin = cells[ cl - 8 ];
  var left = cells[ cl - 6 ];
  var right = cells[ cl - 4 ];
  var end = cells[ cl - 2 ];
  if( lt > 0 ){
    begin.className = 'tabScrollTextC';
    left.className = 'tabScrollTextC';
  }
  else{
    begin.className = 'tabScrollText';
    left.className = 'tabScrollText';
  }
  if( endScroll > 0 ){
    right.className = 'tabScrollTextC';
    end.className = 'tabScrollTextC';
  }
  else{
    right.className = 'tabScrollText';
    end.className = 'tabScrollText';
  }
}

