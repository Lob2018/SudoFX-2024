package fr.softsf.sudokufx.utils.database.keystore;

import ch.qos.logback.classic.Logger;
import ch.qos.logback.classic.spi.ILoggingEvent;
import ch.qos.logback.core.read.ListAppender;
import fr.softsf.sudokufx.interfaces.IOsFolderFactory;
import fr.softsf.sudokufx.utils.FileSystemManager;
import org.junit.jupiter.api.*;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.nio.file.Paths;

import static fr.softsf.sudokufx.utils.MyEnums.Paths.WINDOWS_SUPPOSED_DATA_FOLDER_FOR_SUDO_FX;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.Mockito.*;

@SpringBootTest
class ApplicationKeystoreITest {

    private static IOsFolderFactory iOsFolderFactoryMocked;
    private static String passInit;
    private static String userInit;
    @Autowired
    ApplicationKeystore keystore;
    private ListAppender<ILoggingEvent> logWatcher;

    @BeforeAll
    static void setupAll() {
        new FileSystemManager().deleteFolderRecursively(Paths.get(WINDOWS_SUPPOSED_DATA_FOLDER_FOR_SUDO_FX.getPath()), WINDOWS_SUPPOSED_DATA_FOLDER_FOR_SUDO_FX.getPath());
    }

    @BeforeEach
    void setup() {
        iOsFolderFactoryMocked = mock(IOsFolderFactory.class);
        logWatcher = new ListAppender<>();
        logWatcher.start();
        ((Logger) LoggerFactory.getLogger(ApplicationKeystore.class)).addAppender(logWatcher);
    }

    @AfterEach
    void tearDown() {
        iOsFolderFactoryMocked = null;
        ((Logger) LoggerFactory.getLogger(ApplicationKeystore.class)).detachAndStopAllAppenders();
    }

    @Test
    @Order(0)
    void constructorForKeystoreInitialization_success() {
        keystore.setupApplicationKeystore();
        passInit = keystore.getPassword();
        userInit = keystore.getUsername();
        assertEquals(passInit.length(), userInit.length(), 24);
    }

    @Test
    @Order(1)
    void constructorForAlreadyExistingKeystore_success() {
        keystore.setupApplicationKeystore();
        String pass = keystore.getPassword();
        String user = keystore.getUsername();
        assertEquals(pass.length(), user.length(), 24);
        assertEquals(user, userInit);
        assertEquals(pass, passInit);
    }

    @Test
    void constructorException_fail() {
        iOsFolderFactoryMocked = mock(IOsFolderFactory.class);
        when(iOsFolderFactoryMocked.getOsDataFolderPath()).thenThrow(new RuntimeException(new Exception("██ Exception")));
        keystore.setOsFolderFactoryForTests(iOsFolderFactoryMocked);
        keystore.setupApplicationKeystore();
        verify(iOsFolderFactoryMocked).getOsDataFolderPath();
        assert (logWatcher.list.get(1).getFormattedMessage()).contains("██ Exception");
    }
}
