package br.gov.sp.fatec.springboot3lab420251.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import br.gov.sp.fatec.springboot3lab420251.entity.Usuario;

public interface UsuarioRepository extends JpaRepository<Usuario, Long>{
    
    public Optional<Usuario> findByNome(String nomeUsuario);

    @Query("select u from Usuario u where u.nome = ?1")
    public Optional<Usuario> buscarPorNome(String nomeUsuario);

    public Optional<Usuario> findByNomeAndSenha(String nome, String senha);

    @Query("select u from Usuario u where u.nome = ?1 and u.senha = ?2")
    public Optional<Usuario> buscarPorNomeESenha(String nome, String senha);

    public List<Usuario> findByNomeContains(String nome);

    @Query("select u from Usuario u where u.nome like %?1%")
    public List<Usuario> buscarPorNomeContem(String nome);

    public List<Usuario> findByAnotacoesTextoContains(String texto);

    @Query("select u from Usuario u join u.anotacoes a where a.texto like %?1%")
    public List<Usuario> buscarPorTextoEmAnotacao(String texto);
}
