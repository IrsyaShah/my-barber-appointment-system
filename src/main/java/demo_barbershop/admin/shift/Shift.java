package demo_barbershop.admin.shift;

import java.time.*;

public class Shift {
	private int shiftId;
	private int barberId;
	private String dayName;
	private LocalTime shiftStart;
	private LocalTime shiftFinish;
	
	public Shift() {}
	
	// constructor
	public Shift(int shiftId, int barberId, String dayName, LocalTime shiftStart, LocalTime shiftFinish) {
		super();
		this.shiftId = shiftId;
		this.barberId = barberId;
		this.dayName = dayName;
		this.shiftStart = shiftStart;
		this.shiftFinish = shiftFinish;
	}
    
	// getter and setter for shift ID
	public int getShiftId() {
		return shiftId;
	}

	public void setShiftId(int shiftId) {
		this.shiftId = shiftId;
	}
    
	// getter and setter for barber ID
	public int getBarberId() {
		return barberId;
	}

	public void setBarberId(int barberId) {
		this.barberId = barberId;
	}
    
	// getter and setter for day
	public String getDayName() {
		return dayName;
	}

	public void setDayName(String dayName) {
		this.dayName = dayName;
	}
    
	// getter and setter for shift start
	public LocalTime getShiftStart() {
		return shiftStart;
	}

	public void setShiftStart(LocalTime shiftStart) {
		this.shiftStart = shiftStart;
	}
    
	// getter and setter for shift finish
	public LocalTime getShiftFinish() {
		return shiftFinish;
	}

	public void setShiftFinish(LocalTime shiftFinish) {
		this.shiftFinish = shiftFinish;
	}
}
