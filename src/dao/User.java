package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class User {
    private static boolean initialized = false;

    private static void initialize() throws SQLException, ClassNotFoundException {
        if (!initialized) {
            synchronized (BaiduDB.getConn()) {
                if (!initialized) {
                    Statement stmt = BaiduDB.getConn().createStatement();
                    stmt.execute(
                            "create table if not exists user(" +
                                    "id integer," +
                                    "username text," +
                                    "password text," +
                                    "primary key(id)," +
                                    "check (username not null)," +
                                    "unique (username)" +
                                    ")"
                    );
                    stmt.close();
                    BaiduDB.getConn().commit();
                    initialized = true;
                }
            }
        }
    }

    public static boolean exist(String username) throws SQLException, ClassNotFoundException {
        initialize();
        try (PreparedStatement preStmt = BaiduDB.getConn()
                .prepareStatement("select * from user where username=? limit 1")) {
            preStmt.setString(1, username);
            try (ResultSet rs = preStmt.executeQuery()) {
                return rs.next();
            }
        }
    }

    public static void check(String username, String password) throws SQLException, ClassNotFoundException, InvalidPasswordException, InvalidUsernameException {
        initialize();
        try (PreparedStatement preStmt = BaiduDB.getConn()
                .prepareStatement("select * from user where username=? and password=? limit 1")) {
            preStmt.setString(1, username);
            preStmt.setString(2, password);
            try (ResultSet rs = preStmt.executeQuery()) {
                if (!rs.next()) {
                    if (exist(username)) {
                        throw new InvalidPasswordException();
                    } else {
                        throw new InvalidUsernameException();
                    }
                }
            }
        }
    }

    public static void create(String username, String password) throws SQLException, ClassNotFoundException, UsernameExistException {
        initialize();
        if (exist(username)) {
            throw new UsernameExistException();
        }
        synchronized (BaiduDB.getConn()) {
            try (PreparedStatement preStmt = BaiduDB.getConn()
                    .prepareStatement("insert into user values(null,?,?)")) {
                preStmt.setString(1, username);
                preStmt.setString(2, password);
                preStmt.executeUpdate();
            }
        }
    }

    private User() {
    }

    public static class InvalidUsernameException extends Exception {
    }

    public static class InvalidPasswordException extends Exception {
    }

    public static class UsernameExistException extends Exception {
    }
}
