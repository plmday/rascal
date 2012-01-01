@license{
  Copyright (c) 2009-2011 CWI
  All rights reserved. This program and the accompanying materials
  are made available under the terms of the Eclipse Public License v1.0
  which accompanies this distribution, and is available at
  http://www.eclipse.org/legal/epl-v10.html
}
@contributor{Jurgen J. Vinju - Jurgen.Vinju@cwi.nl - CWI}
@contributor{Atze van der Ploeg - Atze.van.der.Ploeg@cwi.nl (CWI)}
@contributor{Paul Klint - Paul.Klint@cwi.nl - CWI}


module util::Eval

@doc{
Synopsis: Evaluate a (list of) Rascal commands and return the value of the last command.

Description:
Evaluate a command or a list of commands and return the value of the last command that is executed.
An optional `duration` argument may be present to limit the time
(in milliseconds) the execution may take. By default, the duration is set to 1000 ms.

Examples:

<screen>
import util::Eval;
eval("2 * 3;");
eval(["X = 2 * 3;", "X + 5;"]);
</screen>

}
// --- eval with default duration (1000 ms)

// -- Give input string to the Rascal evaluator and return its value
@javaClass{org.rascalmpl.library.util.Eval}
@reflect
public java value eval(str command) throws Timeout;

// -- Give list of commands to the Rascal evaluator and return value of the last one.
@javaClass{org.rascalmpl.library.util.Eval}
@reflect
public java value eval(list[str] commands) throws Timeout;

// --- eval with given duration (in milliseconds)

// -- Give input string to the Rascal evaluator and return its value within duration ms.
@javaClass{org.rascalmpl.library.util.Eval}
@reflect
public java value eval(str command, int duration) throws Timeout;

// -- Give list of commands to the Rascal evaluator and return value of the last one within duration ms.
@javaClass{org.rascalmpl.library.util.Eval}
@reflect
public java value eval(list[str] commands, int duration) throws Timeout;

@doc{
Synopsis: Evaluate a (list of) Rascal commands and return the type of the last command.

Description:
Evaluate a command or a list of commands and return the type of the value of the last command that is executed.
An optional `duration` argument may be present to limit the time
(in milliseconds) the execution may take. By default, the duration is set to 1000 ms.

Examples:
<screen>
import util::Eval;
evalType("2 * 3");
evalType("[1, 2, 3];");
</screen>
}
// --- evalType with default duration (1000 ms)

// -- Give input string to the Rascal evaluator and return its type as string.
@javaClass{org.rascalmpl.library.util.Eval}
@reflect
public java str evalType(str command) throws Timeout;

// -- Give list of commands to the Rascal evaluator and return the type of the last one.
@javaClass{org.rascalmpl.library.util.Eval}
@reflect
public java str evalType(list[str] commands) throws Timeout;

// --- evalType with given duration (in milliseconds)

//-- Give input string to the Rascal evaluator and return its type as string within duration ms.
@javaClass{org.rascalmpl.library.util.Eval}
@reflect
public java str evalType(str command, int duration) throws Timeout;

// -- Give list of commands to the Rascal evaluator and return the type of the last one within duration ms.
@javaClass{org.rascalmpl.library.util.Eval}
@reflect
public java str evalType(list[str] commands, int duration) throws Timeout;

@doc{
Synopsis: Execute a string containing Rascal commands and return the output of the RascalShell.

Description:
Given a single string containing command, or a list of strings containing
successive lines with commands, the commands are fed into the RascalShell
and the output is returned as a list of strings.
An optional `duration` argument may be present to limit the time
(in milliseconds) the execution may take. By default, the duration is set to 1000 ms.

Examples:

<screen>
import util::Eval;
shell("2 * 3");
shell(["X = 2 * 3;", "X + 5;"]);
</screen>
}
// --- shell with default duration (1000 ms)

// -- Give input string to the RascalShell and return its output.
@javaClass{org.rascalmpl.library.util.Eval}
@reflect
public java list[str] shell(str commands);

// -- Give a list of input strings to the RascalShell and return its output.
@javaClass{org.rascalmpl.library.util.Eval}
@reflect
public java list[str] shell(list[str] commands);

// -- shell with given duration (in milliseconds)

// -- Give input string to the RascalShell and return its output within duration ms.
@javaClass{org.rascalmpl.library.util.Eval}
@reflect
public java list[str] shell(str commands, int duration);

// -- Give a list of input strings to the RascalShell and return its output within duration ms.
@javaClass{org.rascalmpl.library.util.Eval}
@reflect
public java list[str] shell(list[str] commands, int duration);

