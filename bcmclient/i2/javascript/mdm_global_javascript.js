function mdm_confirm(msg)
{
  var rc = i2uiShowMessageBox(omxContextPath + "/core/alert/controller/display.cmd?MESSAGE="+msg+"&ALERT_TYPE=MDM_CONFIRM",180,350);
  return rc;
}


function goHome(url)
{
    document.location.href = omxContextPath + '/' + url;
}

function onlyPositiveInteger()
{
    onlyValidCharacters(/[0123456789]/);
}


function onlyInteger()
{
    onlyValidCharacters(/[0123456789.,-/\u0020/\u00A0]/);
    onlyValidFirstCharacters(/[-]/);


}

function onlyCurrency()
{
    onlyValidCharacters(/[0123456789.,-/\u0020\u00A0]/);
    onlyValidFirstCharacters(/[-]/);
}

function onlyValidCharacters(validCharacters)
{
    var bChanged = false;

    var oField = event.srcElement;
    var sField = oField.value;
    var nStringLen = sField.length;
    var sValidField = "";
    var oneDotFound = false;
    var oneCommaFound = false;

    for(var x = 0; x < nStringLen; x++)
    {
        var cChar = sField.charAt(x);

        if(cChar.search(validCharacters) != -1)
        {
          if(cChar == '.')
          {
            if(oneDotFound == true)
            {
                bChanged = true;
            }
            else
            {
                oneDotFound = true;
                sValidField += cChar;
            }
          }
          else
          {
          	if (cChar != '/')
          	{                    
	                sValidField += cChar;
                }
                else
                {
           		bChanged = true;     
                }                
          }
        }
        else
        {
           bChanged = true;
        }
    }

    if(bChanged)
    {
      oField.value = sValidField;
    }
}

function onlyValidFirstCharacters(validCharacters)
{

    var bChanged = false;

    var oField = event.srcElement;
    var sField = oField.value;
    var nStringLen = sField.length;
    var sValidField = "";

    for(var x = 0; x < nStringLen; x++)
    {
      var cChar = sField.charAt(x);

      if(x > 0 && cChar.search(validCharacters) != -1)
      {
           bChanged = true;
      }
      else
      {
            sValidField += cChar;
      }
    }

    if(bChanged)
    {
      oField.value = sValidField;
    }
}

function onlyPositiveNumber(validCharacters)
{
    var bChanged = false;
    var oField = event.srcElement;
    var sField = oField.value;
    var nStringLen = sField.length;
    var sValidField = "";
    var oneDotFound = false;
    var oneCommaFound = false;
    var bDotFound = false;
    
    
    for(var x = 0; x < nStringLen; x++)
    {
      var cChar = sField.charAt(x);
      
	  if(cChar.search(validCharacters) != -1)  {
		if(cChar == '.') {
					if(x == 0)
					{
						bChanged = true;
			  			sValidField += "";
			  		}
			  		else 
			  		{
			  			if(bDotFound != true)
			  			{
			  				bChanged = true;
			  				bDotFound = true;
			  				sValidField += cChar;
			  			}
			  			else
			  			{
			  				bChanged = true;
			  				sValidField += "";
			  			}
			  		}
				}
				
		  	   	else {
		    			if(cChar == ',') 
		    			{
		    				bChanged = true;
		    				sValidField += "";
					}
		    			else
		    			{
		    				sValidField += cChar;
		    			}
			    	}	
			    }	
		  else
		  {
		  	bChanged = true;
		  }
    }

    if(bChanged) 
    {
      oField.value = sValidField;
    }
}

// checks if all check box is selected
function ifAllChecked(form)
{
    var count;
    var numOfChecked = 0;
    var temp =  "document." + form + ".elements.length" ;
    var elementsLen = eval(temp);
    var foundChecked = false;
    var numOfCheckBoxes = 0;

    for(count = 0; count < elementsLen; count++)
        {
            var type = "document."+ form + ".elements[" + count + "].type";
            type = eval(type);
            var checked = "document."+ form + ".elements[" + count + "].checked";
            checked = eval(checked);
            //alert("type = " + type + " checked = " + checked);
            if(

                 type == "checkbox" &&
                 checked == true
               )
               {
                 numOfChecked++;

               }
            if(type == "checkbox" )
               {
                 numOfCheckBoxes++;

               }
        }
    if(numOfChecked == numOfCheckBoxes)
     foundChecked = true;
    //alert("numOfChecked" + numOfChecked)
    return foundChecked;
}

function onlyValidTime(validCharacters)
{
    var bChanged = false;
    var oField = event.srcElement;
    var sField = oField.value;
    var nStringLen = sField.length;
    var sValidField = "";
    var oneDotFound = false;
    var oneCommaFound = false;
    
       
    for(var x = 0; x < nStringLen; x++)
    {
      var cChar = sField.charAt(x);

	  if(cChar.search(validCharacters) != -1)  {
		if(cChar == ':') {
					bChanged = true;
					sValidField += cChar;
				}
				else
				{
					bChanged = true;
					sValidField += cChar;
				}
				
		  	   	
		
    }
    else
    {
    	bChanged = true;
    	sValidField += "";
    	
    }
   }

    if(bChanged) 
    {
      oField.value = sValidField;
    }
   
}
