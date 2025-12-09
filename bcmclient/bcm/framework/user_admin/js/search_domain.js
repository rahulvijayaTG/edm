function onCancel()
{
  document.result_form.action="../../bcm/framework/user_admin/assDomController/cancel.cmd"
  document.result_form.submit();  
}

function onSelectAndReturn()
{
  if(checkifAnySelected(result_form))
  {
    document.result_form.action="../../bcm/framework/user_admin/assDomController/selectDomain.cmd"
    document.result_form.submit();
  }
  else
  {
    alert("Please select a domain to add");
  }
}
function checkifAnySelected(form)
   {
        var count;
        var elementsLen = form.elements.length;
        var foundChecked = false;

        for(count = 0; count < elementsLen; count++)
        {
          if( form.elements[count].type == "checkbox" && form.elements[count].checked == true  &&
             form.elements[count].name != "SELECT_ALL"  ){
              foundChecked = true;
              break;
           }
        }
        return foundChecked;
   }

