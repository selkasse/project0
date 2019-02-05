public class Apex0Exercises {
    
    /* Returns true if character1 and character2 
       are matching left and right Parenthesis */
    public static boolean isMatchingPair(String character1, String character2) 
    { 
       if (character1 == '(' && character2 == ')') 
         return true; 
       else if (character1 == '{' && character2 == '}') 
         return true; 
       else if (character1 == '[' && character2 == ']') 
         return true; 
       else
         return false; 
    } 
    
    public static Integer[] sortArray( Integer[] intList ) 
    {
        for(Integer i =1; i< intList.size(); i++)
        {
            Integer k = i;
            while(k > 0 && intList[k] < intList[k-1] )
            {
                Integer temp = intList[k-1]; 
                intList[k-1] = intList[k]; 
                intList[k] = temp; 
                k--;
            }
        }	
		return intList;
    }
    
    public static void printArray(Integer[] intList)
    {
        for (Integer i = 0; i < intList.size(); i++){
                System.debug(intList[i] + '|');
        }
        System.debug('');
    }
    
    public static Integer nFibonacci( Integer n )
    {
        if(n==0) return 0; 
        if(n==1) return 1;
        else
            return nFibonacci(n-1) + nFibonacci(n-2);
    }
    
    public static Integer nFactorial( Integer n) 
    {
        if (n<0) return -1;
        if(n==0) return 1;
        return n*nFactorial(n-1);
    }
    
    public static Integer[] rotateLeftNTimes( Integer[] ar, Integer n) 
    {
        // Create array of same size to hold rotated values
        Integer[] rotatedArray = new Integer[ar.size()];
        for(Integer i =0; i < ar.size(); i++){
            /*
            Use the modulo operator to account for values of n that are 
            larger than array.length.
            
            This also allows the elements to rotated in a 'circular' fashion,
            and prevents an java.lang.ArrayIndexOutOfBoundsException
            */
            rotatedArray[i] = ar[math.mod((i+n), ar.size())];
            
        }
        return rotatedArray;
    }
    
    public static boolean bracketsAreBalanced( String s ) {
        String[] charString = s.split('');
    	//charString.remove(0);
        System.debug('PRINTING charString');
        for(Integer i = 0; i < charString.size(); i++){
            System.debug('printing charString: ' + charString[i]);
        }
        //System.debug(charString);
        //return isValid(charString);
        return false;
    }
    
    public static boolean isValid(String[] expression)
    {
        Stack bracketStack = new Stack();
        for(Integer i = 0; i < expression.size(); i++)
        {
            // Push to the stack if open bracket
            if (expression[i] == '{' || expression[i] == '(' || expression[i] == '[') 
              bracketStack.push(expression[i]); 

            /* If ending bracket, pop from stack and check if the  
               popped bracket is a matching pair*/
            if (expression[i] == '}' || expression[i] == ')' || expression[i] == ']') 
            {  
                /* If there is an ending bracket without  
                   a pair then return false*/
               if (bracketStack.isEmpty()) 
               { 
                    return false; 
               }  

               /* Pop the top element from stack, if  
                  it is not a pair bracket of character at index i,
                  then there is a mismatch. This happens for  
                  expressions like {(}) */
               else if ( !isMatchingPair(bracketStack.pop(), expression[i]) ) 
                 { 
                     return false; 
                 } 
            } 
        }
        /* If there is something left in expression  
          then there is a starting parenthesis without  
          a closing parenthesis */
        
       if (bracketStack.isEmpty()) 
            return true; /*balanced*/
       else
            return false; /*not balanced*/
         
    }
}