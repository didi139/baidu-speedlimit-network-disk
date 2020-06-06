package dao;

import bean.AssetBean;

import java.io.*;
import java.sql.*;
import java.util.ArrayList;

public class Asset {
    private static boolean initialized = false;

    private static void initialize() throws SQLException, ClassNotFoundException {
        if (!initialized) {
            synchronized (BaiduDB.getConn()) {
                if (!initialized) {
                    try (Statement stmt = BaiduDB.getConn().createStatement()) {
                        stmt.execute(
                                "create table if not exists asset(" +
                                        "id integer," +
                                        "owner integer," +
                                        "filename text," +
                                        "size integer," +
                                        "create_time text," +
                                        "data none," +
                                        "primary key(id)," +
                                        "foreign key (owner) references user(id)," +
                                        "unique (filename)," +
                                        "check (filename not null)" +
                                        ")"
                        );
                        initialized = true;
                    }
                }
            }
        }
    }

    public static boolean exist(int userId, String filename) throws SQLException, ClassNotFoundException {
        initialize();
        try (PreparedStatement preStmt = BaiduDB.getConn()
                .prepareStatement("select * from asset where owner=? and filename=?")) {
            preStmt.setInt(1, userId);
            preStmt.setString(2, filename);
            try (ResultSet rs = preStmt.executeQuery()) {
                return rs.next();
            }
        }
    }

    public static void create(int userId, String filename, byte[] data) throws ClassNotFoundException, SQLException, FileExistException {
        initialize();
        if (exist(userId, filename)) {
            throw new FileExistException();
        }
        synchronized (BaiduDB.getConn()) {
            try (PreparedStatement preStmt = BaiduDB.getConn()
                    .prepareStatement("insert into asset values(null,?,?,?,datetime(current_timestamp, 'localtime'),?)")) {
                preStmt.setInt(1, userId);
                preStmt.setString(2, filename);
                preStmt.setInt(3, data.length);
                preStmt.setBytes(4, data);
                preStmt.executeUpdate();
            }
        }
    }

    public static void update(int userId, String filename, byte[] data) throws ClassNotFoundException, SQLException, FileNoExistException {
        initialize();
        synchronized (BaiduDB.getConn()) {
            try (PreparedStatement preStmt = BaiduDB.getConn()
                    .prepareStatement("update asset set data=? where owner=? and filename=?")) {
                preStmt.setInt(1, userId);
                preStmt.setString(2, filename);
                preStmt.setBytes(3, data);
                if (preStmt.executeUpdate() == 0) {
                    throw new FileNoExistException();
                }
            }
        }
    }

    public static void delete(int userId, String filename) throws SQLException, ClassNotFoundException, FileNoExistException {
        initialize();
        if (!exist(userId, filename)) {
            throw new FileNoExistException();
        }
        synchronized (BaiduDB.getConn()) {
            try (PreparedStatement preStmt = BaiduDB.getConn()
                    .prepareStatement("delete from asset where owner=? and filename=?")) {
                preStmt.setInt(1, userId);
                preStmt.setString(2, filename);
                preStmt.executeUpdate();
            }
        }
    }

    public static AssetBean[] list(int userId) throws SQLException, ClassNotFoundException {
        initialize();
        try (PreparedStatement preStmt = BaiduDB.getConn()
                .prepareStatement("select * from asset where owner=?")) {
            preStmt.setInt(1, userId);
            ArrayList<AssetBean> list = new ArrayList<>();
            try (ResultSet rs = preStmt.executeQuery()) {
                while (rs.next()) {
                    AssetBean asset = new AssetBean();
                    asset.setName(rs.getString("filename"));
                    asset.setSize(rs.getInt("size"));
                    asset.setCreatedTime(rs.getString("create_time"));
                    list.add(asset);
                }
                return list.toArray(new AssetBean[0]);
            }
        }
    }

    public static void outputFile(int userId, String filename, OutputStream os) throws SQLException, ClassNotFoundException, FileNoExistException, IOException {
        initialize();
        try (PreparedStatement preStmt = BaiduDB.getConn()
                .prepareStatement("select data from asset where owner=? and filename=? limit 1")) {
            preStmt.setInt(1, userId);
            preStmt.setString(2, filename);
            try (ResultSet rs = preStmt.executeQuery()) {
                if (!rs.next()) {
                    throw new FileNoExistException();
                }
                InputStream is = rs.getBinaryStream(1);
                byte[] b = new byte[1024];
                int len = 0;
                while ((len = is.read(b)) > 0) {
                    os.write(b, 0, len);
                }
                System.out.println(len);
            }
        }
    }

    private Asset() {
    }

    public static class FileExistException extends Exception {
    }

    public static class FileNoExistException extends Exception {
    }
}
