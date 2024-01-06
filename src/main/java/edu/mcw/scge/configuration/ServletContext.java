package edu.mcw.scge.configuration;

import org.apache.logging.log4j.Level;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import java.sql.Driver;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Enumeration;

public class ServletContext implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {

    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        Enumeration<Driver> drivers = DriverManager.getDrivers();
        while (drivers.hasMoreElements()) {
            Driver driver = drivers.nextElement();
            try {
                DriverManager.deregisterDriver(driver);
                System.out.println( String.format("deregistering jdbc driver: %s", driver));
            } catch (SQLException e) {
               System.out.println(String.format("Error deregistering driver %s", driver));
            }
        }
    }
}
