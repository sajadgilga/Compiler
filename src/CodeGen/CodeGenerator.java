package CodeGen;

import Scanner.Scanner;


public class CodeGenerator {
    Scanner scanner; // This was my way of informing CG about Constant Values detected by Scanner.Scanner, you can do whatever you like

    // Define any variables needed for code generation

    public CodeGenerator(Scanner scanner) {
        this.scanner = scanner;
    }

    public void Generate(String sem) {
        System.out.println(sem); // Just for debug

        if (sem.equals("NoSem"))
            return;
        switch (sem) {
            case "NoSem":
                break;
            case "@pushFName":
                pushFName();
                break;
            case "@detRt":
                detRt();
                break;
            case "@cf":
                cf();
                break;
            case "@pushPName":
                pushPName();
                break;
            case "@cp":
                cp();
                break;
            case "@pushVarName":
                pushVarName();
                break;
            case "@detVarType":
                detVarType();
                break;
            case "@assignVar":
                assignVar();
                break;
            case "@detArray":
                detArray();
                break;
            case "@detArrType":
                detArrType();
                break;
            case "@addDim":
                addDim();
                break;
            case "@return":
                returnf();
                break;
            case "@jp":
                jp();
                break;
            case "@j":
                j();
                break;
            case "@jz":
                jz();
                break;
            case "@cjz":
                cjz();
                break;
            case "@addArrIdx":
                addArrIdx();
                break;
            case "@setArg":
                setArg();
                break;
            case "@push":
                push();
                break;
            case "@callFunc":
                callFunc();
                break;
            case "@land":
                land1();
                break;
            case "@lor":
                lor1();
                break;
            case "@band":
                band();
                break;
            case "@bor":
                bor();
                break;
            case "@xor":
                xor();
                break;
            case "@equ":
                equ();
                break;
            case "@neq":
                neq();
                break;
            case "@leq":
                leq();
                break;
            case "@geq":
                geq();
                break;
            case "lth":
                lth();
                break;
            case "@gth":
                gth();
                break;
            case "@add":
                add();
                break;
            case "@sub":
                sub();
                break;
            case "@mod":
                mod();
                break;
            case "@div":
                div();
                break;
            case "@mul":
                mul();
                break;
            case "@minus":
                minus1();
                break;
            case "@lnot":
                lnot();
                break;

        }
        /*
         * else if (sem.equals("SemanticRoutine1"))
         * {
         * 	...
         * }
         * else if (sem.equals("SemanticRoutine2"))
         * {
         * 	...
         * }
         */
    }

    private void detArray() {
    }

    private void lnot() {
    }

    private void minus1() {
    }

    private void mul() {
    }

    private void div() {
    }

    private void mod() {
    }

    private void sub() {
    }

    private void add() {
    }

    private void gth() {
    }

    private void lth() {
    }

    private void geq() {
    }

    private void leq() {
    }

    private void neq() {
    }

    private void equ() {
    }

    private void xor() {
    }

    private void bor() {
    }

    private void band() {
    }

    private void lor1() {
    }

    private void land1() {
    }

    private void callFunc() {
    }

    private void push() {
    }

    private void setArg() {
    }

    private void addArrIdx() {
    }

    private void cjz() {
    }

    private void jz() {
    }

    private void j() {
    }

    private void jp() {
    }

    private void returnf() {
    }

    private void addDim() {
    }

    private void detArrType() {
    }

    private void assignVar() {
    }

    private void detVarType() {
    }

    private void pushVarName() {
        
    }

    private void cp() {
    }

    private void pushPName() {
    }

    private void cf() {
    }

    private void detRt() {


    }

    private void pushFName() {

    }

    public void FinishCode() // You may need this
    {

    }

    public void WriteOutput(String outputName) {
        // Can be used to print the generated code to output
        // I used this because in the process of compiling, I stored the generated code in a structure
        // If you want, you can output a code line just when it is generated (strongly NOT recommended!!)
    }
}
