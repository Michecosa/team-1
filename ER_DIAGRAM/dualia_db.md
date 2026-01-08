# DB SCHEMA

## Table name: dualia (entity name: _dualia_)

## USER

- `user_id` INT AUTO_INCREMENT **PRIMARY KEY**
- `first_name` VARCHAR(50) NOT NULL
- `last_name` VARCHAR(50) NOT NULL
- `email` VARCHAR(100) UNIQUE NOT NULL
- `password` VARCHAR(150) NOT NULL
- `address` VARCHAR(150) NOT NULL

## CATEGORY

- `category_id` INT AUTO_INCREMENT **PRIMARY KEY**
- `name` VARCHAR(50) NOT NULL
- `description` TEXT NULL

## PRODUCT

- `product_id` INT AUTO_INCREMENT **PRIMARY KEY**
- `name` VARCHAR(50) NOT NULL
- `description` TEXT NOT NULL
- `price` DECIMAL(10,2) NOT NULL
- `product_quantity` INT NULL
- `color` VARCHAR(50) NULL
- `dimensions` VARCHAR(50) NOT NULL
- `url_image` VARCHAR(255)
- `category_id` INT _FOREIGN KEY_

## WISHLIST

- `wishlist_id` INT AUTO_INCREMENT **PRIMARY KEY**
- `user_id` INT UNIQUE _FOREIGN KEY_

## WISHLIST_ITEM

- `wishlist_id` INT _FOREIGN KEY_
- `product_id` INT _FOREIGN KEY_
- **PRIMARY KEY** (`wishlist_id`, `product_id`)

## PROMOTION (or DISCOUNT)

- `promotion_id` INT AUTO_INCREMENT **PRIMARY KEY**
- `name` VARCHAR(100) NOT NULL
- `description` TEXT NULL
- `discount_type` ENUM('percentage', 'fixed') NOT NULL
- `discount_value` DECIMAL(10,2) NOT NULL
- `start_date` DATE NOT NULL
- `end_date` DATE NOT NULL
- `active` BOOLEAN DEFAULT TRUE
- `promo_code` VARCHAR(50) UNIQUE NULL
- `free_shipping` BOOLEAN DEFAULT FALSE

## ORDER

- `order_id` INT AUTO_INCREMENT **PRIMARY KEY**
- `user_id` INT _FOREIGN KEY_
- `order_date` DATE NOT NULL
- `total_amount` DECIMAL(10,2) NOT NULL
- `status` VARCHAR(50) NOT NULL
- `promotion_id` INT _FOREIGN KEY_

## ORDER_ITEM

- `order_id` INT _FOREIGN KEY_
- `product_id` INT _FOREIGN KEY_
- `quantity` INT NOT NULL
- `price` DECIMAL(10,2) NOT NULL
- **PRIMARY KEY** (`order_id`, `product_id`)

## CART

- `cart_id` INT AUTO_INCREMENT **PRIMARY KEY**
- `user_id` INT UNIQUE _FOREIGN KEY_

## CART_ITEM

- `cart_id` INT _FOREIGN KEY_
- `product_id` INT _FOREIGN KEY_
- QUANTITY INT NOT NULL
- **PRIMARY KEY** (`cart_id`, `product_id`)
