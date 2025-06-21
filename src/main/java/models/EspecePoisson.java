package models;

import java.math.BigDecimal;

public class EspecePoisson {
    private int especeId;
    private String nomScientifique;
    private String nomCommun;
    private BigDecimal temperatureOptimaleMin;
    private BigDecimal temperatureOptimaleMax;
    private BigDecimal phOptimalMin;
    private BigDecimal phOptimalMax;

    // Constructors
    public EspecePoisson() {}

    public EspecePoisson(String nomScientifique, String nomCommun) {
        this.nomScientifique = nomScientifique;
        this.nomCommun = nomCommun;
    }

    // Getters and Setters
    public int getEspeceId() { return especeId; }
    public void setEspeceId(int especeId) { this.especeId = especeId; }

    public String getNomScientifique() { return nomScientifique; }
    public void setNomScientifique(String nomScientifique) { this.nomScientifique = nomScientifique; }

    public String getNomCommun() { return nomCommun; }
    public void setNomCommun(String nomCommun) { this.nomCommun = nomCommun; }

    public BigDecimal getTemperatureOptimaleMin() { return temperatureOptimaleMin; }
    public void setTemperatureOptimaleMin(BigDecimal temperatureOptimaleMin) { this.temperatureOptimaleMin = temperatureOptimaleMin; }

    public BigDecimal getTemperatureOptimaleMax() { return temperatureOptimaleMax; }
    public void setTemperatureOptimaleMax(BigDecimal temperatureOptimaleMax) { this.temperatureOptimaleMax = temperatureOptimaleMax; }

    public BigDecimal getPhOptimalMin() { return phOptimalMin; }
    public void setPhOptimalMin(BigDecimal phOptimalMin) { this.phOptimalMin = phOptimalMin; }

    public BigDecimal getPhOptimalMax() { return phOptimalMax; }
    public void setPhOptimalMax(BigDecimal phOptimalMax) { this.phOptimalMax = phOptimalMax; }
}