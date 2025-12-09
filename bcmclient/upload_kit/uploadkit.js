function initContainer(container_id)
{
    i2uiResizeScrollableContainer(container_id,document.body.offsetHeight - 60, null, document.body.offsetWidth - 20, true, 'yes');
}

function resizeContainer(container_id)
{
    i2uiResizeScrollableContainer(container_id,document.body.offsetHeight -60, null, document.body.offsetWidth - 20, true, 'yes');
}

function onLoad(tableId)
{
  i2uiManageTreeTableUserFunction = 'handletoggle';
  i2uiToggleContentUserFunction = 'handletoggle';
	if (!document.layers)
  {
    // scroller + left margin + right margin = 16 + 10 + 10 = 36
    var x = document.body.scrollWidth - 25;

     i2uiResizeScrollableArea(tableId,200,x,null,10);
     i2uiResizeColumns(tableId);  
  }    
}

function trimString (str) 
{
  str = this != window? this : str;
  return str.replace(/^\s+/g, '').replace(/\s+$/g, '');
}