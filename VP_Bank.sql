create table aum (
	customer_id varchar,
	amount varchar
)

create table prod_holding (
	customer_id varchar,
	prod_ca varchar,
	prod_td varchar,
	prod_credit_card varchar,
	prod_app varchar,
	prod_secured_loan varchar,
	prod_upl varchar
)

create table cust (
	customer_id varchar,
	segment varchar,
	province_city varchar
)

alter table aum
alter column amount type numeric using amount::numeric


select a.customer_id, round(amount,2)as amount,
segment,province_city
from aum a
left join cust c
on a.customer_id=c.customer_id
left join prod_holding p
on a.customer_id=p.customer_id

select segment,
sum(case
   when prod_ca ='1'then 1 else 0 end) as "Tài khoản thanh toán",
sum(case
   when prod_td= '1'then 1 else 0 end) as "Gửi có kỳ hạn",
sum(case
   when prod_credit_card='1'then 1 else 0 end) as "Thẻ tín dụng",
sum(case
   when prod_app='1'then 1 else 0 end) as "Chuyển tiền trên mobile",
sum(case
   when prod_secured_loan='1'then 1 else 0 end) as "Vay thế chấp",
sum(case
   when prod_upl='1'then 1 else 0 end) as "Vay tín chấp"
from aum a
left join cust c
on a.customer_id=c.customer_id
left join prod_holding p
on a.customer_id=p.customer_id
group by c.segment

select a.customer_id, round(amount,2)as amount,
case
when prod_ca = '1' then 'Tài khoản thanh toán' else 'No' end as "Sản Phẩm"
from aum a
left join cust c
on a.customer_id=c.customer_id
left join prod_holding p
on a.customer_id=p.customer_id
where prod_ca = '1' 
union 
select a.customer_id, round(amount,2)as amount,
case
when prod_td = '1' then 'Gửi có kỳ hạn' else 'No' end as "Sản Phẩm"
from aum a
left join cust c
on a.customer_id=c.customer_id
left join prod_holding p
on a.customer_id=p.customer_id
where prod_td = '1' 
union 
select a.customer_id, round(amount,2)as amount,
case
when prod_credit_card = '1' then 'Thẻ tín dụng' else 'No' end as "Sản Phẩm"
from aum a
left join cust c
on a.customer_id=c.customer_id
left join prod_holding p
on a.customer_id=p.customer_id
where prod_credit_card = '1'
union 
select a.customer_id, round(amount,2)as amount,
case
when prod_app ='1' then 'Chuyển tiền trên mobile' else 'No' end as "Sản Phẩm"
from aum a
left join cust c
on a.customer_id=c.customer_id
left join prod_holding p
on a.customer_id=p.customer_id
where prod_app ='1'
union 
select a.customer_id, round(amount,2)as amount,
case
when prod_secured_loan ='1' then 'Vay thế chấp' else 'No' end as "Sản Phẩm"
from aum a
left join cust c
on a.customer_id=c.customer_id
left join prod_holding p
on a.customer_id=p.customer_id
where  prod_secured_loan ='1'
union 
select a.customer_id, round(amount,2)as amount,
case
when  prod_upl ='1' then 'Vay tín chấp' else 'No' end as "Sản Phẩm"
from aum a
left join cust c
on a.customer_id=c.customer_id
left join prod_holding p
on a.customer_id=p.customer_id
where   prod_upl ='1'
 
select segment,
sum(case
   when prod_secured_loan='1'then 1 else 0 end) as "Vay thế chấp",
sum(case
   when prod_upl='1'then 1 else 0 end) as "Vay tín chấp"
from cust c
join prod_holding p
on c.customer_id=p.customer_id
group by segment, prod_secured_loan,  prod_upl
order by segment
having prod_secured_loan='1'and prod_upl='1'

 

