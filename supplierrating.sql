CREATE DEFINER=`root`@`localhost` PROCEDURE `supplierrating`()
BEGIN

select supr.SUPP_ID as 'Supplier id'
	  ,supp.SUPP_NAME as name
      ,avg(rati.rat_ratstars) as rating
      ,case when avg(rati.RAT_RATSTARS) = 5 
            then "Excellent"
            when avg(rati.RAT_RATSTARS) > 4
			then "Good service"
            when avg(rati.RAT_RATSTARS) > 2
			then "Average service"
            else "Poor service"
            end as Type_of_service
from supplier supp,
     supplier_pricing supr,
	 `order` ordr,
     rating rati
where supp.SUPP_ID = supr.SUPP_ID
  and supr.PRICING_ID = ordr.PRICING_ID
  and ordr.ORD_ID = rati.ORD_ID
group by supr.SUPP_ID
	  ,supp.SUPP_NAME
order by supr.supp_id;

END