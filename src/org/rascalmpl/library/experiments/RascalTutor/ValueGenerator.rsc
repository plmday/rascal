module experiments::RascalTutor::ValueGenerator

import Boolean;
import Integer;
import String;
import Real;
import List;
import Set;
import Map;
import Relation;
import IO;
import DateTime;
import experiments::RascalTutor::CourseModel;
     
// ---- Parsing types

private int maxInt = 20;
private int minInt = -20;
private int maxReal = maxInt;
private int minReal = -maxReal;

private list[RascalType] baseTypes = [\bool(), \int(minInt,maxInt), \real(minReal,maxReal), \num(minInt,maxInt), \str(), \loc(), \dateTime()];
private list[RascalType] reducedBaseTypes = [\bool(), \int(minInt,maxInt), \real(minReal,maxReal), \str()];


public RascalType parseType(str txt){
   println("parseType: <txt>");
   switch(txt){
     case /^bool$/:		return \bool();
     case /^int$/: 		return \int(minInt, maxInt);
     case /^int\[<f:-?[0-9]+>\]/:
     					return \int(toInt(f), maxInt);
     case /^int\[<f:-?[0-9]+>,<t:-?[0-9]+>\]/:
     					return \int(toInt(f), toInt(t));
     					
     case /^real$/: 	return \real(minReal, maxReal);
     case /^real\[<f:-?[0-9]+>\]/:
     					return \real(toInt(f), maxReal);
     case /^real\[<f:-?[0-9]+>,<t:-?[0-9]+>\]/:
     					return \real(toInt(f), toInt(t));
     
     case /^num$/: 		return \num(minInt, maxInt);
     
     case /^num\[<f:-?[0-9]+>\]/:
     					return \num(toInt(f), maxInt);
     case /^num\[<f:-?[0-9]+>,<t:-?[0-9]+>\]/:
     					return \num(toInt(f), toInt(t));
     case /^str$/: 		return \str();
     case /^loc$/: 		return \loc();
     case /^dateTime$/: return \dateTime();
     case /^list\[<et:.+>\]/:
     					return \list(parseType(et));
     case /^set\[<et:.+>\]$/:
     					return \set(parseType(et));
     					
     case /^map\[<ets:.+>\]$/: {
     						types = parseTypeList(ets);
     						if(size(types) != 2)
     							throw "map type should have to arguments: <txt>";
     					    return \map(types[0], types[1]);
     					}
     					
     case /^tuple\[<ets:.+>\]$/:
     					return \tuple(parseTypeList(ets));
     					
     case /^rel\[<ets:.+>\]$/:
     					return \set(\tuple(parseTypeList(ets)));
     case /^value$/: 	return \value();
     case /^void$/:		return \void();
     					
     case /^arb\[<depth:[0-9]>\]$/:{
     						return \arb(toInt(depth), baseTypes);
     					}					
     case /^arb\[<depth:[0-9]>,<tps:.+>\]$/:{
     						types = parseTypeList(tps);
     						return \arb(toInt(depth), types);
     					}
     					
     case /^arb\[<tps:.+>\]$/:{
     						types = parseTypeList(tps);
     						return \arb(0, types);
     					}
     					
     case /^arb$/:		return \arb(0, baseTypes);
     
     case /^same\[<name:[A-Za-z0-9]+>\]$/:
     					return \same(name);
   }
   throw "Parse error in type: <txt>";
}

public list[RascalType] parseTypeList(str txt){
  str prefix = "";
  return
    for(/<et:[^,]+>($|,)/ := txt){
      try {
         if(prefix != "")
         	prefix += ",";
         pt = parseType(prefix + et);
         append pt;
         prefix = "";
      } catch: {
        prefix += et;
      }
    }
}

test parseType("bool") == \bool();
test parseType("int") == \int(minInt,maxInt);
test parseType("real") == \real(minReal,maxReal);
test parseType("num") == \num(minInt,maxInt);
test parseType("str") == \str();
test parseType("loc") == \loc();
test parseType("dateTime") == \dateTime();
test parseType("list[int]") == \list(\int(minInt,maxInt));
test parseType("list[list[int]]") == \list(\list(\int(minInt,maxInt)));
test parseType("set[int]") == \set(\int(minInt,maxInt));
test parseType("set[list[int]]") == \set(\list(\int(minInt,maxInt)));
test parseType("map[str,int]") == \map(\str(),\int(minInt,maxInt));

