import java.util.List;
import java.util.function.BiFunction;
import java.util.function.BinaryOperator;
import java.util.stream.Collectors;
import java.util.stream.IntStream;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

class StreamsTest {

  @Test
  @DisplayName("should show how does peek work")
  void shouldShowHowPeekWorks() {
    final String result = List
        .of("BMW", "Mercedes-Benz", "Audi", "KIA", "Toyota", "Bentley", "Opel", "Cadillac", "Dacia")
        .stream()
        .peek(it -> System.out.printf("Init: %s\n", it))
        .sorted()
        .peek(it -> System.out.printf("Sorted: %s\n", it))
        .collect(Collectors.joining(", ", "[", "]"));
    System.out.format("Result: %s\n\n", result);
  }

  @Test
  @DisplayName("Shows how does the reduce method work with BinaryOperator when we concatenate of all strings")
  void learningHowToUseReduce1() {
    final String result = List
        .of("BMW", "Mercedes-Benz", "Audi", "KIA", "Toyota", "Bentley", "Opel", "Cadillac", "Dacia")
        .stream()
        .reduce((s, s2) -> String.format("%s, %s", s, s2))
        .orElseGet(() -> "The reduce method has nothing returned.");

    System.out.format("Result of reducing: %s\n\n", result);
  }

  @Test
  @DisplayName("Shows how does the reduce method work with BinaryOperator when we return the longest string in a pair")
  void learningHowToUseReduce2() {
    final String result = List
        .of("BMW", "Mercedes-Benz", "Audi", "KIA", "Toyota", "Bentley", "Opel", "Cadillac", "Dacia")
        .stream()
        .reduce(this::getLongestString)
        .orElseGet(() -> "The reduce method has nothing returned.");

    System.out.format("Result of reducing: %s\n", result);
  }

  private String getLongestString(String left, String right) {
    System.out.format("Left: %s, right: %s\n", left, right);
    return left.length() > right.length() ? left : right;
  }

  @Test
  @DisplayName("Let's sum up all integers of the IntStream in the reduce method with IntBinaryOperator")
  void learningHowToUseReduce3() {
    final int result = IntStream.range(1, 11)
        .reduce(this::sumUp)
        .orElse(0);

    System.out.format("Result of reducing: %s\n\n", result);
  }

  private int sumUp(int left, int right) {
    System.out.format("Left: %s, right: %s\n", left, right);
    return left + right;
  }

  @Test
  @DisplayName("Let's sum up all integers of the IntStream in the reduce method with initial value and IntBinaryOperator")
  void learningHowToUseReduce4() {
    final int result = IntStream.range(1, 11)
        .reduce(0, (this::sumUp));

    System.out.format("Result of reducing: %s\n\n", result);
  }

  @Test
  @DisplayName("Let's use reduce method with identity, accumulator and combiner")
  void learningHowToUseReduce5() {
    final String result = List
        .of("BMW", "Mercedes-Benz", "Audi", "KIA", "Toyota", "Bentley", "Opel", "Cadillac", "Dacia", "Mazda")
        .stream()
        .reduce(">> ", new BiFunction<String, String, String>() {
          @Override
          public String apply(String left, String right) {
            return left + right;
          }
        }, new BinaryOperator<String>() {
          @Override
          public String apply(String left, String right) {
            return left.length() == right.length() ? left : right;
          }
        });

    System.out.format("Result of reducing: %s\n\n", result);
  }
}
