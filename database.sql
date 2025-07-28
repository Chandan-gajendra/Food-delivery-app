-- Drop tables if needed (optional)
DROP TABLE IF EXISTS ratings, order_items, orders, foods, hotels, users CASCADE;
-- create a schema in sql 
swiftbite

-- Users: both customers & managers
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    birthdate DATE,
    gender VARCHAR(10),
    phone VARCHAR(20),
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(20) CHECK (role IN ('customer', 'manager')) NOT NULL
);

-- Hotels: managed by managers
CREATE TABLE hotels (
    id SERIAL PRIMARY KEY,
    manager_id INT REFERENCES users(id) ON DELETE CASCADE,
    name VARCHAR(100) NOT NULL,
    description TEXT
);

-- Foods: linked to hotels
CREATE TABLE foods (
    id SERIAL PRIMARY KEY,
    hotel_id INT REFERENCES hotels(id) ON DELETE CASCADE,
    name VARCHAR(100) NOT NULL,
    price DECIMAL(8,2) NOT NULL,
    available BOOLEAN DEFAULT true,
    image BYTEA -- to store food photo (PNG/JPG)
);

-- Orders: placed by customers
CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES users(id) ON DELETE CASCADE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total DECIMAL(10,2) NOT NULL
);

-- Order Items: individual food items in an order
CREATE TABLE order_items (
    id SERIAL PRIMARY KEY,
    order_id INT REFERENCES orders(id) ON DELETE CASCADE,
    food_id INT REFERENCES foods(id) ON DELETE CASCADE,
    quantity INT NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL
);

-- Ratings: customer reviews on food
CREATE TABLE ratings (
    id SERIAL PRIMARY KEY,
    food_id INT REFERENCES foods(id) ON DELETE CASCADE,
    customer_id INT REFERENCES users(id) ON DELETE CASCADE,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- Insert Managers
INSERT INTO users (name, birthdate, gender, phone, email, password, role) VALUES
('Alice Manager', '1985-05-10', 'Female', '9876543210', 'alice@swiftbite.com', '$2a$10$wVP3gF9Q7BBoW3Fz0J9o4eD.g4PgD/NH7mEGE8j/c8TxrTPpd6dbu', 'manager'), -- password: manager123
('Bob Manager', '1980-02-20', 'Male', '9123456780', 'bob@swiftbite.com', '$2a$10$wVP3gF9Q7BBoW3Fz0J9o4eD.g4PgD/NH7mEGE8j/c8TxrTPpd6dbu', 'manager');

-- Insert Customers
INSERT INTO users (name, birthdate, gender, phone, email, password, role) VALUES
('Charlie Customer', '1995-07-15', 'Male', '9988776655', 'charlie@swiftbite.com', '$2a$10$wVP3gF9Q7BBoW3Fz0J9o4eD.g4PgD/NH7mEGE8j/c8TxrTPpd6dbu', 'customer'), -- password: customer123
('Diana Customer', '1992-03-25', 'Female', '8877665544', 'diana@swiftbite.com', '$2a$10$wVP3gF9Q7BBoW3Fz0J9o4eD.g4PgD/NH7mEGE8j/c8TxrTPpd6dbu', 'customer');

-- Insert Hotels
INSERT INTO hotels (manager_id, name, description) VALUES
(1, 'Alice’s Diner', 'Cozy place serving classic meals.'),
(2, 'Bob’s Bistro', 'Modern cuisine with a twist.');

-- Insert Foods (with dummy image — you’ll upload real images later via the app)
INSERT INTO foods (hotel_id, name, price, available) VALUES
(1, 'Cheeseburger', 5.99, true),
(1, 'Pasta Carbonara', 7.49, true),
(2, 'Grilled Salmon', 12.99, true),
(2, 'Caesar Salad', 4.99, true);

-- Insert Orders
INSERT INTO orders (customer_id, total) VALUES
(3, 18.47);

-- Insert Order Items
INSERT INTO order_items (order_id, food_id, quantity, subtotal) VALUES
(1, 1, 2, 11.98),
(1, 2, 1, 7.49);

-- Insert Ratings
INSERT INTO ratings (food_id, customer_id, rating, comment) VALUES
(1, 3, 5, 'Delicious and juicy!'),
(3, 4, 4, 'Very tasty but a bit pricey.');


