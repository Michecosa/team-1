# DB SCHEMA

## Table name: dualia (entity name: _dualia_)

## CATEGORY

- `category_id` INT AUTO_INCREMENT **PRIMARY KEY**
- `name` VARCHAR(50) NOT NULL
- `description` TEXT NULL

## PRODUCT

- `name` VARCHAR(50) NOT NULL **PRIMARY KEY**
- `description` TEXT NOT NULL
- `price` DECIMAL(10,2) NOT NULL
- `full_price` DECIMAL(10,2) NOT NULL
- `product_quantity` INT NULL
- `color` VARCHAR(50) NULL
- `dimensions` VARCHAR(50) NOT NULL
- `url_image` VARCHAR(255)
- `category_id` INT _FOREIGN KEY_

## DISCOUNT

- `promotion_id` INT AUTO_INCREMENT **PRIMARY KEY**
- `name` VARCHAR(100) NOT NULL
- `description` TEXT NULL
- `discount_type` ENUM('percentage', 'fixed') NOT NULL
- `discount_value` DECIMAL(10,2) NOT NULL
- `start_date` DATE NOT NULL
- `end_date` DATE NOT NULL
- `active` BOOLEAN DEFAULT TRUE
- `promo_code` VARCHAR(50) UNIQUE NULL

## ORDER

- `order_id` INT AUTO_INCREMENT **PRIMARY KEY**
- `date` DATE NOT NULL
- `total_amount` DECIMAL(10,2) NOT NULL
- `status` VARCHAR(50) NOT NULL
- `promotion_id` INT _FOREIGN KEY_
- `free_shipping` BOOLEAN DEFAULT FALSE
- `email` VARCHAR(100) NOT NULL
- `first_name` VARCHAR(50) NOT NULL
- `last_name` VARCHAR(50) NOT NULL
- `street` VARCHAR(255) NOT NULL
- `house_number` VARCHAR(10) NOT NULL
- `city` VARCHAR(50) NOT NULL
- `state` VARCHAR(50) NOT NULL
- `postal_code` VARCHAR(20) NOT NULL
- `country` VARCHAR(50) NOT NULL

## ORDER_ITEM

- `order_id` INT _FOREIGN KEY_
- `product_id` INT _FOREIGN KEY_
- `quantity` INT NOT NULL
- `price` DECIMAL(10,2) NOT NULL
- **PRIMARY KEY** (`order_id`, `product_id`)
