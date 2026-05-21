<%-- Root redirect to HomeController servlet --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% response.sendRedirect(request.getContextPath() + "/home"); %>
