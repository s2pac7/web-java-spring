package org.airport.webjavaspring.util;
;
import org.airport.webjavaspring.service.impl.UserDetailsImpl;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Component;
import io.jsonwebtoken.*;

import java.util.Date;

@Component
public class JWTCore {
    private String token;

    @Value("${testing.app.secret}")
    private String secret;

    @Value("${testing.app.lifetime}")
    private int lifetime;

    public String generateToken(Authentication authentication) {
        UserDetailsImpl userDetails = (UserDetailsImpl) authentication.getPrincipal();
        return Jwts.builder().setSubject(userDetails.getUsername()).setIssuedAt(new Date())
                .setExpiration(new Date((new Date()).getTime() + lifetime))
                .signWith(SignatureAlgorithm.HS256, secret)
                .compact();
    }

    public String getNameFromJwt(String token) {
        try {
            Claims claims = Jwts.parser()
                    .setSigningKey(secret)
                    .parseClaimsJws(token)
                    .getBody();

            System.out.println("Token is valid. Username: " + claims.getSubject());
            return claims.getSubject();
        } catch (ExpiredJwtException e) {
            System.err.println("Token expired: " + e.getMessage());
        } catch (Exception e) {
            System.err.println("Invalid token: " + e.getMessage());
        }
        return null;
    }

}
