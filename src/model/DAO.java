package model;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.query.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;

public class DAO {
	
	SessionFactory factory = HibernateUtil.getSessionFactory();
	
	// Methods regarding Session
	
	public Session getSession()
	{
		Session session = factory.openSession();
		return session;
	}
	
	public void closeSession(Session session)
	{	
		session.close();
	}
	
	
	// Methods regarding User
	
	public void updateUser(User user)
	{	
		Session s=getSession();
		
		try{
			Transaction tr=s.beginTransaction();
			s.update(user);
			tr.commit();
		}catch(Exception ex){
			System.out.println(ex);
		}finally{
			closeSession(s); 
		}
	}
	
	
	
	
	public void insertUser(User user)
	{	
		Session s = getSession();
		
		try{
			Transaction tr=s.beginTransaction();
			s.save(user);
			tr.commit();
		}catch(Exception e){
			System.out.println(e);
		}finally{
			closeSession(s);
		}	
	}
	
	public User getUserByEmail(String email)
	{
		Session session = getSession();

		List<User> al=new ArrayList<User>();
		try 
		{
			Transaction tr=session.beginTransaction();
			Query q=session.createQuery("from User where un='"+email+"'");
			al=q.list();
			tr.commit();
		}catch(Exception ex){
			System.out.println(ex);
		}finally{
			closeSession(session); 
		}
		if(!al.isEmpty())
			return al.get(0);
		else
			return null;
	}
	
	
	// Methods regarding Seller

	public void insertSeller(Seller slvo)
	{
		Session s=getSession();
		
		try{
			Transaction tr=s.beginTransaction();
			s.save(slvo);
			tr.commit();
		}catch(Exception ex){
			System.out.println(ex);
		}finally{
			closeSession(s); 
		}

	}
	
	public void updateSeller(Seller seller)
	{	
		Session s=getSession();
		
		try{
			Transaction tr=s.beginTransaction();
			s.update(seller);
			tr.commit();
		}catch(Exception ex){
			System.out.println(ex);
		}finally{
			closeSession(s); 
		}
	}
	
	public Seller getSellerByEmail(String email)
	{
		Session session = getSession();

		List<Seller> al=new ArrayList<Seller>();
		try 
		{
			Transaction tr=session.beginTransaction();
			Query q=session.createQuery("from Seller where un='"+email+"'");
			al=q.list();
			tr.commit();
		}catch(Exception ex){
			System.out.println(ex);
		}finally{
			closeSession(session); 
		}
		if(!al.isEmpty())
			return al.get(0);
		else
			return null;
	}
	
	
	// Methods regarding Admin
	
	public Admin getAdminByEmail(String email)
	{
		Session session = getSession();

		List<Admin> al=new ArrayList<Admin>();
		try 
		{
			Transaction tr=session.beginTransaction();
			Query q=session.createQuery("from Admin where un='"+email+"'");
			al=q.list();
			tr.commit();
		}catch(Exception ex){
			System.out.println(ex);
		}finally{
			closeSession(session); 
		}
		if(!al.isEmpty())
			return al.get(0);
		else
			return null;
	}
	
	
	// Methods regarding Product
	
	public List<Product> getAllProducts()
	{
		Session session = getSession();

		List<Product> products=new ArrayList<Product>();
		try 
		{
			Transaction tr=session.beginTransaction();
			Query q=session.createQuery("from Product");
			products=q.list();
			tr.commit();
		}catch(Exception ex){
			System.out.println(ex);
		}finally{
			closeSession(session); 
		}
		return products;
		
	}

	public List<Product> getProductsBySeller(Seller seller)
	{
		Session session = getSession();
		
		List<Product> list=new ArrayList<Product>();
		try 
		{
			Transaction tr=session.beginTransaction();
			Query q=session.createQuery("from Product where Seller_Id="+seller.getSid());
			list=q.list();
			tr.commit();
		}catch(Exception ex){
			System.out.println(ex);
		}finally{
			closeSession(session); 
		}
			return list;
	}
	
	public void insertProduct(Product product){
		
		Session s=getSession();
		
		try{
			Transaction tr=s.beginTransaction();	
			s.save(product);
			tr.commit();
		}catch(Exception ex){
			System.out.println(ex);
		}finally{
			closeSession(s); 
		}
	}
	
	public void updateProduct(Product product) {
		// TODO Auto-generated method stub
		Session session=getSession();
		
		try{
			Transaction tr=session.beginTransaction();
			session.update(product);
			tr.commit();
		}catch(Exception ex){
			System.out.println(ex);
		}finally{
			closeSession(session); 
		}
	}
	
