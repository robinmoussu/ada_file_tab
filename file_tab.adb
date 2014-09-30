with Ada.Integer_Text_IO, Ada.Text_IO, File_Tab;
use Ada.Integer_Text_IO, Ada.Text_IO, File_Tab;

package body File_Tab is

    function Nouvelle_File return File is
        f: File;
    begin
        f.elements     := (others => 0);
        f.index_first  := Iterator'First;
        f.current_size := 0;
        return f;
    end Nouvelle_File;


    function Est_Vide(F: in File) return Boolean is
    begin
        return F.current_size = 0;
    end Est_Vide;


    function Est_Pleine(F: in File) return Boolean is
    begin
        return F.current_size = Taille_Max;
    end Est_Pleine;


    procedure Entrer(F: in out File; E: in Integer) is
    begin
        if Est_Pleine(F) then
            raise Erreur_File_Pleine;
        end if;
        F.elements(To_iterator(F, F.current_size)) := E;
        F.current_size := F.current_size + 1;
    end Entrer;


    procedure Sortir(F: in out File; E: out Integer) is
        index_to_pop: Iterator;
    begin
        index_to_pop := F.index_first;
        if Est_Vide(F) then
            raise Erreur_File_Vide;
        end if;
        F.current_size := F.current_size - 1;
        F.index_first  := To_iterator(F, 1);
        E := F.elements(index_to_pop);
    end Sortir;


    procedure Afficher(F: in File) is
        i: Natural := 0;
    begin
        for i in 0..F.current_size - 1 loop
            Put(F.elements(To_iterator(F, i)));
        end loop;
        New_Line;
    end Afficher;

    function To_iterator(F: File; i: Natural) return Iterator is
    begin
        return Iterator((Integer(F.index_first) + i) mod Taille_Max);
    end To_iterator;
end File_Tab ;
