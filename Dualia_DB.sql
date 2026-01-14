-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: localhost    Database: dualia
-- ------------------------------------------------------
-- Server version	8.0.44

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `category_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `description` text,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'Decorations','Decorative objects for interiors'),(2,'Lighting','Lamps and lights for the home'),(3,'Candles and Scents','Candles, diffusers and incense'),(4,'Furniture','Furniture and home accessories'),(5,'Clocks and Frames','Decorative clocks and frames'),(6,'Zen Garden','Decorative elements for relaxation and meditation');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `discount`
--

DROP TABLE IF EXISTS `discount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `discount` (
  `promotion_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` text,
  `discount_type` enum('percentage','fixed') NOT NULL,
  `discount_value` decimal(10,2) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `active` tinyint(1) DEFAULT '1',
  `promo_code` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`promotion_id`),
  UNIQUE KEY `promo_code` (`promo_code`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `discount`
--

LOCK TABLES `discount` WRITE;
/*!40000 ALTER TABLE `discount` DISABLE KEYS */;
INSERT INTO `discount` VALUES (1,'Welcome','Welcome discount for new customers','percentage',10.00,'2026-01-01','2026-12-31',1,'WELCOME10'),(2,'Winter Sales','Seasonal discounts on selected products','percentage',20.00,'2025-01-15','2025-02-28',1,'WINTER20'),(3,'Black Friday','Black Friday promotion on the entire catalog','percentage',30.00,'2025-11-25','2025-11-30',0,'BLACK30'),(4,'Free Shipping','Fixed discount equivalent to shipping costs','fixed',9.99,'2025-03-01','2025-12-31',1,'FREESHIP'),(5,'Furniture Discount','Fixed discount on furniture products','fixed',50.00,'2025-04-01','2025-06-30',1,'FURNITURE50');
/*!40000 ALTER TABLE `discount` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_item`
--

DROP TABLE IF EXISTS `order_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_item` (
  `order_id` int NOT NULL,
  `product_id` varchar(50) NOT NULL,
  `quantity` int NOT NULL,
  `price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`order_id`,`product_id`),
  KEY `order_item_ibfk_2` (`product_id`),
  CONSTRAINT `order_item_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  CONSTRAINT `order_item_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_item`
--

LOCK TABLES `order_item` WRITE;
/*!40000 ALTER TABLE `order_item` DISABLE KEYS */;
INSERT INTO `order_item` VALUES (1,'art-wall-white',1,999.99),(1,'hourglass-black',2,324.99),(2,'large-candle-white',1,69.99),(2,'small-candle-black',2,49.99),(3,'floor-lamp-black',1,1119.99),(3,'side-table-black',1,304.99),(4,'large-vase-white',1,1129.99),(4,'small-vase-black',1,544.99);
/*!40000 ALTER TABLE `order_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `order_id` int NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `status` varchar(50) NOT NULL,
  `promotion_id` int DEFAULT NULL,
  `free_shipping` tinyint(1) DEFAULT '0',
  `email` varchar(100) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `street` varchar(255) NOT NULL,
  `house_number` varchar(10) NOT NULL,
  `city` varchar(50) NOT NULL,
  `state` varchar(50) NOT NULL,
  `postal_code` varchar(20) NOT NULL,
  `country` varchar(50) NOT NULL,
  PRIMARY KEY (`order_id`),
  KEY `orders_ibfk_1` (`promotion_id`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`promotion_id`) REFERENCES `discount` (`promotion_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,'2025-01-10',189.98,'paid',1,0,'mario.rossi@email.it','Mario','Rossi','Via Roma','15','Milan','MI','20100','Italy'),(2,'2025-01-18',79.98,'shipped',NULL,1,'luca.bianchi@email.it','Luca','Bianchi','Corso Italia','102','Turin','TO','10100','Italy'),(3,'2025-02-02',349.99,'delivered',2,0,'giulia.verdi@email.it','Giulia','Verdi','Via Garibaldi','8','Rome','RM','00100','Italy'),(4,'2025-02-10',129.99,'pending',4,1,'francesca.neri@email.it','Francesca','Neri','Via Dante','21','Bologna','BO','40100','Italy');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `product_id` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `full_price` decimal(10,2) NOT NULL,
  `product_quantity` int DEFAULT NULL,
  `color` varchar(50) DEFAULT NULL,
  `dimensions` varchar(50) NOT NULL,
  `url_image` varchar(255) DEFAULT NULL,
  `category_id` int NOT NULL,
  PRIMARY KEY (`product_id`),
  KEY `products_ibfk_1` (`category_id`),
  CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES ('art-wall-black','Art Wall black','Handcrafted from exquisite wood and delicately inlaid with gold, Art Wall reveals its essence in understated elegance. More than mere furnishings, each piece is an organic work of art, designed to harmonize man and nature, evoking both balance and refined sophistication. Every creation is meticulously handcrafted and accompanied by a unique certificate of authenticity. Not simply decoration—this is pure Dualia artistry.',10000.00,10000.00,15,'Black','150x120','artWall_black',1),('art-wall-white','Art Wall white','Handcrafted from exquisite wood and delicately inlaid with gold, Art Wall reveals its essence in understated elegance. More than mere furnishings, each piece is an organic work of art, designed to harmonize man and nature, evoking both balance and refined sophistication. Every creation is meticulously handcrafted and accompanied by a unique certificate of authenticity. Not simply decoration—this is pure Dualia artistry.',10000.00,10000.00,15,'White','150x120','artWall_white',1),('ashtray-black','Ashtray black','Kintsugi is the ancient Japanese art of repairing objects with gold—an exquisite reminder that it is often our wounds and imperfections that make us strong. The Dualia ashtray is crafted with this very philosophy in mind. Smoke whispers of our fleeting existence, a single breath capable of erasing us entirely. In this way, the ashtray becomes a profound metaphor for our time on Earth—a singular piece that, in moments of relaxation and sharing, reminds us to rejoice simply in being. A constant memento mori accompanying us through our days. Each creation is unique, handcrafted, and accompanied by a certificate of authenticity.',814.99,819.99,25,'Black','12x12x5','luxury_ashtray_black',1),('ashtray-white','Ashtray white','Kintsugi is the ancient Japanese art of repairing objects with gold—an exquisite reminder that it is often our wounds and imperfections that make us strong. The Dualia ashtray is crafted with this very philosophy in mind. Smoke whispers of our fleeting existence, a single breath capable of erasing us entirely. In this way, the ashtray becomes a profound metaphor for our time on Earth—a singular piece that, in moments of relaxation and sharing, reminds us to rejoice simply in being. A constant memento mori accompanying us through our days. Each creation is unique, handcrafted, and accompanied by a certificate of authenticity.',814.99,819.99,25,'White','12x12x5','luxury_ashtray_white',1),('buddha-statue-black','Buddha Statue black','Buddha has always been a profoundly powerful spiritual figure. Radiating serenity and peace, he has served for centuries as a beacon of hope for millions. This statue is crafted by master artisans using the finest materials, with meticulous attention to detail and a conscientious respect for the environment at every stage of its creation.',549.99,549.99,20,'Black','25x18x40','bhudda_black',1),('buddha-statue-white','Buddha Statue white','Buddha has always been a profoundly powerful spiritual figure. Radiating serenity and peace, he has served for centuries as a beacon of hope for millions. This statue is crafted by master artisans using the finest materials, with meticulous attention to detail and a conscientious respect for the environment at every stage of its creation.',549.99,549.99,20,'White','25x18x40','bhudda_bianco',1),('candle-holder-black','Candle Holder Black','The Dualia Rose Candle Holders merge delicate design with the subtle power of fragrance. Each miniature bloom cradles a candle whose gentle aroma reconnects the spirit with nature, fostering balance and serenity. Crafted with elegance and attention to detail, these sculptural pieces transform light and scent into a moment of contemplative beauty—inviting the calm and harmony of the natural world into every refined interior.',49.99,75.99,20,'Black','8x8x9','porta_candela_black',1),('candle-holder-white','Candle Holder Black','The Dualia Rose Candle Holders merge delicate design with the subtle power of fragrance. Each miniature bloom cradles a candle whose gentle aroma reconnects the spirit with nature, fostering balance and serenity. Crafted with elegance and attention to detail, these sculptural pieces transform light and scent into a moment of contemplative beauty—inviting the calm and harmony of the natural world into every refined interior.',49.99,75.99,20,'White','8x8x9','porta_candela_white',1),('clock-black','Clock black','The Dualia watch is the perfect adornment for any setting. Crafted with elements of gold and glass, its movement is meticulously produced in Switzerland by expert watchmakers, ensuring unparalleled precision and enduring quality. More than a timepiece, it is an ornamental masterpiece that elevates and enriches every environment it graces.',449.99,449.99,14,'Black','35x35','orologio_black',5),('clock-white','Clock white','The Dualia watch is the perfect adornment for any setting. Crafted with elements of gold and glass, its movement is meticulously produced in Switzerland by expert watchmakers, ensuring unparalleled precision and enduring quality. More than a timepiece, it is an ornamental masterpiece that elevates and enriches every environment it graces.',449.99,449.99,14,'White','35x35','orologio_white',5),('diffuser-black','Diffuser black','In its understated elegance, the Dualia diffuser is the perfect instrument for restoring balance. Carefully designed to be both resilient and refined, it enhances any environment it graces. Engineered to release a fragrance that harmonizes the spirit, it requires no additional oils—our diffuser is crafted to envelop your space in its captivating scent for as long as needed, creating an ambiance of enduring serenity.',72.99,80.99,35,'Black','8x8x20','diffusore_black',3),('diffuser-white','Diffuser white','In its understated elegance, the Dualia diffuser is the perfect instrument for restoring balance. Carefully designed to be both resilient and refined, it enhances any environment it graces. Engineered to release a fragrance that harmonizes the spirit, it requires no additional oils—our diffuser is crafted to envelop your space in its captivating scent for as long as needed, creating an ambiance of enduring serenity.',72.99,80.99,35,'White','8x8x20','diffusore_white',3),('floor-lamp-black','Floor Lamp black','The Dualia Floor Lamp embodies minimalist sophistication, where sleek lines meet subtle opulence. Inlaid with touches of gold, it transforms light into a sculptural presence, casting a warm, refined glow that elevates any interior. More than illumination, it is a statement of elegance—a harmonious fusion of artistry and function designed to enrich the spaces it adorns.',1149.99,1149.99,10,'Black','30x30x160','floor_lamp_black',2),('floor-lamp-white','Floor Lamp white','The Dualia Floor Lamp embodies minimalist sophistication, where sleek lines meet subtle opulence. Inlaid with touches of gold, it transforms light into a sculptural presence, casting a warm, refined glow that elevates any interior. More than illumination, it is a statement of elegance—a harmonious fusion of artistry and function designed to enrich the spaces it adorns.',1149.99,1149.99,10,'White','30x30x160','floor_lamp_white',2),('hourglass-black','Hourglass black','The Dualia Hourglass is an elegant testament to the passage of time, a sculptural piece designed for desks and tables alike. Encased in refined materials, its graceful sands flow with quiet inevitability, a reminder of time’s relentless and beautiful march. More than a decorative object, it invites reflection—turning every glance into a moment of contemplation, a celebration of the fleeting yet precious nature of existence.',324.99,334.99,30,'Black','12x12x25','clessidra_black',1),('hourglass-white','Hourglass white','The Dualia Hourglass is an elegant testament to the passage of time, a sculptural piece designed for desks and tables alike. Encased in refined materials, its graceful sands flow with quiet inevitability, a reminder of time’s relentless and beautiful march. More than a decorative object, it invites reflection—turning every glance into a moment of contemplation, a celebration of the fleeting yet precious nature of existence.',324.99,334.99,30,'White','12x12x25','clessidra_white',1),('incense-burner-black','Incense Burner black','The Dualia Incense Burner is a refined instrument of serenity, where form and philosophy unite. Crafted to release aromatic wisps that purify the air, it transforms smoke into a subtle ritual of calm and introspection. Each fragrance is carefully designed to soothe the spirit, creating an atmosphere of balance and quiet elegance. More than a functional object, it is a contemplative presence—an invitation to pause, breathe, and embrace the serenity that surrounds you.',282.99,282.99,20,'Black','9x9x12','porta_incenso_black',3),('incense-burner-white','Incense Burner white','The Dualia Incense Burner is a refined instrument of serenity, where form and philosophy unite. Crafted to release aromatic wisps that purify the air, it transforms smoke into a subtle ritual of calm and introspection. Each fragrance is carefully designed to soothe the spirit, creating an atmosphere of balance and quiet elegance. More than a functional object, it is a contemplative presence—an invitation to pause, breathe, and embrace the serenity that surrounds you.',282.99,282.99,20,'White','9x9x12','porta_incenso_white',3),('lamp-black','Lamp black','The Dualia Desk Lamp embodies refined craftsmanship and enduring elegance. Sculpted from the finest materials, it offers a solid and graceful presence, casting a luminous glow that enhances both workspace and ambiance. Designed to illuminate with precision while enriching any interior, it stands as a testament to functional beauty—where sophistication meets purpose in perfect harmony.',409.99,609.99,18,'Black','25x25x45','lampada_black',2),('lamp-white','Lamp white','The Dualia Desk Lamp embodies refined craftsmanship and enduring elegance. Sculpted from the finest materials, it offers a solid and graceful presence, casting a luminous glow that enhances both workspace and ambiance. Designed to illuminate with precision while enriching any interior, it stands as a testament to functional beauty—where sophistication meets purpose in perfect harmony.',409.99,609.99,18,'White','25x25x45','lampada_white',2),('lantern-black','Lantern black','The Dualia Lantern evokes a quietly powerful dialogue between darkness and light. Within its sleek black frame rests a pure white candle, a striking contrast that speaks to the duality of existence. As the flame gently illuminates its surroundings, it reveals how shadow and radiance are two faces of the same coin—each defining and elevating the other. More than a decorative accent, it is a contemplative object that transforms any space into a scene of refined balance and poetic harmony.',304.99,404.99,22,'Black','18x18x35','lanterna_black',2),('lantern-white','Lantern white','The Dualia Lantern evokes a quietly powerful dialogue between darkness and light. Within its sleek black frame rests a pure white candle, a striking contrast that speaks to the duality of existence. As the flame gently illuminates its surroundings, it reveals how shadow and radiance are two faces of the same coin—each defining and elevating the other. More than a decorative accent, it is a contemplative object that transforms any space into a scene of refined balance and poetic harmony.',304.99,404.99,22,'White','18x18x35','lanterna_white',2),('large-candle-black','Large Candle black','The Dualia Candle honors a tradition that has endured for centuries. Once an essential source of light, the candle has long been cherished for its calming presence and gentle glow throughout the history of humanity. Crafted with refined materials, it creates an atmosphere of quiet warmth and understated elegance—an invitation to slow down, reflect, and savor the simple luxury of illumination.',84.99,84.99,40,'Black','10x10x15','candela_black_big',3),('large-candle-white','Large Candle white','The Dualia Candle honors a tradition that has endured for centuries. Once an essential source of light, the candle has long been cherished for its calming presence and gentle glow throughout the history of humanity. Crafted with refined materials, it creates an atmosphere of quiet warmth and understated elegance—an invitation to slow down, reflect, and savor the simple luxury of illumination.',84.99,84.99,40,'White','10x10x15','candela_white_big',3),('large-photo-frame-black','Large Photo Frame black','The Dualia Photo Frame embodies minimalist luxury, where clean lines meet exquisite refinement. Crafted from premium materials, it offers an understated presence that elevates the photograph within, transforming memories into curated works of art. Designed to complement any interior, it stands as a discreet yet opulent accent—celebrating the beauty of both craftsmanship and the moments it preserves.',134.99,134.99,20,'Black','30x40','cornice_black_big',5),('large-photo-frame-white','Large Photo Frame white','The Dualia Photo Frame embodies minimalist luxury, where clean lines meet exquisite refinement. Crafted from premium materials, it offers an understated presence that elevates the photograph within, transforming memories into curated works of art. Designed to complement any interior, it stands as a discreet yet opulent accent—celebrating the beauty of both craftsmanship and the moments it preserves.',134.99,134.99,20,'White','30x40','cornice_white_big',5),('large-vase-black','Large Vase black','The Dualia Apartment Vase embodies minimalist refinement, designed to complement sophisticated interiors with effortless grace. Crafted from recycled, environmentally conscious materials, it merges contemporary elegance with a deep respect for nature. Its clean silhouette and timeless presence make it a versatile accent for any room—enhancing spaces with understated beauty and sustainable sophistication.',544.99,559.99,12,'Black','25x25x50','vaso_black',4),('large-vase-white','Large Vase white','The Dualia Apartment Vase embodies minimalist refinement, designed to complement sophisticated interiors with effortless grace. Crafted from recycled, environmentally conscious materials, it merges contemporary elegance with a deep respect for nature. Its clean silhouette and timeless presence make it a versatile accent for any room—enhancing spaces with understated beauty and sustainable sophistication.',544.99,559.99,12,'White','25x25x50','vaso_white',4),('side-table-black','Side Table black','The Dualia Side Table is a study in refined understatement—where simplicity in form reveals extraordinary depth in character. Crafted from the finest woods and premium marble, it merges natural opulence with meticulous craftsmanship. Elegant yet unassuming, it elevates any interior with quiet luxury, transforming a functional surface into a sculptural statement. More than a piece of furniture, it captivates the eye and enriches the space it inhabits—proof that true sophistication needs no excess to command admiration.',1129.99,1159.99,8,'Black','60x60x45','tavolino_black',4),('side-table-white','Side Table white','The Dualia Side Table is a study in refined understatement—where simplicity in form reveals extraordinary depth in character. Crafted from the finest woods and premium marble, it merges natural opulence with meticulous craftsmanship. Elegant yet unassuming, it elevates any interior with quiet luxury, transforming a functional surface into a sculptural statement. More than a piece of furniture, it captivates the eye and enriches the space it inhabits—proof that true sophistication needs no excess to command admiration.',1129.99,1159.99,8,'White','60x60x45','tavolino_white',4),('small-candle-black','Small Candle black','The Dualia Mini Candle pays tribute to a centuries-old tradition while seamlessly adapting to modern spaces. Compact yet refined, it offers the same soothing glow and calming presence that candles have provided throughout history. Its versatile form allows it to enhance any environment, adding a touch of quiet elegance and warmth wherever it resides.',49.99,54.99,50,'Black','7x7x8','candela_black_small',3),('small-candle-white','Small Candle white','The Dualia Mini Candle pays tribute to a centuries-old tradition while seamlessly adapting to modern spaces. Compact yet refined, it offers the same soothing glow and calming presence that candles have provided throughout history. Its versatile form allows it to enhance any environment, adding a touch of quiet elegance and warmth wherever it resides.',49.99,54.99,50,'White','7x7x8','candela_white_small',3),('small-frame-black','Small Frame black','The Dualia Mini Photo Frame distills luxury into a refined, compact form. Minimalist and meticulously crafted from premium materials, it enhances treasured memories without overwhelming the space around them. Its smaller scale makes it exceptionally versatile—ideal for desks, shelves, and intimate corners—offering a discreet touch of elegance that harmoniously complements any interior.',100.99,119.99,30,'Black','15x20','cornice_black_small',5),('small-frame-white','Small Frame white','The Dualia Mini Photo Frame distills luxury into a refined, compact form. Minimalist and meticulously crafted from premium materials, it enhances treasured memories without overwhelming the space around them. Its smaller scale makes it exceptionally versatile—ideal for desks, shelves, and intimate corners—offering a discreet touch of elegance that harmoniously complements any interior.',100.99,119.99,30,'White','15x20','cornice_white_small',5),('small-vase-black','Small Vase black','The Dualia Small Apartment Vase captures minimalist elegance in a refined, compact form. Crafted from recycled, environmentally conscious materials, it offers the same sustainable sophistication as its larger counterpart while fitting seamlessly into smaller spaces. Ideal for shelves, desks, and intimate corners, it enhances interiors with subtle beauty and modern restraint—proof that true elegance needs no grandeur to make an impact.',419.99,424.99,25,'Black','12x12x25','vaso_black_small',4),('small-vase-white','Small Vase white','The Dualia Small Apartment Vase captures minimalist elegance in a refined, compact form. Crafted from recycled, environmentally conscious materials, it offers the same sustainable sophistication as its larger counterpart while fitting seamlessly into smaller spaces. Ideal for shelves, desks, and intimate corners, it enhances interiors with subtle beauty and modern restraint—proof that true elegance needs no grandeur to make an impact.',419.99,424.99,25,'White','12x12x25','vaso_white_small',4),('zen-garden-black','Zen Garden black','The Dualia Desktop Zen Garden channels tranquility into a refined, compact form. Designed to inspire calm and focus, it brings a touch of meditative elegance to any workspace. Each element reflects traditional Zen philosophy, emphasizing harmony, balance, and the beauty of simplicity. Though modest in size, it carries profound meaning—inviting moments of quiet reflection and restoring equilibrium amid the pace of modern life.',69.99,89.99,18,'Black','20x20','giardino_zen_black',6),('zen-garden-deluxe-black','Zen Garden Deluxe black','The Dualia Deluxe Desktop Zen Garden elevates tranquility to an art form. With an array of carefully curated elements, it transforms any workspace into a sanctuary of focus and serenity. Each component is thoughtfully designed to embody Zen philosophy, balancing form, texture, and movement to cultivate harmony and reflection. More than a decorative object, it is a refined instrument of mindfulness—offering an immersive experience of elegance, calm, and inner equilibrium.',164.99,164.99,10,'Black','30x30','giardino_zen_delux_black',6),('zen-garden-deluxe-white','Zen Garden Deluxe white','The Dualia Deluxe Desktop Zen Garden elevates tranquility to an art form. With an array of carefully curated elements, it transforms any workspace into a sanctuary of focus and serenity. Each component is thoughtfully designed to embody Zen philosophy, balancing form, texture, and movement to cultivate harmony and reflection. More than a decorative object, it is a refined instrument of mindfulness—offering an immersive experience of elegance, calm, and inner equilibrium.',164.99,164.99,10,'White','30x30','giardino_zen_delux_white',6),('zen-garden-white','Zen Garden white','The Dualia Desktop Zen Garden channels tranquility into a refined, compact form. Designed to inspire calm and focus, it brings a touch of meditative elegance to any workspace. Each element reflects traditional Zen philosophy, emphasizing harmony, balance, and the beauty of simplicity. Though modest in size, it carries profound meaning—inviting moments of quiet reflection and restoring equilibrium amid the pace of modern life.',69.99,89.99,18,'White','20x20','giardino_zen_white',6);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-01-14 12:05:58
