package org.rascalmpl.library.experiments.Compiler.RVM.Interpreter.Instructions;

import org.rascalmpl.library.experiments.Compiler.RVM.Interpreter.CodeBlock;

public class LoadVar extends Instruction {

	final int pos;
	final String fuid;
	
	public LoadVar(CodeBlock ins, String fuid, int pos){
		super(ins, Opcode.LOADVAR);
		this.fuid = fuid;
		this.pos = pos;
	}
	
	public String toString() { 
		return "LOADVAR " + fuid + ", " + pos;
	}
	
	public void generate(){
		codeblock.addCode(opcode.getOpcode());
		codeblock.addCode((pos == -1) ? codeblock.getConstantIndex(codeblock.vf.string(fuid))
				                      :	codeblock.getFunctionIndex(fuid));
		codeblock.addCode(pos);
	}
}
