%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parcial - Vocaloid
% NOMBRE: Leonardo Olmedo - lgo1980
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



:- begin_tests(utneanos).
  test(mago_que_se_le_permite_entrar_a_una_casa,set(Mago=[harry,draco,ron,ron1])):-
    permisoDeLaCasa(slytherin,Mago).
  test(mago_que_puede_entrar_a_una_casa_por_sus_caracteristicas,set(Mago=[harry,hermione])):-
    caracterApropiado(Mago,slytherin).
  test(mago_que_puede_entrar_a_una_casa_determinada_dependiendo_de_todas_las_condiciones_necesarias,set(Casa=[gryffindor,hufflepuff])):-
    quedarSeleccionado(Casa,harry).
  test(magos_quePueden_estar_en_una_lista_de_amistades,nondet):-
    cadenaDeAmistades([harry,draco]).
  test(si_un_mago_determinado_es_buen_alumno,set(Mago=[ron,draco])):-
    esBuenAlumno(Mago).
  test(saber_que_una_accion_es_recurrente,set(Accion=[mala(tercerPiso,75)])):-
    distinct(accionRecurrente(Accion)).
  test(saber_el_puntaje_total_de_una_casa_determinada,set(PuntajeTotal=[-115])):-
    distinct(puntajeTotalCasa(gryffindor,PuntajeTotal)).
  test(casa_ganadora_de_la_copa,set(Casa=[slytherin])):-
    ganadoraDeLaCopa(Casa).

:- end_tests(utneanos).