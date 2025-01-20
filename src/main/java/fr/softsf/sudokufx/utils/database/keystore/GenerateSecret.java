package fr.softsf.sudokufx.utils.database.keystore;

import fr.softsf.sudokufx.annotations.ExcludedFromCoverageReportGenerated;
import org.passay.CharacterData;
import org.passay.*;

import java.util.ArrayList;
import java.util.List;

import static org.passay.IllegalCharacterRule.ERROR_CODE;

/**
 * Utility class for generating secure passwords using the Passay library.
 */
public final class GenerateSecret {

    @ExcludedFromCoverageReportGenerated
    private GenerateSecret() {
    }

    /**
     * Define the secret special characters
     *
     * @return The special characters
     */
    private static CharacterData createSpecialChars() {
        return new CharacterData() {
            @ExcludedFromCoverageReportGenerated
            public String getErrorCode() {
                return ERROR_CODE;
            }

            public String getCharacters() {
                return "!@#$%^&()";
            }
        };
    }

    /**
     * Generate Passay secret
     *
     * @return The Passay secret
     */
    public static String generatePassaySecret() {
        PasswordGenerator gen = new PasswordGenerator();
        CharacterData lowerCaseChars = EnglishCharacterData.LowerCase;
        CharacterRule lowerCaseRule = new CharacterRule(lowerCaseChars);
        lowerCaseRule.setNumberOfCharacters(2);
        CharacterData upperCaseChars = EnglishCharacterData.UpperCase;
        CharacterRule upperCaseRule = new CharacterRule(upperCaseChars);
        upperCaseRule.setNumberOfCharacters(2);
        CharacterData digitChars = EnglishCharacterData.Digit;
        CharacterRule digitRule = new CharacterRule(digitChars);
        digitRule.setNumberOfCharacters(2);
        CharacterData specialChars = createSpecialChars();
        CharacterRule specialCharsRule = new CharacterRule(specialChars);
        specialCharsRule.setNumberOfCharacters(2);
        List<Rule> rules = new ArrayList<>();
        rules.add(specialCharsRule);
        rules.add(lowerCaseRule);
        rules.add(upperCaseRule);
        rules.add(digitRule);
        return gen.generatePassword(24, rules);
    }
}