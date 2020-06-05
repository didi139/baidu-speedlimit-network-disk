package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

class BaiduDB {
    private static Connection conn;

    private static void initialize() throws SQLException, ClassNotFoundException {
        if (conn == null) {
            synchronized (BaiduDB.class) {
                if (conn == null) {
                    Class.forName("org.sqlite.JDBC");
                    conn = DriverManager.getConnection("jdbc:sqlite:baidu.db");
                    conn.setAutoCommit(false);
                }
            }
        }
    }

    public static Connection getConn() throws SQLException, ClassNotFoundException {
        initialize();
        return conn;
    }

    private BaiduDB() {
    }
}
