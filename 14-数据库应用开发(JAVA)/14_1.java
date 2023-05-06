import java.sql.*;

public class Client {
    public static void main(String[] args) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;

        try 
        {
            Class.forName( "com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/finance?useUnicode=true&characterEncoding=UTF8&useSSL=false&serverTimezone=UTC",  "root", "123123");
            statement = connection.createStatement();
            resultset = statement.executeQuery("select c_name,c_mail,c_phone from client where c_mail is not NULL");
            System.out.println("姓名\t邮箱\t\t\t\t电话");
            while (resultset.next()) {  
                System.out.print(resultset.getString("c_name") + "\t");  
                System.out.print(resultset.getString("c_mail") + "\t\t");  
                System.out.println(resultset.getString("c_phone"));   
            }
        } catch (ClassNotFoundException e) {
            System.out.println("Sorry,can`t find the JDBC Driver!"); 
            e.printStackTrace();
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
                }
                if (statement != null) {
                    statement.close();
                }

                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException throwables) {
                throwables.printStackTrace();
            }
        }
    }
}
