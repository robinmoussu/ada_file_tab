--Programme de test du package File, ici la version File_Tab
with Ada.Integer_Text_IO, Ada.Text_IO, File_Tab; -- a adapter...
use Ada.Integer_Text_IO, Ada.Text_IO, File_Tab;

procedure file_tab_test is
    F : File;
    E : Integer := 1;
begin

    F := Nouvelle_File;
    Afficher(F);

    -- rempli la file
    while not Est_Pleine(F) loop
        Entrer(F, E);
        E := E + 1;
    end loop;
    Afficher(F);
    -- ici la file contient: 1 2 3 4 5

    -- test exception: enfiler dans une file pleine?
    begin
        Entrer(F, E+1);
    exception 
        when Erreur_File_Pleine =>
            New_Line;
            Put_Line("Impossible d'entrer une valeur, file pleine! --> OK");
        -- mais pas d'erreur, et l'execution continue!
    end;

    -- defile deux fois
    Sortir(F, E);
    Put_Line("Valeur sortie: " & Integer'Image(E)); -- sortie de 1
    Afficher(F);

    Sortir(F, E);
    Put_Line("Valeur sortie: " & Integer'Image(E)); -- sortie de 2
    Afficher(F);    -- ici la file contient: 3 4 5

    Entrer(F, E);
    Afficher(F);    -- ici la file contient: 3 4 5 2

    -- vide la file
    while not Est_Vide(F) loop
        Sortir(F, E);
        New_Line;
        Put_Line("Valeur sortie: " & Integer'Image(E));
    end loop;
    Afficher(F);

    -- test exception: vider une file vide?
    begin
        Sortir(F, E);
    exception 
        when Erreur_File_Vide 
         => Put_Line("Impossible de sortir une valeur, file vide! --> OK");
    end;
    New_Line;
    Put_Line("End of test");
end;
