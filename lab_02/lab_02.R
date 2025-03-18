# # # # # # # # # # # # # # Zadanie 1
# 1. Utwórz zmienną temp i nadaj jej wartość "36.6" 
#    (jako tekst, razem z cudzysłowem). 
#   Wyświetl tę zmienną.
temp <- "36.6"
temp

# 2. Dodaj do zmiennej temp wartość 0.1. Spróbuj dodawanie bez konwersji 
#    oraz z konwersją zmiennej temp na typ numeric.
temp + 0.1
as.numeric(temp) + 0.1

# 3. Wyświetl typ zmiennej temp. 
#    Użyj funkcji typeof(), class(), str().
typeof(temp)
class(temp)
str(temp)

# 4. Przekonwertuj temp na typ numeric. 
#    Wyświetl typ nowej zmiennej.
temp <- as.numeric(temp)
typeof(temp)

# 5. Przekonwertuj temp na typ integer. 
#    Czy wartość została zaokrąglona? - nie
#    Jak się zmienia wartość liczb ujemnych?
temp <- as.integer(temp)
temp
x <- -5
x <- as.integer(x)
x

# 6. Wyznacz typy następujących stałych:
#    '36', 36, 36L, 36+0i, TRUE
typeof('36')
typeof(36)
typeof(36L)
typeof(36+0i)
typeof(TRUE)

# 7. Oblicz pierwiastek z -1 
#    aby otrzymać liczbę zespoloną.
sqrt_neg1 <- sqrt(as.complex(-1))
sqrt_neg1



# # # # # # # # # # # # # # Zadanie 2
# 1. Utwórz wektor v1 używając sekwencji 3:0. 
#    Z jakich będzie on się składał elementów?
v1 <- c(3:0)
v1  # 3 2 1 0

# 2. Wyświetl typ zmiennej v1. 
#    Użyj funkcji typeof(), class(), str().
typeof(v1)
class(v1)
str(v1)

# 3. Jaki będzie wynik następujących wyrażeń?
#    a) v1[1]                  : 3
v1[1]

#    b) v1[length(v1)]         : 0
v1[length(v1)]

#    c) v1[length(v1)+1]       : NA
v1[length(v1) + 1]

#    d) v1[c(T, F, T, F)]      : 3 1
v1[c(T, F, T, F)]

#    e) v1[3:1]                : 1 2 3
v1[3:1]

#    f) v1[-1]                 : 2 1 0
v1[-1]

#    g) v1[-2]                 : 3 1 0
v1[-2]

#    h) v1[c(-2, -1)]          : 1 0
v1[c(-2, -1)]

# 4. Jaki będzie typ i wartość wektora: 
#    v2 <- c(0/0, 1/0, 1/Inf, TRUE, as.numeric("abc"))? Sprawdź.
v2 <- c(0/0, 1/0, 1/Inf, TRUE, as.numeric("abc"))
v2
typeof(v2)

# 5. Jaki będzie typ i wartość wektora: 
#    v3 <- as.logical(c("T", "False", "abc"))? Sprawdź.
v3 <- as.logical(c("T", "False", "abc"))
v3
typeof(v3)

# 6. Utwórz poleceniem vector pusty wektor v4 typu numeric o długości 9. 
#    Wyświetl ten wektor oraz jego typ (klasę) i skrukturę.
v4 <- vector(mode = "numeric", length = 9)
v4
class(v4)
str(v4)

# 7. Nadaj elementom 1:4 wartości 1:4, elementom 6:9 wartości 6:9, 
#    a elementowi numer 5 wartość "null". Jaki typ będzie miał wektor?
v4[1:4] <- 1:4
v4[6:9] <- 6:9
v4[5] <- "null"
typeof(v4)
v4

# 8. Przekonwertuj wektor v4 na typ numeric. 
#    Jaką wartość będzie miał v4[5]?
v4 <- as.numeric(v4)
v4
v4[5]

# 9. Jak zaznaczyć tylko te elementy wektora, 
#    w których zapisane są poprawne liczby?
numbers <- v4[!is.na(v4)]
numbers

# 10. Utwórz dwa wektory v5 oraz v6 
#     o wartościach odpowiednio 1:5 oraz 6:10.
#     Jaki będzie wynik następujących wyrażeń? Sprawdź.
v5 <- c(1:5)
v6 <- c(6:10)

#     a) v5 + v6
v5 + v6

#     b) v5 - v6
v5 - v6

#     c) v5 * v6
v5 * v6

#     d) v5 / v6
v5 / v6

#     e) v5 == v6
v5 == v6

#     f) v5 >= 3
v5 >= 3



