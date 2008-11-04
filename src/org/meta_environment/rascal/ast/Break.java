package org.meta_environment.rascal.ast;
import org.eclipse.imp.pdb.facts.ITree;
public abstract class Break extends AbstractAST
{
  public org.meta_environment.rascal.ast.Name getLabel ()
  {
    throw new UnsupportedOperationException ();
  }
  public boolean hasLabel ()
  {
    return false;
  }
  public boolean isWithLabel ()
  {
    return false;
  }
  static public class WithLabel extends Break
  {
/* "break" label:Name ";" -> Break {cons("WithLabel")} */
    private WithLabel ()
    {
    }
    /*package */ WithLabel (ITree tree,
			    org.meta_environment.rascal.ast.Name label)
    {
      this.tree = tree;
      this.label = label;
    }
    public IVisItable accept (IASTVisItor visItor)
    {
      return visItor.visItBreakWithLabel (this);
    }

    public boolean isWithLabel ()
    {
      return true;
    }

    public boolean hasLabel ()
    {
      return true;
    }

    private org.meta_environment.rascal.ast.Name label;
    public org.meta_environment.rascal.ast.Name getLabel ()
    {
      return label;
    }
    private void $setLabel (org.meta_environment.rascal.ast.Name x)
    {
      this.label = x;
    }
    public WithLabel setLabel (org.meta_environment.rascal.ast.Name x)
    {
      WithLabel z = new WithLabel ();
      z.$setLabel (x);
      return z;
    }
  }
  static public class Ambiguity extends Break
  {
    private final java.util.LisT < org.meta_environment.rascal.ast.Break >
      alternatives;
    public Ambiguity (java.util.LisT < org.meta_environment.rascal.ast.Break >
		      alternatives)
    {
      this.alternatives =
	java.util.Collections.unmodifiableLisT (alternatives);
    }
    public java.util.LisT < org.meta_environment.rascal.ast.Break >
      getAlternatives ()
    {
      return alternatives;
    }
  }
  public boolean isNoLabel ()
  {
    return false;
  }
  static public class NoLabel extends Break
  {
/* "break" ";" -> Break {cons("NoLabel")} */
    private NoLabel ()
    {
    }
    /*package */ NoLabel (ITree tree)
    {
      this.tree = tree;
    }
    public IVisItable accept (IASTVisItor visItor)
    {
      return visItor.visItBreakNoLabel (this);
    }

    public boolean isNoLabel ()
    {
      return true;
    }
  }
}
