package org.myslayers.utils;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import java.util.Date;
import lombok.Data;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

/**
 * 生成和校验 jwt 的工具类：【来自 application.yml 配置文件】
 */
@Slf4j
@Data
@Component
@ConfigurationProperties(prefix = "myslayers.jwt")
public class JwtUtils {

    private String secret;
    private long expire;
    private String header;

    /**
     * 生成 jwt token
     */
    public String generateToken(long userId) {
        Date nowDate = new Date();
        //过期时间
        Date expireDate = new Date(nowDate.getTime() + expire * 1000);

        return Jwts.builder()
            .setHeaderParam("typ", "JWT")
            .setSubject(userId + "")
            .setIssuedAt(nowDate)
            .setExpiration(expireDate)
            .signWith(SignatureAlgorithm.HS512, secret)
            .compact();
    }

    /**
     * 获取 jwt 信息
     */
    public Claims getClaimByToken(String token) {
        try {
            return Jwts.parser()
                .setSigningKey(secret)
                .parseClaimsJws(token)
                .getBody();
        } catch (Exception e) {
            log.debug("validate is token error ", e);
            return null;
        }
    }

    /**
     * 判断 token 是否过期，true代表过期；false代表有效
     */
    public boolean isTokenExpired(Date expiration) {
        return expiration.before(new Date());
    }
}