# # # # # # # # # # # # # # Zadanie 3
# 1. Utwórz dwie macierze m1 i m2 z wektorów v5 i v6 
#    używając odpowiednio funkcji rbind() oraz cbind(). 
#    Z jakich elementów będą się składać te macierze?
m1 <- rbind(v5, v6)
m1

m2 <- cbind(v5, v6)
m2

# 2. Przy odwoływaniu się do macierzy m1[1, 2], 
#    który indeks zaznacza wiersz, a który kolumnę? 
#    Co oznacza parametr drop w m1[1, 2, drop=TRUE]?
#    Jak uzyskać podpowiedź dla operatora [ w konsoli R?
m1[1, 2]  # [wiersz, kolumna]
?"["  # trzeba użyć ""
m1[1, 2, drop = TRUE]  # zmniejsza wymiar do najniższego możliwego

# 3. Jak zaznaczyć drugi i trzeci wiersze macierzy m2?
m2[2:3, ]

# 4. Jaki typ będzie miał pierwszy wiersz macierzy m1? 
#    A pierwsza kolumna? Zbadaj typeof() oraz str.
typeof(m1[1, ])
str(m1[1, ])

typeof(m1[, 1])
str(m1[, 1])

# 5. Utwórz macierz m3 o dwóch wierszach i pięciu kolumnach, 
#    zawierającą liczby od 1 do 10 poleceniem matrix(). 
#    Czy macierz zgadza się z macierzą m1?
m3 <- matrix(data = 1:10, nrow = 2, ncol = 5)
m3
identical(m1, m3)

# 6. Utwórz dwie macierze 2×2 oraz pomnóż je 
#    używając operatorów * oraz %*%. Na czym polega różnica?
m4 <- matrix(1:4, 2, 2)
m5 <- matrix(5:6, 2, 2)

m4 * m5  # mnożenie element po elemencie
m4 %*% m5  # iloczyn macierzowy



# # # # # # # # # # # # # # Zadanie 4
# 1. Utwórz wektor k kolorów: 
#    "red", "red", "green", "blue", "red", 
#    "green", "blue", "grey" jako wektor danych nominalnych.
k <- factor(c("red", "red", "green", "blue", "red", "green", "blue", "grey"))
k

# 2. Zbadaj typ i strukturę wektora k. 
str(k)
typeof(k)

# 3. Przekonwertuj wektor k na typ liczbowy. 
k_numeric <- as.numeric(k)
k_numeric

# 4. Stwórz wykres wektora k.
barplot(table(k), col = levels(k), main = "Występowanie kolorów")



# # # # # # # # # # # # # # Zadanie 5
# 1. Utwórz wektor t rozmiarów koszulek: 
#    "L", "L", "XL", "S", "XS", "XXL", "XXL", "M", "M", "S", "S" 
#    jako wektor uporządkowanych danych nominalnych. 
t <- factor(c("L", "L", "XL", "S", "XS", "XXL", "XXL", "M", "M", "S", "S"),
            levels = c("XS", "S", "M", "L", "XL", "XXL"),
            ordered = TRUE)
t

# 2. Zbadaj typ i strukturę wektora t. 
typeof(t)
str(t)

# 3. Przekonwertuj wektor t na typ liczbowy.
t_num <- as.numeric(t)
t_num

# 4. Stwórz wykres wektora t.
barplot(table(t), 
        col = rainbow(length(levels(t))), 
        main = "Występowanie rozmiarów")



# # # # # # # # # # # # # # Zadanie 6
# 1. Utwórz listę l, składającą się 
#    z następujących pięciu elementów: 
#    "R", 1:3, TRUE, NA, lista z dwóch elementów: "r" oraz 4.
l <- list("R", 1:3, TRUE, NA, list("r", 4))
l

# 2. Zbadaj typy danych, otrzymanych z listy operatorem […], 
#    oraz operatorem [[…]]. Na czym polega różnica? 
typeof(l[1])  # Zwraca listę z pierwszym elementem
typeof(l[[1]])  # Zwraca sam pierwszy element

# 3. Wykorzystaj funkcję names, aby nadać elementom listy nazwy 
#    first, second, third, fourth, fifth. Dostęp do elementów 
#    listy przez operator $ jest równoważny dostępowi przez […] czy [[…]]? 
names(l) <- c("first", "second", "third", "fourth", "fifth")
l
l$first
l[1]
l[[1]]  # == l$first

# 4. Czy w operatorach […] oraz [[…]] można zamiast numerów pisać nazwy?
l["first"]
l[["first"]]
# można

# 5. Czy można w nazwach używać polskich znaków? 
names(l)  <- c("pierwszyą", "drógi", "trzeć", " czwartyś", "pięćź")
l$pięćź
l[["pięćź"]]
# tak

