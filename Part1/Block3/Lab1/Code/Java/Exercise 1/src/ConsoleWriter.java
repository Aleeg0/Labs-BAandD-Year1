public class ConsoleWriter extends Writer {
    @Override
    public void outputString(String s) {
        if (s.isEmpty()) {
            System.out.println("Function didn't find number in string.");
        }
        else {
            System.out.println("The number in the string is " + s);
        }
    }
}
