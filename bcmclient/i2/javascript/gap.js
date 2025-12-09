function onRowSelection(){
}

function disableButton(id)
{
  javascript:i2uiToggleItemVisibility( id, 'hide');javascript:i2uiToggleItemVisibility(id + '_disabled', 'show');
}

function enableButton(id)
{
  javascript:i2uiToggleItemVisibility( id, 'show');javascript:i2uiToggleItemVisibility(id + '_disabled', 'hide');
}


// Enter Key Tapping - Start::
browserName = navigator.appName;

if (browserName == "Netscape")
{
  document.captureEvents(Event.KEYPRESS);
  document.onkeypress=NetEnterKey;
}
else
{
  if (browserName.indexOf("Explorer") >= 0)
  {
    document.onkeypress=IEEnterKey;
    document.onkeydown=IEEnterKey;
  }
}


function IEEnterKey()
{

  // if enter key
  if(window.event.keyCode == 13)
  {
    if (window.event.srcElement.onclick != null)
    {
      event.returnValue=true;
    }
    else
    {
      if ( window.event.srcElement.type != "textarea" )
      {
        SetfocusSubmit(window.event.srcElement)
      }

      event.returnValue=false;
    }
  }
  // if backspace
  if (window.event.keyCode==8)
  {
    if (window.event.srcElement.isTextEdit == false)
      event.returnValue=false;
  }
}

  var scmtop = top;
	function findscmtop()
	{
   	scmtop = top;
		// locate SCM from top down
		if (!scmtop.scm_top)
		{
		  // locate SCM from bottom up
		  scmtop = window;
		  while (scmtop && 
			 scmtop != top && 
			 !scmtop.scm_top)
		  {
		    scmtop = scmtop.parent;
		  }
		}
   }

      function initFrameToggleGif(path) 
      {
        if(window == null ) return;
        if(window.frameElement == null ) return;
        if(window.frameElement.parentNode == null ) return;

			findscmtop();
	//[Nitin Goel - changes to support scmui wrapper
	  if (scmtop && scmtop.scm_top)
		frameNode = scmtop.topmost;
	  else
		frameNode = window.frameElement.parentNode;

	  var frameCol = frameNode.cols;
	//]NG
   
        if ( frameCol.charAt(0) == "0") 
        {
          if (document.all) 
          {
            document.header.toggle.alt = "Show Navigation Frame";
            document.header.toggle.src = omxContextPath + "/i2/images/expand.gif";
          }
        }
        else
        {
          if (document.all) 
          {
            document.header.toggle.alt = "Hide Navigation Frame";
            document.header.toggle.src = omxContextPath + "/i2/images/collapse.gif";
          }
        }
      }

      //[Nitin Goel : changes for supporting scmui wrapper
      function togglenav(path) 
      {
        if(window == null ) return;
        if(window.frameElement == null ) return;
        if(window.frameElement.parentNode == null ) return;
        
        findscmtop();
        var frameNode;
			if (scmtop && scmtop.scm_top)
				frameNode = scmtop.topmost;
			else
				frameNode = window.frameElement.parentNode;
        
        var frameCol = frameNode.cols;
      
        if ( frameCol.charAt(0) == "0") 
        {
          if (document.all) 
          {
            document.header.toggle.alt = "Hide Navigation Frame";
            document.header.toggle.src = omxContextPath + "/i2/images/collapse.gif";
            frameNode.cols="170,*";
            tabShow = 0;
            return;
          }
        }
        else
        {    
          if (document.all) 
          {
            document.header.toggle.alt = "Show Navigation Frame";
            document.header.toggle.src = omxContextPath + "/i2/images/expand.gif";
            frameNode.cols="0%,100%";
            tabShow = 1;
          }
        }
       }

	function onSelectRow(id)
	{
		var el = event.srcElement;
		var oRow = null;
		oRow = el.parentElement.parentElement;
		var checked = el.getAttribute("checked");
		setCellColor(oRow, checked);
	}
	
        function setCellColor(oRow, checked)
        {
        	var color = null;
        	if (checked)
        	{
        		//alert("setting to yellow"); 
        		color = '#fff6a6';
        	}
        	else if ((oRow.rowIndex % 2) == 1)
        	{
        		color = '#f7f8fd';
        	}
        	else
        	{
        		color = '#eceef8';
        	}
        	
        	var cells = oRow.cells;
        	//alert("cols = " + cells.length );
        	for (i=0; i < cells.length ; i++)
        	{
        		oRow.cells[i].bgColor = color  ;
        	}
        }
       
       //]Nitin Goel
