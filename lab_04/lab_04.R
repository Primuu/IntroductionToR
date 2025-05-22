setwd("D:/Projekty/IntroductionToR/lab_04")
automobile <- read.csv("automobile_processed.csv")

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


# # # # # # # # # # # # # # Zadanie 1
# 1. Zastosuj test t-Studenta do badania hipotezy o zależności 
#    ceny samochodu od typu paliwa (diesel/benzyna). 
x = automobile$fuel_type == "diesel"
y = automobile$fuel_type == "gas"
price.diesel = automobile$price[x]
price.gas = automobile$price[y]
t.test(price.diesel, price.gas)


# 2. Zastosuj test Wilcoxona do badania hipotezy o zależności ceny 
#    samochodu od typu paliwa (diesel/benzyna). 
#    Porównaj wyniki z poprzednim testem. 
wilcox.test(price.diesel, price.gas)

# 3. Który z tych dwóch testów powinien być stosowany do badania hipotezy? 
shapiro.test(automobile$price)
# --- Należy stosować test wilcoxona, ponieważ nie są z rozkładu normalnego.

# 4. Czy prędkość obrotu zależy od typu paliwa (diesel/benzyna)? 
#    Zastosuj odpowiedni test. 
shapiro.test(automobile$peak_rpm)  # nie jest z normalnego

peak.rpm.diesel <- automobile$peak_rpm[x]
peak.rpm.gas <- automobile$peak_rpm[y]

wilcox.test(peak.rpm.diesel, peak.rpm.gas)

# 5. Czy moc silnika zależy od ilości drzwi?
shapiro.test(automobile$horsepower)  # nie jest z normalnego

two.doors.power <- automobile$horsepower[automobile$num_of_doors == "two"]
four.doors.power <- automobile$horsepower[automobile$num_of_doors == "four"]

wilcox.test(two.doors.power, four.doors.power)

# 6. Zilustruj graficznie zależność wagi samochodów od położenia silnika. 
plot(curb_weight ~ engine_location,
     data = automobile,
     main = "Zależność wagi samochodu od położenia silnika",
     xlab = "Położenie silnika",
     ylab = "Waga samochodu (curb-weight)",
     col = c("lightblue", "lightgreen"))



# # # # # # # # # # # # # # Zadanie 2
# 1. Stwórz tabelę krzyżową dla typu silnika i liczby cylindrów. 
table(automobile$engine_type, automobile$num_of_cylinders)

# 2. Stwórz tabelę krzyżową dla typu silnika, rodzaju paliwa i liczby cylindrów. 
table(automobile$engine_type, automobile$fuel_type, automobile$num_of_cylinders)

# 3. Zastosuj do poprzedniego zadania funkcję ftable
ftable(automobile$engine_type, automobile$num_of_cylinders)
ftable(automobile$engine_type, automobile$fuel_type, automobile$num_of_cylinders)

# 4. Zilustruj graficznie typ nadwozia i napęd samochodu. 
#    (Podpowiedź: użyj wykresu mosaicplot.) 
mosaicplot(table(automobile$body_style, automobile$drive_wheels),
           main = "Typ nadwozia vs. Typ napędu",
           xlab = "Typ nadwozia",
           ylab = "Typ napędu",
           color = c(1, 2, 3),
           las=2)



# # # # # # # # # # # # # # Zadanie 3
# 1. Zbadaj zależność typu silnika i liczby cylindrów. 
x <- table(automobile$engine_type, automobile$num_of_cylinders)
chisq.test(x)

# Hipoteza zerowa (H₀): Zmienne są niezależne
# Hipoteza alternatywna (H₁): Zmienne są zależne
# Przy p-value < 0.05, odrzucamy hipotezę zerową (H₀)

# 2. Zbadaj zależność typu nadwozia i liczby drzwi. 
x <- table(automobile$body_style, automobile$num_of_doors)
chisq.test(x)

