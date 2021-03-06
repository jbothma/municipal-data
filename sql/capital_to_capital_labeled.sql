update capital_labeled set financial_year = left(period_code, 4);
update capital_labeled set amount_type_cde = substr(period_code, 5) where substr(period_code, 5) in ('IBY1', 'IBY2', 'ADJB', 'ORGB', 'AUDA', 'PAUD', 'IBY2');
update capital_labeled set amount_type_cde = 'ACT' where amount_type_cde is null;
update capital_labeled set function_desc = subquery.description from (select * from codes_desc ) as subquery where subquery.column_name = 'FUNCTION_CDE' and subquery.code = function_cde;
update capital_labeled set capital_desc = subquery.description from (select * from codes_desc ) as subquery where subquery.column_name = 'CAPITAL_CDE' and subquery.code = capital_cde;
update capital_labeled set demarcation_desc = sub.name from (select * from demarcation) sub where sub.code = demarcation_code;
update capital_labeled set period_length = 'year' where amount_type_cde != 'ACT';
update capital_labeled set period_length = 'month' where amount_type_cde = 'ACT';
update capital_labeled set financial_period = right(period_code, 2) where period_length = 'month';
update capital_labeled set financial_period = left(period_code, 4) where period_length = 'year';
update capital_labeled set amount_type_desc = sub.name from (select * from amount_type) as sub where sub.code = amount_type_cde;
