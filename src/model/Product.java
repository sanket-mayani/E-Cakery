package model;

import java.util.HashSet;
import java.util.Set;

public class Product {
	
	private int pid;
	private String name;
	private String description;
	private float price;
	private String image;
	private int tier;
	private Flavour flavour;
	private Seller seller;
	private Set<Category> categories = new HashSet<Category>(0);
	private int quantity;
	private float weight;
	private float rating;
	private int numOfRatings;
	
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
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public int getTier() {
		return tier;
	}
	public void setTier(int tier) {
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
	public int getQuantity() {
		return quantity;
	}
	public Set<Category> getCategories() {
		return categories;
	}
	public void setCategories(Set<Category> categories) {
		this.categories = categories;
	}
	public void setQuantity(int quantity) {
		this.quantity=quantity;
	}
	public float getWeight() {
		return weight;
	}
	public void setWeight(float weight) {
		this.weight = weight;
	}
	public float getRating() {
		return rating;
	}
	public void setRating(float rating) {
		this.rating = rating;
	}
	public int getNumOfRatings() {
		return numOfRatings;
	}
	public void setNumOfRatings(int numOfRatings) {
		this.numOfRatings = numOfRatings;
	}
	
}
