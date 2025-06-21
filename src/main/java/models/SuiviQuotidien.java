package models;

import java.math.BigDecimal;
import java.time.LocalDateTime;

public class SuiviQuotidien {
    private int suiviId;
    private LocalDateTime dateObservation;
    private BigDecimal temperatureEau;
    private BigDecimal ph;
    private BigDecimal oxygeneDissosMgL;
    private int mortaliteNombre;
    private BigDecimal poidsMoyenG;
    private BigDecimal quantiteAlimentG;
    private Integer typeAlimentId;
    private String observations;
    private LocalDateTime dateCreation;
    private LocalDateTime dateMiseAJour;
    private int userId;
    private int lotsId;
    private int bassinId;

    // Constructors
    public SuiviQuotidien() {}

    public SuiviQuotidien(int userId, int lotsId, int bassinId) {
        this.userId = userId;
        this.lotsId = lotsId;
        this.bassinId = bassinId;
        this.dateObservation = LocalDateTime.now();
        this.mortaliteNombre = 0;
    }

    // Getters and Setters
    public int getSuiviId() { return suiviId; }
    public void setSuiviId(int suiviId) { this.suiviId = suiviId; }

    public LocalDateTime getDateObservation() { return dateObservation; }
    public void setDateObservation(LocalDateTime dateObservation) { this.dateObservation = dateObservation; }

    public BigDecimal getTemperatureEau() { return temperatureEau; }
    public void setTemperatureEau(BigDecimal temperatureEau) { this.temperatureEau = temperatureEau; }

    public BigDecimal getPh() { return ph; }
    public void setPh(BigDecimal ph) { this.ph = ph; }

    public BigDecimal getOxygeneDissosMgL() { return oxygeneDissosMgL; }
    public void setOxygeneDissosMgL(BigDecimal oxygeneDissosMgL) { this.oxygeneDissosMgL = oxygeneDissosMgL; }

    public int getMortaliteNombre() { return mortaliteNombre; }
    public void setMortaliteNombre(int mortaliteNombre) { this.mortaliteNombre = mortaliteNombre; }

    public BigDecimal getPoidsMoyenG() { return poidsMoyenG; }
    public void setPoidsMoyenG(BigDecimal poidsMoyenG) { this.poidsMoyenG = poidsMoyenG; }

    public BigDecimal getQuantiteAlimentG() { return quantiteAlimentG; }
    public void setQuantiteAlimentG(BigDecimal quantiteAlimentG) { this.quantiteAlimentG = quantiteAlimentG; }

    public Integer getTypeAlimentId() { return typeAlimentId; }
    public void setTypeAlimentId(Integer typeAlimentId) { this.typeAlimentId = typeAlimentId; }

    public String getObservations() { return observations; }
    public void setObservations(String observations) { this.observations = observations; }

    public LocalDateTime getDateCreation() { return dateCreation; }
    public void setDateCreation(LocalDateTime dateCreation) { this.dateCreation = dateCreation; }

    public LocalDateTime getDateMiseAJour() { return dateMiseAJour; }
    public void setDateMiseAJour(LocalDateTime dateMiseAJour) { this.dateMiseAJour = dateMiseAJour; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public int getLotsId() { return lotsId; }
    public void setLotsId(int lotsId) { this.lotsId = lotsId; }

    public int getBassinId() { return bassinId; }
    public void setBassinId(int bassinId) { this.bassinId = bassinId; }
}