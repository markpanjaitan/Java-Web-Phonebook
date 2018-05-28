<%-- 
    Document   : updateContact
    Created on : Apr 29, 2018, 7:31:14 AM
    Author     : valentino
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Contact Page</title>
        <link rel="stylesheet" type="text/css" href="style.css">        
    </head>
    <body>

    <center>
        <%!
            Connection conn;
            PreparedStatement pstmt;
            ResultSet result;
            String qry;
            Integer contactId;
        %>
        <%
            conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/test","root","");
            
            if(request.getParameter("btnUpd") != null){
                contactId = Integer.parseInt(request.getParameter("hiddenId"));                
                try{
                    Class.forName("com.mysql.jdbc.Driver");
                    qry = "UPDATE phonebook SET Nama = ? , NomorHp = ? , Alamat = ? WHERE contactId = ?";
                    pstmt = conn.prepareStatement(qry);
                    
                    pstmt.setString(1, request.getParameter("txtNama"));
                    pstmt.setString(2, request.getParameter("txtNoHp"));                    
                    pstmt.setString(3, request.getParameter("txtAlamat"));
                    pstmt.setInt(4, contactId);
                    
                    pstmt.executeUpdate();
                    response.sendRedirect("./contacts.jsp");
                }catch(ClassNotFoundException cnfe){
                    out.println("Class Not Found Exception :- " + cnfe.toString());
                }catch(SQLException sqle){
                    out.println("SQL Query Exception :- " + sqle);
                }            
            }
            
            if (request.getParameter("id") != null && request.getParameter("id") != ""){
                contactId = Integer.parseInt(request.getParameter("id"));                
                try{
                    Class.forName("com.mysql.jdbc.Driver");
                    qry = "SELECT * FROM phonebook WHERE contactId = ?";
                    pstmt = conn.prepareStatement(qry);
                    pstmt.setInt(1, contactId);                
                    result = pstmt.executeQuery();
                    result.first();
                }catch(ClassNotFoundException cnfe){
                    out.println("Class Not Found Exception :- " + cnfe.toString());
                }catch(SQLException sqle){
                    out.println("SQL Query Exception :- " + sqle);
                }            
            } else{
                response.sendRedirect("./contacts.jsp");
            }

        %>        
         
        <h1>Update Details of Contacts</h1>
        
        <form id="updForm" action="" method="POST">
            <table border="1" cellspacing="5" cellpadding="5">
                <tbody>
                    <tr>
                        <td>Nama : </td>
                        <td>
                            <input type="text" name="txtNama" id="txtNama" value='<%=result.getString("Nama")%>' />
                            
                        </td>
                    </tr>
                    <tr>
                        <td>Nomor HP : </td>
                        <td>
                            <input type="text" name="txtNoHp" id="txtNoHp" value='<%=result.getString("NomorHp")%>' />
                            
                        </td>
                    </tr>
                    <tr>
                        <td>Alamat : </td>
                        <td>
                            <input type="text" name="txtAlamat" id="txtAlamat" value='<%=result.getString("Alamat")%>' />
                            
                        </td>
                    </tr>                    
                    <tr>
                        <td><input type="hidden" name="hiddenId" value="<%=contactId%>" /></td>
                        <td><input type="submit" name="btnUpd" value="Update Contact" id="btnUpd" /></td>
                    </tr>
                </tbody>
            </table>

        </form>
   </center>        
        
    </body>
</html>
