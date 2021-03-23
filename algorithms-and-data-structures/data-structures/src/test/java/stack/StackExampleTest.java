package stack;

import static org.junit.jupiter.api.Assertions.assertEquals;

import java.util.Stack;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

class StackExampleTest {

  @Test
  @DisplayName("Should print the default capacity of a stack which is 10")
  void shouldPrintStackDefaultCapacity() {
    Stack<String> stack = new Stack<>();

    System.out.printf("Default capacity: %s", stack.capacity());
    assertEquals(10, stack.capacity());
  }

  @Test
  @DisplayName("Should print the capacity, last object and size of the stack")
  void shouldPrintStackCapacityAndLastObjectAndSize() {
    Stack<String> cities = new Stack<>();
    cities.push("Berlin");
    cities.push("Warsaw");
    cities.push("London");
    cities.push("Paris");
    cities.push("Madrid");
    cities.push("Milan");
    System.out.printf("Capacity: %s\n", cities.capacity());
    System.out.printf("The object on top: %s\n", cities.peek());
    System.out.printf("Size: %s\n", cities.size());
  }

  @Test
  @DisplayName("Should show how the LI-FO works in stacks")
  void lifoExample() {
    Stack<String> cities = new Stack<>();
    System.out.println("Let's add a few cities:");
    System.out.printf("%s\n", cities.push("Berlin"));
    System.out.printf("%s\n", cities.push("Warsaw"));
    System.out.printf("%s\n", cities.push("London"));

    System.out.printf("\nCities: %s\n", cities);

    System.out.println("\nNow let's remove them one-by-one:");
    while (!cities.isEmpty()) {
      System.out.printf("%s\n", cities.pop());
    }
  }

  @Test
  @DisplayName("Should return an item by index")
  void shouldBeAbleToGetItemByIndex() {
    Stack<String> cities = new Stack<>();
    System.out.println("Let's add a few cities:");
    System.out.printf("%s\n", cities.push("Berlin"));
    System.out.printf("%s\n", cities.push("Warsaw"));
    System.out.printf("%s\n", cities.push("London"));

    System.out.printf("\nCity with index 1: %s\n", cities.get(1));
  }
}