package com.todo.app.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import org.springframework.data.domain.Page;

import com.todo.app.entity.Part;
import com.todo.app.service.PartService;

@Controller
public class PartController {

  @Autowired
  private PartService partService;

  @GetMapping("/part/error")
  public String viewErrorPage() {
    return "error";
  }
  @GetMapping("/books")
  public String test_mapping() {
    return "books";
  }

  @GetMapping("/part")
  public String viewIndexPage(Model model) {
    List<Part>  parts = partService.getAllParts();
    model.addAttribute("parts", parts);
    return "part";
  }

  // @GetMapping("/part/books")
  // public String viewBooks() {
  //   System.out.println("hit books");
  //   return "book_jsp";
  // }

  // @GetMapping("/part/home")
  // public String viewHome(Model model) {
  //   model.addAttribute("part", new Part());
  //   return findPaginated(1, model);
  // }

  @GetMapping("/part/{pageNo}")
  public String findPaginated(@PathVariable(value = "pageNo") int pageNo, Model model) {

    model.addAttribute("part", new Part());

    int pageSize = 6;

    Page<Part> page = partService.getAllPartsPage(pageNo, pageSize);
    List<Part> parts = page.getContent();

    if (parts.isEmpty()) {
      model.addAttribute("noParts", true);
      if (pageNo > 1) {
        return "redirect:/part/home/part/" + (pageNo - 1);
      }
    } else {
      model.addAttribute("currentPage", pageNo);
      model.addAttribute("totalPages", page.getTotalPages());
      model.addAttribute("totalItems", page.getTotalElements());
      model.addAttribute("parts", parts);

      if (pageNo > page.getTotalPages()) {
        return "redirect:/part/home/part/" + page.getTotalPages();
      }
      if (pageNo < 1) {
        return "redirect:/part/home";
      }
    }

    return "part_home";
  }

  // part//part/ Create part using AJAX request
  @PostMapping("/part")
  @ResponseBody
  public ResponseEntity<List<Part>> createPart(@RequestBody Part part) {
    partService.addPart(part);
    List<Part> parts = partService.getAllParts();
    return ResponseEntity.ok(parts);
  }

  //part//part/ Delete part using AJAX request
  @DeleteMapping("/part/home/part/{partId}")
  public ResponseEntity<Void> deletePart(@PathVariable Long partId) {
    partService.deletePart(partId);
    return ResponseEntity.ok().build();
  }

}



