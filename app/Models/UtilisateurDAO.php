<?php



// include '../vendor/Autoloader.php';
// seulement l'id et le mail sont unique, deux personnes peuvent avoir le meme nom, prenom, mot de passe
class UtilisateurDAO extends DAO{
    
    public function getAllUsers(){
        $sql = "SELECT * FROM `UTILISATEUR` WHERE STATUS = 1";
        $res = $this->queryAll($sql);
        $tab = [];
    
        foreach($res as $user){
           $us = new Utilisateur($user[0],$user[1],$user[2],$user[3],$user[4],$user[5],$user[6],$user[7]);
           $tab[]  = $us;
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

    public function deleteUtilisateurByID($id){

        $sql = "DELETE FROM `UTILISATEUR` WHERE UTILISATEUR_ID = :id";
        $this->delete($sql, array('id' => $id));

        $sql = "DELETE FROM `INVENTAIRE` WHERE UTILISATEUR_ID = :id";
        $this->delete($sql, array('id' => $id));


        $sql = "DELETE FROM `PRONOSTIC` WHERE PRONOSTIQUEUR_ID = :id";

        $this->delete($sql, array('id' => $id));
    }
    
    
    // echo "quoicoubeh". (new UtilisateurDAO())->getUtilisateurByName()."lksjdaskd";

    public function getUserId($nom){
        $sql = "SELECT UTILISATEUR_ID FROM `UTILISATEUR` WHERE PSEUDO = :pseudo";
        $result = $this->queryRow($sql, array('pseudo' => $nom));
        if ($result) {
            return $result['UTILISATEUR_ID'];
        } else {
            echo "Erreur : Impossible de récupérer l'ID de l'utilisateur depuis la base de données.";
            return null;
        }
    }

    public function setLastConnection($name){
        $sql = "UPDATE `UTILISATEUR` SET LAST_CONNECTION = CAST(NOW() AS DATE) WHERE PSEUDO = :pseudo";
        $this->update($sql, array(
            "pseudo" => $name
        ));
    }


    public function addPoint($name){
        $sql = "UPDATE `UTILISATEUR` SET POINT_ACTUEL = POINT_ACTUEL + 10 WHERE UTILISATEUR_ID = :id";
        $this->update($sql, array(
            "id" => $this->getUserId($name)
        ));
    }
    public function updatePointJeu($points,$name){
        $sql = "UPDATE `UTILISATEUR` SET POINT_ACTUEL = POINT_ACTUEL + :points WHERE UTILISATEUR_ID = :id";
        $this->update($sql, array(
            "points"=>$points,
            "id" => $this->getUserId($name)
           
        ));
    }
    public function getLastConnection($name){
        $sql = "SELECT LAST_CONNECTION FROM `UTILISATEUR` WHERE PSEUDO = :pseudo";
        $result = $this->queryRow($sql, array('pseudo' => $name));
        if ($result) {
            if($result['LAST_CONNECTION'] != date("Y-m-d")){
                (new UtilisateurDAO())->addPoint($name);
                (new UtilisateurDAO())->setLastConnection($name);
                return "Vous avez gagné 10 points pour votre connexion quotidienne !";
            }
            else{
                return date("Y-m-d");
            }
        }
        else {
            echo "Erreur : Impossible de récupérer la dernière connexion de l'utilisateur depuis la base de données.";
            return "";
        }
    }

    public function getTop10(){
        $sql = "SELECT * FROM `UTILISATEUR` WHERE STATUS = 1 ORDER BY POINT_CLASSEMENT DESC LIMIT 10";
        $res = $this->queryAll($sql);
        $tab = [];
    
        foreach($res as $user){
           $us = new Utilisateur($user[0],$user[1],$user[2],$user[3],$user[4],$user[5],$user[6],$user[7]);
           $tab[]  = $us;
        }
  
        return $tab;
    }
}