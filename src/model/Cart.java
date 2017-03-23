// used to add or remove items from the cart
// we will create one arraylist of all the items , aftr tht to add the item we match the pid
//	and increase the quantity or append the item to d list by in built method of list
// same for remove item frm d cart;

package model;

import java.util.ArrayList;

public class Cart 
{
	private ArrayList<Item> items;
	City city = null;
	
	public Cart()							// creates a list of items in the cart
	{
		items = new ArrayList<Item>();
	}
	
	public City getCity() {
		return city;
	}

	public void setCity(City city) {
		this.city = city;
	}

	public void setItems(ArrayList<Item> items) {
		this.items = items;
	}
	
	public ArrayList<Item> getItems()          // return tht list of items in the cart rit now
	{
		return items;
	}
	
	public int getCount()
	{
		return items.size();
	}
	
	public void addItem(Item item)
	{
		if(contains(item.getProduct()))
			updateQuantity(item.getProduct().getPid(),item.getQuantity());
		else
			items.add(item);
	}
	
	
	public void removeItem(Item item)
	{
		for(Item i:items)
		{
			if(i.getProduct().getPid() == item.getProduct().getPid()){
				items.remove(i);
				break;
			}
		}
	}

	
// quantity cn not be updated if stock is limited than wht is entered by the user , so implmnting tht
// test case below here
	
	public void updateQuantity(int pid,int quantity)
	{
		for(int i=0; i<items.size(); i++)
		{
			if(items.get(i).getProduct().getPid() == pid)
			{	
				Product product =items.get(i).getProduct();      // getting product object related to item
				
				int QuantityInDatabase = product.getQuantity();   
													// getting quantity frm db of this product 
				
				if(QuantityInDatabase >= quantity)
				{
				items.get(i).setQuantity(quantity);
				}
				
				else { 
					// we ve to pass a msg tht only 'QuantityInDatabase' in stock in red letters 
					// do this sanket
					}
				}
			}
	}
	
	
	public Item getItemByPid(int pid)
	{
		for(Item i:items)
		{
			if(i.getProduct().getPid() == pid)
				return i;
		}
		
		return null;
	}
	
	
	public boolean contains(Product product)
	{
		for(Item i:items)
		{
			if(i.getProduct().getPid() == product.getPid())
				return true;
		}
		return false;
	}
	
	public float getCartTotal()
	{
		float total = 0;
		for(Item i : items)
		{
			total += i.getProduct().getPrice() * i.getQuantity();
		}
		return total;
	}
	
	public int getTotalQuantity()
	{
		int total = 0;
		for(Item i : items)
		{
			total += i.getQuantity();
		}
		return total;
	}
	
}