public class Stack {
    
    private static final Integer MAX_LENGTH = 100;
    private Integer top=-1;
    private String[] items = new String[MAX_LENGTH];
    
    //items = expression.split('');
    //items.remove(0);
    public Stack(){
        //items = new String[MAX_LENGTH];
        System.debug('Created Stack of size ' + MAX_LENGTH);
        
    }
    
    public void push(String x)  
    { 
        System.debug('entering Stack.push() method with character ' + x);
        if (top == MAX_LENGTH -1)  
        { 
            System.debug('Stack full'); 
        }  
        else 
        { 
            items[++top] = x; 
            System.debug('pushed ' + x + ' to items[' +top+']');
        } 
    } 
        
    public String pop()  
    { 
        if (top == -1)  
        { 
            System.debug('Underflow error'); 
            return ''; 
        }  
        else 
        { 
            String element = items[top]; 
            System.debug('popped ' + element + ' from items['+top+']');
            top--; 
            return element; 
        } 
    } 
        
    public boolean isEmpty()  
    { 
        if(top == -1){
            System.debug('Stack is empty');
            return true;
        } 
        else{
            System.debug('Stack is NOT empty');
            return false;
        }

    }
}