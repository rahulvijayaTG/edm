//*******************************************************************
// This Javascript file should be included in the frame where ever the
// BO portal js functions are called.
//
// Public methods:
//
//  init() 			- initialize BO environment
//  loginAndInit() 	- login and initialize bo environment
//  login() 		- login bo
//  logout() 		- logout bo
//  isLoginOk()     - check if login ok
//  
//  setGetCorpDocs()- set the flag to retrieve corporate doc list
//  setGetPersDocs()- set the flag to retrieve corporate personal list
//  setGetInboxDocs()- set the flag to retrieve corporate inbox list
//  setCallbackFrame() - set the callback frame object
//
//  displayDocument() - display a webi document
//  getDocumentUrl() - retrieve the webi document url by doc type and name
//  getDocList()    - get the doc list by type and filter
//
//  createDoc() - create a webi document
//
//*******************************************************************

var defAppUrl = ""; //This is the URL pointing to CAS application
var defTargetFrame; //This is the default target frame to run any BO request
var callBackFrame = window; //This is the frame that contains the callback js functions
var responseUrl = ""; //This is the URL to be forwarded to after request is done
var callback = "";  //This is the javascript function name that will be called after request is done

var loginOk = true; //This flag is used to indicate if login failed

// Retrieving corporate docs
// Note: the docUrlList has the following structure:
//       [0] - document name
//       [1] - document URL
//       [2] - category the doc belongs to
var getCorpDocs = true;           // default to true for corporate docs
var corpDocURLList = new Array(); // This is a list of corporate document URLs
var corpDocCat = "";              // This is the category filter for copr doc list
								  // "" means no filter defined

// Retrieving personal docs
var getPersDocs = false;
var persDocURLList = new Array(); // This is a list of personal document URLs
var persDocCat = "";              // This is the category filter for personal doc list

// Retrieving inbox docs
var getInboxDocs = false;
var inboxDocURLList = new Array(); // This is a list of inbox document URLs

function bo_portal_top()
{
	//This method is used to identify the bo portal top
	aler("You found the BO portal base");
}

//*******************************************************************
//This function can be called to initialize BO environment
//
//Scope: Public method
//
//Parms:
// appUrl(required): URL to the CAS application
// targetFrame(optional): the default target frame to run the BO request
// respUrl(optional): the URL that will be forwarded(JSP forward) 
//       into the target frame after the current request is finished.
// callbackFun(optional): the callback function name
//
// Note: when both responseUrl and callbackFunc are provided, responseUrl
//       will take into effect where callbackFunc will be ignored. This
//       is true for all other APIs which have both parameters.
//*******************************************************************
function init(appUrl, targetFrame, respUrl, callbackFunc)
{
	defAppUrl = appUrl;
	setAppName(); // has to be set before buildReq() is called
	defTargetFrame = targetFrame;
	responseUrl = respUrl;
	callback = callbackFunc;

	corpDocURLList = null;
	corpDocURLList = new Array();
	persDocURLList = null;
	persDocURLList = new Array();
	inboxDocURLList = null;
	inboxDocURLList = new Array();

	var url = getAppUrl() + "/portal/jsp/BoLoginInit.jsp?request=init";
	url = buildReq(url);
	getFrame(targetFrame).localtion.replace(url);
	getFrame(targetFrame).status = "";
}

//private function
function buildReq(url)
{
	url += "&getCorpDocs="+getCorpDocs;
	if (corpDocCat != "")
		url += "&corpDocCat="+corpDocCat;

	url += "&getPersDocs="+getPersDocs;
	if (persDocCat != "")
		url += "&persDocCat="+persDocCat;

	url += "&getInboxDocs="+getInboxDocs;
	
	if (callback != null && callback != "")
		url += "&callback="+callback;

	if (responseUrl != null && responseUrl != "")
		url += "&responseUrl="+responseUrl;

	if (appName != null && appName != "")
		url += "&appName="+appName;
	
	return url;
}

//*******************************************************************
//This function can be called to refresh the document list based
//on the current selection and filter.
//
//Scope: Public method
//
//Parms:
// targetFrame(optional): the target frame to run the request
// respUrl(optional): the URL that will be forwarded(JSP forward) 
//       into the target frame after the current request is finished.
// callbackFunc(optional): the callback function name
//*******************************************************************
function refreshList(targetFrame, respUrl, callbackFunc)
{
	init(getAppUrl(), targetFrame, respUrl, callbackFunc)
}


