author('Jack Kerouac').
author('Boris Vian').
author('Jules Vernes').
author('Paolo Coehlo').
author('Fred Vargas').

book('Sur la route').
book('L''ecume de jours').
book('20 000 lieues sous les mers').
book('De la Terre a la Lune').
book('L''ile mysterieuse').
book('L''alchimiste').
book('Pars vite et reviens tard').

author_book('Jack Kerouac', 'Sur la route').
author_book('Boris Vian', 'L''ecume de jours').
author_book('Jules Vernes', '20 000 lieues sous les mers').
author_book('Jules Vernes', 'De la Terre a la Lune').
author_book('Jules Vernes', 'L''ile mysterieuse').
author_book('Paolo Coehlo', 'L''alchimiste').
author_book('Fred Vargas', 'Pars vite et reviens tard').

writer(A, B) :- author(A), book(B), author_book(A, B).


musician('Jimmy Page').
musician('Jimmy Hendrix').
musician('Jaco Pastorius').
musician('Paul McCartney').
musician('Ringo Star').
musician('Elton John').
musician('Michel Berger').
musician('Louis Bertignac').
musician('Louis Amstrong').
musician('Ben Harper').
musician('Charlie Watts').

instrument(guitar).
instrument(piano).
instrument(drums).
instrument(trumpet).
instrument(bass).

genre(pop).
genre(rock).
genre(jazz).
genre(fusion).

play('Jimmy Page', guitar).
play('Jimmy Hendrix', guitar).
play('Jaco Pastorius', bass).
play('Paul McCartney', bass).
play('Paul McCartney', guitar).
play('Paul McCartney', piano).
play('Ringo Star', drums).
play('Elton John', piano).
play('Michel Berger', piano).
play('Louis Bertignac', guitar).
play('Louis Amstrong', trumpet).
play('Ben Harper', guitar).
play('Charlie Watts', drums).


music('Jimmy Page', rock).
music('Jimmy Hendrix', rock).
music('Jaco Pastorius', fusion).
music('Paul McCartney', pop).
music('Paul McCartney', rock).
music('Ringo Star', pop).
music('Ringo Star', rock).
music('Elton John', pop).
music('Michel Berger', pop).
music('Louis Bertignac', rock).
music('Louis Amstrong', jazz).
music('Ben Harper', rock).
music('Charlie Watts', rock).

rock_n_roll(X) :- musician(X), play(X, guitar) , music(X, rock).
rock_n_roll(X) :- musician(X), play(X, drums) , music(X, rock).
rock_n_roll(X) :- musician(X), play(X, bass) , music(X, rock).
