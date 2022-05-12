create database billm
use billm

drop table product
drop table categoryList
drop table vendors
drop table sales
drop table billMaster
drop table customers
drop table statusMaster
drop table
--------------------
create table statusMaster (
statusid int constraint pksid primary key,
statuss varchar(30) constraint uqstat unique constraint nnstat not null
)

select * from statusMaster

insert into statusMaster values (1,'Active'),(0,'Deactive')

--------------------------

create table vendors (
vid int constraint pkvid primary key,
vendor varchar(30) constraint uqvend unique constraint nnvend not null
)

select * from vendors

insert into vendors (vid,vendor) values (111,'Random Repairs'),(112,'Mystery Meats Co.'),(113,'Table Your Needs'),
(114,'Spilling The Beans Inc.'),(115,'Maxxx Energy'),(116,'WeHeartShoes'),(117,'Zeal Wheels'),(118,'Vortex Solar'),
(119,'Erudite Learning'),(120,'Wildflowers')

insert into vendors (vid,vendor) values (132,'Nokia'),(122,'Nike'),(123,'Puma'),(124,'Fern Petals'),(125,'Byjus'),
(126,'Schoolrite'),(128,'Suguna Chicken'),(129,'Wipro Lights'),(130,'Nilkamal Furnitures'),(131,'Honda Accessories')

---------------------------
drop table categoryList
create table categoryList (
catid int constraint pkcat primary key,
category varchar(30) constraint uqcat unique constraint nncat not null
)

insert into categoryList (catid,category) values (1120,'Mobiles'),(1112,'Poultry'),(1113,'Furnitures'),(1114,'Power & Decoration'),
(1115,'Footwear'),(1116,'Vehicle Accessories'),(1117,'Solar'),(1118,'Children & Learning'),(1119,'Flowers')

select * from categoryList
select * from vendors
-------------------------------

create table product (
pid int constraint pkpid primary key,
pname varchar(30) constraint nnpname not null,
pimage int,
vendorid int constraint fkvid references vendors(vid),
catid int constraint fkcatid references categoryList(catid),
price money,
quantity int,
profitPercentage money
)

select * from product

insert into product (pid,pname,pimage,vendorid,catid,price,quantity,profitPercentage) values
(11023,'Nokia 1200',23,132,1120,20000,9000,500),(11002,'Meat',2,112,1112,100,900,50),
(11003,'Plumbing Pipe',3,111,1111,499,1200,33),(11004,'Bean Bag',4,113,1113,6000,9500,78),
(11005,'Tea Table',5,113,1113,1500,50000,60),(11006,'Solar Panels',6,118,1117,1000,400,66),
(11007,'Brown Loafers',7,116,1115,200,6000,95),(11008,'Reebok Shoes',8,116,1115,9000,800,22),
(11009,'Roses',9,120,1119,210,88800,15),(11010,'Smart Light',10,115,1114,8000,500,53),
(11011,'Car Cover',11,117,1116,5000,22500,10),(11012,'Decorative Lamp',12,115,1114,4000,1200,41),
(11013,'Arm Chair',13,113,1113,10,45400,10),(11014,'Canned Meat',14,112,1112,540,200,30),
(11015,'Beans',15,113,1113,540,200,30),(11016,'School Board',16,126,1118,1120,500,24.05),
(11017,'Learning Tab',17,125,1118,25000,2000,20000),(11018,'Learning Tab Mini',18,125,1118,2500,2000,2000),
(11019,'Lavender Fragrance',19,124,1111,825,5000,400),(11020,'Lavender Flowers',20,124,1119,525,5000,400),
(11021,'Plastic Chair',21,130,1113,500,5000,225),(11022,'Plastic Resting Chair',22,130,1113,950,3500,505)

delete from product

---------------------------------------

create table payment(
modeid int constraint pkpayid primary key,
mode varchar(20) constraint uqmode unique constraint nnmode not null
)

insert into payment (modeid,mode) values (1,'Net Banking'),(2,'UPI'),(3,'Debit/CC card'),(4,'Cash')

select * from payment

----------------------------------------

