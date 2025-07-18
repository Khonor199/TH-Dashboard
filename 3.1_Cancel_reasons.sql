-- === 3.1 Причины отмены подзаказа ===

SELECT
    so.supplier_id,
    so.create_ts,
    so.catalog_id,
    COALESCE(so.canceled_ts, so.create_ts) AS times,
    so.id,
    
    CASE 
        WHEN so.system_status = 'DECLINED' THEN 'Отклонено поставщиком'
        WHEN oh.action_type IN ('supplier_order_decline', 'supplier_order_auto_decline') THEN 'Отменено поставщиком'
        ELSE 'Отменено заказчиком'
    END AS "Действие",
    
    CASE 
        WHEN so.system_status IN ('DECLINED', 'CANCELED') AND oh.action_type IN ('supplier_order_decline', 'supplier_order_auto_decline') THEN 1 
        ELSE 0 
    END AS sup,
    
    so.system_status,
    REPLACE(s.name, 'ОБЩЕСТВО С ОГРАНИЧЕННОЙ ОТВЕТСТВЕННОСТЬЮ', '') AS name,
    oh.detail AS "Причина отмены",
    CASE 
        WHEN so.system_status = 'CANCELED' THEN 1 
        ELSE 0 
    END AS canceled_status

FROM order_service.supplier_order so
LEFT JOIN order_service.order_history oh 
    ON so.id = oh.supplier_order_id
    AND oh.action_type IN ('supplier_order_decline', 'supplier_order_auto_decline')
LEFT JOIN supplier_service.supplier s 
    ON so.supplier_id = s.id

WHERE so.create_ts > '2023-01-12'
  AND so.catalog_id = '1877'
  AND so.system_status IN ('DECLINED', 'CANCELED')
