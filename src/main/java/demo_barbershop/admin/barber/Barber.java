package demo_barbershop.admin.barber;

import java.util.*;

public class Barber {
	private int barberId;
	private String fullName;
	private String email;
	private String phoneNum;
	private String address;
	private String status;	
    private List<BarberService> services = new ArrayList<>();
    
    public Barber() {}
    
	// constructor
	public Barber(int barberId, String fullName, String email, String phoneNum, String address, String status) {
		super();
		this.barberId = barberId;
		this.fullName = fullName;
		this.email = email;
		this.phoneNum = phoneNum;
		this.address = address;
		this.status = status;
	}
    
	// getter and setter for barber ID
	public int getBarberId() {
		return barberId;
	}

	public void setBarberId(int barberId) {
		this.barberId = barberId;
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
	
    // getter and setter for status
    public String getStatus() {
        return status;
    }
    public void setStatus(String status) {
        this.status = status;
    }
    
    // getter and setter for services
    public List<BarberService> getServices() {
        return services;
    }

    public void setServices(List<BarberService> services) {
        this.services = services;
    }
}