# 6. Jak nadać nazwy elementom listy w momencie tworzenia? 
l <- list(first = "R", 
          second = 1:3, 
          third = TRUE, 
          fourth = NA, 
          fifth = list("r", 4)
          )
l



# # # # # # # # # # # # # # Zadanie 7
# 1. Wczytaj do zmiennej z tabelę owadów. 
#    Zbadaj strukturę z. Powinna być ramka danych (data.frame) 
#    o czterech numerycznych kolumnach. 
getwd()
setwd("D:/Projekty/IntroductionToR/lab_02/")
getwd()

z <- read.table("owady.txt", header = TRUE, sep = "\t", dec = ",")
z
str(z)

# 2. Jak na trzy różne sposoby uzyskać dostęp do pierwszej kolumny? 
z$Płeć
z[, 1]
z[["Płeć"]]

# 3. Wyświetl i zbadaj typ wiersza, odpowiadającego trzeciemu owadowi. 
z[3, ]
typeof(z[3, ])
str(z[3, ])

# 4. Przekonwertuj z na macierz. Wynik zapisz do zmiennej z.m. 
#    Zbadaj strukturę macierzy. Co się zmieniło w danych? 
z.m <- as.matrix(z)
z.m

str(z.m)
typeof(z.m[1, 1])

z.m[1, 1]

identical(z, z.m)
# wymuszony jeden typ danych 

# 5. Przekonwertuj z.m z powrotem na ramkę. 
#    Czy wynik jest identyczny z z.m? 
z.df <- as.data.frame(z.m)
z.df
identical(z.df, z.m)  # false
identical(z.df, z)  # false

typeof(z.df)
str(z.df)  # 2 pierwsze kolumny zmieniły się z int na num

# 6. Zamień typ pierwszej kolumny z na factor. 
#    Wyświetl i zbadaj strukturę z. 
z[, 1] <- as.factor(z[, 1])
str(z)

# 7. Zamień nazwy wartości pierwszej kolumny z na "male" i "female". 
#    W tabeli zakodowano 0="male", 1="female" 
#    (Podpowiedź: użyj konstrukcji:
#    levels(x) <- c(…).) Wyświetl i zbadaj strukturę z. 
levels(z$Płeć) <- c("male", "female")
str(z)
z

# 8. Zamień wartości oraz nazwy drugiej kolumny na factor. 
z$Kolor <- as.factor(z$Kolor)
str(z)
z

levels(z$Kolor) <- c("red", "green", "blue")
str(z)
z

# 9. Wyświetl dane owadów o płci "male". 
z[z$Płeć == "male", ]
subset(z, Płeć == "male")
z[which(z$Płeć == "male"), ]

# 10. Uporządkuj dane owadów względem wzrostu. 
z[order(z$Wzrost), ]

# 11. Uporządkuj dane owadów względem wzrostu malejąco. 
z[order(-z$Wzrost), ]
z[rev(order(z$Wzrost)), ]

# 12. Uporządkuj dane owadów pierwotnie względem płci 
#     i wtórnie względem wagi. Czemu uporządkowanie 
#     względem płci ma taki, a nie inny porządek? 
z[order(z$Płeć, z$Waga), ]
# ponieważ factor jest posortowany levelami

# 13. Użyj funkcji plot(), aby stworzyć wykres danych o płci owadów. 
plot(table(z$Płeć), 
        col = c("red", "blue"),
        main = "L. owadów względem płci",
        xlab = "Płeć",
        ylab = "Liczba")

barplot(table(z$Płeć), 
     col = c("red", "blue"),
     main = "L. owadów względem płci",
     xlab = "Płeć",
     ylab = "Liczba")

# 14. Utwórz wykres danych o wadze i wzroście owadów.
plot(z$Waga, 
     z$Wzrost,
     main = "Waga vs Wzrost",
     pch = 19,
     xlab = "Waga",
     ylab = "Wzrost",
     col = "blue")

# 15. Utwórz wykres danych o płci i wadze owadów. 
boxplot(Waga ~ Płeć, data=z, main="Waga wg płci", col=c("red", "blue"))

# 16. Utwórz wykres danych o płci, wzroście i wadze owadów. 
#     (Podpowiedź: użyj do wyróżnienia płci symbolu oraz koloru, 
#     jak na poniższym obrazku: 
#     http://wmii.uwm.edu.pl/~denisjuk/uwm/r/cw/ch02s06.html) 
symbols = c(2, 1)
colors = c("red", "black")

plot(x = z$Waga,
     y = z$Wzrost,
     pch = symbols[z$Płeć],
     col = colors[z$Płeć],
     ylab = "Wzrost",
     xlab = "Waga")
legend("topleft", legend = levels(z$Płeć), pch = symbols, col = colors)
