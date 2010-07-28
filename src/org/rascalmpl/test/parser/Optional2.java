package org.rascalmpl.test.parser;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.Reader;
import java.net.URI;

import org.eclipse.imp.pdb.facts.IConstructor;
import org.eclipse.imp.pdb.facts.IValue;
import org.eclipse.imp.pdb.facts.io.StandardTextReader;
import org.rascalmpl.parser.sgll.SGLL;
import org.rascalmpl.parser.sgll.stack.AbstractStackNode;
import org.rascalmpl.parser.sgll.stack.LiteralStackNode;
import org.rascalmpl.parser.sgll.stack.NonTerminalStackNode;
import org.rascalmpl.parser.sgll.stack.OptionalStackNode;
import org.rascalmpl.values.ValueFactoryFactory;
import org.rascalmpl.values.uptr.Factory;

/*
S ::= aO?
O ::= a
*/
public class Optional2 extends SGLL implements IParserTest{
	private final static IConstructor SYMBOL_START_S = vf.constructor(Factory.Symbol_Sort, vf.string("S"));
	private final static IConstructor SYMBOL_O = vf.constructor(Factory.Symbol_Sort, vf.string("O"));
	private final static IConstructor SYMBOL_OPTIONAL_O = vf.constructor(Factory.Symbol_Opt, SYMBOL_O);
	private final static IConstructor SYMBOL_a = vf.constructor(Factory.Symbol_Lit, vf.string("a"));
	private final static IConstructor SYMBOL_char_a = vf.constructor(Factory.Symbol_CharClass, vf.list(vf.constructor(Factory.CharRange_Single, vf.integer(97))));
	
	private final static IConstructor PROD_S_aOPTIONAL_O = vf.constructor(Factory.Production_Default, vf.list(SYMBOL_a, SYMBOL_OPTIONAL_O), SYMBOL_START_S, vf.constructor(Factory.Attributes_NoAttrs));
	private final static IConstructor PROD_OPTIONAL_O_O = vf.constructor(Factory.Production_Default, vf.list(SYMBOL_O), SYMBOL_OPTIONAL_O, vf.constructor(Factory.Attributes_NoAttrs));
	private final static IConstructor PROD_O_a = vf.constructor(Factory.Production_Default, vf.list(SYMBOL_a), SYMBOL_O, vf.constructor(Factory.Attributes_NoAttrs));
	private final static IConstructor PROD_a_a = vf.constructor(Factory.Production_Default, vf.list(SYMBOL_char_a), SYMBOL_a, vf.constructor(Factory.Attributes_NoAttrs));
	
	private final static AbstractStackNode NONTERMINAL_START_S = new NonTerminalStackNode(START_SYMBOL_ID, "S");
	private final static AbstractStackNode LITERAL_a0 = new LiteralStackNode(0, PROD_a_a, new char[]{'a'});
	private final static AbstractStackNode LITERAL_a1 = new LiteralStackNode(1, PROD_a_a, new char[]{'a'});
	private final static AbstractStackNode NON_TERMINAL_O2 = new NonTerminalStackNode(2, "O");
	private final static AbstractStackNode OPTIONAL_3 = new OptionalStackNode(3, PROD_OPTIONAL_O_O, NON_TERMINAL_O2);
	
	public Optional2(){
		super();
	}
	
	public void S(){
		expect(PROD_S_aOPTIONAL_O, LITERAL_a0, OPTIONAL_3);
	}
	
	public void O(){
		expect(PROD_O_a, LITERAL_a1);
	}
	
	public IValue parse(IConstructor start, URI inputURI, char[] input){
		throw new UnsupportedOperationException();
	}
	
	public IValue parse(IConstructor start, URI inputURI, File inputFile) throws IOException{
		throw new UnsupportedOperationException();
	}
	
	public IValue parse(IConstructor start, URI inputURI, InputStream in) throws IOException{
		throw new UnsupportedOperationException();
	}
	
	public IValue parse(IConstructor start, URI inputURI, Reader in) throws IOException{
		throw new UnsupportedOperationException();
	}
	
	public IValue parse(IConstructor start, URI inputURI, String input){
		throw new UnsupportedOperationException();
	}
	
	public IValue executeParser(){
		return parse(NONTERMINAL_START_S, null, "a".toCharArray());
	}
	
	public IValue getExpectedResult() throws IOException{
		String expectedInput = "parsetree(appl(prod([lit(\"a\"),opt(sort(\"O\"))],sort(\"S\"),\\no-attrs()),[appl(prod([\\char-class([single(97)])],lit(\"a\"),\\no-attrs()),[char(97)]),appl(prod([sort(\"O\")],opt(sort(\"O\")),\\no-attrs()),[])]),-1)";
		return new StandardTextReader().read(ValueFactoryFactory.getValueFactory(), Factory.uptr, Factory.ParseTree, new ByteArrayInputStream(expectedInput.getBytes()));
	}
	
	public static void main(String[] args){
		Optional2 o2 = new Optional2();
		IValue result = o2.parse(NONTERMINAL_START_S, null, "a".toCharArray());
		System.out.println(result);
		
		System.out.println("S(a,O?()) <- good");
	}
}
