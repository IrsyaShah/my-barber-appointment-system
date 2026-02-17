package demo_barbershop.admin.service;

public class Service {
	private int serviceId;
	private String serviceName;
	private double price;
	
	public Service() {}
	
	// constructor
	public Service(int serviceId, String serviceName, double price) {
		super();
		this.serviceId = serviceId;
		this.serviceName = serviceName;
		this.price = price;
	}
    
	// getter and setter for service ID
	public int getServiceId() {
		return serviceId;
	}

	public void setServiceId(int serviceId) {
		this.serviceId = serviceId;
	}
    
	// getter and setter for service name
	public String getServiceName() {
		return serviceName;
	}

	public void setServiceName(String serviceName) {
		this.serviceName = serviceName;
	}
    
	// getter and setter for price
	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}
}
