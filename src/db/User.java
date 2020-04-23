package db;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class User {
    private String username;
    private String password;

    public String getUsername() {
        return username;
    }

    public static User get(String username, String password) throws SQLException {
        Connection conn = BaiduDB.connection();
        Statement stm = conn.createStatement();
        ResultSet rs = stm.executeQuery("select * from user where username=\'" + username + "\' and password=\'" + password + "\'");
        if (!rs.next()) {
            return null;
        } else {
            return new User(username, password);
        }
    }

    public static void add(String username, String password) throws SQLException {
        Connection conn = BaiduDB.connection();
        Statement stm = conn.createStatement();
        stm.execute("insert into user values (null, \'" + username + "\', \'" + password + "\')");
        stm.close();
        conn.commit();
    }

    private User(String username, String password) {
        this.username = username;
        this.password = password;
    }

    public static void main(String[] args) throws SQLException {
        add("13", "45");
    }
}
