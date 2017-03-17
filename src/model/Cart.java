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
	
	public void addItem(Item item)        // ultimately increasing the quantity
	{
		int pid = item.getProduct().getPid();
		
		int quantity = item.getQuantity();
		
		for(int i=0; i<items.size(); i++)
		{
			
			Item itemm =items.get(i);  // this method returns the elemnt at specified positin in the list "items"
			
			if(itemm.getProduct().getPid() == pid)     // comapring the pids
			{
				itemm.setQuantity(quantity);
				return;     // if so then finish or return
			}
		}
		
		items.add(item);    // this method append the specified elemnt to d end of the list
	}
	
	
	public void removeItem(Item item)
	{
			int pid = item.getProduct().getPid();
		
			int quantity = item.getQuantity();
		
		for(int i=0; i<items.size(); i++)
		{
			
			Item itemm =items.get(i);  // this method returns the elemnt at specified positin in the list "items"
			
			if(itemm.getProduct().getPid() == pid)     // comapring the pids
			{
				items.remove(i);     // removing the item frm d list of specified positin and other elmnts shifts automatically
				return;
			}
	
	}
	
	}
}