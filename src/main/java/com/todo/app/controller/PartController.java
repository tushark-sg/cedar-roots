package com.todo.app.controller;

import com.todo.app.entity.Part;
import com.todo.app.service.PartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import java.util.List;

@RestController
public class PartController {

    @Autowired
    private PartService partService;

    // @GetMapping("/part/error")
    // public String viewErrorPage() {
    // return "error";
    // }

    /**
     * @description Parts view for the part controller
     */
    @GetMapping("/part")
    public ModelAndView partIndex(@RequestParam(name = "page", required = false) Integer page,
                                  @RequestParam(name = "page_size", required = false) Integer page_size) {
        List<Part> parts;
        if (page != null && page_size != null) {
            parts = partService.getAllPartsPage(page, page_size).getContent();
        } else {
            parts = partService.getAllParts();
        }
        ModelAndView modelAndView = new ModelAndView("part");
        modelAndView.addObject("parts", parts);
        return modelAndView;
    }

    /**
     * @description Parts get api for part controller
     */
//    @GetMapping("/parts")
//    public List getParts(@RequestParam(name = "page", required = false) Integer page,
//                         @RequestParam(name = "page_size", required = false) Integer page_size) {
//        List<Part> parts;
//        if (page != null && page_size != null) {
//            parts = partService.getAllPartsPage(page, page_size).getContent();
//        } else {
//            parts = partService.getAllParts();
//        }
//
//        return parts;
//    }

    @GetMapping("/parts")
    public ModelAndView getPartSearch( ){
        return new ModelAndView("parts");
    }

    // @GetMapping("/part/{pageNo}")
    // public String findPaginated(@PathVariable(value = "pageNo") int pageNo, Model
    // model) {
    //
    // model.addAttribute("part", new Part());
    //
    // int pageSize = 6;
    //
    // Page<Part> page = partService.getAllPartsPage(pageNo, pageSize);
    // List<Part> parts = page.getContent();
    //
    // if (parts.isEmpty()) {
    // model.addAttribute("noParts", true);
    // if (pageNo > 1) {
    // return "redirect:/part/home/part/" + (pageNo - 1);
    // }
    // } else {
    // model.addAttribute("currentPage", pageNo);
    // model.addAttribute("totalPages", page.getTotalPages());
    // model.addAttribute("totalItems", page.getTotalElements());
    // model.addAttribute("parts", parts);
    //
    // if (pageNo > page.getTotalPages()) {
    // return "redirect:/part/home/part/" + page.getTotalPages();
    // }
    // if (pageNo < 1) {
    // return "redirect:/part/home";
    // }
    // }
    //
    // return "part_home";
    // }

    // part//part/ Create part using AJAX request
    // @PostMapping("/part")
    // @ResponseBody
    // public ResponseEntity<List<Part>> createPart(@RequestBody Part part) {
    // partService.addPart(part);
    // List<Part> parts = partService.getAllParts();
    // return ResponseEntity.ok(parts);
    // }
    //
    // // part//part/ Delete part using AJAX request
    // @DeleteMapping("/part/home/part/{partId}")
    // public ResponseEntity<Void> deletePart(@PathVariable Long partId) {
    // partService.deletePart(partId);
    // return ResponseEntity.ok().build();
    // }

}
