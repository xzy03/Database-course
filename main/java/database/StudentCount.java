package database;

public class StudentCount {
    private String sno;
    private String sname;
    private float max;
    private float min;
    private float avg;

    public StudentCount() {
    }

    public StudentCount(String sno, String sname, float max, float min, float avg) {
        this.sno = sno;
        this.sname = sname;
        this.max = max;
        this.min = min;
        this.avg = avg;
    }

    public String getSno() {
        return sno;
    }

    public void setSno(String sno) {
        this.sno = sno;
    }

    public String getSname() {
        return sname;
    }

    public void setSname(String sname) {
        this.sname = sname;
    }

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

    @Override
    public String toString() {
        return "StudentCount{" +
                "sno='" + sno + '\'' +
                ", sname='" + sname + '\'' +
                ", max=" + max +
                ", min=" + min +
                ", avg=" + avg +
                '}';
    }
}