-- =================================================================
-- E-Commerce Customer Churn & Segmentation Analysis
-- File: customer_segmentation_queries.sql
-- Description: Advanced SQL queries including CTEs, Window Functions,
--              and Conditional Aggregations for customer retention.
-- =================================================================

-- 1. Active vs Inactive Customer Overview
SELECT 
    CASE 
        WHEN days_since_last_purchase > 30 THEN 'Inactive / At Risk'
        ELSE 'Active'
    END AS customer_status,
    COUNT(*) AS total_customers,
    ROUND(AVG(total_spend), 2) AS avg_total_spend,
    ROUND(AVG(items_purchased), 2) AS avg_items_purchased,
    ROUND(AVG(days_since_last_purchase), 1) AS avg_days_since_purchase
FROM customers
GROUP BY customer_status;

-- 2. Churn Risk & Spend Analysis by Membership Tier
SELECT 
    membership_type,
    COUNT(customer_id) AS total_customers,
    ROUND(AVG(total_spend), 2) AS avg_spend,
    ROUND(AVG(items_purchased), 1) AS avg_items,
    ROUND(AVG(days_since_last_purchase), 1) AS avg_recency_days,
    ROUND(SUM(CASE WHEN days_since_last_purchase > 30 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS risk_rate_pct
FROM customers
GROUP BY membership_type
ORDER BY avg_spend DESC;

-- 3. Advanced RFM Customer Segmentation using Window Functions (NTILE)
WITH rfm_scores AS (
    SELECT 
        customer_id,
        membership_type,
        total_spend,
        items_purchased,
        days_since_last_purchase,
        NTILE(4) OVER (ORDER BY days_since_last_purchase DESC) AS r_score,
        NTILE(4) OVER (ORDER BY items_purchased ASC) AS f_score,
        NTILE(4) OVER (ORDER BY total_spend ASC) AS m_score
    FROM customers
)
SELECT 
    CASE 
        WHEN (r_score + f_score + m_score) >= 10 THEN 'Champions / Loyal'
        WHEN (r_score + f_score + m_score) BETWEEN 7 AND 9 THEN 'Potential Loyalists'
        WHEN (r_score + f_score + m_score) BETWEEN 5 AND 6 THEN 'At Risk / Need Attention'
        ELSE 'Lost / Hibernating'
    END AS customer_segment,
    COUNT(*) AS customer_count,
    ROUND(AVG(total_spend), 2) AS avg_spend,
    ROUND(AVG(days_since_last_purchase), 1) AS avg_recency
FROM rfm_scores
GROUP BY customer_segment
ORDER BY avg_spend DESC;
