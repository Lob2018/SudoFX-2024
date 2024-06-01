package fr.softsf.sudofx2024.repository;

import fr.softsf.sudofx2024.model.PlayerLanguageModel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.UUID;

@Repository
public interface PlayerLanguageModelRepository extends JpaRepository<PlayerLanguageModel, UUID> {
}
