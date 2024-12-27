/*
 * Author: Nong Hoang Vu || JavaTech
 * Facebook:https://facebook.com/NongHoangVu04
 * Github: https://github.com/JavaTech04
 * Youtube: https://www.youtube.com/@javatech04/?sub_confirmation=1
 */
package javatech.vunh.controller;

import jakarta.servlet.http.HttpServletResponse;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.IOException;

@RestController
@RequestMapping("/api/v1/user")
@Validated
public class UserController {

    @GetMapping("/say-hello")
    @PreAuthorize("hasAnyAuthority('admin', 'manager')")
    public String hello() {
        return "Hello World";
    }

    //@PreAuthorize("hasAnyAuthority('sysadmin')")
    @GetMapping(value = "/say-hello/2", headers = {"apiKey=XYZ"})
    public String hello2() {
        return "Hello World 2";
    }

    @GetMapping(value = "/sendRedirect", headers = {"apiKey=XYZ"})
    @PreAuthorize("hasAnyAuthority('user')")
    public void sendRedirect(HttpServletResponse response) throws IOException {
        response.sendRedirect("https://blog.bytebytego.com/p/ep84-top-12-tips-for-api-security");
    }
}
