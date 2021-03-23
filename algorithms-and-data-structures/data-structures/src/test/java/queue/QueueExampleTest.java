package queue;

import java.util.ArrayDeque;
import java.util.Queue;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

class QueueExampleTest {

  @Test
  @DisplayName("Shows the order of adding and removing of items in a queue (FI-FO)")
  void shouldShowAddingAndRemovingItems() {
    Queue<String> brands = new ArrayDeque<>();
    System.out.println("Let's add a few brands:");
    add(brands, "Audi");
    add(brands, "BMW");
    add(brands, "Cadillac");

    System.out.printf("\nQueue: %s\n\n", brands);

    while (!brands.isEmpty()) {
      System.out.printf("%s\n", brands.remove());
    }
  }

  private void add(Queue<String> queue, String item) {
    queue.add(item);
    System.out.println(item);
  }
}