create table customers (
cid int constraint pkcid primary key,
name varchar(30) constraint nnname not null,
email varchar(30) constraint nnemailnot null,
mobile bigint constraint nnmob not null,
address varchar(30) constraint nnaddress not null,
password varchar(30) constraint nnpass not null,
statusid int constraint fksid foreign key references statusMaster(statusid)
)

drop table customers

select * from customers

insert into customers (cid,name,email,mobile,address,password,statusid) values
(01,'mo ma','mo.ma@gmail.com',9876543210,'Mysore','Excel2',1),
(02,'shamail','shamail@gmail.com',9876543211,'Mysore','Excel2',0),
(03,'shama','shama@gmail.com',9876543212,'Tumkur','Excel2',1),
(04,'nateeqa','nateeqa@gmail.com',9876543213,'Kollegal','Excel2',1),
(05,'nateeq','nateeq@gmail.com',9876543214,'Mandya','Excel2',1),
(06,'vignesh','vg@gmail.com',9876543215,'Mysore','Excel2',0),
(07,'ajay','ajay@gmail.com',9876543216,'Melgavi','Excel2',1),
(08,'rohan','rohan@gmail.com',9876543217,'Mangalore','Excel2',1),
(09,'jyothi','jyothi@gmail.com',9876543218,'Ckmagalaur','Excel2',1),
(10,'jeevan','jeevan@gmail.com',9876543219,'Hassan','Excel2',1),
(11,'Shashi','shashi@gmail.com',9876543201,'Kollegal','Excel2',0),
(12,'ali','ali@gmail.com',9876543202,'Chamrajanagr','Excel2',1),
(13,'subi','subi@gmail.com',9876543203,'Tunkur','Excel2',1),
(14,'aima','aima@gmail.com',9876543204,'Mandya','Excel2',0),
(15,'khateeb','khateeb@gmail.com',9876543205,'Mangalore','Excel2',0)

select * from customers
---------------------------------------

create table billMaster (
billid int constraint pkbid primary key,
dos date constraint defdos default(getdate()),
cid int constraint fkcid foreign key references customers(cid),
paymentmode int constraint fkpmode foreign key references payment(modeid)
)

insert into billMaster (billid,dos,cid,paymentmode) values (1083,'2020-02-28',01,4),(1002,'2020-02-28',01,4),
(1003,'2019-01-28',01,4),(1042,'2020-01-28',05,3),(1043,'2021-02-28',01,3),(1063,'2022-02-10',02,4),
(1004,'2019-02-28',02,4),(1041,'2020-02-28',04,3),(1044,'2021-01-28',02,3),(1064,'2022-02-07',04,3),
(1005,'2019-02-28',02,3),(1040,'2020-03-28',03,3),(1045,'2021-12-28',03,1),(1065,'2022-02-08',08,2),
(1006,'2019-02-28',03,3),(1039,'2020-04-28',02,3),(1046,'2021-12-28',04,1),(1066,'2022-02-28',10,1),
(1007,'2019-09-28',04,2),(1038,'2020-05-28',01,3),(1047,'2021-12-28',05,1),(1067,'2022-03-08',12,1),
(1008,'2019-10-28',05,2),(1037,'2020-06-28',01,2),(1048,'2021-11-28',06,2),(1068,'2022-03-08',14,2),
(1009,'2019-11-28',05,1),(1036,'2020-07-28',02,2),(1049,'2021-10-28',07,2),(1069,'2022-03-08',02,3),
(1010,'2019-12-28',06,3),(1035,'2020-08-28',03,2),(1050,'2021-09-28',08,3),(1070,'2022-03-18',04,4),
(1011,'2019-12-28',06,4),(1034,'2020-09-28',04,2),(1051,'2021-08-28',09,3),(1071,'2022-03-28',08,3),
(1012,'2019-11-28',06,2),(1033,'2020-10-28',05,1),(1052,'2021-07-28',10,2),(1072,'2022-03-28',10,2),
(1013,'2019-10-28',07,1),(1032,'2020-11-28',06,1),(1053,'2021-06-28',11,2),(1073,'2022-03-28',12,1),
(1014,'2019-09-28',08,3),(1031,'2020-12-28',07,2),(1054,'2021-05-28',12,3),(1074,'2022-02-28',14,2),
(1015,'2019-08-28',09,3),(1030,'2020-01-28',08,1),(1055,'2021-04-28',14,4),(1075,'2022-03-19',01,3),
(1016,'2019-07-28',10,1),(1029,'2020-02-28',09,2),(1056,'2021-03-28',15,2),(1076,'2022-02-20',03,4),
(1017,'2019-06-28',11,2),(1028,'2020-03-28',10,1),(1057,'2021-02-28',01,4),(1077,'2022-02-21',05,4),
(1018,'2019-05-28',12,2),(1027,'2020-04-28',15,2),(1058,'2021-01-28',02,1),(1078,'2022-02-27',07,3),
(1019,'2019-04-28',14,1),(1026,'2020-04-28',14,1),(1059,'2021-11-28',03,1),(1079,'2022-02-27',09,2),
(1020,'2019-03-28',10,3),(1025,'2020-05-28',12,3),(1060,'2021-02-28',04,1),(1080,'2021-02-24',11,1),
(1021,'2019-02-28',01,4),(1024,'2020-06-28',11,4),(1061,'2021-12-28',05,2),(1081,'2020-02-25',15,1),
(1022,'2019-01-28',12,1),(1023,'2020-07-28',01,1),(1062,'2021-12-28',05,2),(1082,'2019-02-25',01,2)

