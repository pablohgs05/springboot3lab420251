package br.gov.sp.fatec.springboot3lab420251.service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import br.gov.sp.fatec.springboot3lab420251.entity.Conteudo;
import br.gov.sp.fatec.springboot3lab420251.entity.Trabalho;
import br.gov.sp.fatec.springboot3lab420251.repository.ConteudoRepository;
import br.gov.sp.fatec.springboot3lab420251.repository.TrabalhoRepository;

@Service
public class ConteudoService {

    @Autowired
    private ConteudoRepository repo;

    @Autowired
    private TrabalhoRepository trabalhoRepo;

    public Conteudo novo(Conteudo conteudo) {
        if (conteudo == null ||
                conteudo.getTexto() == null || conteudo.getTexto().isBlank() ||
                conteudo.getTrabalho() == null ||
                conteudo.getTrabalho().getId() == null) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Dados inválidos para o conteúdo");
        }
        Optional<Trabalho> trabalhoOpt = trabalhoRepo.findById(conteudo.getTrabalho().getId());
        if (trabalhoOpt.isEmpty()) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Trabalho não encontrado");
        }
        conteudo.setTrabalho(trabalhoOpt.get());
        if(conteudo.getDataHoraCriacao() == null) {
            conteudo.setDataHoraCriacao(LocalDateTime.now());
        }
        return repo.save(conteudo);
    }

    public List<Conteudo> todos() {
        return repo.findAll();
    }
    
    public List<Conteudo> buscarPorTrabalhoDescricaoETexto(String descricaoTrabalho, String texto) {
        if (texto == null || texto.isBlank() || descricaoTrabalho == null || descricaoTrabalho.isBlank()) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Texto e descrição do trabalho não podem ser vazios");
        }
        return repo.findByTrabalhoDescricaoContainingIgnoreCaseAndTextoContainingIgnoreCase(descricaoTrabalho, texto);
    }

}
