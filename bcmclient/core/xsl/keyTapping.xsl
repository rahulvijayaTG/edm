<?xml version="1.0" standalone='no'?>

<xsl:stylesheet 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:lxslt="http://xml.apache.org/xslt"
                xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
                xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
                extension-element-prefixes="i2 i18n"
                version="1.0">


  <xsl:output method="html"/>


<!-- ********************************************************************** 
     *********************************************************************** -->
<xsl:template name="include_javascript_key_tapping">
<script>
  
<![CDATA[

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
    //document.onkeydown=IEEnterKey;
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
        onKeyPress(window.event.srcElement)
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

function NetEnterKey(e) 
{
  key = e.which; 
  if(key == 13)
  { 
    onKeyPress( e.target )
    return false;
  }
}  

function onKeyPress( target ) 
{
}

// Enter Key Tapping - End.
]]>
</script>
</xsl:template>
<!-- ********************************************************************** 
     *********************************************************************** -->
</xsl:stylesheet>   
