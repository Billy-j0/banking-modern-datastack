with base as (

    SELECT
        v:id::string                 AS transaction_id,
        v:account_id::string         AS account_id,
        v:amount::float              AS amount,
        v:txn_type::string           AS transaction_type,
        v:related_account_id::string AS related_account_id,
        v:status::string             AS status,
        v:created_at::timestamp      AS transaction_time,
        CURRENT_TIMESTAMP            AS load_timestamp
    FROM {{ source('raw', 'transactions') }}

),

deduped as (

    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY transaction_id
               ORDER BY transaction_time DESC
           ) AS rn
    FROM base

)

SELECT
    transaction_id,
    account_id,
    amount,
    transaction_type,
    related_account_id,
    status,
    transaction_time,
    load_timestamp
FROM deduped
WHERE rn = 1
