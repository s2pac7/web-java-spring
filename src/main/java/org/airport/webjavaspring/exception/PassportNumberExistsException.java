package org.airport.webjavaspring.exception;

public class PassportNumberExistsException extends RuntimeException {
    public PassportNumberExistsException(String message) {
        super(message);
    }
}