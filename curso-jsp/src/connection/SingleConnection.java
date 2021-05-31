package connection;

import java.sql.Connection;
import java.sql.DriverManager;

/** RESPONSAVEL POR FAZER A CONEXAO COM O BANCO DE DADOS**/

public class SingleConnection {
   
	private static String banco = "jdbc:postgresql://localhost:5432/curso-jsp?autoReconnect=true";
	private static String password = "admin";
	private static String user="postgres";
	private static Connection connection = null;
	
	static {
		conectar();
	}

    public SingleConnection() {
		conectar();
	}
	
	private static void conectar() {
		try {
          
			if(connection == null) {
				Class.forName("org.postgresql.Driver");
				connection = DriverManager.getConnection(banco, user, password);
			    connection.setAutoCommit(false);
			}
			
		} catch (Exception e) {
			throw new RuntimeException("Erro ao conectar com o banco de dados"); 
		}
	}
	
	public static Connection getConnection() {
		return connection;
	}
	
}
