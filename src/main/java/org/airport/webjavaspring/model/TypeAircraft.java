package org.airport.webjavaspring.model;

public enum TypeAircraft {
    PASSENGER_NARROW_BODY("Пассажирский узкофюзеляжный"),
    PASSENGER_WIDE_BODY("Пассажирский широкофюзеляжный"),
    REGIONAL_JET("Региональный реактивный"),
    TURBOPROP("Турбовинтовой"),
    FREIGHTER("Грузовой"),
    BUSINESS_JET("Бизнес-джет"),
    LIGHT_AIRCRAFT("Легкий самолет"),
    AMPHIBIAN("Амфибия"),
    FIREFIGHTING("Пожарный"),
    AGRICULTURAL("Сельскохозяйственный");

    private final String displayName;

    TypeAircraft(String displayName) {
        this.displayName = displayName;
    }

    public String getDisplayName() {
        return displayName;
    }
}