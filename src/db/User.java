package db;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

public class User {
    private String username;
    private String password;

    public String getUsername() {
        return username;
    }

    public User(String username, String password) throws Exception {
        this.username = username;
        this.password = password;

        username = "\'" + username + "\'";
        password = "\'" + password + "\'";

        Connection conn = BaiduDB.connection();
        Statement stm = conn.createStatement();
        ResultSet rs = stm.executeQuery("select * from user where username=" + username + " and password=" + password);
        if (!rs.next()) {
            throw new Exception("no such user");
        }
    }
}
