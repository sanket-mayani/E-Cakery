package model;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

public class Registerdao {

	public void insert(Registervo rvo){
		SessionFactory sf=new Configuration().configure().buildSessionFactory();
		Session s=sf.openSession();
		Transaction tr=s.beginTransaction();

		s.save(rvo);

		tr.commit();

	}
	
	public void insert(Loginvo lvo){
		SessionFactory sf=new Configuration().configure().buildSessionFactory();
		Session s=sf.openSession();
		Transaction tr=s.beginTransaction();

		s.save(lvo);

		tr.commit();

	}
	public void insert(SellerRegistervo srvo){
		SessionFactory sf=new Configuration().configure().buildSessionFactory();
		Session s=sf.openSession();
		Transaction tr=s.beginTransaction();

		s.save(srvo);

		tr.commit();

	}
	public void insert(SellerLoginvo slvo){
		SessionFactory sf=new Configuration().configure().buildSessionFactory();
		Session s=sf.openSession();
		Transaction tr=s.beginTransaction();

		s.save(slvo);

		tr.commit();

	}
	public List<Loginvo> search(Loginvo log)
	{
		SessionFactory sessionFactory= new Configuration().configure().buildSessionFactory();

		Session session = sessionFactory.openSession();

		List<Loginvo> al=new ArrayList<Loginvo>();
		try 
		{
			Transaction tr=session.beginTransaction();
			Query q=session.createQuery("from Loginvo where un='"+log.getUn()+"'");
			al=q.list();
			tr.commit();
		}

		catch (Exception e) 
		{

				e.printStackTrace();

		}
			return al;

}
	public List<SellerLoginvo> search(SellerLoginvo log)
	{
		SessionFactory sessionFactory= new Configuration().configure().buildSessionFactory();

		Session session = sessionFactory.openSession();

		List<SellerLoginvo> al=new ArrayList<SellerLoginvo>();
		try 
		{
			Transaction tr=session.beginTransaction();
			Query q=session.createQuery("from SellerLoginvo where un='"+log.getUn()+"'");
			al=q.list();
			tr.commit();
		}

		catch (Exception e) 
		{

				e.printStackTrace();

		}
			return al;

}
	public List<AdminLoginvo> search(AdminLoginvo log)
	{
		SessionFactory sessionFactory= new Configuration().configure().buildSessionFactory();

		Session session = sessionFactory.openSession();

		List<AdminLoginvo> al=new ArrayList<AdminLoginvo>();
		try 
		{
			Transaction tr=session.beginTransaction();
			Query q=session.createQuery("from AdminLoginvo where un='"+log.getUn()+"'");
			al=q.list();
			tr.commit();
		}

		catch (Exception e) 
		{

				e.printStackTrace();

		}
			return al;

}
}
