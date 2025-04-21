package model;

import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;
import model.Dentist;
import model.Patient;

@Generated(value="EclipseLink-2.7.12.v20230209-rNA", date="2025-04-21T11:02:09")
@StaticMetamodel(Turn.class)
public class Turn_ { 

    public static volatile SingularAttribute<Turn, Date> date;
    public static volatile SingularAttribute<Turn, Date> treatment;
    public static volatile SingularAttribute<Turn, Patient> patient;
    public static volatile SingularAttribute<Turn, Integer> id;
    public static volatile SingularAttribute<Turn, Dentist> dentist;

}