package org.meta_environment.rascal.ast;
import org.eclipse.imp.pdb.facts.ITree;
public abstract class FunctionDeclaration extends AbstractAST
{
  public org.meta_environment.rascal.ast.Signature getSignature ()
  {
    throw new UnsupportedOperationException ();
  }
  public org.meta_environment.rascal.ast.Tags getTags ()
  {
    throw new UnsupportedOperationException ();
  }
  public org.meta_environment.rascal.ast.FunctionBody getBody ()
  {
    throw new UnsupportedOperationException ();
  }
  public boolean hasSignature ()
  {
    return false;
  }
  public boolean hasTags ()
  {
    return false;
  }
  public boolean hasBody ()
  {
    return false;
  }
  public boolean isDefault ()
  {
    return false;
  }
  static public class Default extends FunctionDeclaration
  {
/* signature:Signature tags:Tags body:FunctionBody -> FunctionDeclaration {cons("Default")} */
    private Default ()
    {
    }
    /*package */ Default (ITree tree,
			  org.meta_environment.rascal.ast.Signature signature,
			  org.meta_environment.rascal.ast.Tags tags,
			  org.meta_environment.rascal.ast.FunctionBody body)
    {
      this.tree = tree;
      this.signature = signature;
      this.tags = tags;
      this.body = body;
    }
    public IVisItable accept (IASTVisItor visItor)
    {
      return visItor.visItFunctionDeclarationDefault (this);
    }

    public boolean isDefault ()
    {
      return true;
    }

    public boolean hasSignature ()
    {
      return true;
    }
    public boolean hasTags ()
    {
      return true;
    }
    public boolean hasBody ()
    {
      return true;
    }

    private org.meta_environment.rascal.ast.Signature signature;
    public org.meta_environment.rascal.ast.Signature getSignature ()
    {
      return signature;
    }
    private void $setSignature (org.meta_environment.rascal.ast.Signature x)
    {
      this.signature = x;
    }
    public Default setSignature (org.meta_environment.rascal.ast.Signature x)
    {
      Default z = new Default ();
      z.$setSignature (x);
      return z;
    }
    private org.meta_environment.rascal.ast.Tags tags;
    public org.meta_environment.rascal.ast.Tags getTags ()
    {
      return tags;
    }
    private void $setTags (org.meta_environment.rascal.ast.Tags x)
    {
      this.tags = x;
    }
    public Default setTags (org.meta_environment.rascal.ast.Tags x)
    {
      Default z = new Default ();
      z.$setTags (x);
      return z;
    }
    private org.meta_environment.rascal.ast.FunctionBody body;
    public org.meta_environment.rascal.ast.FunctionBody getBody ()
    {
      return body;
    }
    private void $setBody (org.meta_environment.rascal.ast.FunctionBody x)
    {
      this.body = x;
    }
    public Default setBody (org.meta_environment.rascal.ast.FunctionBody x)
    {
      Default z = new Default ();
      z.$setBody (x);
      return z;
    }
  }
  static public class Ambiguity extends FunctionDeclaration
  {
    private final java.util.LisT <
      org.meta_environment.rascal.ast.FunctionDeclaration > alternatives;
    public Ambiguity (java.util.LisT <
		      org.meta_environment.rascal.ast.FunctionDeclaration >
		      alternatives)
    {
      this.alternatives =
	java.util.Collections.unmodifiableLisT (alternatives);
    }
    public java.util.LisT <
      org.meta_environment.rascal.ast.FunctionDeclaration > getAlternatives ()
    {
      return alternatives;
    }
  }
  public boolean isAbstract ()
  {
    return false;
  }
  static public class Abstract extends FunctionDeclaration
  {
/* signature:Signature tags:Tags -> FunctionDeclaration {cons("Abstract")} */
    private Abstract ()
    {
    }
    /*package */ Abstract (ITree tree,
			   org.meta_environment.rascal.ast.
			   Signature signature,
			   org.meta_environment.rascal.ast.Tags tags)
    {
      this.tree = tree;
      this.signature = signature;
      this.tags = tags;
    }
    public IVisItable accept (IASTVisItor visItor)
    {
      return visItor.visItFunctionDeclarationAbstract (this);
    }

    public boolean isAbstract ()
    {
      return true;
    }

    public boolean hasSignature ()
    {
      return true;
    }
    public boolean hasTags ()
    {
      return true;
    }

    private org.meta_environment.rascal.ast.Signature signature;
    public org.meta_environment.rascal.ast.Signature getSignature ()
    {
      return signature;
    }
    private void $setSignature (org.meta_environment.rascal.ast.Signature x)
    {
      this.signature = x;
    }
    public Abstract setSignature (org.meta_environment.rascal.ast.Signature x)
    {
      Abstract z = new Abstract ();
      z.$setSignature (x);
      return z;
    }
    private org.meta_environment.rascal.ast.Tags tags;
    public org.meta_environment.rascal.ast.Tags getTags ()
    {
      return tags;
    }
    private void $setTags (org.meta_environment.rascal.ast.Tags x)
    {
      this.tags = x;
    }
    public Abstract setTags (org.meta_environment.rascal.ast.Tags x)
    {
      Abstract z = new Abstract ();
      z.$setTags (x);
      return z;
    }
  }
}