delete from billMaster
select * from billMaster
------------------------------------------

create table sales (
pid int constraint fkspid foreign key references product(pid),
quantity int,
billid int constraint fkbid foreign key references billMaster(billid))


insert into sales (pid,quantity,billid) values (11023,10,1083),(11002,15,1033),(11003,5,1041),
(11004,150,1004),(11011,85,1011),(11018,95,1018),(11005,165,1026),(11012,255,1034),(11019,2,1042),
(11005,15,1005),(11012,75,1012),(11019,105,1019),(11006,175,1027),(11013,265,1035),(11020,3,1043),
(11006,156,1006),(11013,55,1013),(11020,115,1020),(11007,185,1028),(11014,275,1036),(11021,14,1044),
(11007,135,1007),(11014,45,1014),(11021,125,1021),(11008,195,1029),(11015,285,1037),(11022,13,1045),
(11008,145,1008),(11015,45,1015),(11022,135,1022),(11009,205,1030),(11016,295,1038),(11003,12,1046),
(11009,125,1009),(11016,35,1016),(11001,145,1023),(11010,215,1031),(11017,300,1039),(11004,11,1047),
(11010,5,1010),(11017,25,1017),(11005,155,1024),(11011,225,1032),(11018,301,1040),(11005,7,1048)

select * from sales
delete from sales
------------------------------------------------------------------------------------------

select * from categoryList
select * from product
select * from vendors
select * from customers
select * from sales
select * from billMaster
select * from product
select * from sales

----------Categorywise No Of Products--------------------------------------------
select c.category,sum(p.quantity) as [ItemsInStock]
from categoryList c inner join product p
on c.catid=p.catid
group by c.category

-----------Categorywise No Of Products and stock value

select c.category,sum(p.quantity) as [ItemsInStock], sum(p.quantity*p.price) as [StockVal]
from categoryList c inner join product p
on c.catid=p.catid
group by c.category

------List the category and vendorwise products,stock value

select c.category,v.vendor, sum(p.quantity) as [ItemsInStock], sum(p.quantity*p.price) as [StockVal]
from categoryList c inner join product p
on c.catid=p.catid inner join vendors v on v.vid=p.vendorid
group by c.category,v.vendor
order by c.category

------------List Vendor with highest stock value under each catgeory--
with stock as
(select c.category,v.vendor, sum(p.quantity) as [ItemsInStock], sum(p.quantity*p.price) as [StockVal]
from categoryList c inner join product p
on c.catid=p.catid inner join vendors v on v.vid=p.vendorid
group by c.category,v.vendor), MaxStock as (select category,max([StockVal]) as [Highest Stock Value] from stock
group by category)

select t.category,t.vendor,s.[Highest Stock Value] from stock t inner join MaxStock s on t.category=s.category
and t.StockVal=s.[Highest Stock Value]

--------------LIST THE TOTAL NUMBER OF ITEMS SOLD PRODUCTWISE------

select p.pid,p.pname,sum(s.quantity) as [Items Sold]
from product p inner join sales s
on p.pid=s.pid
group by p.pid,p.pname

