-- === 2.1 OTIF GMV ===
-- === 2.2 OTIF (количество моделей) ===


WITH non_straight as (
    SELECT
        so.id,
        DATE_TRUNC('day', so.date_delivery) as plan_date,
        count(oi.model_id) counts,
        sum(quantity * (oi.unit_price + oi.unit_delivery_price)) gmv,
        CASE 
            WHEN (rc_accepted_ts IS NULL AND date_delivery + INTERVAL '5 days' > NOW())
            OR (date_delivery + INTERVAL '5 days' > rc_accepted_ts)
        THEN 'Вовремя'
        ELSE 'Опоздал'
        END AS "Признак"
        
    FROM order_service.order_item oi
    LEFT JOIN order_service.Supplier_Order so ON oi.supplier_order_id = so.id
    WHERE
        so.system_status not in ('DRAFT', 'DECLINED', 'CANCELED') 
        and so.create_ts > '11.01.2023' 
        and so.is_available_basis IN ('false')
        and so.catalog_id = '1877'
        and so.client_delivery_date < now()
    GROUP BY 1,2
),

straight as (
    SELECT
        so.id,
        DATE_TRUNC('day', so.client_delivery_date) as plan_date,
        count(oi.model_id) counts,
        sum(quantity * (oi.unit_price + oi.unit_delivery_price)) gmv,
        CASE 
            WHEN ((delivered_ts IS NULL OR warehouse_delivered_ts IS NULL) AND date_delivery + INTERVAL '5 days' > NOW())
            OR (client_delivery_date + INTERVAL '5 days' > delivered_ts)
            OR (client_delivery_date + INTERVAL '5 days' > warehouse_delivered_ts)
        THEN 'Вовремя'
        ELSE 'Опоздал'
        END AS "Признак"
        
    FROM order_service.order_item oi
    LEFT JOIN order_service.Supplier_Order so ON oi.supplier_order_id = so.id
    WHERE
        so.system_status not in ('DRAFT', 'DECLINED', 'CANCELED') 
        and so.create_ts > '11.01.2023' 
        and so.is_available_basis IN ('true')
        and so.catalog_id = '1877'
        and so.client_delivery_date < now()
    GROUP BY 1,2
)

SELECT * 
FROM non_straight
UNION ALL 
SELECT * 
FROM straight
