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
