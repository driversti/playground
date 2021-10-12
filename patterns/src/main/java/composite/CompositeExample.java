package composite;

import java.util.HashSet;
import java.util.Set;
import lombok.EqualsAndHashCode;

public class CompositeExample {

  public static void main(String[] args) {
    final Box innerBox1_1 = new Box();
    innerBox1_1.add(new Item(2.20));

    final Box innerBox1 = new Box();
    innerBox1.add(innerBox1_1);
    innerBox1.add(new Item(0.90));

    final Box topBox = new Box();
    topBox.add(new Item(2.90));
    topBox.add(new Item(7.80));
    topBox.add(innerBox1);

    final Client client = new Client();
    client.printTotalSum(topBox);
  }

  interface Goods {

    double calculateSum();
  }

  static class Client {

    void printTotalSum(final Goods goods) {
      System.out.printf("Total: %s%n", goods.calculateSum());
    }
  }

  static record Item(double price) implements Goods {

    @Override
    public double calculateSum() {
      return price;
    }
  }

  @EqualsAndHashCode
  static class Box implements Goods {

    private final Set<Goods> goodsSet = new HashSet<>();

    @Override
    public double calculateSum() {
      return goodsSet.stream()
          .mapToDouble(Goods::calculateSum)
          .sum();
    }

    void add(final Goods goods) {
      goodsSet.add(goods);
    }

    void remove(final Goods goods) {
      goodsSet.remove(goods);
    }
  }
}