--------------LIST THE TOTAL NUMBER OF ITEMS SOLD PRODUCTWISE UNDER EACH CATEGORY------

select c.category,p.pid,p.pname,sum(s.quantity) as [Items Sold]
from product p inner join sales s
on p.pid=s.pid inner join categoryList c on c.catid=p.catid
group by c.category,p.pid,p.pname

--------------LIST THE TOTAL NUMBER OF ITEMS SOLD VendorWISE UNDER EACH CATEGORY------

select v.vendor,p.pid,p.pname,sum(s.quantity) as [Items Sold]
from product p inner join sales s
on p.pid=s.pid inner join vendors v on v.vid=p.vendorid
group by v.vendor,p.pid,p.pname

--------------LIST THE TOTAL NUMBER OF ITEMS SOLD VendorWISE UNDER EACH CATEGORY yearwise------

select v.vendor,DATEPART(yyyy,b.dos) as [Years],p.pid,p.pname,sum(s.quantity) as [Items Sold]
from product p inner join sales s
on p.pid=s.pid inner join vendors v on v.vid=p.vendorid inner join billMaster b on b.billid=s.billid
group by v.vendor,DATEPART(yyyy,b.dos),p.pid,p.pname

--------LIST PRODUCTWISE TOTAL REVENUE GENERATED---------------------------------
select p.pid,p.pname,sum(s.quantity) as [Items Sold],p.price,SUM(s.quantity*p.price) as [Revenue Generated]
from product p inner join sales s
on p.pid=s.pid inner join vendors v on v.vid=p.vendorid inner join billMaster b on b.billid=s.billid
group by p.pid,p.pname,p.price

 
--------LIST VENDORWISE TOTAL REVENUE GENERATED---------------------------------
select v.vendor,p.pname,sum(s.quantity) as [Items Sold],p.price,SUM(s.quantity*p.price) as [Revenue Generated]
from product p inner join sales s
on p.pid=s.pid inner join vendors v on v.vid=p.vendorid inner join billMaster b on b.billid=s.billid
group by v.vendor,p.pname,p.price

 --------LIST YEARWISE TOTAL REVENUE GENERATED---------------------------------

select v.vendor,DATEPART(yyyy,b.dos),p.pname,sum(s.quantity) as [Items Sold],p.price,SUM(s.quantity*p.price) as [Revenue Generated]
from product p inner join sales s
on p.pid=s.pid inner join vendors v on v.vid=p.vendorid inner join billMaster b on b.billid=s.billid
group by v.vendor,DATEPART(yyyy,b.dos),p.pname,p.price

 
  --------LIST MONTHWISE TOTAL REVENUE GENERATED under various category for the year 2019---------------------------------

select c.category,DATENAME(MM,b.dos) as [month],sum(s.quantity) as [Items Sold],SUM(s.quantity*p.price) as [Total Revenue Generated]
from product p inner join sales s
on p.pid=s.pid inner join categoryList c on c.catid=p.catid inner join billMaster b on b.billid=s.billid
where DATEPART(yyyy,b.dos)=2019
group by c.category,DATENAME(mm,b.dos)

 --------LIST MONTHWISE TOTAL REVENUE GENERATED under various category for the year 2019 vendorwise---------------------------------

select c.category,v.vendor,DATENAME(MM,b.dos) as [month],sum(s.quantity) as [Items Sold],SUM(s.quantity*p.price) as [Total Revenue Generated]
from product p inner join sales s
on p.pid=s.pid inner join categoryList c on c.catid=p.catid inner join billMaster b on b.billid=s.billid inner join vendors v on v.vid=p.vendorid
where DATEPART(yyyy,b.dos)=2019
group by c.category,v.vendor,DATENAME(mm,b.dos)

 -----LIAT THE TOTAL BILL VALUE FOR ALL THE BILLS---

 select *  from billMaster

select b.billid,SUM(s.quantity*p.price) as [TotalBill]
from product p inner join sales s
on p.pid=s.pid inner join billMaster b on b.billid=s.billid
group by b.billid

-----List the number of bills generated yearwise---

select YEAR(b.dos) as [Years],count(b.billid) as [Number Of Bills GEnerated]
from billMaster b
group by YEAR(b.dos)

