package database;

public class StudentRank {
    private String sno;
    private String sname;
    private int rank;

    public StudentRank() {
    }

    public StudentRank(String sno, String sname, int rank) {
        this.sno = sno;
        this.sname = sname;
        this.rank = rank;
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

    public int getRank() {
        return rank;
    }

    public void setRank(int rank) {
        this.rank = rank;
    }

    @Override
    public String toString() {
        return "StudentRank{" +
                "sno='" + sno + '\'' +
                ", sname='" + sname + '\'' +
                ", rank=" + rank +
                '}';
    }
}
