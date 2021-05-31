package servlet;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.tomcat.util.codec.binary.Base64;

import beans.BeanCursoJsp;
import dao.DaoUsuario;

@WebServlet("/salvarUsuario")
@MultipartConfig
public class Usuario extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private DaoUsuario daoUsuario = new DaoUsuario();

	public Usuario() {
		super();
	}

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			String acao = request.getParameter("acao");
			String user = request.getParameter("user");

			if (acao.equalsIgnoreCase("delete")) {
				daoUsuario.delete(user);
				RequestDispatcher view = request
						.getRequestDispatcher("/cadastroUsuario.jsp");
				request.setAttribute("usuarios", daoUsuario.listar(user));
				view.forward(request, response);
			
			} else if (acao.equalsIgnoreCase("editar")) {

				BeanCursoJsp beanCursoJsp = daoUsuario.consultar(user);

				RequestDispatcher view = request
						.getRequestDispatcher("/cadastroUsuario.jsp");
				request.setAttribute("user", beanCursoJsp);
				view.forward(request, response);
			
			} else if (acao.equalsIgnoreCase("listartodos")) {

				RequestDispatcher view = request
						.getRequestDispatcher("/cadastroUsuario.jsp");
				request.setAttribute("usuarios", daoUsuario.listar(user));
				view.forward(request, response);
			
			} else if(acao.equalsIgnoreCase("download")) {
				BeanCursoJsp usuario = daoUsuario.consultar(user);
				if(usuario != null) {
					String contentType = "";
					byte[] fileBytes = null;
					
					String tipo = request.getParameter("tipo");
					
					if(tipo.equalsIgnoreCase("imagem")){
						contentType = usuario.getContentType();
						fileBytes = new Base64().decodeBase64(usuario.getFotoBase64());
					
					} else if(tipo.equalsIgnoreCase("curriculo")) {
						contentType = usuario.getContentTypeCurriculo();
						fileBytes = new Base64().decodeBase64(usuario.getCurriculoBase64());
					}
					
					response.setHeader("content-Disposition", "attachment;filename=arquivo" 
				    + contentType.split("\\/")[1]);
				    
					/*Coloca os bytes em um objeto de entrada para processar*/
					InputStream is = new ByteArrayInputStream(fileBytes);
					
					/*Inicio da resposta para o navegador*/
					int read = 0;
					byte[] bytes = new byte[1024];
					OutputStream os = response.getOutputStream();
					
					while ((read = is.read(bytes)) != -1) {
						os.write(bytes, 0, read);
						
					}
					
					os.flush();
					os.close();
					
					}
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		String acao = request.getParameter("acao");

		if (acao != null && acao.equalsIgnoreCase("reset")) {
			try {
				RequestDispatcher view = request
						.getRequestDispatcher("/cadastroUsuario.jsp");
				request.setAttribute("usuarios", daoUsuario.listar(acao));
				view.forward(request, response);

			} catch (Exception e) {
				e.printStackTrace();
			}
		} else {

			String id = request.getParameter("id");
			String login = request.getParameter("login");
			String senha = request.getParameter("senha");
			String nome = request.getParameter("nome");
			String telefone = request.getParameter("telefone");
			String  cep = request.getParameter("cep");
			String  rua = request.getParameter("rua");
			String  bairro = request.getParameter("bairro");
			String  cidade = request.getParameter("cidade");
			String  estado = request.getParameter("estado");
			String  ibge = request.getParameter("ibge");

			BeanCursoJsp usuario = new BeanCursoJsp();
			usuario.setId(!id.isEmpty() ? Long.parseLong(id) : null);
			usuario.setLogin(login);
			usuario.setSenha(senha);
			usuario.setNome(nome);
			usuario.setTelefone(telefone);
			usuario.setCep(cep);
			usuario.setRua(rua);
			usuario.setBairro(bairro);
			usuario.setCidade(cidade);
			usuario.setEstado(estado);
			usuario.setIbge(ibge);
			
			try {
				
				/*Inicio File upload de imagens e pdf*/
				if(ServletFileUpload.isMultipartContent(request)) {
				  
					Part imagemFoto = request.getPart("foto");
					
					if(imagemFoto != null && imagemFoto.getInputStream().available() > 0) {
					
					String fotoBase64 = new Base64().encodeBase64String(converteStremParaByte(imagemFoto.getInputStream()));
					usuario.setFotoBase64(fotoBase64);
					usuario.setContentType(imagemFoto.getContentType());
				    
					} else {
						usuario.setFotoBase64(request.getParameter("foto"));
						usuario.setContentType(request.getParameter("contentTypeTemp"));
					}
					
					/*Processa pdf*/
					Part curriculoPdf = request.getPart("curriculo");
					if(curriculoPdf != null && curriculoPdf.getInputStream().available() > 0) {
						
						String curriculoBase64 = new Base64().encodeBase64String(converteStremParaByte(curriculoPdf.getInputStream()));
						usuario.setCurriculoBase64(curriculoBase64);
						usuario.setContentTypeCurriculo(curriculoPdf.getContentType());
					
					} else {
						usuario.setCurriculoBase64(request.getParameter("fotoTempPDF"));
						usuario.setContentTypeCurriculo(request.getParameter(""));
					}
					
				}
					
		        /*Fim File upload de imagens e pdf*/
				String msg = null;
				boolean podeInserir = true;
				
			if(login == null || login.isEmpty()) {
				msg = "Login deve ser informado";
				podeInserir = false;
				
			} else if(senha == null || senha.isEmpty()) {
			   msg = "Senha deve ser informado";	
			   podeInserir = false;
			
			} else if(nome == null || nome.isEmpty()) {
				msg = "Nome deve ser informado";
				podeInserir = false;			
			
			} else if(telefone == null || telefone.isEmpty()) {
				msg = "Telefone deve ser informado";
				podeInserir = false;
			}
			
			else if (id == null || id.isEmpty()
						&& !daoUsuario.validarLogin(login)) {//QUANDO DOR USUÁRIO NOVO
					msg = "Usuário já existe com o mesmo login!";
					podeInserir = false;

				} else if (id == null || id.isEmpty()
						&& !daoUsuario.validarSenha(senha)) {// QUANDO FOR USUÁRIO NOVO
					msg = "\n A senha já existe para outro usuário!";
					podeInserir = false;
				}

				if (msg != null) {
					request.setAttribute("msg", msg);
				}

				if (id == null || id.isEmpty()
						&& daoUsuario.validarLogin(login) && podeInserir) {

					daoUsuario.salvar(usuario);

				} else if (id != null && !id.isEmpty() && podeInserir) {
					daoUsuario.atualizar(usuario);
				}
				
				if (!podeInserir){
					request.setAttribute("user", usuario);
				}

				RequestDispatcher view = request
						.getRequestDispatcher("/cadastroUsuario.jsp");
				request.setAttribute("usuarios", daoUsuario.listar(id));
				request.setAttribute("msg", "Salvo com sucesso!");
				view.forward(request, response);

			} catch (Exception e) {
				e.printStackTrace();
			}

		}

	}
    
	/*Converte a entrada de fluxo de dados da imagem para um array de byte*/
	private static byte[] converteStremParaByte(InputStream imagem) throws Exception {
		
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		int reads = imagem.read();
		while (reads != -1) {
			baos.write(reads);
			reads = imagem.read();
		}
		
		return baos.toByteArray();
	}
	
}
