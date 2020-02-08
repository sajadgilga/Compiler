package com.company;
import java.util.*;

%%
%standalone
%class PascalScanner
%public
%line
%column

%function next_token
%type Token
%eofval{
    if(bracketCount == 0)
        return new Token(TokenConst.EOF, -1);
    else
        Report.error("Odd number of Brackets", - 1);
%eofval}
%eofclose
%{
    int bracketCount = 0;
%}
%{
    public int getLine() { return yyline + 1; }
%}
%eof{
%eof}


Whitespace = [ \n\t\f\r\v]+
SingleLineComment = "--".*
MultiLineComment = [<][-][-]([^-]|[-][^-]|[-][-][^>])*[-][-][>]
ID = [a-zA-Z][_a-zA-Z0-9]*
ICD = [0-9]*[\.][0-9]*
ICC = [0-9]+
HEX = [0][x][a-fA-F0-9]+
StringConst = [\"][^\"]*[\"]
CharConst = ['][^'][']
%%

<YYINITIAL>{
	{Whitespace} {}
	// "write" {
    //     return new Token(TokenConst.WRITE, yytext());
    // }
    // "read" {
    //     return new Token(TokenConst.READ, yytext());
    // }
    // "main" {
    //     return new Token(TokenConst.MAIN, yytext());
    // }
    // "strlen" {
    //     return new Token(TokenConst.STRLEN, yytext());
    // }
    	"assign"							{ return sym(Symbol.ASSIGN); }
        "and"						    	{ return sym(Symbol.LAND); }
        "break"                          { return sym(Symbol.BREAK);}
        "continue"						{ return sym(Symbol.CONTINUE); }
    	"begin"							{ return sym(Symbol.BEGIN); }
    	"array"							{ return sym(Symbol.ARRAY); }
    	"end"					    		{ return sym(Symbol.END); }
    	"do"						    	{ return sym(Symbol.DO); }
    	"of"						    	{ return sym(Symbol.OF); }
    	"if"					        		{ return sym(Symbol.IF); }
    	"else"							{ return sym(Symbol.ELSE); }
    	"not"					    		{ return sym(Symbol.NOT); }
        "return"				    		{ return sym(Symbol.RETURN); }
    	"or"						    	{ return sym(Symbol.LOR); }
    	"function"						{ return sym(Symbol.FUNCTION); }
    	"while"							{ return sym(Symbol.WHILE); }
    	"program"						{ return sym(Symbol.PROGRAM); }
    	"var"					    		{ return sym(Symbol.VAR); }
    	"procedure"					{ return sym(Symbol.PROCEDURE); }
    	"then"							{ return sym(Symbol.THEN); }
    	// names of atomic data structures
    	"boolean"						{ return sym(Symbol.BOOL); }
    	"char"							{ return sym(Symbol.CHAR); }
    	"integer"			    			{ return sym(Symbol.INT); }
        "real"			        			{ return sym(Symbol.REAL); }
        "string"                          { return sym(Symbol.STRING);}

    	// other symbols
    	":="							{ return sym(Symbol.ASSIGN); }
    	":"								{ return sym(Symbol.COLON); }
    	","								{ return sym(Symbol.COMMA); }
    	"."								{ return sym(Symbol.DOT); }
    	"["								{ return sym(Symbol.LBR); }
    	"("								{ return sym(Symbol.LPR); }
    	"]"								{ return sym(Symbol.RBR); }
    	")"								{ return sym(Symbol.RPR); }
    	";"								{ return sym(Symbol.SEMI); }
    	"+"							{ return sym(Symbol.ADD); }
    	"="							{ return sym(Symbol.EQU); }
    	">="							{ return sym(Symbol.GEQ); }
    	">"							{ return sym(Symbol.GTH); }
    	"<"							{ return sym(Symbol.LTH); }
    	"<="							{ return sym(Symbol.LEQ); }
    	"*"								{ return sym(Symbol.MUL); }
    	"<>"							{ return sym(Symbol.NEQ); }
    	"^"								{ return sym(Symbol.XOR); }
    	"-"							{ return sym(Symbol.SUB); }
        "&"							{ return sym(Symbol.BAND); }
        "|"								{ return sym(Symbol.BOR); }
        "/"								{ return sym(Symbol.DIV); }
        "%"							{ return sym(Symbol.MOD); }
        "~"							{ return sym(Symbol.LNOT); }

    	.								{ Report.error("Character not recognizable as valid Pascal keyword, symbol, name, ID or constant.", yyline+1, yycolumn+1, -1); }


    "long" {
        return new Token(Symbol.LONG, yytext());
    }
    {SingleLineComment} {}
    {MultiLineComment}  {}
    {ID} {
        return new Token(Symbol.ID, yytext());
    }
    {ICD} {
        return new Token(Symbol.ICD, Double.parseDouble(yytext()));
    }
    {ICC} {
        return new Token(Symbol.ICC, Integer.parseInt(yytext()));
    }
    {HEX} {
        return new Token(Symbol.HEX, Integer.parseInt(yytext().substring(2), 16));
    }
    {StringConst} {
        return new Token(Symbol.StringConst, yytext());
    }
    {CharConst} {
        return new Token(Symbol.CharConst, yytext());
    }
}