--list the customer details for each bill--
 select *  from customers

select b.billid,c.cid,c.name from customers c inner join billMaster b on b.cid=c.cid

--list the payment mode and number of bills
 select *  from billMaster

select  p.mode,count(b.billid) as [Number Of Bills] from  payment p inner join billMaster b on p.modeid=b.paymentmode
group by p.mode

-----list the total amount collected under various payment options

select pm.mode,sum(s.quantity*p.price) as [REvenue]
from payment pm inner join billMaster b on pm.modeid=b.paymentmode
inner join sales s on s.billid=b.billid inner join product p on p.pid=s.pid
group by pm.mode

--list the number of payment & total amount collected yearwise undeer various payment options.

select year(b.dos) as [Years],pm.mode,count(b.billid) as [Number Of Payments],sum(s.quantity*p.price) as [Total REvenue]
from payment pm inner join billMaster b on pm.modeid=b.paymentmode
inner join sales s on s.billid=b.billid inner join product p on p.pid=s.pid
group by year(b.dos),pm.mode
order by [Years]

------Profit earned yearwise---------------------

select year(b.dos) as [Years],sum(s.quantity*p.price) as [Total REvenue],sum(s.quantity*p.price*p.profitPercentage/100) as [Profit]
from payment pm inner join billMaster b on pm.modeid=b.paymentmode
inner join sales s on s.billid=b.billid inner join product p on p.pid=s.pid
group by year(b.dos)
order by [Years]

--profit earned categorywise-----------------

select c.category,sum(s.quantity*p.price) as [Total REvenue],sum(s.quantity*p.price*p.profitPercentage/100) as [Profit]
from payment pm inner join billMaster b on pm.modeid=b.paymentmode
inner join sales s on s.billid=b.billid inner join product p on p.pid=s.pid inner join categoryList c on c.catid=p.catid
group by c.category

----List the billwise profit---

select b.billid,sum(s.quantity*p.price) as [Total REvenue],sum(s.quantity*p.price*p.profitPercentage/100) as [Profit]
from payment pm inner join billMaster b on pm.modeid=b.paymentmode
inner join sales s on s.billid=b.billid inner join product p on p.pid=s.pid inner join categoryList c on c.catid=p.catid
group by b.billid

----List the vendorwise profit---

select v.vendor,sum(s.quantity*p.price) as [Total REvenue],sum(s.quantity*p.price*p.profitPercentage/100) as [Profit]
from payment pm inner join billMaster b on pm.modeid=b.paymentmode
inner join sales s on s.billid=b.billid inner join product p on p.pid=s.pid inner join vendors v on v.vid=p.vendorid
group by v.vendor

------List the year with highest profit---
with yearProfit as (
select year(b.dos) as [Years],sum(s.quantity*p.price*p.profitPercentage/100) as [Profit]
from payment pm inner join billMaster b on pm.modeid=b.paymentmode
inner join sales s on s.billid=b.billid inner join product p on p.pid=s.pid
group by year(b.dos)
)

select top 1 with ties * from yearProfit order by profit desc

-------list the years with least 2 profit amount------------------------

with yearProfit as (
select year(b.dos) as [Years],sum(s.quantity*p.price*p.profitPercentage/100) as [Profit]
from payment pm inner join billMaster b on pm.modeid=b.paymentmode
inner join sales s on s.billid=b.billid inner join product p on p.pid=s.pid
group by year(b.dos)
)

select top 2 with ties * from yearProfit order by profit


-----list the vendors with least performance in terms of num of items sold in 2019


select top 1 with ties vendor,[ItemsSold] from
(select v.vendor,sum(s.quantity) as [ItemsSold]
from vendors v inner join  product p on p.vendorid=v.vid inner join
sales s on s.pid=p.pid inner join billMaster b on b.billid=s.billid
where year(b.dos)=2019
group by v.vendor)x order by [ItemsSold] 

--List the month in which max num of footwear are sold---


select top 1 with ties month,[ItemsSold] from
(select DATENAME(mm,b.dos) as  [month],sum(s.quantity) as [ItemsSold]
from vendors v inner join  product p on p.vendorid=v.vid inner join
sales s on s.pid=p.pid inner join billMaster b on b.billid=s.billid inner join categoryList c on c.catid=p.catid
where c.category like '%Footwear%'
group by DATENAME(mm,b.dos))x order by [ItemsSold] desc




