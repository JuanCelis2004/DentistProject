package model;

import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;
import model.Responsible;
import model.User;

@Generated(value="EclipseLink-2.7.12.v20230209-rNA", date="2025-04-21T11:02:09")
@StaticMetamodel(Patient.class)
public class Patient_ { 

    public static volatile SingularAttribute<Patient, Responsible> responsible;
    public static volatile SingularAttribute<Patient, Boolean> eps;
    public static volatile SingularAttribute<Patient, Integer> id;
    public static volatile SingularAttribute<Patient, User> user;

}