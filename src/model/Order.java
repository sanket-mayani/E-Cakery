//TemporalType.DATE: maps the date as java.sql.Date.
//TemporalType.TIME: maps the date as java.sql.Time.
//TemporalType.TIMESTAMP: maps the date as java.sql.Timestamp.




package model;

import javax.persistence.*;
import java.sql.Time;
import java.sql.Timestamp;
import java.util.Date;

@Entity
public class Order {
	
	private int oid;
	private int quantity;
	private float amount;
	private String fname;
	private String lname;
	private String email;
	private long mobile;
	private String address;
	private int pincode;
	private String Status;
	//private String date;
	//private String time;
	
	private User user;
	private Product product;
	private Seller seller;
	
	// for date and time
	
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Temporal(TemporalType.DATE)
    private Date date;
    @Temporal(TemporalType.TIME)
    private Date time;
    @Temporal(TemporalType.TIMESTAMP)
    private Date dateTime;

    //	
	
	
	
	
	public String getFname() {
		return fname;
	}
	public void setFname(String fname) {
		this.fname = fname;
	}
	public String getLname() {
		return lname;
	}
	public void setLname(String lname) {
		this.lname = lname;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public long getMobile() {
		return mobile;
	}
	public void setMobile(long mobile) {
		this.mobile = mobile;
	}
	
	public Seller getSeller() {
		return seller;
	}
	public void setSeller(Seller seller) {
		this.seller = seller;
	}
	public int getOid() {
		return oid;
	}
	public void setOid(int oid) {
		this.oid = oid;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public float getAmount() {
		return amount;
	}
	public void setAmount(float amount) {
		this.amount = amount;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public int getPincode() {
		return pincode;
	}
	public void setPincode(int pincode) {
		this.pincode = pincode;
	}
	public String getStatus() {
		return Status;
	}
	public void setStatus(String status) {
		Status = status;
	}

/*	
	
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	
*/	
	
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public Product getProduct() {
		return product;
	}
	public void setProduct(Product product) {
		this.product = product;
	}
	
	// for date and time
	
	  public Date getDate() {
	        return date;
	    }

	    public void setDate(Date date) {
	        this.date = date;
	    }

	    public Date getTime() {
	        return time;
	    }

	    public void setTime(Date time) {
	        this.time = time;
	    }

	    public Date getDateTime() {
	        return dateTime;
	    }

	    public void setDateTime(Date dateTime) {
	        this.dateTime = dateTime;
	    }

	    @Override
	    public String toString() {
	        return "DateAndTime{" +
	                "id=" + id +
	                ", date=" + date +
	                ", time=" + time +
	                ", dateTime=" + dateTime +
	                '}';
	    }
	
}
