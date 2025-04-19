# # # # # # # # # # # # # # Zadanie 1
# 1. Wejdź na stronę repozytorium uczenia maszynowego 
#    Uniwersytetu Kalifornijskiego w Irvine (UCI). 
#    Znajdź zestaw danych Automobile, pobierz dane na dysk i wczytaj do R. 
#    Zadbaj o to aby dane brakujące otrzymały wartość NA. 
#    Znajdź sposób aby dać kolumnom nazwy z opisania danych. 
library(stringr)

setwd("D:/Projekty/IntroductionToR/lab_03/automobile/")
getwd()

data_file <- "imports-85.data"
names_file <- "imports-85.names"

raw_names <- readLines(names_file)
start_index <- which(str_detect(raw_names, "Attribute Information:")) + 3
column_lines <- raw_names[start_index:length(raw_names)]
column_lines <- column_lines[str_detect(column_lines, "^\\s*[0-9]+\\.")]

column_names <- column_lines[1:26] %>%
  str_replace_all("^\\s*[0-9]+\\.\\s*", "") %>%  # usunięcie numerów atrybutów
  str_replace_all("-", "_") %>%  # zamiana "-" na "_" dla kompatybilności z R
  str_extract("^([^:]+)") %>%  # pobranie części przed ":"
  str_trim() %>%  # usunięcie zbędnych spacji
  .[!is.na(.)]  # usunięcie wartości NA

automobile <- read.csv(data_file, 
                       header = TRUE, 
                       col.names = column_names, 
                       na = "?")

# 2.  Sprawdź zgodność danych z opisem na stronie repozytorium:
#     * jeżeli nie zgadza się typ, dokonaj konwersji, 
#       w tym dla danych typu factor.
#       Zwróć uwagę na to że pierwsza kolumna zawiera uporządkowane 
#       dane nominalne o poziomach -3, -2, -1, 0, 1, 2, 3.
#
#     * dane brakujące uzupełnij:
#       - dla danych nominalnych użyj mody
#       - dla kolumn numerycznych zastosuj cyklicznie następujące zasady:
#         a. dla brakujących danych użyj wartości średniej
#         b. dla brakujących danych użyj mediany
#         c. usuń z danych wszystkie wiersze zawierające brakujące dane
x <- ordered(automobile$symboling, levels=-3:3)
str(x)
automobile$symboling <- x

col2 <- automobile$normalized_losses
avg <- mean(col2, na.rm = TRUE)
col2[is.na(col2)] <- avg
automobile$normalized_losses <- col2

automobile$make <- as.factor(automobile$make)
automobile$fuel_type <- as.factor(automobile$fuel_type)
automobile$aspiration <- as.factor(automobile$aspiration)

col6 <- as.factor(automobile$num_of_doors)
t <- table(col6)
moda <- names(t[which.max(t)])
col6[is.na(col6)] <- moda
automobile$num_of_doors <- col6

automobile[, 7] <- as.factor(automobile[, 7])
automobile[, 8] <- as.factor(automobile[, 8])
automobile[, 9] <- as.factor(automobile[, 9])
automobile[, 15] <- as.factor(automobile[, 15])
automobile[, 16] <- as.factor(automobile[, 16])
automobile[, 18] <- as.factor(automobile[, 18])

indices <- !is.na(automobile[, 19])
x <- automobile[indices, ]
na.fail(x$bore)
automobile <- x

na.fail(automobile[[20]])

x <- automobile[[22]]
x_mean <- mean(x, na.rm = TRUE)
x[is.na(x)] <- x_mean
automobile[, 22] <- x

x <- automobile[[23]]
x_median <- median(x, na.rm = TRUE)
x[is.na(x)] <- x_median
automobile[, 23] <- x

automobile <- na.omit(automobile)



# # # # # # # # # # # # # # Zadanie 2
# 1. Znajdź dla wszystkich numerycznych cech samochodów średnią 
#    i odchylenie standardowe. 
#    (Podpowiedź: może się przydać funkcja z rodziny apply().) 
numeric_mean <- function(x) {
  if (is.numeric(x)) {
    m <- mean(x) 
    s <- sd(x)
    c(m, s)
  }
}

lapply(automobile, numeric_mean)

# 2. Znajdź dla wszystkich numerycznych cech samochodów medianę, 
#    kwartyle, oraz odchylenie ćwiartkowe. 
#    (Podpowiedź: może się przydać funkcja z rodziny apply().) 
numeric_median <- function(x) {
  if (is.numeric(x)) {
    m <- median(x)
    q <- quantile(x)
    iqr <- IQR(x)
    c(m, q, iqr)
  }
}

lapply(automobile, numeric_median)

# 3. Dla wszystkich nominalnych cech samochodów wyznacz modę. 
#    (Podpowiedź: może się przydać funkcja z rodziny apply().) 
nominal_mode <- function(x) {
  if (is.factor(x)) {
    x.t <- table(x)
    m.ind <- which.max(x.t)
    moda <- names(x.t)[m.ind]
    moda
  }
}

