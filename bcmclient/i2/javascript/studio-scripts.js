//Caching the images for run-time switching
var ui_filter_disabled_image = new Image();
ui_filter_disabled_image.src = "i2/images/clearfield_disabled.gif";

var ui_filter_enabled_image = new Image();
ui_filter_enabled_image.src = "i2/images/clearfield.gif";

function ui_submit( userAction )
{
  document.form.action = "view.x2ps";
  document.form.BUTTON_ID.value = userAction;
  document.form.submit();
  return;
}

function ui_submit_param( userAction,param )
{
  document.form.action = "view.x2ps?" + param;
  document.form.BUTTON_ID.value = userAction;
  document.form.submit();
  return;
}

function ui_clear( filterObject,imgObject )
{
  filterObject.value="";
  ui_switch_image(filterObject.value,imgObject );
  return;
}


function ui_switch_image(filterObject,imgObject )
{


if ( filterObject.length > 0 )
{
	imgObject.src = ui_filter_enabled_image.src;
	}
else
	imgObject.src = ui_filter_disabled_image.src;

}

function getRecords(actionName, startCount,tableElement)
{
    var page_form = null;
    var search_form = null;

    if(page_form == null)  page_form = document.form;

    if(search_form == null)  search_form = document.form;
 
    jumpTo(actionName, startCount, search_form, page_form,tableElement);
}

function jumpTo(actionName, startCount, search_form, page_form,tableElement)
{
  var maxRows = 10;
   if ( tableElement != null && tableElement != "" ) {
	var maxRowElement = tableElement + "_MAX_ROWS";
 
  if (page_form[maxRowElement] != null)  maxRows = page_form[maxRowElement].value;
	var recCountElement =  tableElement + "_RECORD_COUNT";
	var recCount = page_form[recCountElement].value;
	var startCountElement = tableElement + "_pagenum";
	var bstartCount= page_form[startCountElement].value;
	var pageStartCountValue = page_form[tableElement + "_START_COUNT"].value;
	}
   else {
  	
  if (page_form.MAX_ROWS != null)  maxRows = page_form.MAX_ROWS.value;
     var bstartCount= page_form.pagenum.value;
     var recCount = page_form.RECORD_COUNT.value;
     var pageStartCountValue = page_form.START_COUNT.value;
	}
  var nextCount = parseInt(startCount) + maxRows;
  var prevCount = 0;
  if ( parseInt(startCount) > 0 )
   prevCount = parseInt(startCount) - maxRows;
   if (startCount == null)
     startCount= bstartCount;

      var pagenum= parseInt(startCount);  pagenum--;
      if (actionName == "jump")
      {
        if( (  recCount  == 0 || recCount  > pagenum*maxRows)  &&  (pagenum+1>0) )
        // Commenting this condition because it doesnt work if we click the pagination button
        // quickly twice or more times - eQ :: 533549
        // the START_COUNT value in the form is already set to a different value which
        // makes the subsequent clicks not to work
        // && (pageStartCountValue != pagenum*maxRows) )
        {
          //search_form.reset();
          if ( tableElement == null || tableElement == "" )
            search_form.START_COUNT.value=pagenum*maxRows;
          else {
            var sfStartCount = tableElement + "_START_COUNT";
            search_form[sfStartCount].value = pagenum*maxRows;
          }
          ui_submit('SYS_RELOAD');
        }
      }
}

function sortOrder(order)
{
  var sortOrderElement = document.getElementById(gSortOrderElemName);
  var startCountElement = document.getElementById(gStartCountElemName);
  if (sortOrderElement != null && startCountElement != null)  
  {
    sortOrderElement.value = order;
    startCountElement.value = 0;
  }
  else
  {
    document.form.SORT_ORDER.value = order;
    document.form.START_COUNT.value = 0;
  }

  ui_submit('SYS_RELOAD');
}


function onRefresh()
{
  ui_submit('SYS_REFRESH');
}