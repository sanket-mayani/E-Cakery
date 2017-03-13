package model;

import java.util.HashSet;
import java.util.Set;

public class Product {
	
	private int pid;
	private String name;
	private String description;
	private float price;
	private int image_id;
	private String tier;
	private Flavour flavour;
	private Seller seller;
	private Set<Category> categories = new HashSet<Category>(0);
	private String quantity;
	
	public int getPid() {
		return pid;
	}
	public void setPid(int pid) {
		this.pid = pid;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public float getPrice() {
		return price;
	}
	public void setPrice(float price) {
		this.price = price;
	}
	public int getImage_id() {
		return image_id;
	}
	public void setImage_id(int i) {
		this.image_id = i;
	}
	public String getTier() {
		return tier;
	}
	public void setTier(String tier) {
		this.tier = tier;
	}
	public Flavour getFlavour() {
		return flavour;
	}
	public void setFlavour(Flavour flavour) {
		this.flavour = flavour;
	}
	public Seller getSeller() {
		return seller;
	}
	public void setSeller(Seller seller) {
		this.seller = seller;
	}
	public String getQuantity() {
		return quantity;
	}
	public Set<Category> getCategories() {
		return categories;
	}
	public void setCategories(Set<Category> categories) {
		this.categories = categories;
	}
	public void setQuantity(String quantity) {
		this.quantity=quantity;
	}
	
}
