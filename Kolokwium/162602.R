# wektor z nazwami kolumn
column_names <- c("Sex", "Length", "Diameter", "Height", 
                  "Whole weight", "Shucked weight", 
                  "Viscera weight", "Shell weight", "Rings")

# wczytanie zbioru danych
abalone <- read.csv("abalone.data", 
                    header = FALSE, 
                    col.names = column_names)



# # # # # # # # # # # # ZADANIE 1
# wyodrębnienie osobników płci male 
male <- abalone[abalone$Sex == "M", ]

# utworzenie i zapisanie jako png histogramu:
#   - 21 przedziałów
#   - "Shucked.weight" według notatnika to mięśnie
png("162602a.png")
hist(male$Shucked.weight, 
     breaks = 21, 
     col = "lightblue", 
     main = "Histogram wagi mięśni osobników płci męskiej", 
     xlab = "Waga mięśni (Shucked weight)",
     ylab = "Liczba przypadków")

# dodanie krzywej gęstości (czerwona, pogrubiona)
lines(density(male$Shucked.weight), col = "red", lwd = 2)

# zamknięcie bieżącego urządzenia graficznego
dev.off()



# # # # # # # # # # # # ZADANIE 2
# wyodrębnienie osobników płci infant o wadze całkowitej > 0.16
infant <- abalone[abalone$Sex == "I" & abalone$Whole.weight > 0.16, ]

# wyszukanie największej długości wśród osobników
# o płci infant i wadze całkowitej > 0.16
max_length_infant <- max(infant$Length)

# wyświetlenie wyniku (wynik: 0.725)
max_length_infant



# # # # # # # # # # # # ZADANIE 3
# wyodrębnienie osobników o średnicy > 0.4
greater_diameter <- abalone[abalone$Diameter > 0.4, ]

# zliczenie liczby osobników dla każdej płci o średnicy > 0.4 
sex_counter <- table(greater_diameter$Sex)

# znalezienie wartości maksymalnej w powyżej zliczonych wartościach
max_sex <- which.max(sex_counter)

# wyodrębnienie nazwy płci, która występuje najczęściej 
# (wśród mięczaków o średnicy > 0.4)
most_common_sex <- names(sex_counter)[max_sex]

# wyświetlenie wyniku (wynik: M)
most_common_sex



# # # # # # # # # # # # ZADANIE 4
# wyodrębnienie pierwszych 100 wpisów
data <- abalone[1:100, ]

# utworzenie wektoru kolorów dla płci
colors <- ifelse(
  data$Sex == "M", "blue", 
    ifelse(data$Sex == "F", "red", 
           "green")
  )

# utworzenie i zapisanie jako png wykresu:
#    - oś x odpowiada za długość
#    - oś y odpowiada za wagę całkowitą
#    - kolory ustawione względem płci
png("162602b.png")
plot(data$Length, data$Whole.weight, 
     col = colors, 
     pch = 20, 
     xlab = "Długość", 
     ylab = "Całkowita waga", 
     main = "Długość i całkowita waga mięczaków w zależności od płci")

# dodanie legendy
legend("topleft", legend = c("Male", "Female", "Infant"),
       col = c("blue", "red", "green"), pch = 20)

# zamknięcie bieżącego urządzenia graficznego
dev.off()



# # # # # # # # # # # # ZADANIE 5
# stworzenie losowych danych w zakresie od -1 do 1 dla osi x
x <- runif(400, min = -1, max = 1)

# stworzenie losowych danych w zakresie od -1 do 1 dla osi y
y <- runif(400, min = -1, max = 1)

# utworzenie i zapisanie jako png wykresu:
#    - pierwsza funkcja rysuje na wykresie wszystkie wylosowane punkty na szaro
png("162602c.png")
plot(x, y, 
     xlim = c(-1, 1), 
     ylim = c(-1, 1), 
     pch = 16,
     main = "Błąd statystyczny I rodzaju",
     cex = 1.5,
     col = "gray",
     xlab = "",
     ylab = "")

# znalezienie wartości indeksów danych x i y, które są sobie "prawie równe"
# tzn. leżą "mniej więcej" na przekątnej
diagonal <- abs(x - y) < 0.15

#    - druga funkcja dorysowuje punkty na wykresie
#      "na przekątnej" jeszcze raz ale na czarno
points(x[diagonal],
       y[diagonal], 
       pch = 16, 
       col = "black",
       cex = 1.5)
# zamknięcie bieżącego urządzenia graficznego
dev.off()
