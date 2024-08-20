package database;

public class Course {
    private String cno;
    private String cname;
    private Integer cyear;
    private Integer period;
    private String way;
    private String curriculum;
    private Float credit;

    // Getter and Setter for cno
    public String getCno() {
        return cno;
    }

    public void setCno(String cno) {
        this.cno = cno;
    }

    // Getter and Setter for cname
    public String getCname() {
        return cname;
    }

    public void setCname(String cname) {
        this.cname = cname;
    }

    // Getter and Setter for cyear
    public Integer getCyear() {
        return cyear;
    }

    public void setCyear(Integer cyear) {
        this.cyear = cyear;
    }

    // Getter and Setter for period
    public Integer getPeriod() {
        return period;
    }

    public void setPeriod(Integer period) {
        this.period = period;
    }

    // Getter and Setter for way
    public String getWay() {
        return way;
    }

    public void setWay(String way) {
        this.way = way;
    }

    // Getter and Setter for curriculum
    public String getCurriculum() {
        return curriculum;
    }

    public void setCurriculum(String curriculum) {
        this.curriculum = curriculum;
    }

    // Getter and Setter for credit
    public Float getCredit() {
        return credit;
    }

    public void setCredit(Float credit) {
        this.credit = credit;
    }
}