# 3. Zbadaj zależność następujących dwóch cech. 
#    Waga samochodu jest mała (poniżej 2000), 
#    średnia (w przedziale od 2000 do 3000), 
#    duża (od 3000 do 4000), bardzo duża (powyżej 4000). 
#    Silnik jest słaby (moc poniżej 100), 
#    średni (moc w przedziale od 100 do 200), 
#    potężny (moc powyżej 200). 
x1 <- cut(automobile$curb_weight,
         breaks = c(0, 2000, 3000, 4000, Inf),
         labels = c("mała", "średnia", "duża", "bardzo duża"))

x2 <- cut(automobile$horsepower,
         breaks = c(0, 100, 200, Inf),
         labels = c("słaby", "średni", "potężny"))

chisq.test(table(x1, x2))

# 4. Zbadaj zależność następujących dwóch cech. 
#    Samochodu jest tani (cena poniżej 10000), 
#    niedrogi (cena w przedziale od 10000 do 20000), 
#    nietani (cena od 20000 do 30000), 
#    drogi (cena od 30000 do 40000), 
#    kosztowny (cena powyżej 40000). 
#    Samochód jest luksusowy (średnie spalanie paliwa (mpg) jest poniżej 20), 
#    nieekonomiczny (w przedziale od 20 do 30), 
#    ekonomiczny (od 30 do 40), 
#    oszczędny (powyżej 40). 
x1 <- cut(automobile$price,
          breaks = c(0, 10000, 20000, 30000, 40000, Inf),
          labels = c("tani", "niedrogi", "nietani", "drogi", "kosztowny"))

x2 <- cut((automobile$city_mpg + automobile$highway_mpg) / 2,
          breaks = c(0, 20, 30, 40, Inf),
          labels = c("luksusowy", "nieekonomiczny", "ekonomiczny", "oszczędny"))

chisq.test(table(x1, x2))

# 5. Zilustruj graficznie zależność typu nadwozia i liczby drzwi. 
#    (Podpowiedź: użyj wykresu assocplot.) 
x <- table(automobile$body_style, automobile$num_of_doors)
assocplot(x, 
          main = "Zależność typu nadwozia i liczby drzwi",
          xlab = "Liczba drzwi", 
          ylab = "Typ nadwozia"
          )



# # # # # # # # # # # # # # Zadanie 4
# 1. Oblicz tabelę korelacji dla następujących cech: 
#    waga, długość, prędkość obrotu silnika, moc silnika, 
#    zużycie paliwa na trasie, zużycie paliwa w mieście.
cor_data <- automobile[, c("curb_weight", 
                           "length", 
                           "peak_rpm", 
                           "horsepower", 
                           "highway_mpg", 
                           "city_mpg")
                       ]
cor_matrix <- cor(cor_data)


# 2. Wykorzystaj funkcję symnum() i odpowiedz na pytanie: 
#    między jakimi cechami jest duża korelacja?
symnum(cor_matrix)

# 3. Zbadaj istotność statystyczną korelacji między cechami o dużej korelacji.
cor_test_result <- cor.test(automobile$highway_mpg, automobile$city_mpg)
cor_test_result

# 4. Zilustruj graficznie tabelę korelacji. Użyj funkcji image() oraz axis().
image(1:ncol(cor_matrix),
      1:nrow(cor_matrix),
      cor_matrix,
      col = heat.colors(22), axes = FALSE,
      xlab="", ylab="")
axis(1, at=1:ncol(cor_matrix),
     labels=abbreviate(colnames(cor_matrix)))
axis(2, at=1:nrow(cor_matrix),
     labels=abbreviate(rownames(cor_matrix)),
     las = 2)

# 5, Zilustruj graficznie tabelę korelacji. Użyj funkcji plotcorr().
install.packages("ellipse")
library(ellipse)
plotcorr(cor_matrix, type="lower")

# 6. Zilustruj graficznie tabelę korelacji. Użyj funkcji corrplot(). 
install.packages("corrplot")
library(corrplot)
corrplot(cor_matrix, method = "number", order = "hclust")



