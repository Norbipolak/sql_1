/*
    Az adatbázisokban adatokat tárolunk. 
    Az adatbázis futattásához kell egy adatbázis szerver.
    Relációs adatbázisok 
    A relációs adatbázisok táblákban és rekordokban tárolják az adatokat 

    táblák: egy entitás adatait tárolják 
        mezők (attributumok): Az entitásnak a tulajdonságai 

    Az SQL (Structured Query Language) egy programozási nyelv, amelyet relációs 
    adatbázisokhoz fejlesztettek ki 

    - adatdefiniciós 
    - adatmanupulációs 
    - adatlekérdező nyelv 

    A rekordok az egyes adatokat a táblán 

    tábla - tehát van a tábla ami az egész 
    mezők (attributumok) - hogy a táblán mik vannak pl. itt majd csinálunk egy social media page-t és abban a mezők a UserName, Email stb 
        ezeket mindig nagy betűvel kell írni 
    rekord - ezek, hogy a mezőknek milyen adatokat adunk majd meg, ezt kell majd az INSERT-vel csinálni!!!! 

    Fontos, hogy amikor csinálunk egy táblát, akkor az mindig create table 
    utána adjuk meg, hogy mi legyen az adott database-nek a neve 
    Amit mindig be kell itt állítani az két dolog 
    1. set charset !!!! - ez a mi esetünkben utf8mb4 lesz!!! 
    2. collate - ez is mindig az utf8mb4-vel kezdődik majd, de itt még hozzá kell írni, hogy _general_ci 
    -> 

    Két dolgot határoz meg a collation 
        - kis és nagybetűs érzékeny-e a karakterkészlet 
        különbőzőnek tekinti-e az adatbázis a karaktereknek a ékezetes, nem ékezetes formáit 

        ci -> case insensitive (amit mi is majd mindig használunk), tehát itt ez ugyanannak minősül, hogy RESET vagy reset 
        cs -> case sensitive - itt nem lesz ugyanaz a nagybetűs meg a kisbetűs, tehát RESET !== reset 

        ai -> accented insensitive - itt ugyanannak minősül a érár mint az erar 
        as -> accented sensitive - itt pedig érár !== erar, tehát itt lesz majd különbség 
*/

create database social_media_page 
character set utf8mb4 collate utf8mb4_general_ci 
/*
    fontos, hogy megadunk egy nevet, ami több részből áll, mint itt a social media page, akkor ezeket ezzel _ kell majd elválasztani, nem -
*/

