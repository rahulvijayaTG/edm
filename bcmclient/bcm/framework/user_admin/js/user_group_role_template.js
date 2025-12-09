/**************************************************************************
    COMMAND NAME: 	assignRoleTemplate
    PURPOSE: 		This function saves the data related to the notification to which user subscribes.
    PARAMETERS:		frmFormName - form object that stores the data to be saved
    OTHER CALLS:	validateFormEmpty
    RETURN:			None
    AUTHOR:			Ashish Kapoor
***************************************************************************/
function assignRoleTemplate(frmFormName)
{

  var strSubscribeURL="";			//variable to store URL of update page
  var msg = "";					//variable to store the display message
  // Addition by ASHISH KAPOOR to Fix Issue# 406036 - START
  var strNotificationValue = "";
  var bNotificationSelected = false;

  /* Loop through the SELECTED_AVAILABLE_ROLE_TEMPLATES list to check if any notification has been seleted	*/
  for(count=0; count < frmFormName.SELECTED_AVAILABLE_ROLE_TEMPLATES.length; count++)
  {
    strNotificationValue = frmFormName.SELECTED_AVAILABLE_ROLE_TEMPLATES[count].value;

    if((strNotificationValue.length > 0) && (frmFormName.SELECTED_AVAILABLE_ROLE_TEMPLATES[count].selected == true))
    {
      bNotificationSelected = true;
      break;
    }
  }

  /* Validate if any Notification and Protocols were selected and perform appropriate action */
  if(!bNotificationSelected)
  {
    //display message
    msg += "Please select available role template to assign";
    omx_alert(msg);
  }
  else
  {
    //submit the form
    strSubscribeURL= omxContextPath + '/bcm/framework/user_admin/user_admin_groups_new/assignRoleTemplateToUserGroup.cmd';
    frmFormName.action=strSubscribeURL;
    //alert( strSubscribeURL );
    frmFormName.submit();
  }
}

/**************************************************************************
    COMMAND NAME: 	unsubscribeToNotifications
    PURPOSE: 		This function removes the notification subscription
            inoformation from user's profile.
    PARAMETERS:		frmFormName - form object that stores the data to be
            saved
    OTHER CALLS:	validateFormEmpty
    RETURN:			None
    AUTHOR:			Ashish Kapoor
***************************************************************************/
function unAssignRoleTemplate(frmFormName)
{

  var strUnsubscribeURL="";			//variable to store URL of update page
  var bFormEmpty = false;			//variable to store value if the search form is empty
  var msg = "";					//variable to store the display message


  //call the function to check if the form is empty
  bFormEmpty = validateFormEmpty(frmFormName);
  //validate the response of above function call and take appropriate action
  if(bFormEmpty)	//form empty
  {
    //display message
    msg += "Please select current role template to unassign.";
    omx_alert(msg);
  }
  else
  {
    //submit the form
    strUnsubscribeURL=omxContextPath + '/bcm/framework/user_admin/user_admin_groups_new/removeAssignedRoleTemplate.cmd';
    frmFormName.action=strUnsubscribeURL;
    frmFormName.submit();
  }
}

/**************************************************************************
    COMMAND NAME: 	validateFormEmpty
    PURPOSE: 		This function validates if all the fields of the form
            are empty.
    PARAMETERS:		frmSearchFormName - form object that needs to be validated
    OTHER CALLS:	None
    RETURN:			true - if all the fields in the form are empty
            flase - if at least one field in the form is empty
    AUTHOR:			Ashish Kapoor
***************************************************************************/
function validateFormEmpty(frmFormName)
{
    var count;		//count the number of fields in the form
    var elementsLen = frmFormName.elements.length;	//number of elements in the form
    var foundFilledField = false;		//true or false depending if fields all fields are empty

    //loop through the form elements list to check if any is non empty
  for(count = 0; count < elementsLen; count++)
        {
      if((frmFormName.elements[count].value != "") && (frmFormName.elements[count].type != "hidden"))
            {
        foundFilledField = true;
        break;
            }
        }

  //All form fields empty
    if (foundFilledField)
        {
      return false;
        }
  else	//at least one non empty field
    {
      return true;
    }
}
/***************************************************************************/
