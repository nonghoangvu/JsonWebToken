/*
 * Author: Nong Hoang Vu || JavaTech
 * Facebook:https://facebook.com/NongHoangVu04
 * Github: https://github.com/JavaTech04
 * Youtube: https://www.youtube.com/@javatech04/?sub_confirmation=1
 */
package javatech.vunh.service;

import jakarta.servlet.http.HttpServletRequest;
import javatech.vunh.controller.requests.SignInRequest;
import javatech.vunh.controller.response.TokenResponse;

public interface AuthenticationService {

    TokenResponse createAccessToken(SignInRequest request);

    TokenResponse createRefreshToken(HttpServletRequest request);
}
