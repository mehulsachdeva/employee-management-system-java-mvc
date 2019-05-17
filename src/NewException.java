public class NewException extends Exception{
    String d;
    NewException(String d){
        this.d=d;
    }
    public String toString(){
        return d;
    }
}