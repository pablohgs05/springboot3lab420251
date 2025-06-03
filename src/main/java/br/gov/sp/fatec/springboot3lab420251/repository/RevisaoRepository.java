package br.gov.sp.fatec.springboot3lab420251.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import br.gov.sp.fatec.springboot3lab420251.entity.Revisao;

public interface RevisaoRepository extends JpaRepository<Revisao, Long> {
    
    public List<Revisao> findByTrabalhoTituloContainingIgnoreCaseAndGravidadeGreaterThan(String titulo, Integer gravidade);
    
}
