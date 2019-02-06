public class Apex0Application {
    
    public static void start(){
        Integer[] intList = new Integer[]{10,9,5,7,1,3};
        // n will be used for nFactorial and nFibonacci
        Integer n = 10;
        
        // number of times to rotate left
        Integer rotation = 3;
        
        // nFibonacci
        System.debug('\nPrinting Fibonacci('+ n+'):' +  Apex0Exercises.nFibonacci(n) +'\n');
        
        // sortArray
        intList = Apex0Exercises.sortArray(intList);
        System.debug('Printing sorted array');
        Apex0Exercises.printArray(intList);
        
        // nFactorial
        System.debug('\nPrinting nFactorial('+n+'): ' +  Apex0Exercises.nFactorial(n) + '\n');
        
        // rotateLeftNTimes
        Integer[] rotatedArray =  Apex0Exercises.rotateLeftNTimes(intList, rotation);
        System.debug('Printing rotated array');
        Apex0Exercises.printArray(rotatedArray);    
        
        // bracketsAreBalanced
        String expression = '([])[]{}';
        String message = 'The expression is ';
        if(Apex0Exercises.bracketsAreBalanced(expression))
            message += 'valid';
        else
            message += 'not valid';
        System.debug('\n'+message);

        Apex0Exercises.updateAccountBalance('A-00010');

        Apex0Exercises.updateCALeads();

        Apex0Exercises.updateAccountSize();

        Apex0Exercises.updateAccountStatus('A-00010');

        Apex0Exercises.closePastDueOpportunities();

        Apex0Exercises.createTransaction('A-00010');
    }

}