/*
    int -> egész szám (32 bites)
    kulcs -> egyedi érték -> egyértelműen meghatározza, hogy melyik értékről van szó 
        * esődleges kulcs (ez a UserID általában, ami minden sorban majd csak egyszer szerepelhet)
        * másodlagos kulcs (ez is csak majd egyszer szerepelhet, ilyen az a rekord, aminek megadjuk, hogy UNIQUE legyen)
        * egyszerű kulcs 
        * összetett kulcs -> lakóhely + név 

    auto-increment -> automatikusan inkrementáló mező -> 1,2,3,4,5 stb...

    varchar(fontos, hogy ez nem összekeverendő a charset-vel, amit majd csak a create table-nél kell majd beállítani)
    VARCHAR(100) -> maximum 100 karakteres hosszú karakterlánc, de ez lehet úgy is, hogy két értéket adunk meg neki és akkor az a kér érték között 
        kell, hogy legyen a karakterlánc hossza varchar(4,100)
    NOT NULL -> nem maradhat üresen, tehát a táblázatban nem lehet majd az az értéke, hogy null!!! 
    UNIQUE -> ennek az értéknek muszáj egyedinek lennie (pl. email)
    DATE -> dátum 
    DATETIME -> dátum + idő 
    TIME -> óra + perc + másodperc 

    nagyon fontos 
    ->
    current_timestamp, now(), curdate() -> a rekord felvitelének pontos időpontja!!!! 
    */

    /*
    Az első lépés
    1. create database (név) set charset (utf8mb4) collate (utf8mb4_general_ci)
    2. create table (tábla neve)
        Itt, amikor csinálunk egy táblát meg kell adni, hogy milyen mezőkkel (attributumokkal) rendelkezzen majd a tábla 
    */

    create table users(
        UserID int primary key auto_increment,
        /*
        ennél mindig ez a 3 kell, hogy legyen, int, tehát egész szám, primary key, mert ehhez fogjuk majd csatolni 
        a másik táblából is egy key-t, auto_increment pedig, hogy 1,2,3,4,5 stb...
        */
        UserName varchar(100) not null,
        /*fontos, hogy ezeket majd vesszővek kell elválasztani, amikor meg felsoroljuk, hogy int not null, ott meg semmivel!!!!*/
        Email varchar(100) not null unique,
        FirstName varchar(100),
        LastName varchar(100),
        Created datetime default now()
        /*
        fontos
        datetime, tehát dátum és idő is!!! 
        now() pedig megadja a jelenlegit, de ehhez fontos, hogy ott legyen datetime is 
        default - ez pedig mindig az az érték legyen ->
        default-ra be lehet állítani mást is pl. a FirstName is lehet default Olivér is és akkor az összesnek az lesz az értéke, nem NULL 
        */
    );

    /*
    Már megcsináltuk az összes dolgot a create-vel, most az jön, hogy lehet értéket adni, tehát adatokat felvinni az adatbázisba
    ->
    INSERT !!!!!! 
    pontosabban így 
    INSERT INTO itt meg kell adni a táblanevet, ahova fel akarjuk majd vinni az adatokat (egy ilyenbe pedig azt, hogy melyik mezőnek)
    VALUES(ide meg be kell írni, hogy melyik mezőnek milyen értéket adunk majd meg) 

    ->
    insert into táblanév (mező1, mező2, mező3, mező4 stb...) 
    values('érték1', 'érték2', 'érték3', 'érték4' stb...)

    és itt majd a példában úgy van, hogy megtudunk adni majd több adatot is egy táblának 
    csak a values után mindig új zárójel kell!!! 
    -> 
    insert into valami(mező1, mező2, mező3, mező4 stb...)
    values('érték1', 'érték2', 'érték3', 'érték4' stb...),
    ('érték1', 'érték2', 'érték3', 'érték4' stb...),
    ('érték1', 'érték2', 'érték3', 'érték4' stb...),
    ('érték1', 'érték2', 'érték3', 'érték4' stb...),
    ('érték1', 'érték2', 'érték3', 'érték4' stb...),
    ('érték1', 'érték2', 'érték3', 'érték4' stb...)

    truncate 
    */

    insert into users 
    (UserName, Email, FirstName, LastName)
    values('pista88', 'pista88@gmail.com', 'István', 'Kis');

    /*itt meg egyszerre több adatot is megadunk neki*/
    insert into users(UserName, Email, FirstName, LastName)
    values('kati96', 'kati96@citromail.hu', 'Katalin', 'Szabó'),
    ('gabi92', 'nagy.gabor@gmail.com', 'Gábor', 'Nagy'),
    ('feri76', 'pinter.ferenc@zmail.ru', 'Ferenc', 'Pintér'),
    ('takacszoltan99', 'takacs.zoltan99@gmail.com', 'Zoltán', 'Takács'),
    ('tanacsbeata97', 'tanacs.beata97@citromail.hu', 'Beáta', 'Tanács'),
    ('horvathzsofi93', 'horvath.zsofia93@hotmail.com', 'Zsófia', 'Horváth');

    /*
    Most már csináltunk két create-t, egyszer amikor megcsináltuk a database-t meg utána a tablát 
    és fel is töltöttük az INSERT-vel az adott táblánkat 

    SELECT 

    Adatoknak a lehívása 

    Ki kell választani, hogy melyik mezőknek az értékeit szeretnénk lehívni a taáblából 
    -> 
    select mező1, mező2 from táblanév 

    nagyon fontos, hogy a SELECT-nél mindig kell a FROM is, hogy melyik táblából akarjuk majd lehívni az adatokat!!!! 
    úgy mint a INSERT-nél is kell mindig a az INTO 
    !!!! 
    SELECT FROM - INSERT INTO   
    */

    select FirstName, LastName from users;

    /*
    nagyon fontos, hogyha az összeset le akarjuk hívni, akkor meg a * írunk be a mező(k) neve(i) helyett
    ->
    */

    select * from users;
    /*
    Ilyenkor kiválasztottuk az egész táblát az összes mezővel illetve az összes rekord-val 

    de lehet olyan is, hogy mi csak egy rekordra vagyunk kiváncsiak és nem sz összesre, ilyenkor van egy olyan, hogy 
    WHERE  
    where-nek meg kell adni egy mezőnek az értékét és akkor csak az a rekord fog megjelenni!!!! 
    pl. select * from users where UserID = 1;
    -> 
    ilyenkor csak az a rekord lesz az összes mezővel (mert ugye ott egy * van), aminek a UserID-ja az egy!!!! 

    De van kiegészítése is a WHERE-nek 

    AND 
    -> meg tudunk adni több feltételt is nem csak azt, hogy UserID = 1, hanem azt is mondjuk, hogy Email = 'pista88@gmail.com'
    ezt a kettőt pedig az AND -val kütjük össze

    OR 
    itt is meg tudunk adni még egy feltételt, de viszont az OR-val, és akkor itt majd több rekord is lesz 
    mert itt -> select * from users where UserID = 5 or UserID = 6;
    az 5 és a 6-os id-jűre is igaz lesz, ezért mindegyik meg fog jelenni 

    NOT 
    itt meg az ellentéte lesz, csak az nem fog megjelenni, ami a NOT után van!!! 
    select * from users where UserID != 5;
    de a not-ot lehet úgy is, hogy nem írjuk ki, hanem != jelet teszünk az = helyett 

    példák 
    ->
    */

    select * from users where UserID = 1;

    SELECT * FROM users WHERE  UserID = 1 AND Email = 'pista88@gmail.com';

    select * from users where UserID = 5 OR UserID = 6;

    select * from users where UserID != 5;

    /*
    De azt is meg lehet csinálni, hogy nem töltjük ki az egész táblát, tehát az összes mezőt, amikor INSERT van, hanem csak azokat, amikneknél 
    ott van, hogy NOT NULL, ilyenkor az lesz majd az összes többi mezőre az értékük, hogy NULL, ha nem volt semmi beállítva DEFAULT-val 
    -> 
    */

    insert into users (UserName, Email)
    values('sdferhrth', 'dfgbegfb');
    /*itt csak ezeknek lesz értéke, az összes többi null lesz*/

    /*
    delete 
    nagyon fontos, hogy a delete + táblanév -> letörli az összes rekordot 

    de itt is használhatunk WHERE és akkor csak azt a rekordot törli ki, ahol a mező megegyezik egy megadott értékkel 
    -> 
    WHERE UserID = 8;
    */

    delete from users WHERE UserID = 8;

    /*
    itt is mint a select-nél is a from táblanév kell majd 
    */

    /*
    Lehet UPDATE-lni is dolgokat 

    CRUD 

    Create - Read - Update - Delete

    CRUD alapvető SQL müveletek!!!!! 
    */