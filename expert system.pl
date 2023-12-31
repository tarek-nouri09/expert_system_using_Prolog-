type(java, high).
type(c, low).
type(cplusplus, high).
type(python, high).
type(assembly, low).
type(prolog, high).
type(swift, high).
type(javascript, high).
type(php, high).
type(rust, low).
type(kotlin, high).
type(typescript, high).
type(go, low).
type(ruby, high).
type(scala, high).
type(ocaml, high).
type(csharp, high).

object_oriented(java, yes).
object_oriented(c, no).
object_oriented(cplusplus, yes).
object_oriented(python, yes).
object_oriented(assembly, no).
object_oriented(prolog, no).
object_oriented(swift, yes).
object_oriented(javascript, yes).
object_oriented(php, yes).
object_oriented(rust, no).
object_oriented(kotlin, yes).
object_oriented(typescript, yes).
object_oriented(go, no).
object_oriented(ruby, yes).
object_oriented(scala, yes).
object_oriented(ocaml, yes).
object_oriented(csharp, yes).

logic(java, no).
logic(c, no).
logic(cplusplus, no).
logic(python, no).
logic(assembly, no).
logic(prolog, yes).
logic(swift, no).
logic(javascript, no).
logic(php, no).
logic(rust, yes).
logic(kotlin, no).
logic(typescript, no).
logic(go, yes).
logic(ruby, no).
logic(scala, yes).
logic(ocaml, yes).
logic(csharp, no).

complexity(java, complex).
complexity(c, simple).
complexity(cplusplus, complex).
complexity(python, simple).
complexity(assembly, complex).
complexity(prolog, complex).
complexity(swift, complex).
complexity(javascript, simple).
complexity(php, simple).
complexity(rust, complex).
complexity(kotlin, complex).
complexity(typescript, simple).
complexity(go, complex).
complexity(ruby, simple).
complexity(scala, complex).
complexity(ocaml, complex).
complexity(csharp, simple).

usage(java, 'Web Development').
usage(c, 'System Programming').
usage(cplusplus, 'System Programming').
usage(python, 'Data Science').
usage(assembly, 'Low-Level Programming').
usage(prolog, 'Artificial Intelligence').
usage(swift, 'Mobile App Development').
usage(javascript, 'Web Development').
usage(php, 'Web Development').
usage(rust, 'System Programming').
usage(kotlin, 'Mobile App Development').
usage(typescript, 'Web Development').
usage(go, 'System Programming').
usage(ruby, 'Web Development').
usage(scala, 'Web Development').
usage(ocaml, 'Functional Programming').
usage(csharp, 'Desktop Application Development').

purpose(java,web).
purpose(c,desktop).
purpose(cplusplus,desktop).
purpose(python,web).
purpose(assembly,desktop).
purpose(prolog,web).
purpose(swift,mobile).
purpose(javascript,web).
purpose(php,web).
purpose(rust,desktop).
purpose(kotlin,mobile).
purpose(typescript,web).
purpose(go,desktop).
purpose(ruby,web).
purpose(scala,web).
purpose(ocaml,web).
purpose(csharp,desktop).

valid_level(low).
valid_level(high).
valid_level(idk).

recommend(Language) :-
    ask_level(Level),
    ask_object_oriented(OO),
    ask_logic(Logic),
    ask_complexity(Complexity),
    ask_purpose(Purpose),
    find_language(Level, OO, Logic, Complexity,Purpose ,Language),
    write('Recommended language: '), write(Language), nl,
    ask_more_info(Language),
    ask_for_same(Language).

ask_purpose(Purpose) :-
    repeat,
    write('Is the language purpose desktop, web, or mobile or idk? (web/mobile/desktop/idk): '),
    read(Purpose),
    (valid_purpose(Purpose) -> true ; write('Invalid input. Please enter "Desktop", "Web", or "Mobile" or "idk".'), nl, fail).

valid_purpose(idk).
valid_purpose(web).
valid_purpose(desktop).
valid_purpose(mobile).

ask_complexity(Complexity) :-
    repeat,
    write('Is the language complexity complex, simple, or idk? (complex/simple/idk): '),
    read(Complexity),
    (valid_complexity(Complexity) -> true ; write('Invalid input. Please enter "complex," "simple," or "idk".'), nl, fail).

valid_complexity(complex).
valid_complexity(simple).
valid_complexity(idk).

ask_more_info(Language) :-
    repeat,
    write('Do you want more information about this language? (yes/no): '),
    read(Answer),
    (Answer == yes ->
        display_language_info(Language),
        !
    ; Answer == no ->
        true
    ;
        write('Invalid input. Please enter "yes" or "no".'), nl,
        fail
    ).

ask_for_same(Language) :-
    repeat,
    write('Do you want more languages that are similar with type , oo ,logic to '), write(Language), write('? (yes/no): '),
    read(Answer),
    (Answer == yes ->
        find_the_similarity(Language),
        !
    ; Answer == no ->
        true
    ;
        write('Invalid input. Please enter "yes" or "no".'), nl,
        fail
    ).

find_the_similarity(Language) :-
    type(Language, Type),
    object_oriented(Language, OO),
    logic(Language, Logic),
    purpose(Language,Purpose),
    findall(SimilarLanguage, (
        object_oriented(SimilarLanguage, OO),
        logic(SimilarLanguage, Logic),
        type(SimilarLanguage, Type),
        purpose(SimilarLanguage,Purpose),
        SimilarLanguage \= Language
    ), SimilarLanguages),
    write('Languages with similar characteristics: '), write(SimilarLanguages), nl.

display_language_info(Language) :-
    write('Information about '), write(Language), write(':'), nl,
    type(Language, Type),
    write('Type: '), write(Type), nl,
    object_oriented(Language, OO),
    write('Object-oriented: '), write(OO), nl,
    logic(Language, Logic),
    write('Logic-based: '), write(Logic), nl,
    complexity(Language, Complexity),
    write('Complexity: '), write(Complexity), nl,
    purpose(Language, Purpose),
    write('Purpose: '), write(Purpose), nl,
    usage(Language, Usage),
    write('Usage: '), write(Usage), nl.

ask_level(Level) :-
    repeat,
    write('Is the language low, high, or idk? (low/high/idk): '),
    read(Level),
    (valid_level(Level) -> true ; write('Invalid input. Please enter "low," "high," or "idk".'), nl, fail).

ask_object_oriented(OO) :-
    repeat,
    write('Is the language object-oriented, not object-oriented, or idk? (yes/no/idk): '),
    read(OO),
    (valid_yes_no(OO) -> true ; write('Invalid input. Please enter "yes," "no," or "idk".'), nl, fail).

ask_logic(Logic) :-
    repeat,
    write('Is the language logic-based, not logic-based, or idk? (yes/no/idk): '),
    read(Logic),
    (valid_yes_no(Logic) -> true ; write('Invalid input. Please enter "yes," "no," or "idk".'), nl, fail).

valid_yes_no(yes).
valid_yes_no(no).
valid_yes_no(idk).

find_language(Level, OO, Logic, Complexity, Purpose ,Language) :-
    (Level == idk ; type(Language, Level)),
    (OO == idk ; object_oriented(Language, OO)),
    (Logic == idk ; logic(Language, Logic)),
    (Complexity == idk ; complexity(Language, Complexity)),
    (Purpose  == idk ; purpose(Language, Purpose)).

find_language(_, _, _, _, 'No language found.').