//*******************************************************************
//This function can be called to login and initialize BO environment
//
//Scope: Public method
//
//Parms:
// uid(required): user id
// pwd(required): password
// appUrl(required): URL to the CAS application
// targetFrame(optional): the default target frame to run the BO request
// respUrl(optional): the URL that will be forwarded(JSP forward) 
//       into the target frame after the current request is finished.
// callbackFun(optional): the callback function name
//*******************************************************************
function loginAndInit(uid, pwd, appUrl, targetFrame, respUrl, callbackFunc)
{
	defAppUrl = appUrl;
	setAppName(); // has to be set before buildReq() is called	
	defTargetFrame = targetFrame;
	responseUrl = respUrl;
	callback = callbackFunc;

	corpDocURLList = null;
	corpDocURLList = new Array();
	persDocURLList = null;
	persDocURLList = new Array();
	inboxDocURLList = null;
	inboxDocURLList = new Array();
	
	var url = getAppUrl() + "/portal/jsp/BoLoginInit.jsp?request=both"
			+"&uid="+uid
			+"&pwd="+pwd;
	url = buildReq(url);
	getFrame(targetFrame).location.replace(url);	
	getFrame(targetFrame).status = "Loading...";

}

//*******************************************************************
//This function can be called to do Login of BO user
//
//Scope: Public method
//
//Parms:
// uid(required): userid 
// pwd(required): password
// targetFrame(optional): the target frame to run the request
// respUrl(optional): the URL that will be forwarded(JSP forward) 
//       into the target frame after the current request is finished.
// callbackFunc(optional): the callback function name
//*******************************************************************
function login(uid, pwd, targetFrame, respUrl, callbackFunc)
{
	var url = getAppUrl() + "/portal/jsp/BoLoginInit.jsp?request=login&uid="+uid+"&pwd="+pwd;
	setAppName(); // has to be set before buildReq() is called
	responseUrl = respUrl;
	callback = callbackFunc;
	url = buildReq(url);
	getFrame(targetFrame).location.replace(url);	
}

//*******************************************************************
//This function can be called to check if login is ok after the login
//is done. This function should be called by the callback function of
//Login(), loginAndInit() APIs.
//
//Scope: Public method
//
//Parms: None
//*******************************************************************
function isLoginOk()
{
	return loginOk;
}


//*******************************************************************
//This function can be called to do Logout of BO user
//
//Scope: Public method
//
//Parms:
// targetFrame(optional): the target frame to run the request
// respUrl(optional): the URL that will be forwarded(JSP forward) 
//       into the target frame after the current request is finished.
// callbackFunc(optional): the callback function name
//*******************************************************************
function logout(targetFrame, respUrl, callbackFunc)
{
	if (isLoginOk())
	{
	var url = getAppUrl() + "/portal/jsp/BoLogout.jsp?request=logout";
	responseUrl = respUrl;
	callback = callbackFunc;
	url = buildReq(url);
	getFrame(targetFrame).location.replace(url);
	}
}


//*******************************************************************
//This function can be called to enable retrieving of corp document list
//
//Scope: Public method
//
//Parms:
// getDoc(required): true | false
// category(optional): category name used as filter to be applied on the doc list
//*******************************************************************
function setGetCorpDocs(getDoc, category)
{
	if (getDoc || getDoc == "true")
		getCorpDocs = true;
	else
		getCorpDocs = false;
			
	if (category == null) category = "";
	
	corpDocCat = category;
}

//*******************************************************************
//This function can be called to enable retrieving of personal document list
//
//Scope: Public method
//
//Parms:
// getDoc(required): true | false
// category(optional): category filter to be applied on the doc list
//*******************************************************************
function setGetPersDocs(getDoc, category)
{
	if (getDoc || getDoc == "true")
		getPersDocs = true;
	else
		getPersDocs = false;

	if (category == null) category = "";			
	persDocCat = category;
}

//*******************************************************************
//This function can be called to enable retrieving of inbox document list
//
//Scope: Public method
//
//Parms:
// getDoc(required): true | false
//*******************************************************************
function setGetInboxDocs(getDoc)
{
	getInboxDocs = getDoc;
}

//*******************************************************************
//This function can be called to set the callback frame. Call back frame contains
//the js function that can be called when a request is finished.
//
//Scope: Public method
//
//Parms:
// frame(required): frame object
//*******************************************************************
function setCallbackFrame(frame)
{
	if (frame && frame.location)
	{
		callbackFrame = frame;
	}
	else
		alert("Callback frame is not valid. Please choose a valid frame object.");
}



