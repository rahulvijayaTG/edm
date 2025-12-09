// compute variable scmtop which is the top of the SCM framework
// scmtop should be used in all references instead of top
var scmtop = top;
  // locate SCM from top down
  if (!scmtop.scm_top)
  {
    // locate SCM from bottom up
    scmtop = window;
    while (scmtop && 
           scmtop != top && 
           !scmtop.scm_top)
    {
      scmtop = scmtop.parent;
    }
  }
  // if we did not find the scm_top, maybe we are in another browser
  // check our owner
  if (!scmtop.scm_top)
  {
    scmtop = top.opener;
    // locate SCM from bottom up
    while (scmtop && 
           scmtop != top && 
           !scmtop.scm_top)
    {
      scmtop = scmtop.parent;
    }
  }

