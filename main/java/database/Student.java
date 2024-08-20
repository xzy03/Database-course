package database;

public class Student {
    private String sno;       // 学号
    private String clno;      // 班级号
    private String dno;       // 专业号
    private String sname;     // 学生姓名
    private String ssex;      // 学生性别
    private int sbirth;       // 学生年龄
    private String sprovince; // 所属省份
    private String scity;     // 所属市区
    private float scredit;    // 已修学分
    private float sgpa;       // 学生绩点

    // Getter 和 Setter 方法
    public String getSno() {
        return sno;
    }

    public void setSno(String sno) {
        this.sno = sno;
    }

    public String getClno() {
        return clno;
    }

    public void setClno(String clno) {
        this.clno = clno;
    }

    public String getDno() {
        return dno;
    }

    public void setDno(String dno) {
        this.dno = dno;
    }

    public String getSname() {
        return sname;
    }

    public void setSname(String sname) {
        this.sname = sname;
    }

    public String getSsex() {
        return ssex;
    }

    public void setSsex(String ssex) {
        this.ssex = ssex;
    }

    public int getSbirth() {
        return sbirth;
    }

    public void setSbirth(int sbirth) {
        this.sbirth = sbirth;
    }

    public String getSprovince() {
        return sprovince;
    }

    public void setSprovince(String sprovince) {
        this.sprovince = sprovince;
    }

    public String getScity() {
        return scity;
    }

    public void setScity(String scity) {
        this.scity = scity;
    }

    public float getScredit() {
        return scredit;
    }

    public void setScredit(float scredit) {
        this.scredit = scredit;
    }

    public float getSgpa() {
        return sgpa;
    }

    public void setSgpa(float sgpa) {
        this.sgpa = sgpa;
    }
}
