


module bille() {
    rayon_bille=6;
    rayon_fixation_vis=2.9;
    rayon_corps=15.5/2;
    rayon_tete_vis=2;
    hauteur_corps=11.5;
    hauteur_fixation_vis=max(8.2,hauteur_corps);
    hauteur=15;
    largeur=22;
    hauteur_tete_vis=1.8;
    cote_carre=5;
    diamettre_petite_bille=1.5;
    //petite bille
    translate([cote_carre,cote_carre,hauteur-hauteur_corps]){
        cylinder(hauteur_corps,diamettre_petite_bille,diamettre_petite_bille,$fn=32);
    }
    translate([cote_carre,-cote_carre,hauteur-hauteur_corps]){
        cylinder(hauteur_corps,diamettre_petite_bille,diamettre_petite_bille,$fn=32);
    }
   translate([-cote_carre,cote_carre,hauteur-hauteur_corps]){
        cylinder(hauteur_corps,diamettre_petite_bille,diamettre_petite_bille,$fn=32);
    }
    translate([-cote_carre,-cote_carre,hauteur-hauteur_corps]){
        cylinder(hauteur_corps,diamettre_petite_bille,diamettre_petite_bille,$fn=32);
    }
    
    decallage_centre_vis=(largeur-(2*rayon_corps)-(2*rayon_fixation_vis))/2;
    //tete vis droite
    translate([0,decallage_centre_vis+rayon_corps,hauteur]){
        cylinder(hauteur_tete_vis,rayon_tete_vis,rayon_tete_vis,$fn=32);
    }
     //tete vis gauche
    translate([0,-1*(decallage_centre_vis+rayon_corps),hauteur]){
        cylinder(hauteur_tete_vis,rayon_tete_vis,rayon_tete_vis,$fn=32);
    }
   //fixation vis droite
    translate([0,decallage_centre_vis+rayon_corps,hauteur-hauteur_fixation_vis]){
        cylinder(hauteur_fixation_vis,rayon_fixation_vis,rayon_fixation_vis,$fn=32);
    }
    //fixation vis gauche
    translate([0,-1*(decallage_centre_vis+rayon_corps),hauteur-hauteur_fixation_vis]){
        cylinder(hauteur_fixation_vis,rayon_fixation_vis,rayon_fixation_vis,$fn=32);
    }
    //corps
    translate([0,0,hauteur-hauteur_corps]){
        cylinder(hauteur_corps,rayon_corps,rayon_corps,$fn=32);
    }
    //bille
    translate([0,0,rayon_bille]){
        sphere(rayon_bille);
    }
}


bille();
