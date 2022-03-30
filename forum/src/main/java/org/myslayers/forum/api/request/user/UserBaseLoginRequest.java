package org.myslayers.forum.api.request.user;

import lombok.Data;

import java.io.Serializable;

@Data
public class UserBaseLoginRequest implements Serializable {

    private String ua;

    private String ip;

}
