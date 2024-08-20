package database;

public class Dept {
    private String dno;
    private String dname;
    private Integer dnumber;

    // 默认构造函数
    public Dept() {}

    // 参数化构造函数
    public Dept(String dno, String dname, Integer dnumber) {
        this.dno = dno;
        this.dname = dname;
        this.dnumber = dnumber;
    }

    // Getter 和 Setter 方法
    public String getDno() {
        return dno;
    }

    public void setDno(String dno) {
        this.dno = dno;
    }

    public String getDname() {
        return dname;
    }

    public void setDname(String dname) {
        this.dname = dname;
    }

    public Integer getDnumber() {
        return dnumber;
    }

    public void setDnumber(Integer dnumber) {
        this.dnumber = dnumber;
    }

    // 重写 toString 方法
    @Override
    public String toString() {
        return "Dept{" +
                "dno='" + dno + '\'' +
                ", dname='" + dname + '\'' +
                ", dnumber=" + dnumber +
                '}';
    }
}
