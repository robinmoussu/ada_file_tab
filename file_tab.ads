-- file_tab.ads
--
-- TAD File: ensemble d'elements, modele FIFO (First In First Out)
-- avec:
--   -> file de capacite bornee (fixee statiquement)
--   -> les elements sont entiers (pas encore de genericite)
--   -> exceptions sur Entrer/Sortir
-- 
-- IMPLEMENTATION TABLEAU: les elements sont stockes dans un tableau
--

package File_Tab is

    -- exceptions levees par ce package
    Erreur_File_Vide, Erreur_File_Pleine: Exception;

    -- implementation masquee a ce niveau!
    type File is private;

    -- cree un nouvelle file, vide, de capacite Taille_Max
    -- Complexitée : O(1)
    function Nouvelle_File return File;

    -- Complexitée : O(1)
    function Est_Vide(F: in File) return Boolean;

    -- Complexitée : O(1)
    function Est_Pleine(F: in File) return Boolean;

    -- Si F n'est pas pleine, ajoute en element en queue de file
    -- Sinon, l'exception Erreur_File_Pleine est levee
    -- et F n'est pas modifiee
    -- Complexitée : O(1)
    procedure Entrer(F: in out File; E: in Integer);

    -- Si F n'est pas vide, l'element en tete de file est
    -- enleve de F est mis dans E.
    -- Sinon l'exception Erreur_File_Vide est levee
    -- et F n'est pas modifiee
    -- Complexitée : O(1)
    procedure Sortir(F: in out File; E: out Integer);

    -- Remarque: est-il possible de definir
    --    function Sortir(F: File) return Integer;
    -- Pourquoi?

    -- Affichage le contenu de la file, du 1er au dernier
    -- element
    -- complexité : O(n) avec n le nombre d'éléments
    procedure Afficher(F: in File);

private

    -- taille maximale d'une file (utiliser Taille_Max ds votre code)
    -- (pas d'alloc dynamique pour l'instant!)
    Taille_Max  : constant Natural := 5;

    -- Index des éléments dans le tableau
    type Iterator   is range 0..Taille_Max - 1;
    type File_array is array (Iterator) of Integer;

    type File is record
        -- Les éléments sont stoqués sous forme dans un tableau circulaire
        elements     : File_array := (others => 0);

        -- Contient les valeurs de la file
        -- Index du premier élément dans le tableau
        index_first  : Iterator := Iterator'First;

        -- Nombre d'éléments actuellement dans la File
        current_size : Natural  := 0;
    end record;


    -- Donne l'index de l'élément i dans la file
    -- Complexitée : O(1)
    function To_iterator(F: File; i: Natural) return Iterator;
end;