lapply(automobile, nominal_mode)

# 4. Oblicz, ile jest samochodów poszczególnych marek. 
brand_count <- table(automobile$make)
brand_count

# 5. Stwórz wykres liczebności samochodów różnych marek. 
barplot(brand_count, 
        main = "Liczebność samochodów różnych marek", 
        xlab = "", 
        ylab = "Liczba samochodów", 
        las = 2,
        col = rainbow(length(levels(automobile$make))))

# 6. Który z producentów ma najwięcej samochodów z silnikiem diesla? 
diesel_cars <- table(automobile$make[automobile$fuel_type == "diesel"])
x <- names(which.max(diesel_cars))
x

# 7. Który z producentów ma największy odsetek samochodów z silnikiem diesla? 
x <- diesel_cars / table(automobile$make) * 100
x <- names(which.max(x))
x

# 8. Który z producentów ma najdroższe, a który najtańsze samochody? 
#    (Podpowiedź: może się przydać funkcja tapply() lub aggregate()) 
max_price <- tapply(automobile$price, automobile$make, max)
max_price_brand <- names(which.max(max_price))
max_price_brand

min_price <- tapply(automobile$price, automobile$make, min)
min_price_brand <- names(which.min(min_price))
min_price_brand

# 9. Zilustruj graficznie ceny samochodów różnych marek. 
x <- tapply(automobile$price, automobile$make, mean)
barplot(x, 
        col=rainbow(length(levels(automobile$make))),
        las = 2,
        main = "Ceny samochodów różnych marek"
        )

# 10. Samochody jakiej marki są mniej ryzykowne wzgędem ubezpieczenia? 
x.text <- as.character(automobile$symboling)
x.numeric <- as.numeric(x.text)
symboling.mean <- tapply(x.numeric, automobile$make, mean)
symboling.mean.min <- names(symboling.mean[which.min(symboling.mean)])

# 11. Oblicz średnią prędkość obrotu w zależności od układu rozrządu silnika. 
rotation_speed <- aggregate(automobile$peak_rpm, 
                            by = list(automobile$engine_type), 
                            mean)
rotation_speed

# 12. Zilustruj graficznie średnią prędkość obrotu 
#     w zależności od układu rozrządu silnika. 
barplot(rotation_speed$x,
        names.arg = rotation_speed$Group.1,
        col = "skyblue",
        main = "Średnia prędkość obrotu vs układ rozrządu",
        xlab = "Typ układu rozrządu (engine_type)",
        ylab = "Średnia prędkość obrotu (peak_rpm)",
        las = 2)

# 13. Oblicz średnią prędkość obrotu w zależności od układu 
#     rozrządu silnika i typu paliwa.
rotation_speed2 <- aggregate(automobile$peak_rpm, 
                            by = list(automobile$engine_type, automobile$fuel_type), 
                            mean)
rotation_speed2

# 14. Zilustruj graficznie średnią prędkość obrotu w zależności 
#     od układu rozrządu silnika i typu paliwa. 
fuel_colors <- ifelse(rotation_speed2$Group.2 == "diesel", "lightblue", "lightgreen")

barplot(rotation_speed2[[3]],
        names.arg = rotation_speed2[[1]],
        main = "Średnia prędkość obrotu w zależności od układu rozrządu i paliwa",
        xlab = "Układ rozrządu",
        ylab = "Średnia prędkość obrotu (peak_rpm)",
        las = 2, # Obrót etykiet na osi X,
        col = fuel_colors,
        legend = unique(rotation_speed2$Group.2), # Dodanie legendy
        args.legend = list(title = "Typ paliwa", fill = c("lightblue", "lightgreen"))
)

# 15. Stwórz wykres pudełkowy zużycia paliwa na trasie 
#     (w litrach na 100 kilometrów) przez samochody 
#     z silnikiem diesla i benzynowym. 
boxplot(235 / highway_mpg ~ fuel_type, data = automobile,
        main = "Zużycie paliwa na trasie (l/100km) - Diesel vs Benzyna",
        xlab = "Typ paliwa",
        ylab = "Zużycie paliwa (l/100km)",
        col = c("lightblue", "lightgreen"), # Kolory dla różnych typów paliwa
        border = "black")

# 16. Stwórz wykres pudełkowy średniego zużycia paliwa 
#     (w litrach na 100 kilometrów) przez samochody 
#     z silnikiem diesla i benzynowym. 
boxplot(235 / (highway_mpg + city_mpg) / 2 ~ fuel_type, data = automobile,
        main = "Średnie zużycie paliwa (l/100km) - Diesel vs Benzyna",
        xlab = "Typ paliwa",
        ylab = "Zużycie paliwa (l/100km)",
        col = c("lightblue", "lightgreen"), # Kolory dla różnych typów paliwa
        border = "black")

