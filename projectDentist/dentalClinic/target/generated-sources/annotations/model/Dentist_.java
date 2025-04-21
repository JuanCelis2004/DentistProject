package model;

import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;
import model.Schedule;
import model.User;

@Generated(value="EclipseLink-2.7.12.v20230209-rNA", date="2025-04-21T11:02:09")
@StaticMetamodel(Dentist.class)
public class Dentist_ { 

    public static volatile SingularAttribute<Dentist, Schedule> schedule;
    public static volatile SingularAttribute<Dentist, String> specialty;
    public static volatile SingularAttribute<Dentist, Integer> id;
    public static volatile SingularAttribute<Dentist, User> user;

}