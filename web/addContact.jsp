<%-- 
    Document   : addContact
    Created on : Apr 28, 2018, 7:35:19 PM
    Author     : valentino
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>New Contact Page</title>
        <link rel="stylesheet" type="text/css" href="style.css">
    </head>
    <body>
    <center>
        <%!
            Connection conn;
            PreparedStatement pstmt;
            //Statement stmt;
            //ResultSet result;
            String qry;

        %>
        <%
            if (request.getParameter("btnAdd")!=null){
                try{
                    Class.forName("com.mysql.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/test","root","");
                    //stmt = conn.createStatement();
                    qry = "INSERT IGNORE INTO phonebook(Nama,NomorHp,Alamat) VALUES(?,?,?)";
                    pstmt = conn.prepareStatement(qry);
                    pstmt.setString(1, request.getParameter("txtNama"));
                    pstmt.setString(2, request.getParameter("txtNoHp"));                    
                    pstmt.setString(3, request.getParameter("txtAlamat"));
                    pstmt.executeUpdate();
                    response.sendRedirect("./contacts.jsp");
                    //result = stmt.executeQuery(qry);
                }catch(ClassNotFoundException cnfe){
                    out.println("Class Not Found Exception :- " + cnfe.toString());
                }catch(SQLException sqle){
                    out.println("SQL Query Exception :- " + sqle);
                }
            }
        %>
        
        <h1>Add New Contact</h1>
        <form id="addForm" action="" method="POST">
            <table border="1" cellspacing="5" cellpadding="5">
                <tbody>
                    <tr>
                        <td>Nama : </td>
                        <td><input type="text" name="txtNama" id="txtNama" /></td>
                    </tr>
                    <tr>
                        <td>Nomor HP : </td>
                        <td><input type="text" name="txtNoHp" id="txtNoHp" /></td>
                    </tr>
                    <tr>
                        <td>Alamat : </td>
                        <td><input type="text" name="txtAlamat" id="txtAlamat" /></td>
                    </tr>
                    <tr>
                        <td><input type="submit" name="btnAdd" value="Save New Contact" id="btnAdd" /></td>
                        <td align = "right"><a href="contacts.jsp">Cancel</a></td>
                    </tr>
                </tbody>
            </table>

        </form>
    </center>
    </body>
</html>
