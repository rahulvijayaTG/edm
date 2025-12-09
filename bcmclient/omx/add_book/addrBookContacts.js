
      function editContact( con_id )
      {
        document.contactsForm.EDIT_CONTACT_ID.value = con_id;
        document.contactsForm.action="../contacts/editContact.cmd";
        document.contactsForm.submit();
      }
    

      function addFromExisting()
      {
        if ( checkExistingList() )
        {
          document.addExistingForm.action="../contacts/addExistingContact.cmd";
          document.addExistingForm.submit();
        }
      }

    
      function checkExistingList()
      {
	  var length = document.addExistingForm.CONTACT_ID.length;
	  if(isNaN(length))
	  {
	    if (document.addExistingForm.CONTACT_ID.checked)
          {
  	      if (checkExisting(document.addExistingForm.CONTACT_ID.value))
	        return false;
          }
	  }
	  for (var i=0;i<length;i++)
	  {
	    if (document.addExistingForm.CONTACT_ID[i].checked)
          {
  	      if (checkExisting(document.addExistingForm.CONTACT_ID[i].value))
	        return false;
          }
        }	 	    
	  return true;
      }


      function checkExisting( id )
      {
 	  if(!document.contactsForm.CONTACT_ID)
	    return false;
	  else
	  {
	    var length = document.contactsForm.CONTACT_ID.length;
	    if(isNaN(length))
	    {
	      if (document.contactsForm.CONTACT_ID.value == id)
            {
              omx_alert( "Contact is allready in the contacts list" );
		  return true;
            }
	    }
	    for (var i=0;i<length;i++)
	    {
	      if (document.contactsForm.CONTACT_ID[i].value == id)
            {
              omx_alert( "Contact is allready in the contacts list" );
		  return true;
            }
	    }	 	    
	  }  
	  return false;
      }


      function confirmRemoveContact()
      {
	 if (!isCheckboxSelected())
	   omx_alert("PLEASE_SELECT_CONTACT");
	 else
	 {
            document.contactsForm.action="../contacts/removeContact.cmd";
            document.contactsForm.submit();
	 }
      }
	
      function isCheckboxSelected()
      {
	if(!document.contactsForm.CONTACT_ID)
	   return false;
	else
	{
	   var length = document.contactsForm.CONTACT_ID.length;
	   if(isNaN(length))
	   {
	      if (document.contactsForm.CONTACT_ID.checked)
	        return true;
	   }
	   for (var i=0;i<length;i++)
	   {
	      if (document.contactsForm.CONTACT_ID[i].checked)
	      {
		return true;
	      }
	   }	 	    
	 }  
	 return false;
      }
        
      function addNewContact()
      {
        if( requiredFieldCheck() == 'false' )
        {
         document.addNewContactForm.action="../contacts/addNewContact.cmd";
         document.addNewContactForm.submit();
        }
      }
        
      function updateContact()
      {
        if( requiredFieldCheck() == 'false' )
        {
         document.addNewContactForm.action="../contacts/updateContact.cmd";
         document.addNewContactForm.submit();
        }
      }
    
       function initUsersTable()
		{
		 
		   if (!document.layers)
  	       {
 
            // scroller + left margin + right margin = 16 + 10 + 10 = 36
            var x = document.body.scrollWidth - 7.5;
  
             i2uiResizeScrollableArea('usersTable',200,x,null,20);
             i2uiResizeColumns('usersTable');
		    }
		}

	function initContactTable()
		{
		 
		   if (!document.layers)
  	       {
 
            // scroller + left margin + right margin = 16 + 10 + 10 = 36
            var x = document.body.scrollWidth - 7.5;
  
             i2uiResizeScrollableArea('contactTable',200,x,null,20);
             i2uiResizeColumns('contactTable');
		    }
		}
	
		function onresize()
		{
			 initUsersTable();
			 initContactTable();   
		}
		
        function onload()
		{
			initUsersTable();
			initContactTable();
		}
