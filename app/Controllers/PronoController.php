<?php
class PronoController extends Controllers{
    public  function index(){
     
       (new VerifSession());
        View::View('pronostique',["tableau"=>(new EvenementDAO())->getAll(),
    "pointsUser"=>( new UtilisateurDAO())->getPointUser($_SESSION['nom']),
    "tableauProno"=>(new PronostiqueDAO())->selectPronoByUser($_SESSION['nom']),
    "lastConnection"=>(new UtilisateurDAO())->getLastConnection($_SESSION['nom'])]);
    
        $testData=(new EvenementDAO())->getAll();
        $encodedDataArray = [];
        
        foreach ($testData as $event) {
            if (!empty($event)) {
               
                $eventData = [
                    'id' => $event->getId(),
                    'equipe_domicile' => $event->getEquipe_domicile(),
                    'equipe_exterieur' => $event->getEquipe_exterieur(),
                    'nom_evenement' => $event->getNomEvenement(),
                    'cat_sport' => $event->getCatSport(),
                    'date_evenement' => $event->getDate_evenement(),
                    'cote_domicile' => $event->getCote_domicile(),
                    'cote_exterieur' => $event->getCote_exterieur(),
                ];
        
              
                $encodedDataArray[] = $eventData;
            }
        }
        
       
        $finalEncodedData = json_encode($encodedDataArray);
 
        file_put_contents('data.json', $finalEncodedData);
    
    }

    public function insert(){
        $event = new EvenementDAO();
        $event->insertEvenement($_POST);
    }
    
  
}