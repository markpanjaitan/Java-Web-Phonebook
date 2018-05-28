<%-- 
    Document   : contacts
    Created on : Apr 30, 2018, 7:55:35 PM
    Author     : valentino
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Contacts List</title>
        <link rel="stylesheet" type="text/css" href="style.css">    
    </head>
    <body>
        <%!
            Connection conn;
            Statement stmt;
            String qry, cariNama;
            Integer contactId;
            ResultSet result;
         %>
        <%           
            try{
                String cariNama = request.getParameter("txtSearch");
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/test","root","");
                stmt = conn.createStatement();
                qry = "SELECT * FROM phonebook where Nama like '%" + request.getParameter("txtSearch") + "%'";
                result = stmt.executeQuery(qry);

            }catch(ClassNotFoundException cnfe){
                out.println("Class Not Found Exception :- " + cnfe.toString());
            }catch(SQLException sqle){
                out.println("SQL Query Exception :- " + sqle);
            }
        %>

        <center>   
        <h1>Search Result</h1><br>                    
        
        <!---- SEARCH ---->
        <form name = "formSearch" action="" method="GET">
            <table border="1" width="700" cellspacing="5" cellpadding="5">
                <thead>
                </thead>
                <tbody>
                    <tr>
                        <td>Cari Nama</td>
                        <td><input type="text" name="txtSearch" id="txtSearch" /></td>
                        <td><input type="submit" name="btnSearch" value="CARI" id="btnSearch" /></td>                        
                    </tr>
                </tbody>
            </table>            
        </form>
        <br>        
        
        <br>
            
            <!----- Tabel Contacts----->
            <table border="1" cellspacing="5" cellpadding="5">
                <thead>
                    <tr>
                        <th>No.</th>
                        <th>Contact Name</th>
                        <th>Nomor HP</th>
                        <th>Alamat</th>                        
                        <th colspan="2">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        int i = 1;
                        while(result.next()){
                            contactId = result.getInt("contactId");
                    %>
                    <tr>
                        <td><%=i%></td>
                        <td><%=result.getString("Nama")%></td>
                        <td><%=result.getString("NomorHp")%></td>
                        <td><%=result.getString("Alamat")%></td>                        
                        
                        <td><a href="updateContact.jsp?id=<%=contactId%>">Update</a></td>      
                        <td><a href="deleteContact.jsp?id=<%=contactId%>" onclick="return confirm('Are you sure you want to delete?')">Delete</a></td>
                    </tr>
                    <%
                        i ++;
                        }
                    %>
                </tbody>
            </table>
                
            <br>
            <h3><a href="addContact.jsp">Add New Contact</a></h3>
            
            <br>
            
            <h6><a href="contacts.jsp">mark.panjaitan@gmail.com</a></h6>

        </center>
    </body>
</html>
