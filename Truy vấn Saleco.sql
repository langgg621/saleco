/*Câu truy vấn:
Câu 1:
Lấy ra bảng customer:*/
SELECT *
FROM CUSTOMER

/*Câu 2:
lấy ra những vật phẩm có giá > 20*/
SELECT *
FROM PRODUCT
WHERE P_PRICE > 20
/*Câu 3:
Đếm số hóa đơn trong hệ thống*/
SELECT COUNT (I.INV_NUM) AS TOTAL_OF_INVOICE
FROM INVOICE I
/*Câu 4:
Lấy ra hóa đơn, dòng hóa đơn, tên sản phẩm*/
SELECT I.INV_NUM,CUS_CODE,EMP_CODE,LINE_NUM,LINE_UNITS, P_NAME,P_PRICE
FROM INVOICE I INNER JOIN (INV_LINE L INNER JOIN PRODUCT P ON L.P_CODE = P.P_CODE )
        ON I.INV_NUM = L.INV_NUM
/*Câu 5:
Lấy ra đối tượng được thêm vào mới nhất trong bảng cơ sở dữ liệu.
Với điều kiện giả sử những đối tượng được thêm vào có thứ tự ID tăng dần vậy nên đối tượng được thêm vào mới nhất sẽ có ID là max.*/
SELECT *
FROM VENDOR 
WHERE V_CODE = (SELECT max(V_CODE) FROM VENDOR);
/*Câu 6:
Lấy ra người có tuổi cao thứ 2 trong bảng EMPLOYEE.*/
SELECT MAX(EMP_DOB) AS SECOND_OLDEST_PERSON
FROM (SELECT TOP 2 * FROM EMPLOYEE ORDER BY EMP_DOB) EMPLOYEE; 
/*Câu 7:
Lấy ra 5 người đầu tiên trong bảng CUSTOMER với thứ tự sắp xếp theo CUS_CODE tăng dần*/
SELECT *
FROM (SELECT ROW_NUMBER() OVER(ORDER BY CUS_CODE) AS ROW_NUM,* FROM CUSTOMER ) CUSTOMER 
WHERE ROW_NUM <= 5;
/*Câu 8:
Lấy ra những khách hàng đã mua hàng:*/
SELECT C.CUS_CODE, C.CUS_LNAME,C.CUS_FNAME,C.CUS_INITIAL
FROM CUSTOMER C INNER JOIN (INVOICE I INNER JOIN INV_LINE L ON I.INV_NUM = L.INV_NUM) ON C.CUS_CODE = I.CUS_CODE
GROUP BY C.CUS_CODE, C.CUS_LNAME,C.CUS_FNAME,C.CUS_INITIAL;
/*Câu 9:
Lấy ra thông tin tài khoản của những khách hàng đã mua hàng, lấy ra số tài khoản bé nhất, lớn nhất và trung bình*/
SELECT MIN(CUS_BALANCE) AS MIN_BALANCE, MAX(CUS_BALANCE) AS MAX_BALANCE, AVG(CUS_BALANCE) AS AVERAGE_BALANCE
FROM (SELECT CUSTOMER.CUS_CODE, CUS_BALANCE
FROM CUSTOMER INNER JOIN INVOICE ON CUSTOMER.CUS_CODE = INVOICE.CUS_CODE
GROUP BY CUSTOMER.CUS_CODE,CUS_BALANCE) CUSTOMER;
/*Câu 10:
Những nhân viên đã tạo ra hóa đơn và mã của hóa đơn đó:*/
SELECT E.EMP_NAME, I.INV_NUM
FROM INVOICE I INNER JOIN EMPLOYEE E ON I.EMP_CODE = E.EMP_CODE
ORDER BY EMP_NAME

/*Câu 11:
Những sản phẩm đã được bán, hóa đơn, giá tiền, số lượng và tổng giá tiền.*/
SELECT I.INV_NUM, P_NAME,P_TYPE,L.LINE_UNITS, P_PRICE, (P_PRICE*LINE_UNITS) AS TOTAL_PRICE
FROM CUSTOMER C INNER JOIN (
        INVOICE I INNER JOIN (
        INV_LINE L INNER JOIN PRODUCT P ON L.P_CODE = P.P_CODE) 
        ON I.INV_NUM = L.INV_NUM) ON C.CUS_CODE = I.CUS_CODE;