# 17. Stwórz histogram dla wag samochodu.
hist(automobile$curb_weight, 
     breaks = 20,
     freq = FALSE)

# 18. Dodaj do poprzedniego histogramu wykres gęstości. 
lines(density(automobile$curb_weight), 
      col="red")

# 19. Stwórz wyrkes beeswarm dla długości, szerokości i wysokości samochodów.
# install.packages("beeswarm")
library(beeswarm)

beeswarm(automobile[, c("length", "width", "height")], 
         col = 1:3)

# 20. Dodaj do poprzedniego wykresu wykres pudełkowy, aby zobaczyć kwartyle. 
boxplot(automobile[, c("length", "width", "height")], 
        add = TRUE, 
        col = c("black", "red", "green"))



# ^^^^^^^^^^^^^^^^^ KOLOS 1 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^



# # # # # # # # # # # # # # Zadanie 2
# p-value większe od 0.05 - przyjmujemy zerową hipotezę

# 1. Zastosuj test t-Studenta do badania hipotezy o równości wartości 
#    średniej długości samochodów do średniej z podanej próbki. 
t.test(automobile$length, mu=mean(automobile$length))

# 2. Zastosuj test Wilcoxona do badania hipotezy o równości wartości średniej 
#    długości samochodów do średniej z podanej próbki. 
#    Porównaj wyniki z poprzednim testem.
wilcox.test(automobile$length, mu=median(automobile$length), conf.int = TRUE)

# 3. Zbadaj hipotezę o równości wartości średniej i średniej z próbki dla mocy
#    silników diesla samochodów
horsepower <- automobile$horsepower[automobile$fuel_type == "diesel"]
medain_power <- median(horsepower)
wilcox.test(horsepower, mu=medain_power)

# 4. Zbadaj hipotezę o równości wartości średniej i średniej z próbki 
#    dla mocy czterocylindrowych silników diesla 
four_cyl_disel_cars <- automobile$horsepower[
  automobile$fuel_type == "diesel" & 
    automobile$num_of_cylinders == "four"]

median.power <- median(four_cyl_disel_cars)
wilcox.test(four_cyl_disel_cars, mu=median.power)



# # # # # # # # # # # # # # Zadanie 3
# 1. Zastosuj test Shapiro-Wilka 
#    do badania normalności próbek z zadania powyżej.
shapiro.test(automobile$length)
shapiro.test(horsepower)
shapiro.test(four_cyl_disel_cars)

# 2. Zastosuj test Kołmogorowa-Smirnowa do badania 
#    normalności próbek z zadania powyżej.
ks.test(automobile$length, "pnorm")
ks.test(horsepower, "pnorm")
ks.test(four_cyl_disel_cars, "pnorm")

# 3. Do badania średniej których próbek z zadania 
#    powyżej można stosować test t-Studenta?
# --- Do żadnej, test wilcoxona.



# # # # # # # # # # # # # # Zadanie 4
# 1 / 2/ 3. Dla danych z zadania powyżej, które nie przeszły testu, 
#    spróbuj zastosować przekształcenie logarytmiczne, pierwiastkowe 
#    i kwadratowe i ponownie przeprowadzić test. 
length_log <- log(automobile$length + 1)
shapiro.test(length_log)

length_sqrt <- sqrt(automobile$length + 1)
shapiro.test(length_sqrt)

length_pow <- automobile$length ^ 2
shapiro.test(length_pow)



# # # # # # # # # # # # # # Zadanie 5
# 1. Zastosuj test dwumianowy do sprawdzania, czy procent silników diesla 
#    pośród samochodów marki Toyota jest taki sam, 
#    jak średni dla wszystkich producentów. 
x <- sum(automobile$make == "toyota" 
                & automobile$fuel_type == "diesel")
y <- sum(automobile$make == "toyota")
z <- sum(automobile$fuel_type == "diesel") / nrow(automobile)
binom.test(x=x, n=y, p=z, alternative="two.sided")

# 2. Zastosuj test proporcji do sprawdzania, czy procent silników diesla 
#    pośród samochodów marki Toyota jest taki sam, 
#    jak średni dla wszystkich producentów. 
prop.test(x=x, n=y, p=z, alternative="two.sided")

# 3. Czy procent samochodów dwudrzwiowych, marki Toyota jest taki sam, 
#    jak dla wszystkich samochodów? 
x <- sum(automobile$make == "toyota" 
         & automobile$num_of_doors == "two")
y <- sum(automobile$make == "toyota")
z <- sum(automobile$num_of_doors == "two") / nrow(automobile)
binom.test(x=x, n=y, p=z, alternative="two.sided")



# -----------------------------------------------------------------
write.csv(automobile, "automobile_processed.csv", row.names = FALSE)
