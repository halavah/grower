package org.myslayers.forum.common.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum AuditStateEn {
    WAIT("WAIT", "待审核"),
    PASS("PASS", "审核通过"),
    REJECT("REJECT", "审核拒绝"),
    ;

    private String value;
    private String desc;

    public static AuditStateEn getEntity(String value) {
        for (AuditStateEn entity : values()) {
            if (entity.getValue().equalsIgnoreCase(value)) {
                return entity;
            }
        }

        return null;
    }

}
