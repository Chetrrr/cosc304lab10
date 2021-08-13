DROP TABLE review;
DROP TABLE shipment;
DROP TABLE productinventory;
DROP TABLE warehouse;
DROP TABLE orderproduct;
DROP TABLE incart;
DROP TABLE product;
DROP TABLE category;
DROP TABLE ordersummary;
DROP TABLE paymentmethod;
DROP TABLE customer;


CREATE TABLE customer (
    customerId          INT IDENTITY,
    firstName           VARCHAR(40),
    lastName            VARCHAR(40),
    email               VARCHAR(50),
    phonenum            VARCHAR(20),
    address             VARCHAR(50),
    city                VARCHAR(40),
    state               VARCHAR(20),
    postalCode          VARCHAR(20),
    country             VARCHAR(40),
    userid              VARCHAR(20),
    password            VARCHAR(30),
    PRIMARY KEY (customerId)
);

CREATE TABLE paymentmethod (
    paymentMethodId     INT IDENTITY,
    paymentType         VARCHAR(20),
    paymentNumber       VARCHAR(30),
    paymentExpiryDate   DATE,
    customerId          INT,
    PRIMARY KEY (paymentMethodId),
    FOREIGN KEY (customerId) REFERENCES customer(customerid)
        ON UPDATE CASCADE ON DELETE CASCADE 
);

CREATE TABLE ordersummary (
    orderId             INT IDENTITY,
    orderDate           DATETIME,
    totalAmount         DECIMAL(10,2),
    shiptoAddress       VARCHAR(50),
    shiptoCity          VARCHAR(40),
    shiptoState         VARCHAR(20),
    shiptoPostalCode    VARCHAR(20),
    shiptoCountry       VARCHAR(40),
    customerId          INT,
    PRIMARY KEY (orderId),
    FOREIGN KEY (customerId) REFERENCES customer(customerid)
        ON UPDATE CASCADE ON DELETE CASCADE 
);

CREATE TABLE category (
    categoryId          INT IDENTITY,
    categoryName        VARCHAR(50),    
    PRIMARY KEY (categoryId)
);

CREATE TABLE product (
    productId           INT IDENTITY,
    productName         VARCHAR(40),
    productPrice        DECIMAL(10,2),
    productImageURL     VARCHAR(100),
    productImage        VARBINARY(MAX),
    productDesc         VARCHAR(1000),
    categoryId          INT,
    PRIMARY KEY (productId),
    FOREIGN KEY (categoryId) REFERENCES category(categoryId)
);

