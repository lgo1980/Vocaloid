%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parcial - Vocaloid
% NOMBRE: Leonardo Olmedo - lgo1980
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

/*
  Es un software de síntesis de voz en el que se animan a personajes, llamados vocaloids. Muy pronto
habrán varios conciertos de esta temática a lo largo de varias ciudades del mundo, y para determinar
información crítica de los cantantes nos pidieron una solución en Prolog para ayudar a los
organizadores a elegir los vocaloids que participarán en cada concierto.
De cada vocaloid (o cantante) se conoce el nombre y además la canción que sabe cantar. De cada
canción se conoce el nombre y la cantidad de minutos de duración.
*/
%Queremos reflejar entonces que:
%megurineLuka sabe cantar la canción nightFever cuya duración es de 4 min y también canta la canción foreverYoung que dura 5 minutos.
vocaloid(megurineLuka,cancion(nightFever,4)).
vocaloid(megurineLuka,cancion(foreverYoung,5)).
%hatsuneMiku sabe cantar la canción tellYourWorld que dura 4 minutos.
vocaloid(hatsuneMiku,cancion(tellYourWorld,4)).
%gumi sabe cantar foreverYoung que dura 4 min y tellYourWorld que dura 5 min
vocaloid(gumi,cancion(tellYourWorld,5)).
vocaloid(gumi,cancion(foreverYoung,4)).
%seeU sabe cantar novemberRain con una duración de 6 min y nightFever con una duración de 5 min.
vocaloid(seeU,cancion(novemberRain,6)).
vocaloid(seeU,cancion(nightFever,5)).
cantante(Cantante):-
  vocaloid(Cantante,_).
%kaito no sabe cantar ninguna canción.
% No se hace nada por principio del universo cerrado
%Tener en cuenta que puede haber canciones con el mismo nombre pero con diferentes duraciones.

/*
a) Generar la base de conocimientos inicial
Definir los siguientes predicados que sean totalmente inversibles, a menos que se indique lo
contrario.
1. Para comenzar el concierto, es preferible introducir primero a los cantantes más novedosos,
por lo que necesitamos un predicado para saber si un vocaloid es novedoso cuando saben al
menos 2 canciones y el tiempo total que duran todas las canciones debería ser menor a 15.
*/
vocaloidNovedoso(Vocaloid):-
  vocaloid(Vocaloid,_),
  findall(Cancion,vocaloid(Vocaloid,Cancion),Canciones),
  length(Canciones, CantidadCanciones),
  CantidadCanciones > 1.
vocaloidNovedoso(Vocaloid):-
  vocaloid(Vocaloid,_),
  findall(Duracion,vocaloid(Vocaloid,cancion(_,Duracion)),Duraciones),
  length(Duraciones, CantidadDeDuraciones),
  CantidadDeDuraciones < 15.

/*
2. Hay algunos vocaloids que simplemente no quieren cantar canciones largas porque no les
gusta, es por eso que se pide saber si un cantante es acelerado, condición que se da cuando
todas sus canciones duran 4 minutos o menos. Resolver sin usar forall/2.
*/
cantanteAcelerado(Cantante):-
  cantante(Cantante),
  not((duracionDeCanciones(Cantante,Tiempo),Tiempo > 4)).

duracionDeCanciones(Cantante,Tiempo):-
  vocaloid(Cantante,Cancion),
  devolverTiempo(Cancion,Tiempo).

devolverTiempo(cancion(_,Tiempo),Tiempo).

/*
  Además de los vocaloids, conocemos información acerca de varios conciertos que se darán en un
futuro no muy lejano. De cada concierto se sabe su nombre, el país donde se realizará, una cantidad
de fama y el tipo de concierto.
Hay tres tipos de conciertos:
● gigante del cual se sabe la cantidad mínima de canciones que el cantante tiene que saber y
además la duración total de todas las canciones tiene que ser mayor a una cantidad dada.
● mediano sólo pide que la duración total de las canciones del cantante sea menor a una
cantidad determinada.
● pequeño el único requisito es que alguna de las canciones dure más de una cantidad dada.

Queremos reflejar los siguientes conciertos:
● Miku Expo, es un concierto gigante que se va a realizar en Estados Unidos, le brinda 2000 de
fama al vocaloid que pueda participar en él y pide que el vocaloid sepa más de 2 canciones y
el tiempo mínimo de 6 minutos.
*/
concierto(mikuExpo,usa,2000,gigante(2,6)).
/*
● Magical Mirai, se realizará en Japón y también es gigante, pero da una fama de 3000 y pide
saber más de 3 canciones por cantante con un tiempo total mínimo de 10 minutos.
*/
concierto(magicalMirai,japon,3000,gigante(3,10)).
/*
  ● Vocalekt Visions, se realizará en Estados Unidos y es mediano brinda 1000 de fama y exige
un tiempo máximo total de 9 minutos.
*/
concierto(vocalektVisions,usa,1000,mediano(9)).
/*
  ● Miku Fest, se hará en Argentina y es un concierto pequeño que solo da 100 de fama al
vocaloid que participe en él, con la condición de que sepa una o más canciones de más de 4
minutos.
*/
concierto(mikuFest,argentina,100,pequenio(1,4)).
%1. Modelar los conciertos y agregar en la base de conocimiento todo lo necesario.¿
/*
  2. Se requiere saber si un vocaloid puede participar en un concierto, esto se da cuando cumple
los requisitos del tipo de concierto. También sabemos que Hatsune Miku puede participar en
cualquier concierto.
*/
puedeParticiparEnUnConcierto(hatsuneMiku,Concierto):-
  concierto(Concierto,_,_,_).
puedeParticiparEnUnConcierto(Cantante,Concierto):-
  vocaloid(Cantante,_),
  Cantante \= hatsuneMiku,
  concierto(Concierto,_,_,Requisitos),
  verificarRequerimiento(Cantante,Requisitos).

