/*
 * Author: Nong Hoang Vu || JavaTech
 * Facebook:https://facebook.com/NongHoangVu04
 * Github: https://github.com/JavaTech04
 * Youtube: https://www.youtube.com/@javatech04/?sub_confirmation=1
 */
package javatech.vunh.controller;


import javatech.vunh.controller.requests.SignInRequest;
import javatech.vunh.service.AuthenticationService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import static org.springframework.http.HttpStatus.OK;

@Slf4j
@RestController
@RequestMapping("/api/v1/auth")
@RequiredArgsConstructor
public class AuthenticationController {
    private final AuthenticationService authenticationService;

    @PostMapping("/access-token")
    @ResponseStatus(OK)
    public ResponseEntity<?> accessToken(@RequestBody SignInRequest request){
        log.info("POST /access-token");
        return new ResponseEntity<>(authenticationService.createAccessToken(request), OK);
    }
}
