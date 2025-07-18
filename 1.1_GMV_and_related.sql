-- === 1.1 GMV график ===
-- === 4.1 заказы ===
-- === 5.1 GMV, Доля заказов менее 1500 ===
-- === 6.1 Средний чек ===
-- === 7.1 GMV, Среднее время владения (в днях) ===


SELECT 
    oi.model_id, 
    so.supplier_id, 
    oi.quantity "Количество", 
    so.create_ts,
    so.create_ts as create2,
    b2.name as RC_name,
    oi.quantity * (oi.unit_price + oi.unit_delivery_price) "GMV", 
    o.id o_id,
    (oi.unit_delivery_price - oi.origin_unit_delivery_net) * oi.quantity "GMV Последняя миля", 
    be.legal_entity,
    so.rc_accepted_ts,
    so.warehouse_delivered_ts,
    CASE 
    WHEN so.warehouse_delivered_ts IS NULL AND so.delivered_ts IS NULL THEN 
        (EXTRACT(EPOCH FROM (now() - so.rc_accepted_ts)) / 86400.0)::numeric(10,1)
    ELSE 
        CASE 
            WHEN so.warehouse_delivered_ts IS NULL THEN 
                (EXTRACT(EPOCH FROM (so.delivered_ts - so.rc_accepted_ts)) / 86400.0)::numeric(10,1)
            ELSE 
                (EXTRACT(EPOCH FROM (so.warehouse_delivered_ts - so.rc_accepted_ts)) / 86400.0)::numeric(10,1)
        END
    END AS "Время владения (в днях)",
    CASE 
        WHEN SUM(oi.quantity * (oi.unit_price + oi.unit_delivery_price)) OVER (PARTITION BY o.id) > 1500 
        THEN 1 
        ELSE 0 
    END
FROM order_service.Order_Item oi
LEFT JOIN order_service.supplier_order so ON oi.supplier_order_id = so.id
LEFT JOIN order_service.order o ON oi.order_id = o.id

LEFT JOIN client_service.basis b on b.id = o.basis_id
LEFT JOIN client_service.business_entity be on be.id = b.be_id
LEFT JOIN client_service.client cl on cl.id = o.client_id
LEFT JOIN dictionary_service.Basis b2 ON o.distribution_basis_id = b2.id

WHERE so.system_status NOT IN ('DRAFT', 'DECLINED', 'CANCELED')
AND so.create_ts > '01.01.2023'
AND oi.catalog_id = '1877'