# # # # # # # # # # # # # # Zadanie 5
# 1. Oblicz regresję liniową pomiędzy ceną samochodu a mocą silnika. 
#    Przealanizuj istotność statystyczną współczynników regresji.
reg <- lm(price ~ horsepower, data = automobile)
summary(reg)

# 2. Zilustruj graficznie regresję liniową pomiędzy 
#    ceną samochodu a mocą silnika. Umieść na wykresie dane oraz linię regresji.
plot(automobile$horsepower, automobile$price, 
     main = "Regresja liniowa: Cena vs. Moc silnika", 
     xlab = "Moc silnika (horsepower)", 
     ylab = "Cena samochodu", 
     pch = 16, col = "blue")
abline(reg, col = "red", lwd = 2)

# 3. Oblicz regresję liniową pomiędzy wagą samochodu a jego długością. 
#    Przealanizuj istotność statystyczną współczynników regresji.
lm_weight_length <- lm(curb_weight ~ length, data = automobile)
summary(lm_weight_length)


# 4. Zilustruj graficznie regresję liniową pomiędzy wagą a długością samochodu. 
#    Umieść na wykresie dane oraz linię regresji. 
plot(automobile$length, automobile$curb_weight, 
     main = "Regresja liniowa: Waga vs. Długość samochodu", 
     xlab = "Długość samochodu (mm)", 
     ylab = "Waga samochodu (curb_weight)", 
     pch = 16, col = "green")
abline(lm_weight_length, col = "red", lwd = 2)



# # # # # # # # # # # # # # Zadanie 6
# 1. W tym ćwiczeniu wykorzystaj dane Haberman's Survival.
#    Pobierz dane i wczytaj je do R. 
columns = c("patient_age", "operation_year",
            "positive_axillary_nodes_num", "survival_status")
data <- read.table("haberman/haberman.data", sep = ",", col.names = columns)
str(data)

# 2. Czy wiek pacjienta ma wpływ na przeżycie?
data$survival_status <- data$survival_status - 1
haberman_glm <- glm(survival_status ~ patient_age, 
                    data = data, 
                    family = binomial)
summary(haberman_glm)

# 3. Czy ilość węzłów chłonnych, dotkniętych nowotworem 
#    ma wpływ na przeżycie pacjenta?
haberman_glm_2 <- glm(survival_status ~ positive_axillary_nodes_num, 
                    data = data, 
                    family = binomial)
summary(haberman_glm)



# # # # # # # # # # # # # # Zadanie 7
# 1. Zbadaj, czy istnieje zależność mocy silnika od napędu samochodu.
x <- anova(lm(automobile$horsepower ~ automobile$drive_wheels))
x

# 2. Zilustruj graficznie (boxplot) moc silnika samochodu 
#    w zależności od napędu samochodu.
boxplot(automobile$horsepower ~ automobile$drive_wheels)

# 3. Zbadaj, czy istnieje zależność wagi samochodu od typu nadwozia.
x <- anova(lm(automobile$curb_weight ~ automobile$body_style))
x

# 4. Zilustruj graficznie (boxplot) wagę samochodu 
#    w zależności od typu nadwozia. 
boxplot(automobile$curb_weight ~ automobile$body_style,
        col = c("red", "green", "blue", "yellow", "purple"))



# # # # # # # # # # # # # # Zadanie 8
# 1. Zastosuj do poprzedniego zadania test Kruskala-Wallisa.
# Test Kruskala-Wallisa dla mocy silnika i napędu samochodu
kruskal_test_hp <- kruskal.test(horsepower ~ drive_wheels, data = automobile)
kruskal_test_hp

kruskal_test_weight <- kruskal.test(curb_weight ~ body_style, data = automobile)
kruskal_test_weight

# 2. Który z dwóch testów powinno się zastosować? 
shapiro.test(automobile$horsepower)
shapiro.test(automobile$curb_weight)
# p-value < 0.05 więc hipoteza alternatywna: dane nie pochodzą z rozkładu
# normalnego. Dlatego też powinno używać się do tego testu kruskala.
