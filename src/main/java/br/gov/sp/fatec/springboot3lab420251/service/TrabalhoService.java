package br.gov.sp.fatec.springboot3lab420251.service;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import br.gov.sp.fatec.springboot3lab420251.entity.Trabalho;
import br.gov.sp.fatec.springboot3lab420251.repository.TrabalhoRepository;

@Service
public class TrabalhoService {

    @Autowired
    private TrabalhoRepository repo;
    
    public List<Trabalho> buscarTodos() {
        return repo.findAll();
    }

    public Trabalho novo(Trabalho trabalho) {
        if(trabalho.getTitulo() == null ||
            trabalho.getTitulo().isBlank() ||
            trabalho.getGrupo() == null ||
            trabalho.getGrupo().isBlank()) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Falta título ou grupo!");
        }
        if(trabalho.getDataHoraEntrega() == null) {
            trabalho.setDataHoraEntrega(LocalDateTime.now());
        }
        return repo.save(trabalho);
    }

    public List<Trabalho> buscarPorTituloENota(String titulo, Integer nota) {
        return repo.buscarPorTituloENota(titulo, nota);
    }
}
