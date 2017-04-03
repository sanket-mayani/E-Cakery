// this class will be used when the user picks or add product to the cart then further 
	// details of tht product in the cart : as ex quantity and etc will be handled by
	// this Item class

package model;

public class Item {
	
	private Product product;
	private int quantity;
	
	
	public Item(){}
	
	public void setProduct(Product p)
		{
			product =p;
		}
	
	public Product getProduct()
		{ 
			return product; 
		}
	
	public void setQuantity(int quantity)
		{
			this.quantity=quantity;
		}
	
	public int getQuantity()
		{
			return quantity;
		}
	
}
