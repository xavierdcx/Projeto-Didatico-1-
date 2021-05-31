<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Cadatro de usuário</title>
<link rel="stylesheet" href="resources/css/cadastro.css">

 <!-- Adicionando JQuery -->
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"
            integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo="
            crossorigin="anonymous"></script>

</head>
<body>
<a href="acessoliberado.jsp">Inicio</a>
<a href="index.jsp">Sair</a>
  <center><h1>Cadastro de usuário</h1></center>
  
  <center><h3 style="color: orange">${msg}</h3></center>
  
  <form action="salvarUsuario" method="post" id="formUser" onsubmit="return validarCampos()? true : false;" enctype="multipart/form-data">
  <ul class="form-style-1"><li>
    <table>
       <tr>
       <td>ID:</td>
       <td><input type="text" readonly="readonly" id="id" name="id" value="${user.id}" class="field-long"/></td>
       
       <td>Cep:</td>
       <td><input type="text" id="cep" name="cep" onblur="consultaCEP()" value="${user.cep}" placeholder="Digite seu cep"/></td>
       
      </tr>
   
   
   
      <tr>
       <td>Login:</td>
       <td><input type="text" id="login" name="login" value="${user.login}" placeholder="Digite o login" maxlength="10"/></td>
       
       <td>Rua:</td>
       <td><input type="text" id="rua" name="rua" value="${user.rua}"/></td>
       
      </tr>
   
   
     
      <tr>
       <td>Senha:</td>
       <td><input type="password" id="senha" name="senha" value="${user.senha}" placeholder="Digite a senha" maxlength="10"/></td>
       
       <td>Bairro:</td>
       <td><input type="text" id="bairro" name="bairro" value="${user.bairro}"/></td>
       
      </tr>
   
      <tr>
       <td>Nome:</td>
       <td><input type="text" id="nome" name="nome" value="${user.nome}" placeholder="Digite seu nome" maxlength="50"/></td>
       
       <td>Cidade:</td>
       <td><input type="text" id="cidade" name="cidade" value="${user.cidade}"/></td>
       
      </tr>
      
      <tr>
       <td>Telefone:</td>
       <td><input type="text" id="telefone" name="telefone" value="${user.telefone}" placeholder="Digite seu telefone"/></td>
       
        <td>Estado:</td>
       <td><input type="text" id="estado" name="estado" value="${user.estado}"/></td>
     </tr>
      
      
      <tr>
       <td>IBGE:</td>
       <td><input type="text" id="ibge" name="ibge" value="${user.ibge}"/></td>
      </tr>
      
      <tr>
        <td>
          Foto: 
        </td>
        <td>
         <input type="file" name="foto"> 
         <input type="text" name="fotoTemp" readonly="readonly" style="display: none;" value="${user.fotoBase64}"/>
         <input type="text" name="contentTypeTemp" readonly="readonly" style="display: none;" value="${user.contentType}"/>
         </td>
      </tr>
      
       <tr>
        <td>
          Curriculo: 
        </td>
        <td>
         <input type="file" name="curriculo" value="curriculo" />
         <input type="text" name="fotoTempPDF" readonly="readonly" style="display: none;" value="${user.curriculoBase64}"/>
         <input type="text" name="contentTypeTempPDF" readonly="readonly" style="display: none;" value="${user.contentTypeCurriculo}"/>
        </td>
      </tr>
   
  </table>   
   <input type="submit" value="Salvar">
   <input type="submit" value="Cancelar" onclick="document.getElementById('formUser').action = 'salvarUsuario?acao=reset'">
   </li>
   </ul>
  </form>
   
   <div class="container">
   <table class="responsive-table">
   <caption>Usuarios Cadastrados</caption>
     <tr>
       <th>Id</th>
       <th>Foto</th>
       <th>Curriculo</th> 
       <th>Nome</th>
       <th>Delete</th>
       <th>Update</th>
       <th>Telefone</th>
       
     </tr>
   <c:forEach items="${usuarios}" var="user">
       <tr>
       
       <td><c:out value="${user.id}" /></td>
       
       <td><a href="salvarUsuario?acao=download&tipo=imagem&user=${user.id}"><img src='<c:out value="${user.temFotoUser}"></c:out>' width="20px" heigth="20px" alt="Imagem User" title="Imagem User"></td>  
       
       <td><a href="salvarUsuario?acao=download&tipo=curriculo&user=${user.id}"><img alt="Curriculo" src="resources/img/iconPdf.png" width="20px" height="20px"></a></td>   
        
       <td><c:out value="${user.nome}"></c:out></td>  
        
       <td><a href="salvarUsuario?acao=delete&user=${user.id}"><img src="resources/img/excluir.png" width="20px" heigth="20px" title="Exluir"></a>
       </td>
         
       <td><a href="salvarUsuario?acao=editar&user=${user.id}"><img src="resources/img/editar.png" width="20px" heigth="20px" title="Editar"></a>
       </td>
         
       <td><a href="salvarTelefones?acao=addFone&user=${user.id}"><img src="resources/img/telefone.png" alt="Telefones" width="20px" heigth="20px" title="Telefones"></a>
       </td>  
           
        </tr>   
      </c:forEach>   
   </table>
   </div>
   <script type="text/javascript">
     function validarCampos(){
    	 if(document.getElementById("login").value == ''){
    		 alert('Informe o Login');
    		 return false;
    	 }
    	 else
    	 if(document.getElementById("senha").value == ''){
    		 alert('Informe a Senha');
    		 return false;
    	 }
    	 else
    	 if(document.getElementById("nome").value == ''){
    		 alert('Informe o Nome');
    		 return false;
    	 }
    	 else
    	 if(document.getElementById("Telefone").value == ''){
    		 alert('Informe o Telefone');
    		 return false;
    	 }
    	 
    	 return true;
     }
     
     function consultaCEP(){
    	 var cep = $("#cep").val();
    	 
    	 
    	 //Consulta o webservice viacep.com.br/
         $.getJSON("https://viacep.com.br/ws/"+ cep +"/json/?callback=?", function(dados) {

             if (!("erro" in dados)) {
            	 $("#rua").val(dados.logradouro);
            	 $("#bairro").val(dados.bairro);
                 $("#cidade").val(dados.localidade);
                 $("#estado").val(dados.uf);
                 $("#ibge").val(dados.ibge);
             } //end if.
             else {
            	 $("#cep").val('');
            	 $("#rua").val('');
            	 $("#bairro").val('');
                 $("#cidade").val('');
                 $("#estado").val('');
                 $("#ibge").val('');
                 //CEP pesquisado não foi encontrado.
                 limpa_formulário_cep();
                 alert("CEP não encontrado.");
             }
         });
     }
   </script>
   
 </body>
</html>