	public Product getProductById(int pid) {
		// TODO Auto-generated method stub
		
		Session session = getSession();
		
		List<Product> list=new ArrayList<Product>();
		try 
		{
			Transaction tr=session.beginTransaction();
			Query q=session.createQuery("from Product where pid="+pid);
			list=q.list();
			tr.commit();
		}catch(Exception ex){
			System.out.println(ex);
		}finally{
			closeSession(session); 
		}
		if(!list.isEmpty())
			return list.get(0);
		else
			return null;
	}
	
	public int getQuantity(Product product)
	{
		Session session = getSession();
		
		int quantity = 0;
		try 
		{
			Transaction tr=session.beginTransaction();
			Query q=session.createQuery("select quantity from Product where pid="+product.getPid());
			quantity=(int)q.uniqueResult();
			tr.commit();
		}catch(Exception ex){
			System.out.println(ex);
		}finally{
			closeSession(session); 
		}
		return quantity;
	}
	
	
	// Methods regarding Flavour
	
	public Flavour getFlavourByName(String name)
	{
		Session session = getSession();

		List<Flavour> al=new ArrayList<Flavour>();
		try 
		{
			Transaction tr=session.beginTransaction();
			Query q=session.createQuery("from Flavour where name='"+name+"'");
			al=q.list();
			tr.commit();
		}catch(Exception ex){
			System.out.println(ex);
		}finally{
			closeSession(session); 
		}
		if(!al.isEmpty())
			return al.get(0);
		else
			return null;
	}
	
	public List<Flavour> getAllFlavours()
	{
		Session session = getSession();

		List<Flavour> al=new ArrayList<Flavour>();
		try 
		{
			Transaction tr=session.beginTransaction();
			Query q=session.createQuery("from Flavour");
			al=q.list();
			tr.commit();
		}catch(Exception ex){
			System.out.println(ex);
		}finally{
			closeSession(session); 
		}
		return al;
	}
	
	
	// Methods regarding Category
	
	public Category getCategoryByName(String name)
	{
		Session session = getSession();

		List<Category> al=new ArrayList<Category>();
		try 
		{
			Transaction tr=session.beginTransaction();
			Query q=session.createQuery("from Category where name='"+name+"'");
			al=q.list();
			tr.commit();
		}catch(Exception ex){
			System.out.println(ex);
		}finally{
			closeSession(session); 
		}
		if(!al.isEmpty())
			return al.get(0);
		else
			return null;
	}
	
	public List<Category> getAllCategories()
	{
		Session session = getSession();

		List<Category> list=new ArrayList<Category>();
		try 
		{
			Transaction tr=session.beginTransaction();
			Query q=session.createQuery("from Category");
			list=q.list();
			tr.commit();
		}catch(Exception ex){
			System.out.println(ex);
		}finally{
			closeSession(session); 
		}
		return list;
	}	
	
	
	// Methods regarding City
	
	public City getCityByName(String name)
	{
		Session session = getSession();

		List<City> al=new ArrayList<City>();
		try 
		{
			Transaction tr=session.beginTransaction();
			Query q=session.createQuery("from City where name='"+name+"'");
			al=q.list();
			tr.commit();
		}catch(Exception ex){
			System.out.println(ex);
		}finally{
			closeSession(session); 
		}
		if(!al.isEmpty())
			return al.get(0);
		else
			return null;
	}
		
	public List<City> getAllCities()
	{
		Session session = getSession();

		List<City> al=new ArrayList<City>();
		try 
		{
			Transaction tr=session.beginTransaction();
			Query q=session.createQuery("from City");
			al=q.list();
			tr.commit();
		}catch(Exception ex){
			System.out.println(ex);
		}finally{
			closeSession(session); 
		}
		return al;
	}
	
	
	// Methods regarding Order
	
	public boolean placeOrder(Order order)
	{
		Product product = order.getProduct();
		int quantityInDB = getQuantity(product);
		int quantityOrdered = order.getQuantity();
		if(quantityInDB >= quantityOrdered)
		{
			insertOrder(order);
			product.setQuantity(quantityInDB - quantityOrdered);
			updateProduct(product);
			return true;
		}
		else
			return false;
	}
	
	public void insertOrder(Order order)
	{
		Session s=getSession();
		
		try{
			Transaction tr=s.beginTransaction();
			s.save(order);
			tr.commit();
		}catch(Exception ex){
			System.out.println(ex);
		}finally{
			closeSession(s); 
		}
	}
	
	public List<Order> getOrderByUser(User user)
	{
		Session s=getSession();
		
		List<Order> orders = new ArrayList<Order>();
		try{
			Transaction tr=s.beginTransaction();
			Query q=s.createQuery("from Order where user.UID="+user.getUID()+" order by placedAt desc");
			orders=q.list();
			tr.commit();
		}catch(Exception ex){
			System.out.println(ex);
		}finally{
			closeSession(s); 
		}
		
		return orders;
	}

