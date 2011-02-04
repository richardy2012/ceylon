grammar Visitorgen;

options { output=template; }

@parser::header { package com.redhat.ceylon.compiler.treegen; }
@lexer::header { package com.redhat.ceylon.compiler.treegen; }

@members {

    public java.io.PrintStream out = System.out;

    String className(String nodeName) { 
        return toJavaIdentifier(nodeName, true); 
    }
    
    String fieldName(String nodeName) { 
        return toJavaIdentifier(nodeName, false); 
    }
    
    String toJavaIdentifier(String nodeName, boolean boundary) {
        StringBuilder result = new StringBuilder();
        for (char c: nodeName.toCharArray()) {
            if (c=='_') {
                boundary=true;
            }
            else if (boundary) {
                result.append(c);
                boundary=false;
            }
            else {
                result.append(Character.toLowerCase(c));
            }
        }
        return result.toString();
    }
    
    void print(String text) {
       out.print(text); 
    }
    
    void println(String text) {
       out.println(text); 
    }
    
}

nodeList : { 
           println("package com.redhat.ceylon.compiler.tree;\n");
           println("import static com.redhat.ceylon.compiler.tree.Tree.*;\n");
           println("public interface Visitor {\n");
           }
           (DESCRIPTION? node)+ 
           EOF
           { println("}"); }
           ;

node : '^' '('
       n=NODE_NAME 
       { println("public void visit(" + className($n.text) + " that);"); }
       extendsNode? 
       (DESCRIPTION? subnode)*
       (DESCRIPTION? field)*
       ')'
     ;

extendsNode : ':' n=NODE_NAME;

subnode : n=NODE_NAME OPTIONAL?
        | mn=NODE_NAME MANY 
        ;

field : TYPE_NAME FIELD_NAME ';';

NODE_NAME : ('A'..'Z'|'_')+;

FIELD_NAME : ('a'..'z') ('a'..'z'|'A'..'Z')*;
TYPE_NAME : ('A'..'Z') ('a'..'z'|'A'..'Z')*;

WS : (' ' | '\n' | '\t' | '\r' | '\u000C') { skip(); };

CARAT : '^';

LPAREN : '(';
RPAREN : ')';

MANY : '*'|'+';
OPTIONAL : '?';

EXTENDS : ':';

SEMI : ';';

DESCRIPTION : '\"' (~'\"')* '\"';
