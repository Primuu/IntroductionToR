# # # # # # # # # # # # # # Zadanie 1.
# 1. Jak wyjść z R?
q()

# 2. Jak wyjść z R nie zapisując przestrzeni roboczej?
q("no")
q(save="no")



# # # # # # # # # # # # # # Zadanie 2
# 1.
(1 + 2^4) / (1 / (2 + sqrt(3)) - 3)

# 2.
(1 + 10/2019)^2019

# 3.
exp(10)

# 4.
(2^(1/2) - 2^(1/4)) / (2^(1/5) - 2^(1/6))

# 5.
pi/4 - atan(1)

# 6.
sin(pi/4)

# 7.
sin(45 * 2*pi/360)

# 8.
log(10)

# 9.
log10(10)

# 10.
log(-10)

# 11.
sqrt(-1)

# 12.
1/0

# 13. Dla koła o promieniu r = 6 , 32 obliczyć pole i obwód.
r = 6.32
area <- pi * r^2
area

circumference <- 2 * pi * r
circumference

# 14. Obliczyć pole powierzchni i objętość kuli o tym promieniu.
area <- 4 * pi * r^2
area

volume <- 4/3 * pi * r^3
volume

# 15. Obliczyć pole i objętość torusa o promieniach r = 7,33 i  R = 22,54 
r=7.33
R=22.54

area <- 4 * pi^2 * R * r
area

volume <- 2 * pi^2 * R * r^2
volume



# # # # # # # # # # # # # # Zadanie 3
# 1. Jakie są sposoby nadania wartości w R?
a = 5
a <- 5
5 -> a


# 2. Jak w jednym wierszu do zmiennej x wpisać wartość 10, 
#    a do zmiennej y wpisać -10?
x <- 10; y <- -10
x
y

# 3. Podstawiając za a , b , c różne wartości znajdź rozwiązania równania
#    ax^2 + bx + c = 0. Rozwiąż następujące równania:

# 2x^2 -2x -1 = 0
a <- 2; b <- -2; c <- - 1

delta <- b^2 - 4 * a * c
x1 <- (-b - sqrt(delta)) / (2 * a) 
x2 <- (-b + sqrt(delta)) / (2 * a) 

x1; x2

# -5x^2 -6x +5 = 0
a <- -5; b <- -6; c <- 5

delta <- b^2 - 4 * a * c
x1 <- (-b - sqrt(delta)) / (2 * a) 
x2 <- (-b + sqrt(delta)) / (2 * a) 

x1; x2

# x^2 -4x +5 = 0
a <- 1; b <- -4; c <- 5

delta <- b^2 - 4 * a * c
x1 <- (-b - sqrt(delta)) / (2 * a) 
x2 <- (-b + sqrt(delta)) / (2 * a) 

x1; x2



# # # # # # # # # # # # # # Zadanie 4
# 1. Utwórz tablicę liczb od 1 do 20.
tab <- 1:20; tab

# 2. Utwórz tablicę parzystych liczb od 1 do 20
tab <- seq(2, 20, 2); tab
tab <- 2 * (1:10); tab
tab <- (1:20)[(1:20) %% 2 == 0]; tab

# 3. Utwórz tablicę liczb od 1 do 20 z krokiem ½
tab <- seq(1, 20, 1/2); tab
tab <- 1/2 * (1:40); tab

# 4. Utwórz tablicę sinusów liczb od 1 do 10 stopni z krokiem ½
tab <- sin((seq(1, 10, 0.5)) * 2*pi/360); tab

angles <- seq(1, 10, by=0.5)
sin_values <- sin(angles * pi/180)
data.frame(Kąt=angles, Sinus=sin_values)

# 5. Utwórz po 100 wyrazów ciągów
# 1/n
n <- 1:100
a <- 1/n; a

# 1/n^2
a <- 1 / n^2; a

# (1 + 1/n)^n
a <- (1 + 1/n)^n; a

# 6. Oblicz następujące sumy
# Suma od i=0 do 20 = 1/i!
i <- 0:20
suma1 <- sum(1 / factorial(i)); suma1

