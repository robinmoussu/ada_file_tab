--Programme de test du package File, ici la version File_Tab
with Ada.Integer_Text_IO, Ada.Text_IO, File_Tab; -- a adapter...
use Ada.Integer_Text_IO, Ada.Text_IO, File_Tab;

procedure file_tab_test is
    F, F2 : File := Nouvelle_File;
    E     : Integer := 1;
begin

    Put_Line("F (doit être vide) : ");
    Afficher(F);
    New_Line; Put_Line("F2 (doit être vide) : ");
    Afficher(F2);

    -- rempli la file
    New_Line;
    while not Est_Pleine(F) loop
        Entrer(F, E);
        E := E + 1;
    end loop;
    Put_Line("F (doit être 1 2 3 4 5) : ");
    Afficher(F);
    -- ici la file contient: 1 2 3 4 5

    -- test exception: enfiler dans une file pleine?
    New_Line;
    begin
        Entrer(F, E+1);
    exception 
        when Erreur_File_Pleine =>
            New_Line;
            Put_Line("Impossible d'entrer une valeur, file pleine! --> OK");
        -- mais pas d'erreur, et l'execution continue!
    end;
    Put_Line("F (doit être 1 2 3 4 5) : ");
    Afficher(F);

    -- defile deux fois
    New_Line;
    Sortir(F, E); -- sortie de 1
    Put_Line("Valeur sortie (doit être 1) : " & Integer'Image(E));
    Put_Line("F (doit être 2 3 4 5) : ");
    Afficher(F);
    New_Line;
    Put_Line("F2 (doit être vide) : ");
    Afficher(F2);

    New_Line;
    for i in 0..3 loop
        Entrer(F2,2*i);
    end loop;
    Put_Line("F2 (doit être 0 2 4 6) : ");
    Afficher(F2);

    New_Line;
    Sortir(F, E); -- sortie de 2
    Put_Line("Valeur sortie (doit être 2) : " & Integer'Image(E));
    Put_Line("F (doit être 3 4 5) : ");
    Afficher(F);

    New_Line;
    Entrer(F, E); -- entrée de 2
    Put_Line("F (doit être 3 4 5 2) : ");
    Afficher(F);

    New_Line;
    -- vide la file
    while not Est_Vide(F) loop
        Sortir(F, E);
        Put_Line("Valeur sortie: " & Integer'Image(E));
    end loop;
    New_Line;
    Put_Line("F (doit être vide) : ");
    Afficher(F);

    -- test exception: vider une file vide?
    New_Line;
    begin
        Sortir(F, E);
    exception 
        when Erreur_File_Vide 
         => Put_Line("Impossible de sortir une valeur, file vide! --> OK");
    end;
    Put_Line("F (doit être vide) : ");
    Afficher(F);

    New_Line;
    Put("End of test");
end;
