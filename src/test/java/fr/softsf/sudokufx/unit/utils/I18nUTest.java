package fr.softsf.sudokufx.unit.utils;

import fr.softsf.sudokufx.utils.I18n;
import org.junit.jupiter.api.MethodOrderer;
import org.junit.jupiter.api.Order;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestMethodOrder;

import static org.junit.jupiter.api.Assertions.assertEquals;


@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
class I18nUTest {

    @Test
    @Order(0)
    void testDefault_language_is_french() {
        String fr = I18n.getLanguage();
        assertEquals("fr", fr);
    }

    @Test
    @Order(1)
    void testDefault_language_is_french_with_value() {
        String testFR = I18n.getValue("test");
        assertEquals("testFR", testFR);
    }


    @Test
    @Order(2)
    void testChange_language_to_english_with_value() {
        I18n.setLocaleBundle("EN");
        String testEN = I18n.getValue("test");
        assertEquals("testUS", testEN);
    }

    @Test
    @Order(3)
    void testChanged_language_is_english() {
        String en = I18n.getLanguage();
        assertEquals("en", en);
    }

    @Test
    @Order(4)
    void testChange_english_language_to_french() {
        I18n.setLocaleBundle("");
        String testFR = I18n.getValue("test");
        assertEquals("testFR", testFR);
    }
}