package org.example;

        import org.junit.jupiter.api.Test;


        import java.util.HashSet;
        import java.util.Set;

        import static org.junit.jupiter.api.Assertions.*;

class FindSymbolsTest {

    private static HashSet<Character> answer;

    @Test
    void findSymbolsTest() {
        //test only digits
        answer = new HashSet<>(Main.findSymbols("fsasf2525safsaf"));
        assertEquals(answer, Set.of('2'));
        answer.clear();
        //test empty
        answer = new HashSet<>(Main.findSymbols("asf9jf7io53,u."));
        assertEquals(answer, Set.of());
        answer.clear();
        //test digits and symbols 1
        answer = new HashSet<>(Main.findSymbols("safasf8sf2-+10"));
        assertEquals(answer, Set.of('-','+','0','2','8'));
        answer.clear();
        //test digits and symbols 2
        answer = new HashSet<>(Main.findSymbols("sa(at[asf'sf7%-10"));
        assertEquals(answer, Set.of('%','-','(','[','0'));
        answer.clear();
        //test digits and symbols 3
        answer = new HashSet<>(Main.findSymbols("{pjop]+11-34=-23/5=4.6)"));
        assertEquals(answer, Set.of('{',']',')','-','+','/','2','4','6'));
        answer.clear();
    }
}