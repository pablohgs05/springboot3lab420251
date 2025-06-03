package br.gov.sp.fatec.springboot3lab420251.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import br.gov.sp.fatec.springboot3lab420251.entity.Conteudo;

public interface ConteudoRepository extends JpaRepository<Conteudo, Long> {
    
    public List<Conteudo> findByTrabalhoDescricaoContainingIgnoreCaseAndTextoContainingIgnoreCase(String descricaoTrabalho, String texto);
}