# Suma od i=0 do 20 = 2^i/i!
suma2 <- sum(2^i / factorial(i)); suma2

# Suma od i=1 do 200 = (-1)^i/i
i <- 1:200
suma3 <- sum((-1)^i / i); suma3



# # # # # # # # # # # # # # Zadanie 5
# 1. Utwórz plik tekstowy z danymi o żukach z  tabeli: 
#    http://wmii.uwm.edu.pl/~denisjuk/uwm/r/cw/ch01s05.html#table:%C5%BCuki

# 2. Zmień katalog roboczy na ten, w którym znajduje się plik z tabelą.
getwd()
setwd("D:/Projekty/IntroductionToR/lab_01")

# 3. Wczytaj dane do zmiennej z: 
#    udając, że nie pamiętasz nazwy funkcji do wczytywania danych z tabeli, 
#    wpisz tylko read i naciśnij dwa razy TAB. 
#    (wyświetlenie wszystkich pasujących nazw funkcji, zmiennych itd.)
#    Czy w taki sam sposób może uzyskać podpowiedź o parametrach funkcji?
#    (Użycie TAB po otwarciu nawiasu funkcji wydrukuje możliwe parametry)
#    Jaki efekt ma pojedyncze wciśnięcie TAB?
#    (uzupełnienie nazwy do jedynej pasującej)

z <- read.table(file="zuki.txt", header=TRUE, dec=","); z

# 4. Zmień wagę czwartego owada na 9,77.
z <- de(z)
z

# 5. Zapisz zmodyfikowaną tablicę do pliku owady.csv. 
#    Sprawdź zawartość tego pliku w programie zewnętrznym.
write.table(x=z, file="owady.csv", dec=",", sep=";", row.names=FALSE)



# # # # # # # # # # # # # # Zadanie 6
# 1. Zrób wykres samochodów z lat dwudziestych zbliżony do pierwszego
#    (http://wmii.uwm.edu.pl/~denisjuk/uwm/r/cw/ch01s06.html):
plot(cars, 
     xlab="prędkość", 
     ylab="droga hamowania", 
     pch="x", 
     col="red", 
     main="Samochody z lat dwudziestych")
legend("topleft", legend="Samochody", pch="x", col="red", bg="grey")

# 2. Zapisz wykres do pliku PNG.
png("wykres_1.png")
plot(cars, 
     xlab="prędkość", 
     ylab="droga hamowania", 
     pch="x", 
     col="red", 
     main="Samochody z lat dwudziestych")
legend("topleft", legend="Samochody", pch="x", col="red", bg="grey")
dev.off()

# 3. Zapisz wykres do pliku PDF.
cairo_pdf("wykres_1.pdf")
plot(cars, 
     xlab="prędkość", 
     ylab="droga hamowania", 
     pch="x", 
     col="red", 
     main="Samochody z lat dwudziestych")
legend("topleft", legend="Samochody", pch="x", col="red", bg="grey")
dev.off()

# 4. Zapisz wykres do pliku SVG.
svg("wykres_1.svg")
plot(cars, 
     xlab="prędkość", 
     ylab="droga hamowania", 
     pch="x", 
     col="red", 
     main="Samochody z lat dwudziestych")
legend("topleft", legend="Samochody", pch="x", col="red", bg="grey")
dev.off()

# 5. Samochód o prędkości 15 oraz drodze hamowania 20 to Cadillac. 
#    Wykorzystaj interaktywną funkcję locator(), aby podpisać odpowiedni punkt.
plot(cars, 
     xlab="prędkość", 
     ylab="droga hamowania", 
     pch="x", 
     col="red", 
     main="Samochody z lat dwudziestych")
legend("topleft", legend="Samochody", pch="x", col="red", bg="grey")
text(locator(), "Cadillac")

# 6. Zrób wykres funkcji sinus zbliżony do drugiego
#    (http://wmii.uwm.edu.pl/~denisjuk/uwm/r/cw/ch01s06.html):
plot.function(sin, -pi, pi,
              col="purple",
              xlab="x",
              ylab="sin(x)",
              xaxt="n")
axis(side=1,
     at=c(-pi, -pi/2, 0, pi/2 , pi))

