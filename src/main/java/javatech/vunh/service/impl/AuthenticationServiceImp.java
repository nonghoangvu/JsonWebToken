/*
 * Author: Nong Hoang Vu || JavaTech
 * Facebook:https://facebook.com/NongHoangVu04
 * Github: https://github.com/JavaTech04
 * Youtube: https://www.youtube.com/@javatech04/?sub_confirmation=1
 */
package javatech.vunh.service.impl;

import jakarta.servlet.http.HttpServletRequest;
import javatech.vunh.controller.requests.SignInRequest;
import javatech.vunh.controller.response.TokenResponse;
import javatech.vunh.exception.UnauthorizedException;
import javatech.vunh.repository.UserRepository;
import javatech.vunh.service.AuthenticationService;
import javatech.vunh.service.JwtService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.stereotype.Service;

@Service
@Slf4j(topic = "AUTHENTICATION-SERVICE")
@RequiredArgsConstructor
public class AuthenticationServiceImp implements AuthenticationService {

    private final AuthenticationManager authenticationManager;
    private final UserRepository userRepository;
    private final JwtService jwtService;

    @Override
    public TokenResponse createAccessToken(SignInRequest request) {
        var user = userRepository.findByUsername(request.getUsername());
        if(user == null) {
            throw new UnauthorizedException("Username not found");
        }
        authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(request.getUsername(), request.getPassword(), user.getAuthorities()));

        log.info("getAuthorities {} - {}", user.getAuthorities(), user.isAdmin());

        String accessToken = jwtService.generateToken(user.getId(), user.getUsername(), user.getAuthorities());
        String refreshToken = jwtService.generateRefreshToken(user.getId(), user.getUsername(), user.getAuthorities());
        return TokenResponse.builder()
                .accessToken(accessToken)
                .refreshToken(refreshToken)
                .isAdmin(user.isAdmin())
                .authorities(user.getAuthorities())
                .build();
    }

    @Override
    public TokenResponse createRefreshToken(HttpServletRequest request) {
        return null;
    }
}
