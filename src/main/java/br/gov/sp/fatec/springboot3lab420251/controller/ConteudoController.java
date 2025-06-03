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

import br.gov.sp.fatec.springboot3lab420251.entity.Conteudo;
import br.gov.sp.fatec.springboot3lab420251.service.ConteudoService;

@RestController
@CrossOrigin
@RequestMapping(value = "/conteudo")
public class ConteudoController {

    @Autowired
    private ConteudoService service;

    @PostMapping
    public Conteudo novo(@RequestBody Conteudo conteudo) {
        return service.novo(conteudo);
    }

    @GetMapping
    public List<Conteudo> todos() {
        return service.todos();
    }
    
    @GetMapping(value = "/{texto}/{descricaoTrabalho}")
    public List<Conteudo> buscarPorTextoEDescricaoTrabalho(@PathVariable("texto") String texto, @PathVariable("descricaoTrabalho") String descricaoTrabalho) {
        return service.buscarPorTrabalhoDescricaoETexto(descricaoTrabalho, texto);
    }

}