# 7. Co to jest sinus?

# 8. Na wyborach prezydenckich 2015 roku głosy oddało 48,96% wyborców. 
#    Wyniki wyborów są przedstawione w poniższej tabeli:
#    http://wmii.uwm.edu.pl/~denisjuk/uwm/r/cw/ch01s06.html#table:wybory
#    Zilustruj frekwencję na wyborach wykresem zbliżonym do trzeciego
#    (http://wmii.uwm.edu.pl/~denisjuk/uwm/r/cw/ch01s06.html):
wybory <- read.table(file="wybory.txt", header=FALSE, sep="\t")
wybory$V2 <- (gsub("%", "", wybory$V2))
wybory$V2 <- as.numeric(gsub(",", ".", wybory$V2))

frekwecja <- c(48.96, 100 - 48.96)
etykiety <- c("zagłosowało", "nie głosowało")
kolory <- c("black", "grey")
pie(frekwecja, 
    labels=etykiety,
    main="Frekwencja",
    col=kolory)

# 9. Zilustruj wyniki wyborów wykresem barplot zbliżonym do czwartego
#    (http://wmii.uwm.edu.pl/~denisjuk/uwm/r/cw/ch01s06.html) 
#    (podpowiedź: wykorzystałem funkcję paste, 
#    aby „podkleić” symbol procentu do liczb):
kandydaci <- wybory$V1
wyniki <- wybory$V2
kolory <- c("red", "green", "blue", "cyan", "magenta", "yellow", 
            "gray", "black", "red", "green", "blue")

barplot(height=wyniki,
        names.arg=paste(wyniki, "%", sep=""),
        col=kolory,
        las=2)

legend("topright", legend=kandydaci, fill=kolory, bty = "n")

# 10. Wykres dotchart jest lepszą wersją diagramów słupkowych. 
#     Zilustruj wyniki wyborów wykresem zbliżonym do piątego
#    (http://wmii.uwm.edu.pl/~denisjuk/uwm/r/cw/ch01s06.html):
dotchart(x=rev(wyniki),
         labels=rev(kandydaci),
         ann=TRUE,
         xlab="% głosów",
         main="Wybory prezydenckie 2015",
         )

# 11. Rozkład normalny.Wygeneruj 200-elementową próbkę 
#     rozkładu normalnego o średniej 15 i odchyleniu standardowym 5.
proba <- rnorm(200, 15, 5)

# 12. Utwórz histogram próbki:
hist(x=proba,
     breaks=15,
     main="Rozkład normalny N(15,5)",
     col="lightblue",
     xlab="x",
     ylab="Częstotliwość")

# 13. Utwórz dla próbki histogram połączony z krzywą gęstości. 
#     Wykorzystaj funkcje lines() oraz density().
hist(x=proba,
     breaks=15,
     main="Histogram, połączony z gęstością",
     col="lightblue",
     xlab="Zmienna X",
     ylab="Gęstość prawdopodobieństwa",
     probability=TRUE)
lines(density(proba), col="red", lwd=2)

# 14. Zapisz histogram do pliku JPEG.
jpeg("histogram.jpeg")
hist(x=proba,
     breaks=15,
     main="Histogram, połączony z gęstością",
     col="lightblue",
     xlab="Zmienna X",
     ylab="Gęstość prawdopodobieństwa",
     probability=TRUE)
lines(density(proba), col="red", lwd=2)
dev.off()

# 15. Zapisz histogram do pliku PDF
cairo_pdf("histogram.pdf")
hist(x=proba,
     breaks=15,
     main="Histogram, połączony z gęstością",
     col="lightblue",
     xlab="Zmienna X",
     ylab="Gęstość prawdopodobieństwa",
     probability=TRUE)
lines(density(proba), col="red", lwd=2)
dev.off()

# 16. Zapisz histogram do pliku SVG
svg("histogram.svg")
hist(x=proba,
     breaks=15,
     main="Histogram, połączony z gęstością",
     col="lightblue",
     xlab="Zmienna X",
     ylab="Gęstość prawdopodobieństwa",
     probability=TRUE)
lines(density(proba), col="red", lwd=2)
dev.off()



















