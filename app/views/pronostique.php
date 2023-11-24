<?php

use \App\Utils;
use \App\Config;

?>


<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sportify</title>
    <link rel="stylesheet" href="../../public/css/pronostique_style.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  
</head>
<body>
    <header>
        <a id="accueil" href="actu.html"><img src="../../public/images/logo.png"></a>
        <a id="actu" href="">Actu</a>
        <a id="prono" href="">Prono</a>
        <a id="boutique" href="">Boutique</a>
        <a id="deconnexion" href="">Déconnexion</a>
    </header>
    <div id="base">
        <aside id="categorie">
            <form>
                <fieldset>
                    <legend>Filtres</legend>
                    <legend>Types d'item</legend>
                    <input type="radio" name="categorie" value="icone">Icône<br>
                    <input type="radio" name="categorie" value="fond">Fond<br>
                    <input type="radio" name="categorie" value="badges">Badges<br>
                    <input type="radio" name="categorie" value="badges">Style nom<br>
                    <legend>Couleur</legend>
                    <select id="couleur">
                        <option value="">Aucune</option>
                        <option value="dog">Rouge</option>
                        <option value="cat">Vert</option>
                        <option value="hamster">Bleu</option>
                        <option value="parrot">Noir</option>
                        <option value="spider">Blanc</option>
                    </select>
                    <br>
                    <legend>Disponibilité</legend>
                    <input type="radio" name="dispo" value="possédé">Possédé<br>
                    <input type="radio" name="dispo" value="possédé">Non possédé<br>
                       
                </fieldset>
            </form>
        </aside>
        <main>
        <p> This is another example paragraph. </p> 
            <!--TODO: Millieu de page a actualiser avec BD -->
        <?php 
             foreach($tableau as $evenement){?>
<section class='prono_ev' id='p<?php echo $evenement->getId()?>'>
         <div class='div1'>
             <img src='../../public/images/football.svg' id='image_sport'>
         </div>
         <div class='div2'>
             <p><?php  echo $evenement->getEquipe_domicile() ." - " .$evenement->getEquipe_exterieur() ?></p>
             <p><?php echo $evenement->getNomEvenement()?></p>
             <p><?php echo $evenement->getCatSport()?></p>
             <p><?php  echo $evenement->getDate_evenement() ?></p>
         </div>
         <div class='div3'>
             <button id="cote_dom" class="openModal" ><?php  echo $evenement->getCote_domicile() ?><a></a></button>
         </div>
         <div class='div4'>
             <button id="cote_ext" class="openModal"><?php  echo $evenement->getCote_exterieur() ?></button>
        </div>
    
    </section>

            <?php }?>
            <script>  
            var para = document.getElementsByTagName('p')[0]; 
            para.id = 'example2';
            $(document).ready(function() {
            $(".openModal").on("click", function() {
                console.log($(this).attr("id"));
            });
            });
  </script>
    </main>
    <aside id="profil">
        <input type="text" placeholder="Rechercher">
        <a>100 Sporticoin</a>
    </aside>
    </div>
    <div class="modal" id="modal">
        <div class="modal-inner">
                <h2>Confirmation</h2>
                <p>Êtes-vous sûr de vouloir parier sur ce match ?</p>
                
                <form>
                    <input type="number" name="mise" id="mise" placeholder="0">
                    <input type="submit" value="Valider">
                </form>
                <button id="closeModal">Annuler</button>
        </div>
    </div>
                
    </div>
</body>
</html>
<script src="../../public/js/prono.js"></script>
<script src="../../public/js/popup.js"></script>


