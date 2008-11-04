package org.meta_environment.rascal.ast;
import org.eclipse.imp.pdb.facts.ITree;
public abstract class Rule extends AbstractAST
{
  public org.meta_environment.rascal.ast.Type getType ()
  {
    throw new UnsupportedOperationException ();
  }
  public org.meta_environment.rascal.ast.Match getMatch ()
  {
    throw new UnsupportedOperationException ();
  }
  public boolean hasType ()
  {
    return false;
  }
  public boolean hasMatch ()
  {
    return false;
  }
  public boolean isWithGuard ()
  {
    return false;
  }
  static public class WithGuard extends Rule
  {
/* "[" type:Type "]" match:Match -> Rule {cons("WithGuard")} */
    private WithGuard ()
    {
    }
    /*package */ WithGuard (ITree tree,
			    org.meta_environment.rascal.ast.Type type,
			    org.meta_environment.rascal.ast.Match match)
    {
      this.tree = tree;
      this.type = type;
      this.match = match;
    }
    public IVisItable accept (IASTVisItor visItor)
    {
      return visItor.visItRuleWithGuard (this);
    }

    public boolean isWithGuard ()
    {
      return true;
    }

    public boolean hasType ()
    {
      return true;
    }
    public boolean hasMatch ()
    {
      return true;
    }

    private org.meta_environment.rascal.ast.Type type;
    public org.meta_environment.rascal.ast.Type getType ()
    {
      return type;
    }
    private void $setType (org.meta_environment.rascal.ast.Type x)
    {
      this.type = x;
    }
    public WithGuard setType (org.meta_environment.rascal.ast.Type x)
    {
      WithGuard z = new WithGuard ();
      z.$setType (x);
      return z;
    }
    private org.meta_environment.rascal.ast.Match match;
    public org.meta_environment.rascal.ast.Match getMatch ()
    {
      return match;
    }
    private void $setMatch (org.meta_environment.rascal.ast.Match x)
    {
      this.match = x;
    }
    public WithGuard setMatch (org.meta_environment.rascal.ast.Match x)
    {
      WithGuard z = new WithGuard ();
      z.$setMatch (x);
      return z;
    }
  }
  static public class Ambiguity extends Rule
  {
    private final java.util.LisT < org.meta_environment.rascal.ast.Rule >
      alternatives;
    public Ambiguity (java.util.LisT < org.meta_environment.rascal.ast.Rule >
		      alternatives)
    {
      this.alternatives =
	java.util.Collections.unmodifiableLisT (alternatives);
    }
    public java.util.LisT < org.meta_environment.rascal.ast.Rule >
      getAlternatives ()
    {
      return alternatives;
    }
  }
  public boolean isNoGuard ()
  {
    return false;
  }
  static public class NoGuard extends Rule
  {
/* match:Match -> Rule {cons("NoGuard")} */
    private NoGuard ()
    {
    }
    /*package */ NoGuard (ITree tree,
			  org.meta_environment.rascal.ast.Match match)
    {
      this.tree = tree;
      this.match = match;
    }
    public IVisItable accept (IASTVisItor visItor)
    {
      return visItor.visItRuleNoGuard (this);
    }

    public boolean isNoGuard ()
    {
      return true;
    }

    public boolean hasMatch ()
    {
      return true;
    }

    private org.meta_environment.rascal.ast.Match match;
    public org.meta_environment.rascal.ast.Match getMatch ()
    {
      return match;
    }
    private void $setMatch (org.meta_environment.rascal.ast.Match x)
    {
      this.match = x;
    }
    public NoGuard setMatch (org.meta_environment.rascal.ast.Match x)
    {
      NoGuard z = new NoGuard ();
      z.$setMatch (x);
      return z;
    }
  }
}
