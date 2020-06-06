package utils;

import javax.servlet.http.HttpServletRequest;

public class Cookie {
    public static String getCookieValue(HttpServletRequest req, String name) {
        for (javax.servlet.http.Cookie it : req.getCookies()) {
            if (it.getName().equals(name)) {
                return it.getValue();
            }
        }
        return null;
    }
}
