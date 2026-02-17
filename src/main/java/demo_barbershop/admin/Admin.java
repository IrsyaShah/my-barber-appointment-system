package demo_barbershop.admin;

public class Admin {
	
	private String username;
	private String password;
	private String fullName;
	
	public Admin() {}

	// constructor
	public Admin(String username, String password, String fullName) {
		super();
		this.username = username;
		this.password = password;
		this.fullName = fullName;
	}
    
	// getter and setter for username
	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}
    
	// getter and setter for password
	public String getPassword() {
		return password;
	}
 
	public void setPassword(String password) {
		this.password = password;
	}
    
	// getter and setter for admin name
	public String getFullName() {
		return fullName;
	}

	public void setFullName(String fullName) {
		this.fullName = fullName;
	}
}
