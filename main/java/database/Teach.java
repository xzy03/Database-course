package database;

public class Teach {
    private String cno;        // 课程号
    private String tno;        // 教师号
    private String time;       // 授课时间
    private int maxnum;        // 最大人数
    private int choosenum;     // 已选人数

    // 默认构造函数
    public Teach() {
    }

    // 带参数的构造函数
    public Teach(String cno, String tno, String time, int maxnum, int choosenum) {
        this.cno = cno;
        this.tno = tno;
        this.time = time;
        this.maxnum = maxnum;
        this.choosenum = choosenum;
    }

    // Getter 和 Setter 方法
    public String getCno() {
        return cno;
    }

    public void setCno(String cno) {
        this.cno = cno;
    }

    public String getTno() {
        return tno;
    }

    public void setTno(String tno) {
        this.tno = tno;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public int getMaxnum() {
        return maxnum;
    }

    public void setMaxnum(int maxnum) {
        this.maxnum = maxnum;
    }

    public int getChoosenum() {
        return choosenum;
    }

    public void setChoosenum(int choosenum) {
        this.choosenum = choosenum;
    }

    // toString 方法
    @Override
    public String toString() {
        return "Teach{" +
                "cno='" + cno + '\'' +
                ", tno='" + tno + '\'' +
                ", time='" + time + '\'' +
                ", maxnum=" + maxnum +
                ", choosenum=" + choosenum +
                '}';
    }
}
