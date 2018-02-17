DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS merchants;

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  first_name VARCHAR(255),
  last_name VARCHAR(255),
  monthly_income INT,
  budget INT,
  pay_date INT
);

CREATE TABLE merchants (
  id SERIAL PRIMARY KEY,
  merchant_name VARCHAR(255)
);

CREATE TABLE transactions (
  id SERIAL PRIMARY KEY,
  user_id INT REFERENCES users(id) ON DELETE CASCADE,
  merchant_id INT REFERENCES merchants(id) ON DELETE CASCADE,
  amount INT,
  tag VARCHAR(255),
  trans_date DATE,
  recurring_transaction BOOLEAN NOT NULL DEFAULT false
);
