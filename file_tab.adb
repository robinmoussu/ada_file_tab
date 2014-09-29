with Ada.Integer_Text_IO, Ada.Text_IO;
use Ada.Integer_Text_IO, Ada.Text_IO;

package body File_Tab is

    function Nouvelle_File return File is
        f: File := (others => 0);
    begin
        return f;
    end Nouvelle_File;


    function Est_Vide(F: in File) return Boolean is
    begin
        return current_size = 0;
    end Est_Vide;


    function Est_Pleine(F: in File) return Boolean is
    begin
        return current_size = Taille_Max;
    end Est_Pleine;


    procedure Entrer(F: in out File; E: in Integer) is
    begin
        if Est_Pleine(F) then
            raise Erreur_File_Pleine;
        end if;
        elements(To_iterator(current_size)) := E;
        current_size := current_size + 1;
    end Entrer;


    procedure Sortir(F: in out File; E: out Integer) is
        index_to_pop: Iterator;
    begin
        index_to_pop := index_first;
        if Est_Vide(F) then
            raise Erreur_File_Vide;
        end if;
        current_size := current_size - 1;
        index_first  := To_iterator(1);
        E := elements(index_to_pop);
    end Sortir;


    procedure Afficher(F: in File) is
        i: Natural := 0;
    begin
        for i in 0..Taille_Max - 1 loop
            Put(elements(To_iterator(i)));
        end loop;
        New_Line;
    end Afficher;

    function To_iterator(i: Natural) return Iterator is
    begin
        return Iterator((Integer(index_first) + i) mod Taille_Max);
    end To_iterator;
end File_Tab ;