/*Câu 12:
Những mã giảm giá tương ứng với những sản phẩm và giá của sản phẩm sau khi áp dụng giảm giá*/
SELECT P.P_CODE , DIS_CONDITION, P_NAME,P_TYPE,P_PRICE, (P_PRICE - (P_PRICE * DIS_PERCENTAGE / 100)) AS AFTER_PRICE
FROM DISCOUNT D INNER JOIN PRODUCT P ON D.P_CODE = P.P_CODE
/*Câu 13:
Những hóa đơn áp dụng được mã giảm giá, tổng hóa đơn, sản phẩm và giá thành của sản phẩm sau khi giảm giá.
 Nếu không có mã giảm giá nào thì sẽ trả về không và nếu không thể áp dụng mã giảm giá nào thì giá trị của hóa đơn sẽ giữ nguyên.*/
SELECT I.INV_NUM, L.LINE_NUM,P.P_CODE,P.P_NAME,P_TYPE,P_PRICE, LINE_UNITS, 
    P_PRICE * LINE_UNITS AS TOTAL,ISNULL(D.DIS_CODE,' ') AS 'Discount code that can apply' ,
    ISNULL(P_PRICE * LINE_UNITS - (P_PRICE * LINE_UNITS * DIS_PERCENTAGE / 100),P_PRICE * LINE_UNITS) AS AFTER_DISCOUNT
FROM INVOICE I INNER JOIN (
    (INV_LINE L INNER JOIN PRODUCT P ON L.P_CODE = P.P_CODE )
    LEFT JOIN DISCOUNT	D ON L.DIS_CODE= D.DIS_CODE) ON I.INV_NUM = L.INV_NUM
/*Câu 14:
In ra những sản phẩm có giá thành tổng lớn nhất trong những đơn hàng*/
SELECT O.V_CODE,O.ORD_NUM, P.P_NAME,P.P_PRICE,OL.ORD_LINE_UNITS, MAX_PRICE_OF_ORDER
FROM (ORDER1 O INNER JOIN (
    ORD_LINE OL INNER JOIN PRODUCT P ON OL.P_CODE = P.P_CODE) ON O.ORD_NUM = OL.ORD_NUM ) 
    INNER JOIN (SELECT ORD_NUM, MAX(ORD_LINE_UNITS*P_PRICE) AS MAX_PRICE_OF_ORDER
    FROM ORD_LINE OL INNER JOIN PRODUCT P ON OL.P_CODE = P.P_CODE
GROUP BY ORD_NUM) ORDER1 ON O.ORD_NUM = ORDER1.ORD_NUM

/*Câu 15:
In ra tên nhân viên và người quản lý của họ*/
SELECT M.EMP_CODE AS MANAGER_CODE, M.EMP_NAME  AS MANAGER_NAME, E.EMP_CODE , E.EMP_NAME AS EMPLOYEE_NAME
FROM EMPLOYEE M, EMPLOYEE E
WHERE E.EMP_MANAGER = M.EMP_CODE
/*Câu 16:
In ra tổng số hóa đơn khách hàng đã có trong hệ thống và tính tổng số tiền , số tiền trung bình tiêu của những hóa đơn đó*/
SELECT CUSTOMER.CUS_CODE,CUS_BALANCE, ROUND(SUM(LINE_UNITS * P_PRICE),2) AS TOTAL_PURCHASE, 
    COUNT(LINE_UNITS) AS NUMBER_OF_PURCHASE, 
    ROUND((SUM(LINE_UNITS * P_PRICE)/COUNT(LINE_UNITS)),2) AS AVERAGE_PURCHASE_AMOUNT
