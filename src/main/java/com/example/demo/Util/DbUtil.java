package com.example.demo.Util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DbUtil {


    private static Connection connection = null;

    public static Connection getConnection()  {


        if (connection != null)
            return connection;
        else {
            try {

                connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/songs_api?useSSL=true", "root", "vbellos@123!");
            }catch(Exception e) {
                e.printStackTrace();
            }
            return connection;

        }

    }
}
