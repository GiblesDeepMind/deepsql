-- ��¥ ǥ�� ����
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';

DROP TABLE user_info;

/*user_info ���̺� ����*/
CREATE TABLE user_info(
    personID NUMBER NOT NULL,
    register_Date DATE,
    personName VARCHAR2(50),
    address VARCHAR2(50),
    age NUMBER,
    PRIMARY KEY(personID)
);

INSERT INTO user_info(personID, register_Date, personName, address, age)
VALUES(1, '2010-01-01', '�����', '����', NULL);
INSERT INTO user_info(personID, register_Date, personName, address, age)
VALUES(2, '2012-03-18', 'õ����', '����', 28);
INSERT INTO user_info(personID, register_Date, personName, address, age)
VALUES(3, '2013-07-15', '������', NULL, 29);
INSERT INTO user_info(personID, register_Date, personName, address, age)
VALUES(4, '2016-10-23', '�赿��', '�λ�', 35);
INSERT INTO user_info(personID, register_Date, personName, address, age)
VALUES(5, '2019-06-13', NULL, '����', 28);

select * from user_info;

/*purchase_order ���̺� ����*/
CREATE TABLE purchase_order(
    personID NUMBER,
    orderID NUMBER NOT NULL,  
    orderDate DATE,
    Reciever VARCHAR2(50),
    order_address VARCHAR2(50),
    product_name VARCHAR2(50),
    price NUMBER,
    quantity NUMBER,
    PRIMARY KEY(orderID),
    CONSTRAINT FK_personID FOREIGN KEY (PersonID) 
    REFERENCES user_info(personID)
    );
    
INSERT INTO purchase_order(personID, orderID, orderDate, Reciever, order_address, product_name, price, quantity)
VALUES(1, 100000001, '2020-10-05 10:30:22', '��η�', 'LA', '�渶����', 100000, 1);
INSERT INTO purchase_order(personID, orderID, orderDate, Reciever, order_address, product_name, price, quantity)
VALUES(3, 300000001, '2017-08-03 17:21:35', '������', '�д籸', 'ġ�׵���', 120000, 1);
INSERT INTO purchase_order(personID, orderID, orderDate, Reciever, order_address, product_name, price, quantity)
VALUES(3, 300000002, '2019-02-22 08:37:38', '������', '�д籸', '���콺', 11000, 1);
INSERT INTO purchase_order(personID, orderID, orderDate, Reciever, order_address, product_name, price, quantity)
VALUES(5, 500000001, '2019-09-30 18:11:23', '��׷�', '����', '�ƺ�', 2000000, 1);
INSERT INTO purchase_order(personID, orderID, orderDate, Reciever, order_address, product_name, price, quantity)
VALUES(5, 500000002, '2020-02-22 19:22:16', '��׷�', '����', '�����е�', 1000000, 1);

SELECT * FROM purchase_order;

-- ���� �߻� : ���Ἲ ����
INSERT INTO purchase_order(personID, orderID, orderDate, Reciever, order_address, product_name, price, quantity)
VALUES(6, 600000001, '2020-02-23 17:42:16', '�ȿ���', '����', '����ũž', 3000000, 1);

-- ���� �߻� : ����Ű ����
DROP TABLE user_info;