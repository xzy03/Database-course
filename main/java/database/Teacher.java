package database;

public class Teacher {
    private String tno;
    private String tname;
    private String tsex;
    private Integer tbirth;
    private String tposition;
    private String tphone;

    // Getter and Setter for tno
    public String getTno() {
        return tno;
    }

    public void setTno(String tno) {
        this.tno = tno;
    }

    // Getter and Setter for tname
    public String getTname() {
        return tname;
    }

    public void setTname(String tname) {
        this.tname = tname;
    }

    // Getter and Setter for tsex
    public String getTsex() {
        return tsex;
    }

    public void setTsex(String tsex) {
        this.tsex = tsex;
    }

    // Getter and Setter for tbirth
    public Integer getTbirth() {
        return tbirth;
    }

    public void setTbirth(Integer tbirth) {
        this.tbirth = tbirth;
    }

    // Getter and Setter for tposition
    public String getTposition() {
        return tposition;
    }

    public void setTposition(String tposition) {
        this.tposition = tposition;
    }

    // Getter and Setter for tphone
    public String getTphone() {
        return tphone;
    }

    public void setTphone(String tphone) {
        this.tphone = tphone;
    }

    @Override
    public String toString() {
        return "Teacher{" +
                "tno='" + tno + '\'' +
                ", tname='" + tname + '\'' +
                ", tsex='" + tsex + '\'' +
                ", tbirth=" + tbirth +
                ", tposition='" + tposition + '\'' +
                ", tphone='" + tphone + '\'' +
                '}';
    }
}
