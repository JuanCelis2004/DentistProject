package model;

import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.7.12.v20230209-rNA", date="2025-04-21T11:02:09")
@StaticMetamodel(Person.class)
public abstract class Person_ { 

    public static volatile SingularAttribute<Person, String> lastName;
    public static volatile SingularAttribute<Person, String> phoneNumber;
    public static volatile SingularAttribute<Person, String> address;
    public static volatile SingularAttribute<Person, String> name;
    public static volatile SingularAttribute<Person, Date> dateBirth;
    public static volatile SingularAttribute<Person, String> dni;
    public static volatile SingularAttribute<Person, String> email;

}