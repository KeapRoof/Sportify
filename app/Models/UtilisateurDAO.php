<?php



require 'Singleton.php';

// seulement l'id et le mail sont unique, deux personnes peuvent avoir le meme nom, prenom, mot de passe
class UtilisateurDAO extends DAO{
    
    
    public function getAllUSers(){
        $sql = "SELECT * FROM `UTILISATEUR`";
        $res = $this->queryAll($sql);
        $tab =[];
        //   var_dump($res);
        foreach($res as $user){
            $users[] = new Utilisateur($user[0],$user[1],$user[2],$user[3],$user[4],$user[5],$user[6],$user[7]);
            
            $tab[] = $users;
        }
        return $tab;
    }
    
    public function select($nom, $mdp) {
        $sql = "SELECT * FROM `UTILISATEUR` WHERE PSEUDO LIKE :pseudo";
        $res = $this->queryRow($sql, array('pseudo' => $nom));
        
        $bool = FALSE;
        
        if ($res) {
            
            $motDePasseBD = $res['MOT_DE_PASSE'];
            echo "BD : ". $motDePasseBD."<br>";
            echo "mdp : ".$mdp;
            
            if (password_verify($mdp, $motDePasseBD)) {
                
                echo "Utilisateur présent";
                $bool = TRUE;
            } else {
                
                echo "Mot de passe incorrect";
            }
        } else {
            
            echo "Utilisateur inconnu";
        }
        
        return $bool;
    }
    
    public function insertUtilisateur($utilisateur) {
        $sql = "INSERT INTO `UTILISATEUR` (`PSEUDO`, `EMAIL`, `MOT_DE_PASSE`, `POINT_ACTUEL`, `POINT_CLASSEMENT`, `STATUS`, `SCORE_JEU`) VALUES 
        (:pseudo, :mail, :mdp, :point_actuel, :points_classement, :statut, :score_jeu)";
        $this->insert($sql,array(
            
            "pseudo" => $utilisateur->getPseudo(),
            "mail" => $utilisateur->getEmail(),
            "mdp" => $utilisateur->getMotDePasse(),
            "point_actuel" => $utilisateur->getPointActuel(),
            "points_classement" => $utilisateur->getPointClassement(),
            "statut" => $utilisateur->getStatus(),
            "score_jeu" => $utilisateur->getScoreJeu()
        ));
        
        
    }
    //a changer 
    public function selectInscription($nom,$mdp,$email){
        $sql = "SELECT * from `UTILISATEUR` where PSEUDO like :pseudo  or EMAIL like :mail";
        $res=  $this->queryRow($sql,array('pseudo'=>$nom,
        'mail'=>$email));
        $bool = FALSE;
        if($res){   
            echo "utilisateur present";
            
            $bool = TRUE;
        }
        else{
            
            
            echo "Utilisateur inconnue";
            
        }
        return $bool;
        
    }
    
    public function getUtilisateurByName($nom){
        
        if (isset($nom)) {
            
            $sql = "SELECT UTILISATEUR_ID FROM `UTILISATEUR` WHERE PSEUDO = :pseudo";
            $result = $this->queryRow($sql, array('pseudo' => $nom));
            
            
            if ($result) {
                return $result['UTILISATEUR_ID'];
            } else {
                echo "Erreur : Impossible de récupérer l'ID de l'utilisateur depuis la base de données.";
                return null;
            }
        } else {
            echo "Erreur : La variable de session 'nom' n'est pas définie.";
            return null;
        }
    }
    
    
    
    public function updatePoint($id, $pointActuel, $mise) {
        $sql = "UPDATE `UTILISATEUR` SET POINT_ACTUEL = POINT_ACTUEL - :mise WHERE UTILISATEUR_ID = :id";
        $this->update($sql, array(
            "id" => $id,
            "mise" => $mise
        ));
    }
    
    
    public function getPointUser($nom){
        $sql = "SELECT POINT_ACTUEL FROM `UTILISATEUR` WHERE PSEUDO = :pseudo";
        $result = $this->queryRow($sql, array('pseudo' => $nom));
        if ($result) {
            return $result['POINT_ACTUEL'];
        } else {
            echo "Erreur : Impossible de récupérer le nombre de points de l'utilisateur depuis la base de données.";
            return null;
        }
    }
    public function supprimerUtilisateur(){ 
        $data = file_get_contents("php://input");
        $user = json_decode($data, true);  
        var_dump($data);      
    }
    
    // echo "quoicoubeh". (new UtilisateurDAO())->getUtilisateurByName()."lksjdaskd";
    
}
(new UtilisateurDAO())->supprimerUtilisateur();
