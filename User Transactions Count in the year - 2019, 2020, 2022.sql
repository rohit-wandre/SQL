-- create a table
CREATE TABLE users (
  user_id INTEGER PRIMARY KEY,
  user_name TEXT NOT NULL
);

-- insert some values
INSERT INTO users VALUES 
(248,'Stokes'),
(448,'Francis'),
(638,'Hunter'),
(701,'Hanson'),
(984,'Martin');


CREATE TABLE transactions (
  trans_id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL
);

ALTER TABLE transactions
ADD CONSTRAINT fk_user_id
FOREIGN KEY (user_id) REFERENCES users(user_id);

INSERT INTO transactions VALUES
(19910,448),
(19685,701),
(21890,701),
(17679,248),
(20697,701),
(20698,701),
(20699,701),
(20984,448),
(19887,638);


WITH cte AS 
(
SELECT 
    substr(trans_id,1,2) AS trans_year,
    user_id 
FROM transactions
)
    
SELECT 
    user_name,
    SUM(year_19),
    SUM(year_20),
    SUM(year_21)
FROM 
    (
        SELECT 
            user_name,
            SUM(CASE WHEN trans_year = 19 THEN 1 ELSE 0 END) AS year_19,
            SUM(CASE WHEN trans_year = 20 THEN 1 ELSE 0 END) AS year_20,
            SUM(CASE WHEN trans_year = 21 THEN 1 ELSE 0 END) AS year_21
    
        FROM 
        (
            SELECT 
                users.user_name,
                cte.trans_year,
                cte.user_id 
            FROM cte 
            INNER JOIN users
            ON cte.user_id = users.user_id
        )a
        GROUP BY trans_year, user_name
    ) b
    GROUP BY user_name;






