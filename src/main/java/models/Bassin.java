package models;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

public class Bassin {
    private int bassinId;
    private String nom;
    private String statut;
    private BigDecimal capaciteM3;
    private int typeBassinId;
    private LocalDate dateMiseEnService;
    private String description;
    private String localisation;
    private LocalDateTime dateCreation;
    private LocalDateTime dateMiseAJour;

    // Constructors
    public Bassin() {}

    public Bassin(String nom, BigDecimal capaciteM3, int typeBassinId) {
        this.nom = nom;
        this.capaciteM3 = capaciteM3;
        this.typeBassinId = typeBassinId;
        this.statut = "actif";
    }

    // Getters and Setters
    public int getBassinId() { return bassinId; }
    public void setBassinId(int bassinId) { this.bassinId = bassinId; }

    public String getNom() { return nom; }
    public void setNom(String nom) { this.nom = nom; }

    public String getStatut() { return statut; }
    public void setStatut(String statut) { this.statut = statut; }

    public BigDecimal getCapaciteM3() { return capaciteM3; }
    public void setCapaciteM3(BigDecimal capaciteM3) { this.capaciteM3 = capaciteM3; }

    public int getTypeBassinId() { return typeBassinId; }
    public void setTypeBassinId(int typeBassinId) { this.typeBassinId = typeBassinId; }

    public LocalDate getDateMiseEnService() { return dateMiseEnService; }
    public void setDateMiseEnService(LocalDate dateMiseEnService) { this.dateMiseEnService = dateMiseEnService; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getLocalisation() { return localisation; }
    public void setLocalisation(String localisation) { this.localisation = localisation; }

    public LocalDateTime getDateCreation() { return dateCreation; }
    public void setDateCreation(LocalDateTime dateCreation) { this.dateCreation = dateCreation; }

    public LocalDateTime getDateMiseAJour() { return dateMiseAJour; }
    public void setDateMiseAJour(LocalDateTime dateMiseAJour) { this.dateMiseAJour = dateMiseAJour; }
}