package main.java.dto;

import java.sql.Date;

public class Participant {

	private int participantNo;
	private int tripshareNo;
	private String partuserId;
	private Date regDate;
	
	public int getParticipantNo() {
		return participantNo;
	}
	public void setParticipantNo(int participantNo) {
		this.participantNo = participantNo;
	}
	public int getTripshareNo() {
		return tripshareNo;
	}
	public void setTripshareNo(int tripshareNo) {
		this.tripshareNo = tripshareNo;
	}
	public String getPartuserId() {
		return partuserId;
	}
	public void setPartuserId(String partuserId) {
		this.partuserId = partuserId;
	}
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
	
	
	
}
