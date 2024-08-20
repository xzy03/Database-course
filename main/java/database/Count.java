package database;

public class Count {
    private float max; // 最大值
    private float min; // 最小值
    private float avg; // 平均值

    // 无参构造函数
    public Count() {}

    // 有参构造函数
    public Count(float max, float min, float avg) {
        this.max = max;
        this.min = min;
        this.avg = avg;
    }

    // Getter 和 Setter 方法
    public float getMax() {
        return max;
    }

    public void setMax(float max) {
        this.max = max;
    }

    public float getMin() {
        return min;
    }

    public void setMin(float min) {
        this.min = min;
    }

    public float getAvg() {
        return avg;
    }

    public void setAvg(float avg) {
        this.avg = avg;
    }

    // 重写 toString 方法
    @Override
    public String toString() {
        return "Count{" +
                "max=" + max +
                ", min=" + min +
                ", avg=" + avg +
                '}';
    }
}
