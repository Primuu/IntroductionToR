# wektor z nazwami kolumn
column_names <- c("age", "sex", "chest_pain_type", "resting_bp", 
                  "serum_cholestoral", "fasting_blood_sugar", "rest_ecg", 
                  "max_heart_rate", "exercise_induced_angina","oldpeak", 
                  "slope", "num_major_vessels", "thal", "heart_disease")

# wczytanie zbioru danych
heart <- read.csv("heart.dat", header = FALSE, col.names = column_names, sep="")



# # # # # # # # # # # # ZADANIE 1
# obliczenie liczby kobiet z dławicą wysiłkową
x <- sum(heart$sex == 0 & heart$exercise_induced_angina == 1)

# obliczenie liczby kobiet
y <- sum(heart$sex == 0)

# obliczenie proporcji dławicy w całej populacji
z <- sum(heart$exercise_induced_angina == 1) / nrow(heart)

# test dwumianowy
binom.test(x = x, n = y, p = z, alternative = "two.sided")

# p-value = 0.0161 < 0.05 => odsetek kobiet z dławicą różni się istotnie 
# od ogólnego odsetka.



# # # # # # # # # # # # ZADANIE 2
# utworzenie tabeli krzyżowej
x <- table(heart$sex, heart$num_major_vessels)

# wykonanie testu chi squared
chisq.test(x)
# p-value = 0.09115 > 0.05 =>  nie ma istotnej statystycznie zależności 
# między płcią a liczbą głównych naczyń zabarwionych fluoroskopowo



# # # # # # # # # # # # ZADANIE 3
# utworzenie modelu regresji liniowej
reg <- lm(max_heart_rate ~ oldpeak, data = heart)

# zapis do pliku PDF
cairo_pdf("162602a.pdf")

# tworzenie wykresu
plot(heart$oldpeak, heart$max_heart_rate,
     main = "Zależność między maksymalnym tętnem a obniżeniem odcinka ST",
     xlab = "Obniżenie ST (oldpeak)",
     ylab = "Maksymalne tętno (max_heart_rate)",
     pch = 16, col = "darkblue")

# dodanie linii regresji
abline(reg, col = "red", lwd = 2)

# zamknięcie bieżącego urządzenia graficznego
dev.off()



# # # # # # # # # # # # ZADANIE 4
# sprawdzenie rozkładu danych
shapiro.test(heart$oldpeak)

# p-value = 2.103e-15 < 0.05 => dane dotyczące stopnia obniżenia odcinka ST 
# nie należą do rozkładu normalnego, zatem należy zastosować test
# nieparametryczny: Kruskal-Wallisa, a nie ANOVA.

# zastosowanie testu Kruskal-Wallisa
kruskal.test(oldpeak ~ thal, data = heart)

# p-value = 1.71e-07 < 0.05 => stopień obniżenia odcinka ST wywołanego wysiłkiem
# fizycznym istotnie statystycznie różni się w zależności
# od typu talasemii (thal).



# # # # # # # # # # # # ZADANIE 5
# klasa programmer
programmer <- function(x, y) {
  structure(list(hours = x, weeks = y), class = "programmer")
}

# test klasy
p1 <- programmer(c(40, 42, 38, 45), c(1, 2, 3, 4))
p1

# funkcja tworząca wykres
plot.programmer <- function(x,
                            type = "o",
                            lty = 2,
                            pch = 16,
                            col = "blue",
                            xlab = "Tydzień",
                            ylab = "Godziny pracy",
                            main = "Godziny pracy w kolejnych tygodniach",
                            ...) {
  plot(x$weeks,
       x$hours,
       type = type,
       lty = lty,
       pch = pch,
       col = col,
       xlab = xlab,
       ylab = ylab,
       main = main,
       ...)
}

# test funkcji
plot(p1)
