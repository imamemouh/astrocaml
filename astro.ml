open Directions;;
module Images = Images50;;
let perso = Images.hornGirl;;
(* Graphics.close_graph ();; *)
Graphics.open_graph " 350x350";;
Graphics.set_color (Graphics.rgb 0 40 180);;
Graphics.fill_rect 0 0 350 350;;
Graphics.remember_mode false;;

let afficher img (i,j) =
  Dessiner.dessiner_image img (j * 50) (300 - i * 50);;

let etoiles = [(0,0);(6,6);(4,5);(2,2);(3,5)];;

let perso_i, perso_j = ref 3, ref 3;;

let afficher_decor () =
  Graphics.synchronize();;
let afficher_perso() =
  afficher perso (!perso_i,!perso_j);;
let afficher_mobiles () =
  List.iter (afficher Images.star) etoiles;
  afficher_perso ();;

print_string "          *** космонавт ***\n";;
print_string "       Salut jeune astronaute\n";;
print_string "\n";;
(* TODO trouver le nom de l'auteur *)
print_string " Crédit image : lostgarden.com\n";;

let deplacer direction =
  let () = match direction with
    | E -> perso_j := !perso_j + 1
    | O -> perso_j := !perso_j - 1
    | S -> perso_i := !perso_i + 1
    | N -> perso_i := !perso_i - 1
  in
  afficher_decor ();
  afficher_mobiles ();;

let jouer p = Interprete.run p deplacer;;
