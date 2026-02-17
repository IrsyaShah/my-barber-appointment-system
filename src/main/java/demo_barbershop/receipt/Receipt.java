package demo_barbershop.receipt;

import java.sql.*;
import java.time.*;
import java.util.*;

import demo_barbershop.admin.appointment.AppointmentService;

public class Receipt {	
    private int receiptId;
    private String paymentName;
    private double totalAmount;
    private Timestamp issuedDate;
    private String customerName;
    private String barberName;
    private String barberPhone;
    private LocalDate appointmentDate;
    private LocalTime startTime;
    private LocalTime finishTime;
    private String remarks;
    private List<AppointmentService> services;
    
    // getter and setter for receipt ID
	public int getReceiptId() {
		return receiptId;
	}
	
	public void setReceiptId(int receiptId) {
		this.receiptId = receiptId;
	}
	
	// getter and setter for payment name
	public String getPaymentName() {
		return paymentName;
	}
	
	public void setPaymentName(String paymentName) {
		this.paymentName = paymentName;
	}
	
	// getter and setter for total amount
	public double getTotalAmount() {
		return totalAmount;
	}
	
	public void setTotalAmount(double totalAmount) {
		this.totalAmount = totalAmount;
	}
	
	// getter and setter for issued date
	public Timestamp getIssuedDate() {
		return issuedDate;
	}
	
	public void setIssuedDate(Timestamp issuedDate) {
		this.issuedDate = issuedDate;
	}
	
	// getter and setter for customer name
	public String getCustomerName() {
		return customerName;
	}
	
	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}
	
	// getter and setter for barber name
	public String getBarberName() {
		return barberName;
	}
	
	public void setBarberName(String barberName) {
		this.barberName = barberName;
	}
	
	// getter and setter for barber phone no
	public String getBarberPhone() {
		return barberPhone;
	}
	
	public void setBarberPhone(String barberPhone) {
		this.barberPhone = barberPhone;
	}
	
	// getter and setter for appointment date
	public LocalDate getAppointmentDate() {
		return appointmentDate;
	}
	
	public void setAppointmentDate(LocalDate appointmentDate) {
		this.appointmentDate = appointmentDate;
	}
	
	// getter and setter for appointment start
	public LocalTime getStartTime() {
		return startTime;
	}
	
	public void setStartTime(LocalTime startTime) {
		this.startTime = startTime;
	}
	
	// getter and setter for appointment finish
	public LocalTime getFinishTime() {
		return finishTime;
	}
	
	public void setFinishTime(LocalTime finishTime) {
		this.finishTime = finishTime;
	}
	
	// getter and setter for remarks
	public String getRemarks() {
		return remarks;
	}
	
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	
	// getter and setter for selected service
	public List<AppointmentService> getServices() {
		return services;
	}
	
	public void setServices(List<AppointmentService> services) {
		this.services = services;
	}
}
