package demo_barbershop.admin.barber;

public class BarberService {
	private int barberId;
	private int serviceId;
	private String serviceName;
	private double price;
	private String skillLevel;
	
	public BarberService() {}
	
	// constructor
	public BarberService(int barberId, int serviceId, String skillLevel) {
		super();
		this.barberId = barberId;
		this.serviceId = serviceId;
		this.skillLevel = skillLevel;
	}
    
	// getter and setter for barber ID
	public int getBarberId() {
		return barberId;
	}

	public void setBarberId(int barberId) {
		this.barberId = barberId;
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
    
	// getter and setter for skill level
	public String getSkillLevel() {
		return skillLevel;
	}

	public void setSkillLevel(String skillLevel) {
		this.skillLevel = skillLevel;
	}	
}
