package models;

import java.time.LocalDateTime;

public class Utilisateur {
    private int userId;
    private String nom;
    private String email;
    private String motDePasse;
    private String role;
    private LocalDateTime dateCreation;
    private LocalDateTime dateMiseAJour;
    private boolean actif;

    // Constructors
    public Utilisateur() {}

    public Utilisateur(String nom, String email, String motDePasse, String role) {
        this.nom = nom;
        this.email = email;
        this.motDePasse = motDePasse;
        this.role = role;
        this.actif = true;
    }

    // Getters and Setters
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getNom() { return nom; }
    public void setNom(String nom) { this.nom = nom; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getMotDePasse() { return motDePasse; }
    public void setMotDePasse(String motDePasse) { this.motDePasse = motDePasse; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }

    public LocalDateTime getDateCreation() { return dateCreation; }
    public void setDateCreation(LocalDateTime dateCreation) { this.dateCreation = dateCreation; }

    public LocalDateTime getDateMiseAJour() { return dateMiseAJour; }
    public void setDateMiseAJour(LocalDateTime dateMiseAJour) { this.dateMiseAJour = dateMiseAJour; }

    public boolean isActif() { return actif; }
    public void setActif(boolean actif) { this.actif = actif; }
}