test parseType("tuple[int,str]") == \tuple([\int(minInt,maxInt), \str()]);
test parseType("tuple[int,tuple[real,str]]") == \tuple([\int(minInt,maxInt), \tuple([\real(minReal,maxReal),\str()])]);
test parseType("rel[int,str]") == \set(\tuple([\int(minInt,maxInt), \str()]));
test parseType("rel[int,tuple[real,str]]") == \set(\tuple([\int(minInt,maxInt), \tuple([\real(minReal,maxReal),\str()])]));
test parseType("arb[0]") == \arb(0, [\bool(),\int(minInt,maxInt),\real(minReal,maxReal),\num(minInt,maxInt),\str(),\loc(),\dateTime()]);
test parseType("set[arb]") == \set(\arb(0,[\bool(),\int(minInt,maxInt),\real(minReal,maxReal),\num(minInt,maxInt),\str(),\loc(),\dateTime()]));

test parseType("value") == \value();
test parseType("set[value]") == \set(\value());
test parseType("void") == \void();


// --- printing types

public str toString(RascalType t){
     switch(t){
       case \bool(): 		return "bool";
       case \int(int f, int t): 	
       						return "int";
       case \real(int f, int t):		
       						return "real";
       case \num(int f, int t): 	
       						return "num";
       case \str(): 		return "str";
       case \loc():			return "loc";
       case \dateTime():	return "datetime";
       case \list(et): 		return "list[<toString(et)>]";
       case \set(et):		return "set[<toString(et)>]";
       case \map(kt, vt):	return "map[<toString(kt)>,<toString(vt)>]";
       case \tuple(list[RascalType] ets):	
       						return "tuple[<for(i<-index(ets)){><(i>0)?",":""><toString(ets[i])><}>]";
       case \rel(list[RascalType] ets):	
       						return "rel[<for(i<-index(ets)){><(i>0)?",":""><toString(ets[i])><}>]";
       case \value():		return "value";
       case \void():		return "void";
     }
     throw "Unknown type: <t>";
}

// ---- Generating types

public RascalType generateType(str t){
  return generateType(parseType(t), ());
}

public RascalType generateType(str t, VarEnv env){
  return generateType(parseType(t), env);
}

public RascalType generateType(RascalType t){
  return generateType(t, ());
}

public RascalType generateType(RascalType t, VarEnv env){
     println("generateType(<t>, <env>)");
     switch(t){
       case \list(et): 		return \list(generateType(et, env));
       case \set(et):		return \set(generateType(et, env));
       case \map(kt, vt):  	return \map(generateType(kt, env), generateType(vt, env));
       case \tuple(list[RascalType] ets):	
       						return generateTupleType(ets, env);
       case \rel(list[RascalType] ets):	
       						return generateRelType(ets, env);
       case \arb(int d, list[RascalType] tps):
       						return generateArbType(d, tps, env);
       case \same(str name):return env[name].rtype;
       default:				return t;
     }
     throw "Unknown type: <t>";
}

// ---- Variables used in a RascalType

public set[str] uses(RascalType t){
     println("uses(<t>)");
     set[str] u = {};
     visit(t){
       case \same(str name): u += name;
     }
    return u;
}

public RascalType generateTupleType(list[RascalType] ets, VarEnv env){
   return \tuple([generateType(et, env) | et <- ets ]);
}

public RascalType generateRelType(list[RascalType] ets, VarEnv env){
   return \rel([generateType(et, env) | et <- ets ]);
}

test generateType(\bool(), ()) == \bool();
test generateType(\int(minInt,maxInt), ()) == \int(minInt,maxInt);
test generateType(\real(minReal,maxReal), ()) == \real(minReal,maxReal);
test generateType(\num(minInt,maxInt), ()) == \num(minInt,maxInt);
test generateType(\loc(), ()) == \loc();
test generateType(\dateTime(), ()) == \dateTime();
test generateType(\list(\int(minInt,maxInt)), ()) == \list(\int(minInt,maxInt));
test generateType(\set(\int(minInt,maxInt)), ()) == \set(\int(minInt,maxInt));
test generateType(\map(\str(), \int(minInt,maxInt)), ()) == \map(\str(), \int(minInt,maxInt));
test generateType(\tuple([\int(minInt,maxInt), \str()]), ()) == \tuple([\int(minInt,maxInt), \str()]);
test generateType(\rel([\int(minInt,maxInt), \str()]), ()) == \rel([\int(minInt,maxInt), \str()]);
test generateType(\same("A"), ("A" : <\int(minInt,maxInt),"">, "B" : <\str(), "">)) == \int(minInt,maxInt);
test generateType(\same("B"), ("A" : <\int(minInt,maxInt),"">, "B" : <\str(), "">)) == \str();
test generateType(\list(\same("B")), ("A" : <\int(minInt,maxInt),"">, "B" : <\str(), "">)) == \list(\str());

