function initContainer(container_id)
{
    i2uiResizeScrollableContainer(container_id,document.body.offsetHeight - 60, null, document.body.offsetWidth - 20, true, 'yes');
}

function resizeContainer(container_id)
{
    i2uiResizeScrollableContainer(container_id,document.body.offsetHeight -60, null, document.body.offsetWidth - 20, true, 'yes');
}

function onLoad()
{
  i2uiManageTreeTableUserFunction = 'handletoggle';
  i2uiToggleContentUserFunction = 'handletoggle';
	if (!document.layers)
  {
    // scroller + left margin + right margin = 16 + 10 + 10 = 36
    var x = document.body.scrollWidth - 15;

     i2uiResizeScrollableArea('errorsTable',100,x,null,10);
     i2uiResizeColumns('errorsTable');  
  }    
}


function handletoggle(item, delta)
{
  var x = document.body.scrollWidth - 15;
  if (item == 'errorsTable')
    i2uiResizeScrollableArea('errorsTable',100,x,null,10);
 
 initContainer('errorContainer');
 resizeContainer('errorContainer');
}
