{% macro concat_value(column1) -%}

case when {{column1}} like '%T00:00:00Z%' then substring(end_date,6,2)
            when {{column1}} like '%Jan%' then substring (replace({{column1}}, 'Jan', '01'),4,2) 
            when {{column1}} like '%Feb%' then substring (replace({{column1}}, 'Feb', '02'),4,2) 
            when {{column1}} like '%Mar%' then substring (replace({{column1}}, 'Mar', '03'),4,2) 
            when {{column1}} like '%Apr%' then substring (replace({{column1}}, 'Apr', '04'),4,2)
            when {{column1}} like '%May%' then substring (replace({{column1}}, 'May', '05'),4,2)
            when {{column1}} like '%Jun%' then substring (replace({{column1}}, 'Jun', '06'),4,2)
            when {{column1}} like '%Jul%' then substring (replace({{column1}}, 'Jul', '07'),4,2)
            when {{column1}} like '%Aug%' then substring (replace({{column1}}, 'Aug', '08'),4,2)
            when {{column1}} like '%Sep%' then substring (replace({{column1}}, 'Sep', '09'),4,2)
            when {{column1}} like '%Oct%' then substring (replace({{column1}}, 'Oct', '10'),4,2)
            when {{column1}} like '%Nov%' then substring (replace({{column1}}, 'Nov', '11'),4,2)
            when {{column1}} like '%Dec%' then substring (replace({{column1}}, 'Dec', '12'),4,2)
            else {{column1}}
            end end_month_m,
            when {{column1}} like '%T00:00:00Z%' then substring(end_date,1,4)
            when {{column1}} like '%Jan%' then substring (replace({{column1}}, 'Jan', '01'),7,4) 
            when {{column1}} like '%Feb%' then substring (replace({{column1}}, 'Feb', '02'),7,4) 
            when {{column1}} like '%Mar%' then substring (replace({{column1}}, 'Mar', '03'),7,4) 
            when {{column1}} like '%Apr%' then substring (replace({{column1}}, 'Apr', '04'),7,4)
            when {{column1}} like '%May%' then substring (replace({{column1}}, 'May', '05'),7,4)
            when {{column1}} like '%Jun%' then substring (replace({{column1}}, 'Jun', '06'),7,4)
            when {{column1}} like '%Jul%' then substring (replace({{column1}}, 'Jul', '07'),7,4)
            when {{column1}} like '%Aug%' then substring (replace({{column1}}, 'Aug', '08'),7,4)
            when {{column1}} like '%Sep%' then substring (replace({{column1}}, 'Sep', '09'),7,4)
            when {{column1}} like '%Oct%' then substring (replace({{column1}}, 'Oct', '09'),7,4)
            when {{column1}} like '%Nov%' then substring (replace({{column1}}, 'Nov', '09'),7,4)
            when {{column1}} like '%Dec%' then substring (replace({{column1}}, 'Dec', '12'),7,4)
            else end_date
            end end_year_m,
        case when end_date like '%T00:00:00Z%' then substring(end_date,9,2)
            when end_date like '%Jan%' then substring (replace(end_date, 'Jan', '01'),1,2) 
            when end_date like '%Feb%' then substring (replace(end_date, 'Feb', '02'),1,2) 
            when end_date like '%Mar%' then substring (replace(end_date, 'Mar', '03'),1,2) 
            when end_date like '%Apr%' then substring (replace(end_date, 'Apr', '04'),1,2)
            when end_date like '%May%' then substring (replace(end_date, 'May', '05'),1,2)
            when end_date like '%Jun%' then substring (replace(end_date, 'Jun', '06'),1,2)
            when end_date like '%Jul%' then substring (replace(end_date, 'Jul', '07'),1,2)
            when end_date like '%Aug%' then substring (replace(end_date, 'Aug', '08'),1,2)
            when end_date like '%Sep%' then substring (replace(end_date, 'Sep', '09'),1,2)
            when end_date like '%Oct%' then substring (replace(end_date, 'Oct', '09'),1,2)
            when end_date like '%Nov%' then substring (replace(end_date, 'Nov', '09'),1,2)  
            when end_date like '%Dec%' then substring (replace(end_date, 'Dec', '12'),1,2)
            else end_date
            end end_date_m

{%-endmacro %}