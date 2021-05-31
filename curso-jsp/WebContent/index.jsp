<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Bem Vindo</title>
<link rel="stylesheet" href="resources/css/estilo.css">
</head>
<body>

<p/>
<p/>

<div class="login-page"> 
<center><h3>Projeto Didático</h3></center>
<center><h1>JSP + Servlet + JDBC</h1></center>
<center><span>USUARIO E SENHA: admin</span></center>

<div class="form"> 
<form action="LoginServlet" method="post" class="login-form"> 
Login 
<input type="text" id="login" name="login"> 
 Senha 
<input type="password" id="senha" name="senha"> 
<button type="submit" value="Logar">Logar</button> 
</form> 
</div>
<center><h3>Formação Java Web</h3></center> 
</div> 
  
</body>
</html>
