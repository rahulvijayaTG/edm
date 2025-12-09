
//*******************************************
// The following code of getting boPortalTop 

  var boPortalTop = top;
  // locate SCM from top down
  if (!boPortalTop.bo_portal_top)
  {
    // locate SCM from bottom up
    boPortalTop = window;
    while (boPortalTop && 
           boPortalTop != top && 
           !boPortalTop.bo_portal_top)
    {
      boPortalTop = boPortalTop.parent;
    }
  }
  // if we did not find the bo_portal_top, maybe we are in another browser
  // check our owner
  if (!boPortalTop.bo_portal_top)
  {
    boPortalTop = top.opener;
    // locate SCM from bottom up
    while (boPortalTop && 
           boPortalTop != top && 
           !boPortalTop.bo_portal_top)
    {
      boPortalTop = boPortalTop.parent;
    }
  }
  
  if ( boPortalTop == null || !boPortalTop.bo_portal_top )
  {
	findboPortalTopFromTopDown( top );
  }
  
  if ( boPortalTop == null || !boPortalTop.bo_portal_top )
  {
  	alert("Could not find portal base!");
  }
 
  function findboPortalTopFromTopDown( currentFrame )
  {
  	  if ( currentFrame == null || currentFrame == "" ) 
	  {
	  	return;
	  }
  
	  if ( currentFrame != null && currentFrame.bo_portal_top )
	  {
		boPortalTop = currentFrame;
		return;
	  }
	  
	  for( var i = 0; currentFrame.frames != null && i < currentFrame.frames.length; ++i )
	  {
		findboPortalTopFromTopDown( currentFrame.frames[i] );
	  	
	  	if ( boPortalTop != null && boPortalTop.bo_portal_top )
	  	{
	  		return;
	  	}
	  }
	  
	  return;
  }

  
  
  
//**********************************************************
