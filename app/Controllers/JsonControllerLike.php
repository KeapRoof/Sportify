<?php

class JsonControllerLike{
    public function like(){
        // ajout like
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $data = file_get_contents("php://input");
            $like_info = json_decode($data, true);
            $id = $like_info['id'];
            $user_id = (new UtilisateurDAO())->getUtilisateurByName($_SESSION['nom']);
            (new ActuDAO())->updateLike($id, $user_id);
            
            
        }
    }
}