package model;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

public class DAO {
	
	public void insertUser(User user){
		SessionFactory sf=new Configuration().configure().buildSessionFactory();
		Session s=sf.openSession();
		Transaction tr=s.beginTransaction();

		s.save(user);

		tr.commit();

	}

	public void insertSeller(Seller slvo){
		SessionFactory sf=new Configuration().configure().buildSessionFactory();
		Session s=sf.openSession();
		try{
		Transaction tr=s.beginTransaction();

		s.save(slvo);

		tr.commit();
		}catch(Exception ex){
			
		}finally{
			 if (s.isOpen()){
	                s.close();
	            }
		}

	}
	
	public void insertProduct(Product product){
		SessionFactory sf=new Configuration().configure().buildSessionFactory();
		Session s=sf.openSession();
		Transaction tr=s.beginTransaction();

		s.save(product);

		tr.commit();

	}
	
	public void updateSeller(Seller seller){
		SessionFactory sf=new Configuration().configure().buildSessionFactory();
		Session s=sf.openSession();
		try{
			Transaction tr=s.beginTransaction();
	
			s.update(seller);
	
			tr.commit();
		}catch(Exception ex){
			
		}finally{
			 if (s.isOpen()){
	                s.close();
	            }
		}
	}
	
	public List<User> searchUser(User log)
	{
		SessionFactory sessionFactory= new Configuration().configure().buildSessionFactory();

		Session session = sessionFactory.openSession();

		List<User> al=new ArrayList<User>();
		try 
		{
			Transaction tr=session.beginTransaction();
			Query q=session.createQuery("from User where un='"+log.getUn()+"'");
			al=q.list();
			tr.commit();
		}

		catch (Exception e) 
		{

				e.printStackTrace();

		}
			return al;

}
	public List<Seller> searchSeller(Seller log)
	{
		SessionFactory sessionFactory= new Configuration().configure().buildSessionFactory();

		Session session = sessionFactory.openSession();

		List<Seller> al=new ArrayList<Seller>();
		try 
		{
			Transaction tr=session.beginTransaction();
			Query q=session.createQuery("from Seller where un='"+log.getUn()+"'");
			al=q.list();
			tr.commit();
		}

		catch (Exception e) 
		{

				e.printStackTrace();

		}finally{
			 if (session.isOpen()){
	                session.close();
	            }
		}
			return al;

}
	public List<AdminLoginvo> searchAdmin(AdminLoginvo log)
	{
		SessionFactory sessionFactory= new Configuration().configure().buildSessionFactory();

		Session session = sessionFactory.openSession();

		List<AdminLoginvo> al=new ArrayList<AdminLoginvo>();
		try 
		{
			Transaction tr=session.beginTransaction();
			Query q=session.createQuery("from Admin where un='"+log.getUn()+"'");
			al=q.list();
			tr.commit();
		}

		catch (Exception e) 
		{

				e.printStackTrace();

		}
			return al;

}
	public List<Flavour> searchFlavour(Flavour flavour)
	{
		SessionFactory sessionFactory= new Configuration().configure().buildSessionFactory();

		Session session = sessionFactory.openSession();

		List<Flavour> al=new ArrayList<Flavour>();
		try 
		{
			Transaction tr=session.beginTransaction();
			Query q=session.createQuery("from Flavour where name='"+flavour.getName()+"'");
			al=q.list();
			tr.commit();
		}

		catch (Exception e) 
		{

				e.printStackTrace();

		}
			return al;

		}
	public List<City> searchCity(City city)
	{
		SessionFactory sessionFactory= new Configuration().configure().buildSessionFactory();

		Session session = sessionFactory.openSession();

		List<City> al=new ArrayList<City>();
		try 
		{
			Transaction tr=session.beginTransaction();
			Query q=session.createQuery("from City where name='"+city.getName()+"'");
			al=q.list();
			tr.commit();
		}catch(Exception ex){
		
		}finally{
			 if (session.isOpen()){
	                session.close();
	            }
		}
			return al;

		}

		public List<Flavour> getFlavour()
		{
			SessionFactory sessionFactory= new Configuration().configure().buildSessionFactory();

			Session session = sessionFactory.openSession();

			List<Flavour> al=new ArrayList<Flavour>();
		try 
		{
			Transaction tr=session.beginTransaction();
			Query q=session.createQuery("from Flavour");
			al=q.list();
			tr.commit();
		}

		catch (Exception e) 
		{

				e.printStackTrace();

		}
			return al;

		}
		
		public List<City> getCity()
		{
			SessionFactory sessionFactory= new Configuration().configure().buildSessionFactory();

			Session session = sessionFactory.openSession();

			List<City> cities=new ArrayList<City>();
			try 
			{
				Transaction tr=session.beginTransaction();
				Query q=session.createQuery("from City");
				cities=q.list();
				tr.commit();
			}
	
			catch (Exception e) 
			{
	
					e.printStackTrace();
	
			}
			return cities;

		}
		
}
