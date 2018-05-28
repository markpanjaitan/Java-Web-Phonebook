<%-- 
    Document   : deleteContact
    Created on : Apr 29, 2018, 7:04:33 AM
    Author     : valentino
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>

        <%!
            Connection conn;
            PreparedStatement pstmt;
            //Statement stmt;
            //ResultSet result;
            String qry;
            Integer contactId;
        %>
        <%
            if (request.getParameter("id")!=null && request.getParameter("id")!=""){
                contactId = Integer.parseInt(request.getParameter("id"));
                try{
                    Class.forName("com.mysql.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/test","root","");
                    //stmt = conn.createStatement();
                    qry = "DELETE FROM phonebook WHERE contactId = ?";
                    pstmt = conn.prepareStatement(qry);
                    pstmt.setInt(1, contactId);
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