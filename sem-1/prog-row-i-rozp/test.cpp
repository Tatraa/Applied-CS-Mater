#include <iostream>
#include <cassert>

class Test {
public:
    void runTests() {
        testAddition();
        testSubtraction();
        std::cout << "All tests passed!" << std::endl;
    }

private:
    void testAddition() {
        assert(add(2, 3) == 5);
        assert(add(-1, 1) == 0);
        assert(add(0, 0) == 0);
    }

    void testSubtraction() {
        assert(subtract(5, 3) == 2);
        assert(subtract(1, 1) == 0);
        assert(subtract(0, 1) == -1);
    }

    int add(int a, int b) {
        return a + b;
    }

    int subtract(int a, int b) {
        return a - b;
    }
};

int main() {
    Test test;
    test.runTests();
    return 0;
}