CREATE TABLE orderproduct (
    orderId             INT,
    productId           INT,
    quantity            INT,
    price               DECIMAL(10,2),  
    PRIMARY KEY (orderId, productId),
    FOREIGN KEY (orderId) REFERENCES ordersummary(orderId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE incart (
    orderId             INT,
    productId           INT,
    quantity            INT,
    price               DECIMAL(10,2),  
    PRIMARY KEY (orderId, productId),
    FOREIGN KEY (orderId) REFERENCES ordersummary(orderId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE warehouse (
    warehouseId         INT IDENTITY,
    warehouseName       VARCHAR(30),    
    PRIMARY KEY (warehouseId)
);

CREATE TABLE shipment (
    shipmentId          INT IDENTITY,
    shipmentDate        DATETIME,   
    shipmentDesc        VARCHAR(100),   
    warehouseId         INT, 
    PRIMARY KEY (shipmentId),
    FOREIGN KEY (warehouseId) REFERENCES warehouse(warehouseId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE productinventory ( 
    productId           INT,
    warehouseId         INT,
    quantity            INT,
    price               DECIMAL(10,2),  
    PRIMARY KEY (productId, warehouseId),   
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (warehouseId) REFERENCES warehouse(warehouseId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE review (
    reviewId            INT IDENTITY,
    reviewRating        INT,
    reviewDate          DATETIME,   
    customerId          INT,
    productId           INT,
    reviewComment       VARCHAR(1000),          
    PRIMARY KEY (reviewId),
    FOREIGN KEY (customerId) REFERENCES customer(customerId)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO category(categoryName) VALUES ('Beverages');
INSERT INTO category(categoryName) VALUES ('Food');
INSERT INTO category(categoryName) VALUES ('Personal Care');
INSERT INTO category(categoryName) VALUES ('Toys');
INSERT INTO category(categoryName) VALUES ('Custom Keyboard');
INSERT INTO category(categoryName) VALUES ('Accessories');
INSERT INTO category(categoryName) VALUES ('Streaming Gear');
INSERT INTO category(categoryName) VALUES ('PC Components');


INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('VTuber Keycaps', 5, 'Vtuber themed keycaps for simps',118.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Universal Gaming Controller',6,'RGB ready gaming controller for PC',39.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Gaming Fuel',1,'550 ml ready to mix energy drink',10.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Instant Noodles',2,'Fire noodles extra spicy',2.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Reflex Brown Gaming Switches 32g',5,'Brown silent switches',21.35);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('HD Streaming Gaming Camera',7,'Camera for streaming 720p ready',75.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Wireless Mouse',6,'Lightweight zero latency wireless mouse',50.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Ultrafast Zero Latency LEMO USB Cable',5,'LEMO connector high speed connector',80.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Overpriced Mechanical Keyboard',5,'Mechanical keyboard (does not include switches or keycaps)',197.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Printed Desk Pad',6,'Custom printed desk mat',31.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Freespin Gaming Industry Chair',6,'Gaming chair using japanese ball bearings',821.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Keyboard Carrying Case',5,'Fits most keyboards',38.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Exotic Keycaps',5,'Highly visible keycaps',123.25);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Professional Gaming Keycaps',5,'Rubber keycaps for extra grip',25.50);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Scented Soap',3,'Assorted soap',17.45);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('RGB Strips',8,'Yellow LED strips',39.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Gamer''s Choice Microphone for Streaming',7,'USB microphone plug and play',62.50);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('RGB Boomarm',7,'360 rotation noise reducing arm',19.20);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Gamer''s Choice Shockmount',7,'Comes with pop filter',11.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Astro Gaming Headphones',6,'Red',120.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Professional Gaming Water Bottle',6,'RGB ready water bottle easy twist',11.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Gamer''s Choice RGB IEMs',6,'Wired earphones',214.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('PrayStation 6',4,'For gamers by gamers',418.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Punko Pops',4,'Exclusive online store only',19.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Translucent RGB OK Stabilizers',5,'RGB ready plate mount stabilizers',18.40);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Gaming Quick Springs 36g',5,'Easy to swap springs',9.65);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Quick Install Gaskets',5,'Peel and stick gaskets',14.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Extra RGB Hotswap PCB',5,'Hotswap beat the competition PCB',51.05);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Carbon Fibre 60% Plate',5,'Extra stiff easily replacable plate',24.00);
    
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Arnold', 'Anderson', 'a.anderson@gmail.com', '204-111-2222', '103 AnyWhere Street', 'Winnipeg', 'MB', 'R3X 45T', 'Canada', 'arnold' , 'test');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Bobby', 'Brown', 'bobby.brown@hotmail.ca', '572-342-8911', '222 Bush Avenue', 'Boston', 'MA', '22222', 'United States', 'bobby' , 'bobby');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Candace', 'Cole', 'cole@charity.org', '333-444-5555', '333 Central Crescent', 'Chicago', 'IL', '33333', 'United States', 'candace' , 'password');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Darren', 'Doe', 'oe@doe.com', '250-807-2222', '444 Dover Lane', 'Kelowna', 'BC', 'V1V 2X9', 'Canada', 'darren' , 'pw');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Elizabeth', 'Elliott', 'engel@uiowa.edu', '555-666-7777', '555 Everwood Street', 'Iowa City', 'IA', '52241', 'United States', 'beth' , 'test');


DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (1, '2019-10-15 10:25:55', 91.70)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 1, 1, 18)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 5, 2, 21.35)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 10, 1, 31);

DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (2, '2019-10-16 18:00:00', 106.75)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 5, 5, 21.35);

DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (3, '2019-10-15 3:30:22', 140)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 6, 2, 25)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 7, 3, 30);

DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (2, '2019-10-17 05:45:11', 327.85)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 3, 4, 10)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 8, 3, 40)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 13, 3, 23.25)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 28, 2, 21.05)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 29, 4, 14);

DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (5, '2019-10-15 10:25:55', 277.40)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 5, 4, 21.35)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 19, 2, 81)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 20, 3, 10);