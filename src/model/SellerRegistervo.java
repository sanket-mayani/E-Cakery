package model;

public class SellerRegistervo {

	private int srid;
	private String fn;
	private String ln;
	private long mob;
	public long getMob() {
		return mob;
	}
	public void setMob(long mob) {
		this.mob = mob;
	}
	SellerLoginvo v;
	public int getSrid() {
		return srid;
	}
	public void setSrid(int srid) {
		this.srid = srid;
	}
	public String getFn() {
		return fn;
	}
	public void setFn(String fn) {
		this.fn = fn;
	}
	public String getLn() {
		return ln;
	}
	public void setLn(String ln) {
		this.ln = ln;
	}
	public SellerLoginvo getV() {
		return v;
	}
	public void setV(SellerLoginvo v) {
		this.v = v;
	}
}
