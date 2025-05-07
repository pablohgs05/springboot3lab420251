package br.gov.sp.fatec.springboot3lab420251.service;

import java.util.List;
import java.util.Optional;

import org.springframework.http.HttpStatus;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import br.gov.sp.fatec.springboot3lab420251.entity.Usuario;
import br.gov.sp.fatec.springboot3lab420251.repository.UsuarioRepository;

@Service
public class UsuarioService {

    private UsuarioRepository repo;

    public UsuarioService(UsuarioRepository repo) {
        this.repo = repo;
    }

    public List<Usuario> listarTodos() {
        return repo.findAll();
    }

    @PreAuthorize("hasAnyRole('ADMIN', 'MANAGER')")
    public Usuario novo(Usuario usuario) {
        if(usuario == null ||
                usuario.getNome() == null ||
                usuario.getNome().isBlank() ||
                usuario.getSenha() == null ||
                usuario.getSenha().isBlank()) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Dados inválidos!");
        }
        return repo.save(usuario);
    }

    @PreAuthorize("isAuthenticated()")
    public Usuario buscarPorId(Long id) {
        Optional<Usuario> usuarioOp = repo.findById(id);
        if(usuarioOp.isEmpty()) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Id não encontrado!");
        }
        return usuarioOp.get();
    }
    
}
