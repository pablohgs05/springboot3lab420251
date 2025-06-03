package br.gov.sp.fatec.springboot3lab420251.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import br.gov.sp.fatec.springboot3lab420251.entity.Trabalho;
import br.gov.sp.fatec.springboot3lab420251.service.TrabalhoService;

@RestController
@CrossOrigin
@RequestMapping(value = "trabalho")
public class TrabalhoController {
    
    @Autowired
    public TrabalhoService service;

    @GetMapping
    public List<Trabalho> buscarTrabalhos() {
        return service.buscarTodos();
    }

    @PostMapping
    public Trabalho novoTrabalho(@RequestBody Trabalho trabalho) {
        return service.novo(trabalho);
    }

    @GetMapping(value = "/{titulo}/{nota}")
    public List<Trabalho> buscarTrabalhoPorTituloENota(@PathVariable("titulo") String titulo, @PathVariable("nota") Integer nota) {
        return service.buscarPorTituloENota(titulo, nota);
    }

}