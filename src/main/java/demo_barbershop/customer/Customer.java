package demo_barbershop.customer;

public class Customer {
	private int customerId;
	private String fullName;
	private String email;
	private String password;
	private String phoneNum;
	private String address;
	
	public Customer() {}
	
	// constructor
	public Customer(int customerId, String fullName, String email, String password, String phoneNum, String address) {
		super();
		this.customerId = customerId;
		this.fullName = fullName;
		this.email = email;
		this.password = password;
		this.phoneNum = phoneNum;
		this.address = address;
	}

	// getter and setter for customer ID
	public int getCustomerId() {
		return customerId;
	}

	public void setCustomerId(int customerId) {
		this.customerId = customerId;
	}

	// getter and setter for full name
	public String getFullName() {
		return fullName;
	}

	public void setFullName(String fullName) {
		this.fullName = fullName;
	}

	// getter and setter for email
	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	// getter and setter for password
	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	// getter and setter for phone number
	public String getPhoneNum() {
		return phoneNum;
	}

	public void setPhoneNum(String phoneNum) {
		this.phoneNum = phoneNum;
	}

	// getter and setter for address
	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}
}
