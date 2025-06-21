package models;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

public class LotPoisson {
    private int lotsId;
    private int especeId;
    private LocalDateTime dateIntroduction;
    private int nombreInitial;
    private BigDecimal poidsMoyenInitialG;
    private String provenance;
    private LocalDate dateRecoltePrevue;
    private String statut;
    private String commentaires;
    private LocalDateTime dateCreation;
    private LocalDateTime dateMiseAJour;

    // Constructors
    public LotPoisson() {}

    public LotPoisson(int especeId, int nombreInitial, BigDecimal poidsMoyenInitialG) {
        this.especeId = especeId;
        this.nombreInitial = nombreInitial;
        this.poidsMoyenInitialG = poidsMoyenInitialG;
        this.statut = "actif";
        this.dateIntroduction = LocalDateTime.now();
    }

    // Getters and Setters
    public int getLotsId() { return lotsId; }
    public void setLotsId(int lotsId) { this.lotsId = lotsId; }

    public int getEspeceId() { return especeId; }
    public void setEspeceId(int especeId) { this.especeId = especeId; }

    public LocalDateTime getDateIntroduction() { return dateIntroduction; }
    public void setDateIntroduction(LocalDateTime dateIntroduction) { this.dateIntroduction = dateIntroduction; }

    public int getNombreInitial() { return nombreInitial; }
    public void setNombreInitial(int nombreInitial) { this.nombreInitial = nombreInitial; }

    public BigDecimal getPoidsMoyenInitialG() { return poidsMoyenInitialG; }
    public void setPoidsMoyenInitialG(BigDecimal poidsMoyenInitialG) { this.poidsMoyenInitialG = poidsMoyenInitialG; }

    public String getProvenance() { return provenance; }
    public void setProvenance(String provenance) { this.provenance = provenance; }

    public LocalDate getDateRecoltePrevue() { return dateRecoltePrevue; }
    public void setDateRecoltePrevue(LocalDate dateRecoltePrevue) { this.dateRecoltePrevue = dateRecoltePrevue; }

    public String getStatut() { return statut; }
    public void setStatut(String statut) { this.statut = statut; }

    public String getCommentaires() { return commentaires; }
    public void setCommentaires(String commentaires) { this.commentaires = commentaires; }

    public LocalDateTime getDateCreation() { return dateCreation; }
    public void setDateCreation(LocalDateTime dateCreation) { this.dateCreation = dateCreation; }

    public LocalDateTime getDateMiseAJour() { return dateMiseAJour; }
    public void setDateMiseAJour(LocalDateTime dateMiseAJour) { this.dateMiseAJour = dateMiseAJour; }
}