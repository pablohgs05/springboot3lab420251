package br.gov.sp.fatec.springboot3lab420251.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.annotation.JsonView;

import br.gov.sp.fatec.springboot3lab420251.entity.Usuario;
import br.gov.sp.fatec.springboot3lab420251.entity.View;
import br.gov.sp.fatec.springboot3lab420251.service.UsuarioService;

@RestController
@CrossOrigin
@RequestMapping(value = "/usuario")
public class UsuarioController {

    @Autowired
    private UsuarioService service;

    @GetMapping
    @JsonView(View.UsuarioSimplificado.class)
    public List<Usuario> listarTodos() {
        return service.listarTodos();
    }

    @PostMapping
    public ResponseEntity<Usuario> novo(@RequestBody Usuario usuario) {
        return ResponseEntity.ok(service.novo(usuario));
    }

    @GetMapping(value = "/{id}")
    @JsonView(View.UsuarioCompleto.class)
    public ResponseEntity<Usuario> buscarPorId(@PathVariable("id") Long id) {
        return ResponseEntity.ok(service.buscarPorId(id));
    }
    
}
