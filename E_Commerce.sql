CREATE DATABASE E_commerce;

USE E_commerce;

#Query1
CREATE TABLE Supplier
(
Supp_ID int primary key auto_increment,
Supp_Name varchar(30),
Supp_City varchar(40),
Supp_phone varchar(10)
);

CREATE TABLE IF NOT EXISTS Customer
(
Cus_ID int not null,
Cus_Name varchar(20) null default null,
Cus_Phone varchar(10),
Cus_City varchar(30),
Cus_Gender char,
primary key (Cus_ID)
);

CREATE TABLE IF NOT EXISTS Product
(
Pro_ID int not null,
Pro_Name varchar(20) null default null,
Pro_Desc varchar(60) null default null,
Cat_ID int not null,
primary key (Pro_ID),
foreign key (Cat_ID) references category(Cat_ID)
);

CREATE TABLE IF NOT EXISTS Orders
(
Ord_ID int not null,
Ord_Amount int not null,
Ord_Date Date,
Cus_ID int not null,
Prod_ID int not null,
primary key(Ord_ID),
foreign key(Cus_ID) references Customer(Cus_ID),
foreign key(Prod_ID) references Product_Details(Prod_ID)
);

CREATE TABLE IF NOT EXISTS Rating
(
Rat_ID int not null,
Cus_ID int not null,
Supp_ID int not null,
Rat_RatStars int not null,
primary key(Rat_ID),
foreign key(Supp_ID) references Supplier(Supp_ID),
foreign key(Cus_ID) references Customer(Cus_ID)
);

#Query2
insert into Supplier values(1,"Rajesh Retails","Delhi",'1234567890');
insert into Supplier values(2,"Appario Ltd","Mumbai",'2589631470');
insert into Supplier values(3,"Knome Products","Bangalore",'9785462315');
insert into Supplier values(4,"Bansal Retails","Kochi",'8975463285');
insert into Supplier values(5,"Mittal Ltd","Lucknow",'7898456532');

insert into Customer values(1,"Akash",'9999999999',"Delhi",'M');
insert into Customer values(2,"Aman",'9785463215',"Noida",'M');
insert into Customer values(3,"Neha",'9999999999',"Mumbai",'F');
insert into Customer values(4,"Megha",'9994566239',"Kolkata",'F');
insert into Customer values(5,"Pulkit",'7895999999',"Lucknow",'M');

insert into Category values(1,"Books");
insert into Category values(2,"Games");
insert into Category values(3,"Groceries");
insert into Category values(4,"Electronics");
insert into Category values(5,"Clothes");

insert into Product values(1,"GTA V","DFJDJFDJFDJFDJFDJF",2);
insert into Product values(2,"TSHIRT","DFDFJDFJDKFD",5);
insert into Product values(3,"ROG LAPTOP","DFNTTNTNTERND",4);
insert into Product values(4,"OATS","REURENTBTOTH",3);
insert into Product values(5,"HARRY POTTER","NBEMCTHTJTH",1);

insert into Product_Details values(1,1,2,1500);
insert into Product_Details values(2,3,5,30000);
insert into Product_Details values(3,5,1,3000);
insert into Product_Details values(4,2,3,2500);
insert into Product_Details values(5,4,1,1000); 

insert into orders values(50,2000,"2021-10-06",2,1);
insert into orders values(20,1500,"2021-10-12",3,5);
insert into orders values(25,30500,"2021-09-16",4,2);
insert into orders values(26,2000,"2021-10-05",1,1);
insert into orders values(30,3500,"2021-08-16",4,3);

insert into Rating values(1,2,2,4);
insert into Rating values(2,3,4,5);
insert into Rating values(3,4,1,5);
insert into Rating values(4,1,3,2);
insert into Rating values(5,4,5,4);

#Query 3
Select Customer.Cus_Gender, count(Customer.Cus_Gender) as count from Customer
inner join Orders on Customer.Cus_ID = Orders.Cus_ID
Where Orders.ord_Amount >= 3000 group by
Customer.Cus_Gender;

#Query4
Select Orders.*, Product.Pro_Name from Orders, Product_Details,Product 
Where Orders.Cus_ID=2 and 
Orders.Prod_ID=Product_Details.Prod_ID and Product_Details.Prod_ID=Product.pro_ID;

#Query5
Select Supplier.* from Supplier, product_Details where Supplier.Supp_ID in 
(Select Product_Details.Supp_ID from Product_Details group by Product_Details.Supp_ID having
count(Product_Details.Supp_ID) > 1) group by Supplier.Supp_ID;

#Query6
Select Category.* from Orders inner join Product_Details on 
Orders.Prod_ID = Product_Details.Prod_ID inner join Product on 
Product.Pro_ID = Product_Details.Pro_ID inner join Category on
Category.Cat_ID =Product.Cat_ID
having min(Orders.Ord_Amount);

#Query7
Select Product.Pro_id, Product.pro_Name from Orders inner join Product_Details on 
Product_Details.Prod_ID = Orders.Prod_ID inner join Product on 
Product.pro_ID = Product_Details.Pro_ID where Orders.Ord_Date > "2021-10-05";

#Query8
Select Customer.Cus_Name, Customer.Cus_Gender from Customer where
Customer.Cus_Name like 'A%' or Customer.Cus_Name like '%A';

#Query9
/*Select Supplier.Supp_ID, Supplier.Supp_Name, Rating.Rat_RatStars,
case 
 when Rating.Rat_RatStars > 4 then 'Genuine Supplier'
 when Rating.Rat_RatStars > 2 then 'Average Supplier'
 else 'Supplier should not be considered'
end
as verdict from Rating inner join Supplier on Supplier.Supp_ID = Rating.Supp_ID; */

Delimiter $$
create procedure proc1()
begin
Select Supplier.Supp_ID, Supplier.Supp_Name, Rating.Rat_RatStars,
case 
 when Rating.Rat_RatStars > 4 then 'Genuine Supplier'
 when Rating.Rat_RatStars > 2 then 'Average Supplier'
 else 'Supplier should not be considered'
end
as verdict from Rating inner join Supplier on Supplier.Supp_ID = Rating.Supp_ID;
end $$

call proc1;
