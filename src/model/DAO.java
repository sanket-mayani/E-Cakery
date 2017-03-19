package model;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;


import org.hibernate.HibernateException;

import javax.servlet.http.HttpSession;

import org.hibernate.Criteria;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Projection;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;

public class DAO {
	
	public Session getSession()
	{
		SessionFactory sf=new Configuration().configure().buildSessionFactory();
		Session session = sf.openSession();
		return session;
	}
	
	public void closeSession(Session session)
	{
		if (session.isOpen())
		{
            session.close();
        }
	}
	
	public void insertUser(User user){
		
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

	public void insertSeller(Seller slvo){
	
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
	
	public void updateSeller(Seller seller){
		
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
	
	public List<User> searchUser(User log)
	{
		Session session = getSession();

		List<User> al=new ArrayList<User>();
		try 
		{
			Transaction tr=session.beginTransaction();
			Query q=session.createQuery("from User where un='"+log.getUn()+"'");
			al=q.list();
			tr.commit();
		}catch(Exception ex){
			System.out.println(ex);
		}finally{
			closeSession(session); 
		}
		return al;

}
	public List<Seller> searchSeller(Seller log)
	{
		Session session = getSession();

		List<Seller> al=new ArrayList<Seller>();
		try 
		{
			Transaction tr=session.beginTransaction();
			Query q=session.createQuery("from Seller where un='"+log.getUn()+"'");
			al=q.list();
			tr.commit();
		}catch(Exception ex){
			System.out.println(ex);
		}finally{
			closeSession(session); 
		}
		return al;

}
	public List<AdminLoginvo> searchAdmin(AdminLoginvo log)
	{
		Session session = getSession();

		List<AdminLoginvo> al=new ArrayList<AdminLoginvo>();
		try 
		{
			Transaction tr=session.beginTransaction();
			Query q=session.createQuery("from Admin where un='"+log.getUn()+"'");
			al=q.list();
			tr.commit();
		}catch(Exception ex){
			System.out.println(ex);
		}finally{
			closeSession(session); 
		}
		return al;

	}
	
	public Flavour searchFlavourByName(String name)
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
		return al.get(0);

	}
	
	public City searchCityByName(String name)
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
		return al.get(0);

	}
	
	public Category searchCategoryByName(String name)
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
		return al.get(0);

	}

	public List<Flavour> getFlavour()
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
		
	public List<City> getCity()
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
		
	public List<Category> getCategory()
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
	
	public List<Product> getProduct()
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
			
	public List<Product> getProducts(Seller seller)
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

	public Product searchProductById(int pid) {
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

		return list.get(0);
	}

	
		
}
