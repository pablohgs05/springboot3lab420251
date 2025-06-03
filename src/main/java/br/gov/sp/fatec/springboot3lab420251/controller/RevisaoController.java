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

import br.gov.sp.fatec.springboot3lab420251.entity.Revisao;
import br.gov.sp.fatec.springboot3lab420251.service.RevisaoService;

@RestController
@CrossOrigin
@RequestMapping(value = "revisao")
public class RevisaoController {

    @Autowired
    private RevisaoService service;

    @GetMapping
    public List<Revisao> buscarRevisoes() {
        return service.todas();
    }

    @PostMapping
    public Revisao novaRevisao(@RequestBody Revisao revisao) {
        return service.nova(revisao);
    }

    @GetMapping(value = "/{titulo}/{gravidade}")
    public List<Revisao> buscarRevisaoPorTrabalhoTituloEComentario(@PathVariable("titulo") String titulo, @PathVariable("gravidade") Integer gravidade) {
        return service.buscarPorTrabalhoTituloEComentario(titulo, gravidade);
    }
}
