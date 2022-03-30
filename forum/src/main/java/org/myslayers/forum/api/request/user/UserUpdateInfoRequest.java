package org.myslayers.forum.api.request.user;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class UserUpdateInfoRequest implements Serializable {

    private String email;

    private String nickname;
    
    private String signature;

}
