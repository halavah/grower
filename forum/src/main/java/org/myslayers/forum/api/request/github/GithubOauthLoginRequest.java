package org.myslayers.forum.api.request.github;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.myslayers.forum.api.request.user.UserBaseLoginRequest;

import java.io.Serializable;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class GithubOauthLoginRequest extends UserBaseLoginRequest implements Serializable {

    private String code;
}