--------------------------------------------------------

---ASSIGNMENT
-------------------------------------------------------



-------list the top 3 vendors with highest profit earned

select top 3 with ties vendor,[Profit] from
(select v.vendor,sum(s.quantity*p.price*p.profitPercentage) as [Profit]
from vendors v inner join  product p on p.vendorid=v.vid inner join
sales s on s.pid=p.pid inner join billMaster b on b.billid=s.billid
where year(b.dos)=2019
group by v.vendor)x order by [Profit] desc

----------List the categories of product which havent been sold in the year 2019
select * from categoryList where category not in (
select distinct c.category from
categoryList c left join product p on p.catid=c.catid inner join sales s on s.pid=p.pid 
inner join billMaster b on b.billid=s.billid
where year(b.dos)=2019)

-----product sold in max number between '1 april 2018' to 31 mar 2019---

select p.pid,p.pname,b.dos,sum(s.quantity) as [ItemsSold]
from product p inner join sales s on s.pid=p.pid inner join billMaster b on b.billid=s.billid
where b.dos between '2018-04-01' and '2019-03-31'
group by p.pid,p.pname,b.dos

----daywise num of items sold in year 2019

select DATENAME(dw,b.dos) as [Day],sum(s.quantity) as [ItemsSold]
from product p inner join sales s on s.pid=p.pid inner join billMaster b on b.billid=s.billid
where year(b.dos)=2019
group by DATENAME(dw,b.dos)


-----category which brought max revenue in year 2020
select top 1 with ties * from
(select c.category,sum(s.quantity*p.price) as [Revenue]
from payment pm inner join billMaster b on pm.modeid=b.paymentmode
inner join sales s on s.billid=b.billid inner join product p on p.pid=s.pid inner join categoryList c on c.catid=p.catid
where year(b.dos)=2020
group by c.category)x order by Revenue desc


----list monthwise num of items sold,revenue generated, profit earned categorywise for 2019

select c.category,datename(mm,b.dos) as [Month], sum(s.quantity) as [ItemsSold],sum(s.quantity*p.price) as [Revenue],
sum(s.quantity*p.price*p.profitPercentage/100) as [Profit]
from payment pm inner join billMaster b on pm.modeid=b.paymentmode
inner join sales s on s.billid=b.billid inner join product p on p.pid=s.pid inner join categoryList c on c.catid=p.catid
where year(b.dos)=2020
group by c.category,datename(mm,b.dos)


-----Products which have been sold less than 15 in qunatity

select p.pid,p.pname,sum(s.quantity) as [ItemsSold]
from billMaster b inner join sales s on s.billid=b.billid inner join product p on p.pid=s.pid 
group by p.pid,p.pname
having sum(s.quantity)<15

-----Views

Create view products as select pid,pname
from product

select * from products

drop view CustList
--------------------------------------


create view CustList as
select * from customers

select * from CustList where statusid=1 and address='Mysore'

create view CustList as
select cid,name,email,mobile,address from customers

-
------------view join table------------------------------------------------------

select c.cid,c.name,p.pname,sum(s.quantity) as [ItemsSold],b.dos
from CustList c inner join billMaster b on c.cid=b.cid inner join sales s on s.billid=b.billid inner join product p
on p.pid=s.pid
group by c.cid,c.name,p.pname,b.dos


----------MULTI-VALUE TABLE FUNCTION--------------------------------------------------
create function listCust(@balance money,@from date,@to date)
returns @list table (account int,name varchar(30),preferredAcc varchar(30),balance money,custCat varchar(50))
as
begin
	declare cust cursor for select c.acc_no,c.name,a.account from customers c inner join accounts a on a.id=c.account
	declare @accnum int,@name varchar(30),@account varchar(30),@totdep money,@totwith money,@availbal money,
	 @cat varchar(50)
	open cust
		fetch next from cust into @accnum,@name,@account
		while @@FETCH_STATUS=0
			begin
				select @totdep=sum(amount) from accTransactions where transtype=1 and dot between 
				select @totwith=sum(amount) from accTransactions where transtype=2 and dot between @from and @to
				set @availbal=ISNULL(@totdep,0)-ISNULL(@totwith,0)
				if @availbal>=@balance
					begin
						set @cat= 'Premium Customer'
					end
				else if @availbal>=0 and @availbal<@balance
					begin
						set @cat=  'Non-Premium Customer'
					end
				else if @availbal<0
					begin
						set @cat= 'Overdue customer'
					end
				insert into @list values (@accnum,@name,@account,@availbal,@cat)
				fetch next from cust into @accnum,@name,@account
			end
	close cust
	deallocate cust
	return