	public List<Order> FetchOrders(Seller seller, String date, String status)
	{
		//This method fetches the orders seller-wise from db where
		//date is the date(of form 'yyyy-MM-dd') for which the records are to be fetched
		//status is the status of the order, possible values - placed, approved, packed, shipped, delivered, cancelled by customer, cancelled by seller
		
		Session s=getSession();
		
		List<Order> orders = new ArrayList<Order>();
		try{
			Transaction tr=s.beginTransaction();
			Query q=s.createQuery("from Order where (seller.sid="+seller.getSid()+" and placedAt like '"+date+"%' and status='"+status+"') order by placedAt desc");
			orders=q.list();
			tr.commit();
		}catch(Exception ex){
			System.out.println(ex);
		}finally{
			closeSession(s); 
		}
		
		return orders;
	}
	
	public Order getOrderByOid(int oid)
	{
		Session s=getSession();
		
		List<Order> orders = null;
		try{
			Transaction tr=s.beginTransaction();
			Query q=s.createQuery("from Order where oid="+oid);
			orders=q.list();
			tr.commit();
		}catch(Exception ex){
			System.out.println(ex);
		}finally{
			closeSession(s); 
		}
		
		if(orders!=null)
			return orders.get(0);
		else
			return null;
	}
	
	public void updateOrder(Order order)
	{
		Session session=getSession();
		
		try{
			Transaction tr=session.beginTransaction();
			session.update(order);
			tr.commit();
		}catch(Exception ex){
			System.out.println(ex);
		}finally{
			closeSession(session); 
		}
	}
	
	// Other Methods
		
	public List<Product> fetchCakes(City city,Flavour flavour,Category category,int start) {
		// TODO Auto-generated method stub
		Session session = getSession();
		
		List<Product> list = new ArrayList<Product>();
		try
		{			
			Transaction tr = session.beginTransaction();
			//Query q=session.createQuery("from Product p where p.seller.city.cid="+city.getCid());
			Criteria cr = session.createCriteria(Product.class);
			cr.createCriteria("seller").add(Restrictions.eq("city.cid", city.getCid()));
			if(flavour != null)
				cr.add(Restrictions.eq("flavour.fid", flavour.getFid()));
			if(category != null)
				cr.createCriteria("categories").add(Restrictions.eq("cid", category.getCid()));
			cr.setFirstResult(start);
			cr.setMaxResults(8);
			list=cr.list();
			tr.commit();
		}catch(Exception ex){
			System.out.println(ex);
		}finally{
			closeSession(session); 
		}
		return list;
	}
	
	public long getMaxPages(City city,Flavour flavour,Category category) {
		// TODO Auto-generated method stub
		Session session = getSession();
		
		long maxPages = 0;
		try
		{
			Transaction tr = session.beginTransaction();
			//int records=((Long)session.createQuery("select count(*) from Product p where p.seller.city.cid="+city.getCid()).uniqueResult()).intValue();
			Criteria cr = session.createCriteria(Product.class);
			cr.setProjection(Projections.rowCount());
			cr.createCriteria("seller").add(Restrictions.eq("city.cid", city.getCid()));
			if(flavour != null)
				cr.add(Restrictions.eq("flavour.fid", flavour.getFid()));
			if(category != null)
				cr.createCriteria("categories").add(Restrictions.eq("cid", category.getCid()));
			
			long records = (long)cr.uniqueResult();
			maxPages = records/8 + (records%8>0?1:0);
			
			tr.commit();
		}catch(Exception ex){
			System.out.println(ex);
		}finally{
			closeSession(session); 
		}
		return maxPages;
	}
	
	public List<Order> getPackedOrders()
	{
		Session session = getSession();

		List<Order> list=new ArrayList<Order>();
		try 
		{
			Transaction tr=session.beginTransaction();
			Query q=session.createQuery("from Order where Status='packed'");
			list=q.list();
			tr.commit();
		}catch(Exception ex){
			System.out.println(ex);
		}finally{
			closeSession(session); 
		}
		return list;
	}	
	public List<Order> getDeliveredOrders()
	{
		Session session = getSession();

		List<Order> list=new ArrayList<Order>();
		try 
		{
			Transaction tr=session.beginTransaction();
			Query q=session.createQuery("from Order where Status='delivered'");
			list=q.list();
			tr.commit();
		}catch(Exception ex){
			System.out.println(ex);
		}finally{
			closeSession(session); 
		}
		return list;
	}	


	
		
}
