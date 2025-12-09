/**************************************************************************
		COMMAND NAME: 	updateGeneralUserPref
		PURPOSE: 		This function updates the values of general user
						preferences.
		PARAMETERS:		frmFormName - form object that stores the data to be
						saved
		OTHER CALLS:	validateFormEmpty
		RETURN:			None
		AUTHOR:			Ashish Kapoor
***************************************************************************/
function updateGeneralUserPref(frmFormName)
{
	var strUpdateURL="";			//variable to store URL of update page
	var bFormEmpty = false;			//variable to store value if the search form is empty
	var msg = "";					//variable to store the display message
	var intDefaultCount = frmFormName.CURRENT_USER_DEFAULT_COUNT.value;
	//Addition by ASHISH KAPOOR to fix Issue# 404611 - START
	var strSelectedOP = "";			//stores the value of selected Order Point
	var strSelectedOC = "";			//stores the value of selected Org Carrier
	var strSelectedCC = "";			//stores the values of selected Cost Center
	//Addition by ASHISH KAPOOR to fix Issue# 404611 - END
	
	//call the function to check if the form is empty
	bFormEmpty = validateFormEmpty(frmFormName);

	//validate the response of above function call and take appropriate action
	if(bFormEmpty)	//form empty
	{
		//display message
		msg += "Please select preferences from the dropdown.";
		omx_alert(msg);
	}
	else
	{
			//Addition by ASHISH KAPOOR to fix Issue# 404611 - START
			//get the selected values
			strSelectedOP = frmFormName.ORDER_POINT.value;
			strSelectedOC = frmFormName.CARRIER.value;
			strSelectedCC = frmFormName.COST_CENTER.value;
			
			//validate if all the required values are provided
			if(strSelectedOP.length == 0)
			{
				//display message
				msg += "Please select an Order Point.";
				omx_alert(msg);
			}
			else if(strSelectedOC.length == 0)
			{
				//display message
				msg += "Please select a Carrier.";
				omx_alert(msg);
			}
			else if(strSelectedCC.length == 0)
			{
				//display message
				msg += "Please select a Cost Center.";
				omx_alert(msg);
			}
			else
			//Addition by ASHISH KAPOOR to fix Issue# 404611 - END
			{
				if(intDefaultCount > 0)
				{
					//submit the form
					strUpdateURL="user_admin_users_pref/updateGeneralUserPreferences.cmd";
					frmFormName.action=strUpdateURL;
					frmFormName.submit();
				}
				else
				{
					//submit the form
					strUpdateURL="user_admin_users_pref/addGeneralUserPreferences.cmd";
					frmFormName.action=strUpdateURL;
					frmFormName.submit();
				}
			}
	}
}

/**************************************************************************
		COMMAND NAME: 	subscribeToNotifications
		PURPOSE: 		This function saves the data related to the 
						notification to which user subscribes.
		PARAMETERS:		frmFormName - form object that stores the data to be
						saved
		OTHER CALLS:	validateFormEmpty
		RETURN:			None
		AUTHOR:			Ashish Kapoor
***************************************************************************/
function subscribeToNotifications(frmFormName)
{
	var strSubscribeURL="";			//variable to store URL of update page
	var msg = "";					//variable to store the display message
	// Addition by ASHISH KAPOOR to Fix Issue# 406036 - START
	var strNotificationValue = "";
	var strProtocolValue = "";
	var bNotificationSelected = false;
	var bProtocolSelected = false;
	var iCount = 0;
	// Addition by ASHISH KAPOOR to Fix Issue# 406036 - END
	
	//Addition by ASHISH KAPOOR to Fix Issue# 406036 - START
	/* Loop through the SELECTED_AVAILABLE_NOTIFICATION list to
	   check if any notification has been seleted */
	for(count=0; count < frmFormName.SELECTED_AVAILABLE_NOTIFICATION.length; count++)
	{
		strNotificationValue = frmFormName.SELECTED_AVAILABLE_NOTIFICATION[count].value;
		if((strNotificationValue.length > 0) && (frmFormName.SELECTED_AVAILABLE_NOTIFICATION[count].selected == true))
		{
			bNotificationSelected = true;
			break;
		}
	}
		
	/* Loop through the  list to COMMUNICATION_PROTOCOLS
	   check if any protocol has been seleted */
	for(count=0; count < frmFormName.COMM_PROTOCOL.length; count++)
	{
		strProtocolValue = frmFormName.COMM_PROTOCOL[count].value;
		if((strProtocolValue.length > 0) && (frmFormName.COMM_PROTOCOL[count].checked == true))
		{
			bProtocolSelected = true;
			break;
		}
	}
	
	/* Validate if any Notification and Protocols were selected 
	   and perform appropriate action */	
	if(!bNotificationSelected)
	{
		//display message
		msg += "Please select Notifications to subscribe.";
		omx_alert(msg);
	}
	else if(!bProtocolSelected)
	{
		//display message
		msg += "Please select Protocols.";
		omx_alert(msg);
	}
	else
	// Addition by ASHISH KAPOOR to Fix Issue# 406036 - END
	{
		//submit the form
		strSubscribeURL="user_admin_users_pref/subscribeToNotifications.cmd";
		frmFormName.action=strSubscribeURL;
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
function unsubscribeToNotifications(frmFormName)
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
		msg += "Please select the Notifications to unsubscribe.";
		omx_alert(msg);
	}
	else
	{
		//submit the form
		strUnsubscribeURL="user_admin_users_pref/unsubscribeToNotifications.cmd";
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
