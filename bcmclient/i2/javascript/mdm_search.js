function SetfocusSubmit( target ) 
{
  if(target.name == 'pagenum')
  {
    getRecords('jump');
  }
  else if ( target.form != null && (target.form == document.search_form))
  {
    onSearch();
  } 
  else if (target.form != null && (target.form == document.search_footer_form))
  {   
    getRecords('jump');
  }
  else if (target.protocol == 'javascript:')
  {
    var js = target.toString();
    eval(js);
  }
  else
  {
     onSearch();
  }
}       
