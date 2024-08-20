package database;

public class User {
    private String account;
    private String password;
    private String identify;

    // 无参数构造函数
    public User() {}

    // 有参数构造函数
    public User(String account, String password, String identify) {
        this.account = account;
        this.password = password;
        this.identify = identify;
    }

    // Getter 和 Setter 方法
    public String getAccount() {
        return account;
    }

    public void setAccount(String account) {
        this.account = account;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getIdentify() {
        return identify;
    }

    public void setIdentify(String identify) {
        this.identify = identify;
    }

    @Override
    public String toString() {
        return "BaocUser{" +
                "account='" + account + '\'' +
                ", password='" + password + '\'' +
                ", identify='" + identify + '\'' +
                '}';
    }
}
