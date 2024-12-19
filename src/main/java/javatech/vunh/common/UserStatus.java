/*
 * Author: Nong Hoang Vu || JavaTech
 * Facebook:https://facebook.com/NongHoangVu04
 * Github: https://github.com/JavaTech04
 * Youtube: https://www.youtube.com/@javatech04/?sub_confirmation=1
 */
package javatech.vunh.common;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum UserStatus {

    @JsonProperty("active")
    ACTIVE("active"),

    @JsonProperty("inactive")
    INACTIVE("inactive"),

    @JsonProperty("locked")
    LOCKED("locked"),

    @JsonProperty("none")
    NONE("none");

    private String value;
}