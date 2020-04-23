package db;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class BaiduDB {
    private static Connection conn;
    private static final String[] ss = {
            "create table if not exists user(" +
                    "id integer," +
                    "username text not null unique," +
                    "password text," +
                    "primary key(id autoincrement)," +
                    "check (username not null)," +
                    "unique (username)" +
                    ");",
            "create table if not exists resource(" +
                    "id integer," +
                    "data blob," +
                    "primary key(id autoincrement)" +
                    ");",
            "create table if not exists own(" +
                    "user_id integer," +
                    "resource_id integer," +
                    "primary key(user_id, resource_id)" +
                    ");"
    };

    public static Connection connection() {
        if (conn == null) {
            synchronized (BaiduDB.class) {
                if (conn == null) {
                    try {
                        Class.forName("org.sqlite.JDBC");
                        conn = DriverManager.getConnection("jdbc:sqlite:baidu.db");
                        conn.setAutoCommit(false);
                        Statement stm = conn.createStatement();
                        for (String each : ss) {
                            stm.execute(each);
                        }
                        stm.close();
                        conn.commit();
                    } catch (ClassNotFoundException | SQLException e) {
                        throw new RuntimeException(e);
                    }
                }
            }
        }

        return conn;
    }

    private BaiduDB() {
    }
}
