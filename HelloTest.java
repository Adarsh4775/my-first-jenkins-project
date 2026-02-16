public class HelloTest {
    public static void main(String[] args) {
        testAdd();
        System.out.println("All tests passed!");
    }
    
    public static void testAdd() {
        int result = Hello.add(2, 3);
        if (result != 5) {
            throw new AssertionError("Test failed: expected 5 but got " + result);
        }
        System.out.println("✓ add() test passed");
    }
}
