/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package persistence;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import java.io.Serializable;
import javax.persistence.Query;
import javax.persistence.EntityNotFoundException;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import java.util.List;
import javax.persistence.Persistence;
import model.Dentist;
import persistence.exceptions.NonexistentEntityException;

/**
 *
 * @author juand
 */
public class DentistJpaController implements Serializable {

    public DentistJpaController(EntityManagerFactory emf) {
        this.emf = emf;
    }
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }
    
    public DentistJpaController(){
        emf=Persistence.createEntityManagerFactory("DentistPU");
    }

    public void create(Dentist dentist) {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            em.persist(dentist);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(Dentist dentist) throws NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            dentist = em.merge(dentist);
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                Integer id = dentist.getId();
                if (findDentist(id) == null) {
                    throw new NonexistentEntityException("The dentist with id " + id + " no longer exists.");
                }
            }
            throw ex;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void destroy(Integer id) throws NonexistentEntityException {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Dentist dentist;
            try {
                dentist = em.getReference(Dentist.class, id);
                dentist.getId();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The dentist with id " + id + " no longer exists.", enfe);
            }
            em.remove(dentist);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<Dentist> findDentistEntities() {
        return findDentistEntities(true, -1, -1);
    }

    public List<Dentist> findDentistEntities(int maxResults, int firstResult) {
        return findDentistEntities(false, maxResults, firstResult);
    }

    private List<Dentist> findDentistEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(Dentist.class));
            Query q = em.createQuery(cq);
            if (!all) {
                q.setMaxResults(maxResults);
                q.setFirstResult(firstResult);
            }
            return q.getResultList();
        } finally {
            em.close();
        }
    }

    public Dentist findDentist(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Dentist.class, id);
        } finally {
            em.close();
        }
    }

    public int getDentistCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<Dentist> rt = cq.from(Dentist.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
    
}
