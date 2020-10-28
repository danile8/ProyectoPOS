package com.web.repositorio;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.web.modelo.Producto;

@Repository
public interface ProductoRepositorio extends JpaRepository<Producto, Integer> {

	public List<Producto> findByNombreLike(String nombre);
}