verificarRequerimiento(Cantante,pequenio(_,Tiempo)):-
  vocaloid(Cantante,Cancion),
  devolverTiempo(Cancion,TiempoCancion),
  TiempoCancion > Tiempo.

verificarRequerimiento(Cantante,mediano(Tiempo)):-
  duracionDeCanciones(Cantante,TiempoCancion),
  TiempoCancion < Tiempo.

verificarRequerimiento(Cantante,gigante(Canciones,Tiempo)):-
  cantidadCancionesVocaloid(Cantante,Canciones),
  duracionDeCanciones(Cantante,TiempoCancion),
  TiempoCancion > Tiempo.

cantidadCancionesVocaloid(Vocaloid,Cantidad):-
  vocaloid(Vocaloid,_),
  findall(Cancion,vocaloid(Vocaloid,Cancion),Canciones),
  length(Canciones, CantidadCanciones),
  CantidadCanciones > Cantidad.

/*
  3. Conocer el vocaloid más famoso, es decir con mayor nivel de fama. El nivel de fama de un
vocaloid se calcula como la fama total que le dan los conciertos en los cuales puede participar
multiplicado por la cantidad de canciones que sabe cantar.
*/
vocaloidMasFamoso(Cantante):-
  calcularNivelDeFama(Cantante,NivelMayor),
  forall((calcularNivelDeFama(OtroCantante,NivelMenor),OtroCantante \= Cantante), NivelMayor > NivelMenor).

calcularNivelDeFama(Cantante,NivelMayor):-
  cantante(Cantante),
  findall(NivelFama,obtenerNivelFama(Cantante,NivelFama),NivelesFama),
  sum_list(NivelesFama,SumaNiveles),
  cantidadCancionesVocaloid1(Cantante,Cantidad),
  NivelMayor is SumaNiveles * Cantidad.

obtenerNivelFama(Cantante,NivelFama):-
  distinct(puedeParticiparEnUnConcierto(Cantante,Concierto)),
  concierto(Concierto,_,NivelFama,_).

cantidadCancionesVocaloid1(Vocaloid,CantidadCanciones):-
  vocaloid(Vocaloid,_),
  findall(Cancion,vocaloid(Vocaloid,Cancion),Canciones),
  length(Canciones, CantidadCanciones).

/*
4. Sabemos que:
● megurineLuka conoce a hatsuneMiku y a gumi
● gumi conoce a seeU
● seeU conoce a kaito
Queremos verificar si un vocaloid es el único que participa de un concierto, esto se cumple si
ninguno de sus conocidos ya sea directo o indirectos (en cualquiera de los niveles) participa
en el mismo concierto.
*/
conoceA(megurineLuka,hatsuneMiku).
conoceA(megurineLuka,gumi).
conoceA(gumi,seeU).
conoceA(seeU,kaito).

/*unicoParticipanteDeUnConcierto(Cantante,Concierto):-
  conoceA(Cantante,OtroCantante),
  puedeParticiparEnUnConcierto(Cantante,Concierto),
  puedeParticiparEnUnConcierto(OtroCantante,Concierto).*/

unicoParticipanteDeUnConcierto(Cantante,Concierto):- 
  puedeParticiparEnUnConcierto(Cantante, Concierto),
  not((conocido(Cantante, OtroCantante), 
  puedeParticiparEnUnConcierto(OtroCantante, Concierto))).

%Conocido directo
conocido(Cantante, OtroCantante) :- 
  conoceA(Cantante, OtroCantante).

%Conocido indirecto
conocido(Cantante, OtroCantante) :- 
  conoceA(Cantante, UnCantante), 
  conocido(UnCantante, OtroCantante).


/*
5. Supongamos que aparece un nuevo tipo de concierto y necesitamos tenerlo en cuenta en
nuestra solución, explique los cambios que habría que realizar para que siga todo
funcionando. ¿Qué conceptos facilitaron dicha implementación?
*/

/*
En la solución planteada habría que agregar una claúsula en el predicado cumpleRequisitos/2  que tenga en cuenta el nuevo functor con sus respectivos requisitos 
El concepto que facilita los cambios para el nuevo requerimiento es el polimorfismo, que nos permite dar un tratamiento en particular a cada uno de los conciertos en la cabeza de la cláusula.
*/
  


:- begin_tests(utneanos).
  test(vocaloid_que_es_novedoso_por_tener_mas_de_una_cancion,set(Vocaloid=[megurineLuka,gumi,seeU,hatsuneMiku])):-
    vocaloidNovedoso(Vocaloid).
  test(cantante_que_es_acelerado_cuando_canta_todas_sus_canciones_en_menos_de_cierto_tiempo,set(Cantante=[hatsuneMiku])):-
    cantanteAcelerado(Cantante).
  test(si_un_vocaloid_determinado_puede_participar_en_un_concierto,set(Concierto=[vocalektVisions,mikuFest])):-
    puedeParticiparEnUnConcierto(gumi,Concierto).
  test(si_un_vocaloid_determinado_puede_participar_en_todos_los_conciertos,set(Concierto=[mikuExpo,vocalektVisions,mikuFest,magicalMirai])):-
    puedeParticiparEnUnConcierto(hatsuneMiku,Concierto).
  test(un_vocaloid_determinado_es_el_que_tiene_mas_fama,set(Cantante=[hatsuneMiku])):-
    vocaloidMasFamoso(Cantante).
  test(un_vocaloid_determinado_es_el_unico_que_participa_en_un_concierto,set(Concierto=[mikuExpo,magicalMirai])):-
    unicoParticipanteDeUnConcierto(hatsuneMiku,Concierto).
:- end_tests(utneanos).