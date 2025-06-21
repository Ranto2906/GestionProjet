package connect;

import java.sql.Connection;
import java.sql.DriverManager;

public class Connexion {
    public static Connection openConnection() throws Exception {
        Connection connection = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            String url = "jdbc:mysql://localhost:3306/piciculture?serverTimezone=UTC";
            String user = "root";
            String password = "root";

            connection = DriverManager.getConnection(url, user, password);
        } catch (Exception e) {
            throw new Exception("Erreur de connexion à la base de données : " + e.getMessage());
        }
        return connection;
    }
}