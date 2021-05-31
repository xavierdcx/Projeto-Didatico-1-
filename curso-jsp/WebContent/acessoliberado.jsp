<jsp:useBean id="calcula"  class="beans.BeanCursoJsp" type="beans.BeanCursoJsp" scope="page"/> 
  <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Seja bem vindo ao sistema em jsp</title>
</head> 
<body>
	<jsp:setProperty property="*" name="calcula"/>  
	<h3>Seja bem vindo ao sistema em jsp</h3>
	
	 <a href="salvarUsuario?acao=listartodos"><img width="100px" height="100px" title="Cadastro de usuário" alt="Cadastro de usuário" src="resources/img/cadastro.png"> </a>
	 
	 <a href="salvarProduto?acao=listartodos"><img width="100px" height="100px" title="Cadastro de Produto" alt="Cadastro de Produto" src="resources/img/cadastroProduto.png"> </a>
	</body>
</html>