FROM (INVOICE INNER JOIN CUSTOMER ON INVOICE.CUS_CODE = CUSTOMER.CUS_CODE) 
INNER JOIN (INV_LINE L INNER JOIN PRODUCT P ON L.P_CODE = P.P_CODE) ON INVOICE.INV_NUM=L.INV_NUM
GROUP BY CUSTOMER.CUS_CODE,CUS_BALANCE
ORDER BY CUS_CODE;

/*Câu 17:
In ra thông tin của những nhà cung cấp mà mình đặt hàng và có mã vùng là 322 hoặc 311*/
SELECT *
FROM VENDOR
WHERE V_ORDER = 'Y' AND (V_AREACODE = 322 OR V_AREACODE = 311)  
/*Câu 18
Lấy ra những sản phẩm được nhập vào trước ngày 9/10/2017*/
SELECT *
FROM PRODUCT
WHERE P_INDATE <= '2017-10-9'
/*Câu 19:
Lấy ra những khách hàng có hóa đơn và nằm trong vùng 615*/
SELECT C.CUS_CODE, CUS_LNAME , CUS_FNAME, CUS_INITIAL, INV_NUM
FROM CUSTOMER C INNER JOIN INVOICE I ON C.CUS_CODE = I.CUS_CODE
WHERE CUS_AREACODE = 615
/*Câu 20:
Lấy ra những sản phẩm trong kho và sắp xếp chúng theo giá tiền tổng giảm dần*/
SELECT P_NAME,P_TYPE,P_QOH,P_PRICE,(P_QOH*P_PRICE) AS Subtotal
From PRODUCT
ORDER BY Subtotal DESC;
/*Câu 21:
Tính tổng tiền trong tài khoản, số tiền lớn nhất, nhỏ nhất và trung bình của những khách hàng chưa mua hàng lần nào cả*/
SELECT SUM(CUS_BALANCE2) AS "Total balance",MIN(CUS_BALANCE2) AS "Minimun balance",
    MAX(CUS_BALANCE2) AS "Maximun balance",AVG(CUS_BALANCE2) AS "Average balance"
FROM(SELECT CUS_BALANCE AS CUS_BALANCE2
        FROM CUSTOMER, INVOICE
WHERE CUSTOMER.CUS_CODE NOT IN(
    SELECT CUSTOMER.CUS_CODE FROM CUSTOMER 
    INNER JOIN INVOICE ON CUSTOMER.CUS_CODE=INVOICE.CUS_CODE 
    GROUP BY CUSTOMER.CUS_CODE)
GROUP BY CUSTOMER.CUS_CODE,CUS_BALANCE) CUSTOMER;
/*Câu 22:
Tổng số sản phẩm đã bán ra*/
SELECT P_NAME,P.P_CODE,SUM(LINE_UNITS) AS 'Total sales'
FROM INVOICE I INNER JOIN (INV_LINE L 
        INNER JOIN PRODUCT P ON L.P_CODE=P.P_CODE)
        ON I.INV_NUM=L.INV_NUM
GROUP BY P_NAME,P.P_CODE
/*Câu 23:
Sản phẩm được bán ra nhiều nhất*/
SELECT TOP 1  P_NAME,P.P_CODE,SUM(LINE_UNITS) AS 'Total sales'
FROM INVOICE I INNER JOIN (INV_LINE L INNER JOIN PRODUCT P ON L.P_CODE=P.P_CODE)ON I.INV_NUM=L.INV_NUM
GROUP BY P_NAME,P.P_CODE
ORDER BY [Total sales] DESC
/*Câu 24:
In ra thông tin khách hàng mua hàng nhiều nhất:*/
SELECT TOP 1 C.CUS_CODE, C.CUS_LNAME,C.CUS_FNAME,C.CUS_INITIAL,C.CUS_PHONE, SUM(LINE_UNITS) AS 'Total of products purchased'
FROM CUSTOMER C INNER JOIN (INVOICE I INNER JOIN INV_LINE L ON I.INV_NUM=L.INV_NUM )ON C.CUS_CODE=I.CUS_CODE
GROUP BY C.CUS_CODE, C.CUS_LNAME,C.CUS_FNAME,C.CUS_INITIAL,C.CUS_PHONE
ORDER BY [Total of products purchased] DESC