public RascalType generateArbType(int n, list[RascalType] prefs, VarEnv env){
   if(n <= 0)
   	  return getOneFrom(prefs);
   	  
   switch(arbInt(5)){
     case 0: return \list(generateArbType(n-1, prefs, env));
     case 1: return \set(generateArbType(n-1, prefs, env));
     case 2: return \map(generateArbType(n-1, prefs, env), generateArbType(n-1, prefs, env));
     case 3: return generateArbTupleType(n-1, prefs, env);
     case 4: return generateArbRelType(n-1, prefs, env);
   }
} 

// ---- Generating values

public str generateValue(str t){
   return generateValue(parseType(t), ());
}

public str generateValue(RascalType t){
   return generateValue(t, ());
}

public str generateValue(RascalType t, VarEnv env){
     switch(t){
       case \bool(): 		return generateBool();
       case \int(int f,int t): 		
       						return generateInt(f,t);
       case \real(int f, int t):    
       						return generateReal(f, t);
       case \num(int f, int t): 	
       						return generateNumber(f, t);
       case \str(): 		return generateString();
       case \loc():			return generateLoc();
       case \dateTime():	return generateDateTime();
       case \list(et): 		return generateList(et, env);
       case \set(et):		return generateSet(et, env);
       case \map(kt, vt):	return generateMap(kt, vt, env);
       case \tuple(list[RascalType] ets):	
       						return generateTuple(ets, env);
       case \rel(list[RascalType] ets):	
       						return generateSet(\tuple(ets), env);
       case \value():		return generateArb(0, baseTypes, env);
       case \arb(d, tps):   return generateArb(d, tps, env);
       case \same(name):	return generateValue(env[name].rtype, env);
     }
     throw "Unknown type: <t>";
}

set[set[str]] vocabularies =
{
// Letters:
{"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P",
"Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"},

// Sesame Street:
{"Bert", "Ernie", "Big Bird", "Cookie Monster", "Grover", "Elmo",
"Slimey the Worm", "Telly Monster", "Count Von Count", "Countess Darling Von Darling",
"Countess Von Backwards", "Guy Smiley", "Barkley the Dog", "Little Bird",
"Forgetful Jones", "Bruno", "Hoots The Owl", "Prince Charming",
"Mumford the Magician", "Two-Headed Monster"},

// Star Wars:
{"Jar Jar Binks", "C-3PO", "E-3PO", "Boba Fett", "Isolder", "Jabba the Hut",
"Luke Skywalker", "Obi-Wan Kenobi", "Darth Sidious", "Pincess Leia",
"Emperor Palpatine", "R2-D2", "Admiral Sarn", "Boba Fett", 
"Anakin Skywalker", "Sy Snootles", "Han Solo", "Tibor", "Darth Vader",
"Ailyn Vel", "Yoda", "Zekk", "Joh Yowza"},

// Fruits:
{"Blackcurrant", "Redcurrant", "Gooseberry", "Eggplant", "Guava",
"Pomegranate", "Kiwifruit", "Grape", "Cranberry", "Blueberry",	"Pumpkin",
"Melon", "Orange", "Lemon", "Lime", "Grapefruit", "Blackberry",
 "Raspberry", "Pineapple", "Fig", "Apple", "Strawberry",
 "Mandarin", "Coconut", "Date", "Prune", "Lychee", "Mango", "Papaya",
 "Watermelon"},

// Herbs and spices:
{"Anise", "Basil", "Musterd", "Nutmeg", "Cardamon", "Cayenne", 
"Celery", "Pepper", "Cinnamon", "Coriander", "Cumin",
"Curry", "Dill", "Garlic", "Ginger", "Jasmine",
"Lavender", "Mint", "Oregano", "Parsley", "Peppermint",
"Rosemary", "Saffron", "Sage", "Sesame", "Thyme",
"Vanilla", "Wasabi"}

};      
       
public str generateBool(){
   return toString(arbBool());
}
 
 public str generateInt(int from, int to){
   return toString(from + arbInt(to - from));
}
 
 public str generateReal(int from, int to){
   return toString(from + arbReal() * (to - from));
}

public str generateNumber(int from, int to){
   return (arbBool()) ? generateInt(from, to) : generateReal(from, to);
}

public str generateLoc(){
  return "|file:///home/paulk/pico.trm|(0,1,\<2,3\>,\<4,5\>)";
   /*
   scheme = getOneFrom(["http", "file", "stdlib", "cwd"]);
   authority = "auth";
   host = "www.cwi.nl";
   port = "80";
   path = "/a/b";

uri: the URI of the location. Also subfields of the URI can be accessed:

scheme: the scheme (or protocol) like http or file. Also supported is cwd: for current working directory (the directory from which Rascal was started).

authority: the domain where the data are located.

host: the host where the URI is hosted (part of authority).

port: port on host (part ofauthority).

path: path name of file on host.

extension: file name extension.

query: query data

fragment: the fragment name following the path name and query data.

user: user info (only present in schemes like mailto).

offset: start of text area.

length: length of text area

begin.line, begin.column: begin line and column of text area.

end.line, end.column end line and column of text area.
*/
}

