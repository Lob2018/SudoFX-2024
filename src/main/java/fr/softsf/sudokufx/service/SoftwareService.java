package fr.softsf.sudokufx.service;

import java.util.Optional;

import fr.softsf.sudokufx.interfaces.mapper.ISoftwareMapper;
import fr.softsf.sudokufx.model.Software;
import fr.softsf.sudokufx.dto.SoftwareDto;
import fr.softsf.sudokufx.repository.SoftwareRepository;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Slf4j
@Service
public class SoftwareService {

    private final SoftwareRepository softwareRepository;

    private static final ISoftwareMapper iSoftwareMapper = ISoftwareMapper.INSTANCE;

    public SoftwareService(SoftwareRepository softwareRepository) {
        this.softwareRepository = softwareRepository;
    }

    public Optional<SoftwareDto> getSoftware() {
        try {
            return softwareRepository.findFirstSoftware()
                    .map(iSoftwareMapper::mapSoftwareToDto)
                    .or(() -> {
                        log.error("██ No software found.");
                        return Optional.empty();
                    });
        } catch (Exception e) {
            log.error("██ Exception retrieving software : {}", e.getMessage(), e);
            return Optional.empty();
        }
    }

    @Transactional
    public Optional<SoftwareDto> updateSoftware(SoftwareDto softwareDto) {
        try {
            Software software = iSoftwareMapper.mapSoftwareDtoToSoftware(softwareDto);
            Software updatedSoftware = softwareRepository.save(software);
            return Optional.ofNullable(iSoftwareMapper.mapSoftwareToDto(updatedSoftware));
        } catch (Exception e) {
            log.error("██ Error updating software : {}", e.getMessage(), e);
            return Optional.empty();
        }
    }
}
