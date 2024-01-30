WITH account_info AS 
    (SELECT * FROM PD2023_WK07_ACCOUNT_INFORMATION as a, 
    LATERAL SPLIT_TO_TABLE(a.ACCOUNT_HOLDER_ID, ','))
    
SELECT 
    transaction_details.transaction_id,
    transaction_details.transaction_date,
    transaction_details.value,
    transaction_details.transaction_date,
    transaction_path.account_to,
    transaction_path.account_from AS account_number,
    account_info.account_type,
    account_info.balance,
    account_holders.name,
    account_holders.date_of_birth,
    account_holders.contact_number,
    account_holders.first_line_of_address
    
FROM PD2023_WK07_TRANSACTION_DETAIL AS transaction_details
JOIN PD2023_WK07_TRANSACTION_PATH AS transaction_path 
ON transaction_details.transaction_id = transaction_path.transaction_id

JOIN ACCOUNT_INFO
ON TRANSACTION_PATH.ACCOUNT_FROM=ACCOUNT_INFO.ACCOUNT_NUMBER

JOIN PD2023_WK07_ACCOUNT_HOLDERS AS ACCOUNT_HOLDERS
ON ACCOUNT_INFO.VALUE = ACCOUNT_HOLDERS.ACCOUNT_HOLDER_ID

WHERE cancelled_= 'N' 
AND transaction_details.value > 1000
AND account_info.account_type != 'Platinum'
