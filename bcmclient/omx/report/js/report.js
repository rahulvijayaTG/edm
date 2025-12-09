function onDelete()
{
  if (checkifAnySelected(document.result_form))
	{
		document.result_form.target="appFrame";
	  document.result_form.action="../report/custom_reports/delete.cmd";
		document.result_form.submit();
  }
}

