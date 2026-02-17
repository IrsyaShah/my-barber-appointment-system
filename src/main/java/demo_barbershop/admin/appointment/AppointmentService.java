package demo_barbershop.admin.appointment;

public class AppointmentService {
	private int appointmentId;
	private int serviceId;
    private String serviceName;
    private double price;
	
	public AppointmentService() {}
    
	// constructor
	public AppointmentService(int appointmentId, int serviceId) {
		super();
		this.appointmentId = appointmentId;
		this.serviceId = serviceId;
	}
    
	// getter and setter for appointment ID
	public int getAppointmentId() {
		return appointmentId;
	}

	public void setAppointmentId(int appointmentId) {
		this.appointmentId = appointmentId;
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
