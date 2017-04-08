package model;

public class Deliver {
	
	private int DID;
	private String un;
	private String pw;
	private City city;
	public int getDID() {
		return DID;
	}
	public void setDID(int dID) {
		DID = dID;
	}
	public City getCity() {
		return city;
	}
	public void setCity(City city) {
		this.city = city;
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
