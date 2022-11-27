/* Qn - 3: Total number of customers based on gender who have placed orders of worth at least Rs3000 */
select cust.cus_gender,count(distinct cust.cus_id) as customer_count
from customer cust
inner join `order` ord
on cust.cus_id = ord.cus_id
where ord.ord_amount >= 3000
group by cust.cus_gender
;

/* Qn - 4: Display all the orders along with product name ordered by a customer having Customer_Id=2 */

select ord.*,prod.pro_name
from `order` ord
	,product prod
	,supplier_pricing supr
where ord.cus_id = 2
  and ord.PRICING_ID = supr.PRICING_ID
  and supr.PRO_ID = prod.PRO_ID;

/* Qn - 5 : Display the Supplier details who can supply more than one product */

select *
from supplier sup
where sup.supp_id in (
select spr.supp_id
from supplier_pricing spr
group by spr.supp_id
having count(supp_id) > 1)
;

/* Qn - 6 : Find the least expensive product from each category and print the table with category id, name, product name and price of the product */

select catg.cat_id,
	   catg.cat_name,
       prod.PRO_NAME,
       supr.SUPP_PRICE
from product prod
    ,category catg
	,supplier_pricing supr
    ,
(select prod.CAT_ID,min(supr.SUPP_PRICE) as minprice
from product prod
    ,supplier_pricing supr
where supr.PRO_ID = prod.pro_id
group by prod.cat_id) prsu
where prod.cat_id = prsu.cat_id
  and catg.cat_id = prod.cat_id
  and supr.pro_id = prod.pro_id
  and supr.supp_price = prsu.minprice
;

/* Qn 7 - Display the Id and Name of the Product ordered after “2021-10-05” */
select pro.pro_id
	  ,pro.pro_namesupplierrating
from `order` ord
	,supplier_pricing spr
    ,product pro
where ord_date 		 > '2021-10-05'
  and ord.pricing_id = spr.PRICING_ID
  and spr.pro_id 	 = pro.pro_id
;

/* Qn8 - Display customer name and gender whose names start or end with character 'A'*/
select cus_name,cus_gender
from customer
where cus_name like 'A%'
or cus_name like '%A';

/* Qn 9 - Create a stored procedure to display supplier id, name, rating and Type_of_Service. For Type_of_Service, If rating =5, print “Excellent Service”,If rating >4 print “Good Service”, If rating >2 print “Average Service” else print “Poor Service”*/
call supplierrating();