//*******************************************************************
//This function can be called to display a document. The document name
//has already been retrieved by loginAndInit() or init() function call,
//and user has already logged in (with either login() or loginAndInit()
//call). 
//
//Scope: Public method
//
//Parms:
// docName(required): document name
// docType(required): document type (C-corporate,P-personal, I-inbox)
// targetFrame(optional): the frame to be used to display the document
// callbackFunc(optional): the callback function name
//*******************************************************************
function displayDocument(docName, docType, targetFrame, callbackFunc)
{
	//var docUrl = getAppUrl() + getDocumentUrl(docType, docName);
	//var url = getAppUrl() + "/portal/jsp/BoContainer.jsp?docUrl="+escape(docUrl);
	if (isLoginOk())
	{
	var url = getDocumentUrl(docName, docType);
	if (callbackFunc != null && callbackFunc != "")
		url += "&callback="+callbackFunc;
	getFrame(targetFrame).location.replace(url);
	}
}

//*******************************************************************
//This function can be called to retrieve bo docuemnt URL. This URL can
//later be used to retrive and display the document.
//
//Scope: Public method
//
//Parms:
// docType(required): document type("C"-corporate, "P"-personal, "I"-inbox)
// docName(required): document name
//*******************************************************************
function getDocumentUrl(docName, docType)
{
	if (isLoginOk())
	{

	var url = "#";
	var docArray = new Array();
	if (docType == "C")
	{
		docArray = corpDocURLList;
	}
	else if (docType == "P")
	{
		docArray = persDocURLList;
	}
	else if (docType == "I")
	{
		docArray = inboxDocURLList;
	}
	else
	{
		// will be the empty array as initialized
	}

	for (i=0; i<docArray.length; i++)
	{
		if (docArray[i][0] == docName)
		{
			url = docArray[i][1];
			break;
		}
	}


	var docUrl = getAppUrl() + url;
	var myUrl = getAppUrl() + "/portal/jsp/BoContainer.jsp?docUrl="+escape(docUrl);

	return myUrl;
	}

}

//*******************************************************************
//This function can be called to retrieve the document list
//
//Scope: Public method
//
//Parms:
// docType(required): document type("C"-corporate, "P"-personal, "I"-inbox)
// category(optional): category the documents are in
//
//return:
// mArray: array of document names under a docType and category
//*******************************************************************
function getDocList(docType, category)
{
	if (isLoginOk())
	{

	var mArray = new Array();
	var origArray = corpDocURLList; // by default, use corporate
	
	if (docType == "C")
		origArray = corpDocURLList;
	else
	if (docType == "P")
		origArray = persDocURLList;	
	else
	if (docType == "I")
		origArray = inboxDocURLList;
	
	var j = 0;
	for (i=0; i<origArray.length; i++)
	{
		if (category != null && category != "" && docType != "I")
		{
			if (origArray[i][2] == category)
			{
				mArray[j++] = origArray[i][0];
			}
		}
		else
		{
			mArray[j++] = origArray[i][0];
		}
	}
	return mArray;
	}
}

//*******************************************************************
//This function can be called to create a webi document
//
//Scope: Public method
//
//Parms: 
// targetFrame(optional): the target frame to run the request
//*******************************************************************
function createDoc(targetFrame)
{
	var cDocUrl = getAppUrl() + "/bo/jsp/newDocUnvListFrameTop.jsp";
	var url = getAppUrl() + "/portal/jsp/BoContainer.jsp?docUrl="+escape(cDocUrl);
	var tFrame = getFrame(targetFrame);
	tFrame.location.replace(url);
}

//*******************************************************************
//This function can be called to get the target frame object
//
//Scope: Private method (should NOT be called by any outsider
//
//Parms:
// targetFrame(optional): the target frame to run the request
//*******************************************************************
function getFrame(targetFrame)
{
	if (targetFrame && targetFrame.location)
		return targetFrame;
	else
	{
		if (defTargetFrame && defTargetFrame.location)
			return defTargetFrame;
		else
		{
			var win = new window("", "Please wait...", "width=350,height=150,screenX=" + (screen.availWidth - 350)/2 + ",screenY=" + (screen.availHeight - 150)/2 + ",top=" + (screen.availWidth - 350)/2 + ",left=" + (screen.availHeight - 150)/2 + ",resizable,scrollbars" );
			return win;
		}		
	}		

}

//*******************************************************************
//This function can be called to get the application URL
//
//Scope: Private method (should NOT be called by any outsider
//
//Parms:
// appUrl(optional): the target frame to run the request
//*******************************************************************
function getAppUrl(myAppUrl)
{
	if (myAppUrl)
		return myAppUrl;
	else
	{
		if (defAppUrl != "")
			return defAppUrl;
		else
			return "http://localhost:80/cas";	
	}

}

//*******************************************************************
//This function can be called to get the application URL
//
//Scope: Private method (should NOT be called by any outsider
//
//Parms:
// appUrl(optional): the target frame to run the request
//*******************************************************************
var appName = "cas";
function setAppName()
{
	var url = getAppUrl();
	appName = url.substr(url.lastIndexOf("/"),4);
}

function testCallback()
{
	alert("callback called");
}
