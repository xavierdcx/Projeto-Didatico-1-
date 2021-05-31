<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Cadatro de telefones</title>
<link rel="stylesheet" href="resources/css/cadastro.css">
</head>
<body>
<a href="acessoliberado.jsp">Inicio</a>
<a href="index.jsp">Sair</a>
<center><h1>Cadastro de telefones</h1></center>
  
  <center><h3 style="color: orange">${msg}</h3></center>
  
  <form action="salvarTelefones" method="post" id="formUser" onsubmit="return validarCampos()? true : false;">
  <ul class="form-style-1"><li>
    <table>
       <tr>
       <td>User:</td>
       <td><input type="text" id="user" name="user" readonly="readonly" value="${userEscolhido.id}" class="field-long"/></td>
       
       
       <td><input type="text"  id="nome" readonly="readonly" name="nome" value="${userEscolhido.nome}" class="field-long"/></td>
       
       </tr>
       
       <tr>
       <td>Numero:</td>
       <td><input type="text" id="numero" name="numero"></td>
       <td>
       <select id="tipo" name="tipo">
         <option>Casa</option>
          <option>Contato</option>
          <option>Celular</option>
       </select>
       </td>
       </tr>
         
    </table>
   
   <input type="submit" value="Salvar">
   <input type="submit" value="Voltar" onclick="document.getElementById('formUser').action = 'salvarTelefones?acao=voltar'">
   </li>
   </ul>
  </form>
   
   <div class="container">
   <table class="responsive-table">
   <caption>Usuarios Cadastrados</caption>
     <tr>
       <th>Id</th>
       <th>Numero</th> 
       <th>Tipo</th>
       <th>Excluir</th>
       
     </tr>
   <c:forEach items="${telefones}" var="fone">
       <tr>
         <td style="width: 150px"><c:out value="${fone.id}">
           </c:out></td>
         <td style="width: 150px"><c:out value="${fone.numero}">
           </c:out></td>
         <td><c:out value="${fone.tipo}"></c:out></td>  
         
         <td><a href="salvarTelefones?user=${fone.usuario}&acao=deleteFone&foneId=${fone.id}"><img src="resources/img/excluir.png" width="20px" heigth="20px" title="Exluir"></a>
         </td>
       </tr>   
      </c:forEach>   
   </table>
   
   </div>
   <script type="text/javascript">
     function validarCampos(){
    	 if(document.getElementById("numero").value == ''){
    		 alert('Informe o Número');
    		 return false;
    	 }
    	 
    	 if(document.getElemntById("tipo").value == ''){
    		 alert('Informe o Tipo');
    		 return false;
    	 }
    	 
    	 if(document.getElementById("nome").value == ''){
    		 alert('Informe o Nome');
    		 return false;
    	 }
    	
     }
     
    
  </script>  
 </body>
</html>