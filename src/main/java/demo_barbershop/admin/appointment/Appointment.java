package demo_barbershop.admin.appointment;

import java.time.*;
import java.util.*;

public class Appointment {
	private int appointmentId;
	private int customerId;
	private String customerName;
	private String phoneNum;
	private int barberId;
	private String barberName; 
	private LocalDate appointmentDate;
	private LocalTime appointmentStart;
	private LocalTime appointmentFinish;
	private String remarks;
	private String status;
	private List<AppointmentService> services = new ArrayList<>();
	
	public Appointment() {}
	
	// constructor
	public Appointment(int appointmentId, int customerId, int barberId, LocalDate appointmentDate, LocalTime appointmentStart, LocalTime appointmentFinish, String remarks, String status) {
		super();
		this.appointmentId = appointmentId;
		this.customerId = customerId;
		this.barberId = barberId;
		this.appointmentDate = appointmentDate;
		this.appointmentStart = appointmentStart;
		this.appointmentFinish = appointmentFinish;
		this.remarks = remarks;
		this.status = status;	
	}
    
	// getter and setter for appointment ID
	public int getAppointmentId() {
		return appointmentId;
	}

	public void setAppointmentId(int appointmentId) {
		this.appointmentId = appointmentId;
	}
    
	// getter and setter for customer ID
	public int getCustomerId() {
		return customerId;
	}

	public void setCustomerId(int customerId) {
		this.customerId = customerId;
	}
	
    // getter and setter for customer name
	public String getCustomerName() {
		return customerName;
	}

	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}
	
    // getter and setter for phone number
	public String getPhoneNum() {
		return phoneNum;
	}

	public void setPhoneNum(String phoneNum) {
		this.phoneNum = phoneNum;
	}
    
	// getter and setter for barber ID
	public int getBarberId() {
		return barberId;
	}

	public void setBarberId(int barberId) {
		this.barberId = barberId;
	}
    
	// getter and setter for barber name
	public String getBarberName() {
		return barberName;
	}

	public void setBarberName(String barberName) {
		this.barberName = barberName;
	}
    
	// getter and setter for appointment date
	public LocalDate getAppointmentDate() {
		return appointmentDate;
	}

	public void setAppointmentDate(LocalDate appointmentDate) {
		this.appointmentDate = appointmentDate;
	}
    
	// getter and setter for appointment start
	public LocalTime getAppointmentStart() {
		return appointmentStart;
	}

	public void setAppointmentStart(LocalTime appointmentStart) {
		this.appointmentStart = appointmentStart;
	}
    
	// getter and setter for appointment finish
	public LocalTime getAppointmentFinish() {
		return appointmentFinish;
	}

	public void setAppointmentFinish(LocalTime appointmentFinish) {
		this.appointmentFinish = appointmentFinish;
	}
    
	// getter and setter for remarks
	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
    
	// getter and setter for status
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
    // getter and setter for services
    public List<AppointmentService> getServices() {
        return services;
    }

    public void setServices(List<AppointmentService> services) {
        this.services = services;
    }

}
