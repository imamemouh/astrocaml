open Directions;;
module Images = Images50;;
let perso = Images.hornGirl;;
(* Graphics.close_graph ();; *)
Graphics.open_graph " 350x350";;
Graphics.set_color (Graphics.rgb 0 40 180);;
Graphics.fill_rect 0 0 350 350;;
Graphics.set_color (Graphics.rgb 0 128 255);;
let f i =
  Graphics.draw_segments [|
      (50*i,0,50*i,350);
      (0,50*i,350,50*i)
     |];
in
List.iter f [1;2;3;4;5;6];;

Graphics.remember_mode false;;

let afficher img (i,j) =
  Dessiner.dessiner_image img (!j * 50) (300 - !i * 50);;

let etoiles =  [(ref 0,ref 0);(ref 6,ref 6);(ref 4, ref 5)
                ;(ref 2, ref 2);(ref 3,ref 5)];;

let perso_i, perso_j = ref 3, ref 3;;

let afficher_decor () =
  Graphics.synchronize();;
let afficher_perso() =
  afficher perso (perso_i,perso_j);;
let afficher_mobiles () =
  List.iter (afficher Images.star) etoiles;
  afficher_perso ();;


let deplacer direction =
  let () = match direction with
    | E -> perso_j := !perso_j + 1
    | O -> perso_j := !perso_j - 1
    | S -> perso_i := !perso_i + 1
    | N -> perso_i := !perso_i - 1
  in
  let ramasser_etoile (ri,rj) =
    if (!ri,!rj) = (!perso_i,!perso_j) then
      begin
        ri := -1;
        rj := 7;
      end
  in
  List.iter ramasser_etoile etoiles;
  afficher_decor ();
  afficher_mobiles ();;

let jouer p = Interprete.run p deplacer;;


print_string "          *** космонавт ***\n";;
print_string "       Salut jeune astronaute\n";;
print_string "\n";;
(* TODO trouver le nom de l'auteur *)
print_string " Crédit image : lostgarden.com\n";;
afficher_mobiles ();;
