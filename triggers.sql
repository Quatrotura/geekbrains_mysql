
DELIMITER //
DROP TRIGGER IF EXISTS calc_amount //
CREATE TRIGGER calc_amount BEFORE INSERT ON orders_products
FOR EACH ROW
BEGIN
    SET NEW.order_amount =
        (SELECT ps.price_value FROM product_styles AS ps WHERE ps.style_no = NEW.style_no_id LIMIT 1) *
        (SELECT ps.ordered_qty FROM product_styles AS ps WHERE ps.style_no = NEW.style_no_id LIMIT 1) *
        (NEW.qty_share_to_ship_by_route / 100);
END //

DELIMITER //
DROP TRIGGER IF EXISTS calc_check_payment //
CREATE TRIGGER calc_check_payment BEFORE INSERT ON payments
FOR EACH ROW
BEGIN
    DECLARE p_type VARCHAR(255);
    DECLARE amount_share_for_payment INT;
    DECLARE order_calc_amount DECIMAL(12,2);
    SET p_type = NEW.payment_type;
    SET order_calc_amount = (SELECT sum(order_amount)
                            FROM orders_products op WHERE op.order_id = NEW.order_id);

    CASE p_type
        WHEN 'advance payment' THEN
        SET amount_share_for_payment = (SELECT pt.advance_payment_val
                                FROM orders
                                JOIN contracts contr on orders.contract_no_id = contr.id
                                JOIN payment_terms pt on contr.payment_terms_id = pt.id
                                WHERE NEW.order_id = orders.id);
        WHEN 'before shipment' THEN
        SET amount_share_for_payment = (SELECT pt.before_shpmt_payment_val
                                FROM orders
                                JOIN contracts contr on orders.contract_no_id = contr.id
                                JOIN payment_terms pt on contr.payment_terms_id = pt.id
                                WHERE NEW.order_id = orders.id);
        WHEN 'postpayment_1' THEN
        SET amount_share_for_payment = (SELECT pt.postpayment_1_val
                                FROM orders
                                JOIN contracts contr on orders.contract_no_id = contr.id
                                JOIN payment_terms pt on contr.payment_terms_id = pt.id
                                WHERE NEW.order_id = orders.id);
        WHEN 'postpayment_2' THEN
        SET amount_share_for_payment = (SELECT pt.postpayment_2_val
                                FROM orders
                                JOIN contracts contr on orders.contract_no_id = contr.id
                                JOIN payment_terms pt on contr.payment_terms_id = pt.id
                                WHERE NEW.order_id = orders.id);
    END CASE;
    SET NEW.payment_amount_suggested = order_calc_amount * (amount_share_for_payment/100);

END //

DELIMITER ;