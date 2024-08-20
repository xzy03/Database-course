package database;

public class StudentScore {
    private String sno; // 学号
    private String sname; // 学生姓名
    private String dno; // 系号
    private String clno; // 班号
    private String cno; // 课程号
    private String cname; // 课程名称
    private float ccredit; // 课程学分
    private String tname; // 教师姓名
    private int score; // 成绩
    private float grade; // 绩点

    // 无参构造函数
    public StudentScore() {}

    // 有参构造函数
    public StudentScore(String sno, String sname, String dno, String clno, String cno, String cname, float ccredit, String tname, int score, float grade) {
        this.sno = sno;
        this.sname = sname;
        this.dno = dno;
        this.clno = clno;
        this.cno = cno;
        this.cname = cname;
        this.ccredit = ccredit;
        this.tname = tname;
        this.score = score;
        this.grade = grade;
    }

    // Getter 和 Setter 方法

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

    public String getDno() {
        return dno;
    }

    public void setDno(String dno) {
        this.dno = dno;
    }

    public String getClno() {
        return clno;
    }

    public void setClno(String clno) {
        this.clno = clno;
    }

    public String getCno() {
        return cno;
    }

    public void setCno(String cno) {
        this.cno = cno;
    }

    public String getCname() {
        return cname;
    }

    public void setCname(String cname) {
        this.cname = cname;
    }

    public float getCcredit() {
        return ccredit;
    }

    public void setCcredit(float ccredit) {
        this.ccredit = ccredit;
    }

    public String getTname() {
        return tname;
    }

    public void setTname(String tname) {
        this.tname = tname;
    }

    public int getScore() {
        return score;
    }

    public void setScore(int score) {
        this.score = score;
    }

    public float getGrade() {
        return grade;
    }

    public void setGrade(float grade) {
        this.grade = grade;
    }

    @Override
    public String toString() {
        return "StudentScore{" +
                "sno='" + sno + '\'' +
                ", sname='" + sname + '\'' +
                ", dno='" + dno + '\'' +
                ", clno='" + clno + '\'' +
                ", cno='" + cno + '\'' +
                ", cname='" + cname + '\'' +
                ", ccredit=" + ccredit +
                ", tname='" + tname + '\'' +
                ", score=" + score +
                ", grade=" + grade +
                '}';
    }
}