end

select * from listCust(138491,'2019-12-14','3/31/2022')
select * from customers

----------------TRIGGERS------------------------------------
select * into customerBackup from customers
alter table customerBackup add usser varchar(30),DAO date,operation varchar(30)
select * from customerBackup



select system_user

alter trigger trgCusts on customers
after insert,update,delete
as
begin
	declare @insertCount int,@delCount int
	declare @user varchar(30)
	select @insertCount=count(*) from inserted
	select @delCount=count(*) from deleted
	select @user=SYSTEM_USER
	if @insertCount=1 and @delCount=0
		begin
			insert into customerBackup select *, @user, getdate(),'Added'
			from inserted
		
		end
	else if @insertCount=0 and @delCount>0
		begin
			insert into customerBackup select *, @user, getdate(),'Deleted'
			from deleted
		end
	else if @insertCount>0 and @insertCount=@delCount
		begin
			insert into customerBackup select *,@user, getdate(),'Updated'
			from deleted
		end
end

insert into customers (acc_no,name,address,account,status,aod)values (1072,'Baig','mumbai',12,1,'2013-01-31')
update customers set status=1 where acc_no=1071
delete from customers where acc_no=1072

select * from customerBackup
----------------------------Instead Of-------------------------

select * from customers

alter trigger trgCust on customers
instead of insert
as
begin
	declare @address varchar(30)
	declare @count int
	select @address=address from inserted
	select @count=count(*) from customers where address=@address
	if @count<5
		begin
			insert into customers select * from inserted 
			print 'The new customer address added to '+@address
		end
	else
		begin
			print 'Customer address can not be added'+@address+' because it has '+cast(@count as varchar(5))+'Address'
			
		end
end

insert into customers values(10687,'shamail Khan','mumbai',13,1)

-----------------------------------------

alter trigger trgMonitor on accTransactions
instead of insert
as
begin
	declare @day int
	declare @time int
	select @day=DATEPART(dw,GETDATE())
	if @day=1 or @day=7
	begin
		print 'Transaction not permitted in weekends'
	end
	else
	begin
		select 
		@time=DATEPART(hh,getdate())
		if @time>8 or @time<14
		begin
			print 'Transact during working hours'
		end
		else
		begin
			insert into accTransactions select accno,amount,dot,transtype from inserted
			print 'Transaction successfull'
		end
end
end

select * from accTransactions

select  * from accounts

insert into accTransactions (accno,amount,dot,transtype) values (1059,2522,'3/14/2022',1)

delete from accTransactions where accno=1059

------ENABLING AND DISABLING TRIGGERS----------------------------------------------------

ALTER TAble accTransactions disable trigger trgMonitor
ALTER TAble accTransactions enable trigger trgMonitor


------------DDL TRIGGERS---------------------------------------------------------------

create trigger trgCreate3 on database
for create_table,create_view,create_procedure
as
begin
	print 'Trigger 3'
end

create table studentTrgDemo (
stid int constraint pksid primary key,
name varchar(30)
)

create view sttrgview as select * from studentTrgDemo

drop view sttrgview
----Disable DDL Triggers------

disable trigger trgCreate on database
disable trigger all on database
enable trigger trgCreate2 on database
enable trigger all on database

------------------TRIGGER FOR ALL DATABASES IN SERVER------------

create trigger trgDbMonitor on all server
after create_procedure,alter_procedure,drop_procedure
as
	begin
		print 'A procedure has been created/altered/dropped'
	end

disable trigger trgDbMonitor on all server
enable trigger trgDbMonitor on all server
disable trigger all on all server
enable trigger all on all server