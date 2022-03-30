package org.myslayers.forum.common.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum UserSourceEn {
    REGISTER("REGISTER", "注册"),
    GITHUB("GITHUB", "github"),
    ;

    private String value;
    private String desc;

    public static UserSourceEn getEntity(String value) {
        for (UserSourceEn en : values()) {
            if (en.getValue().equalsIgnoreCase(value)) {
                return en;
            }
        }

        return null;
    }
}
