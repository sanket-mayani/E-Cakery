package model;

public class Seller {
	
	private int sid;
	private String name;
	private String un;
	private String pw;
	private String vatid;
	private String pan;
	private String accno;
	private int pincode;
	private long mobile;
	
	public long getMobile() {
		return mobile;
	}
	public void setMobile(long mobile) {
		this.mobile = mobile;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getPincode() {
		return pincode;
	}
	public void setPincode(int pincode) {
		this.pincode = pincode;
	}
	public String getVatid() {
		return vatid;
	}
	public void setVatid(String vatid) {
		this.vatid = vatid;
	}
	public String getPan() {
		return pan;
	}
	public void setPan(String pan) {
		this.pan = pan;
	}
	public String getAccno() {
		return accno;
	}
	public void setAccno(String accno) {
		this.accno = accno;
	}
	
	public int getSid() {
		return sid;
	}
	public void setSid(int sID) {
		sid = sID;
	}
	public String getUn() {
		return un;
	}
	public void setUn(String un) {
		this.un = un;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	

}
