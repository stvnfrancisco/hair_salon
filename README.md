Hair_Salon by: Steven Francisco                          

As an salon owner you can add, update and delete stylists. You can view, add, update and delete clients. Also, you can
add clients to a stylist. 

username=# CREATE DATABASE hair_salon;
username=# \c hair_salon;
# CREATE TABLE stylists (id serial PRIMARY KEY, name varchar);
# CREATE TABLE clients (id serial PRIMARY KEY, name varchar, stylist_id int);
# CREATE DATABASE hair_salon_test WITH TEMPLATE hair_salon;



