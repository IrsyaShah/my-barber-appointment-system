package demo_barbershop.staff;

public class Staff {	
	private int staffId;
	private String fullName;
	private String email;
	private String phoneNum;
	private String address;
	
	// constructor
	public Staff(int staffId, String fullName, String email, String phoneNum, String address) {
		super();
		this.staffId = staffId;
		this.fullName = fullName;
		this.email = email;
		this.phoneNum = phoneNum;
		this.address = address;
	}
    
	// getter and setter for staff ID
	public int getStaffId() {
		return staffId;
	}

	public void setStaffId(int staffId) {
		this.staffId = staffId;
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
