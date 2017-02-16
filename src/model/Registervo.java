package model;

public class Registervo {

	private int rid;
	private String fn;
	private String ln;
	private long mob;
	public long getMob() {
		return mob;
	}
	public void setMob(long mob) {
		this.mob = mob;
	}
	Loginvo v;
	public int getRid() {
		return rid;
	}
	public void setRid(int rid) {
		this.rid = rid;
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
	public Loginvo getV() {
		return v;
	}
	public void setV(Loginvo v) {
		this.v = v;
	}
}
