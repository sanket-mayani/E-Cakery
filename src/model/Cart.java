// used to add or remove items from the cart
// we will create one arraylist of all the items , aftr tht to add the item we match the pid
//	and increase the quantity or append the item to d list by in built method of list
// same for remove item frm d cart;

package model;

import java.util.ArrayList;

public class Cart 
{
	private ArrayList<Item> items;
	
	public Cart()							// creates a list of items in the cart
	{
		items = new ArrayList<Item>();
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
	
	public void updateQuantity(int pid,int quantity)
	{
		for(int i=0; i<items.size(); i++)
		{
			if(items.get(i).getProduct().getPid() == pid)
			{
				items.get(i).setQuantity(quantity);
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
	
}