public str generateDateTime(){
   year = 1990 + arbInt(150);
   month = 1 + arbInt(11);
   day = 1 + arbInt(6);
   dt1 = createDate(year, month, day);
   if(arbBool())
	  return "<dt1>";
   hour = arbInt(24);
   minute = arbInt(60);
   second = arbInt(60);
   milli = arbInt(1000);
   dt2 = createTime(hour, minute, second, milli);
  return "<joinDateAndTime(dt1, dt2)>";
}

public str generateString(){
  vocabulary = getOneFrom(vocabularies);
  return "\"<getOneFrom(vocabulary)>\"";
}

public str generateList(RascalType et, VarEnv env){
   return "[<for(int i <- [0 .. arbInt(5)]){><(i==0)?"":", "><generateValue(et, env)><}>]";
}

public str generateSet(RascalType et, VarEnv env){
   return "{<for(int i <- [0 .. arbInt(5)]){><(i==0)?"":", "><generateValue(et, env)><}>}";
}

public str generateMap(RascalType kt, RascalType vt, VarEnv env){
   return "(<for(int i <- [0 .. arbInt(5)]){><(i==0)?"":", "><generateValue(kt, env)> : <generateValue(vt, env)><}>)";
}

public str generateTuple(list[RascalType] ets, VarEnv env){
   return "\<<for(int i <- [0 .. size(ets)-1]){><(i==0)?"":", "><generateValue(ets[i], env)><}>\>";
}

public str generateRel(list[RascalType] ets, VarEnv env){
   return "\<<for(int i <- [0 .. size(elts)-1]){><(i==0)?"":", "><generateValue(ets[i], env)><}>\>";
}

public str generateArb(int n, list[RascalType] prefs, VarEnv env){
   if(n <= 0)
   	  return generateValue(getOneFrom(prefs), env);
   	  
   switch(arbInt(5)){
     case 0: return \list(generateArb(n-1, prefs, env));
     case 1: return \set(generateArb(n-1, prefs, env));
     case 2: return \map(generateArb(n-1, prefs, env), generateArb(n-1, prefs, env));
     case 3: return generateArbTuple(n-1, prefs, env);
     case 4: return generateArbRel(n-1, prefs, env);
   }
} 

public RascalType generateArbTupleType(int n, list[RascalType] prefs, VarEnv env){
   return \tuple([generateArbType(n - 1, prefs, env) | int i <- [0 .. arbInt(5)] ]);
}

public RascalType generateArbRelType(int n, list[RascalType] prefs, VarEnv env){
   return \rel([generateArbType(n - 1, prefs, env) | int i <- [0 .. arbInt(5)] ]);
}

public list[tuple[str,RascalType]] autoDeclare(str expr){
    list[tuple[str,RascalType]] d = [];
    set[str] decls = {};
    visit(expr){
      case /^\<<name:[A-Za-z0-9]>:<tp:[A-Za-z0-9\-,\[\]]+>\>/: {
        atp = parseType(tp);
        u = uses(atp);
        if(u - decls != {})
        	throw "reference to undefined sort: <u - decls>";
        d += <name, atp>;
        decls += name;
      }
      case /^\<@?<name:[A-Za-z0-9]>\>/: {
        throw "name reference \<<name>\>not allowed";
      }
      case/^\<<tp:[A-Za-z0-9\-,\[\]]+>\>/: {
        throw "nameless type \<<tp>\> not allowed";
      }
    };
    return d;
}

// ---- Substitute given value assignment in a text

public str subst(str txt, VarEnv env){
  println("subst(<txt>,<env>)");
  return visit(txt){
     case /^\<<name:[A-Z]>\>/: {
        println("name = <name>");
        v = env[name].rval;
        insert v;
      }
      case /^\<<name:[A-Z]>:<tp:[A-Za-z0-9\-,\[\]]+>\>/: {
        println("name = <name>");
        v = env[name].rval;
        insert v;
      }
      case /^\<@<name:[A-Z]>\>/: {
        println("name = <name>");
        v = toString(env[name].rtype);
        insert v;
      }
  };
}

// ---- Used variables in a text

public set[str] uses(str txt){
  println("uses(<txt>)");
  set[str] u = {};
  visit(txt){
     case /^\<@?<name:[A-Z]>\>/: {
        println("name = <name>");
        u += name;
      }
  };
  return u;
}
