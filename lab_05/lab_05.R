# W pliku bike.zip zapisane są dane o trasach rowerowych w formacie tcx. 
# Wczytać je można za pomocą funkcji readTCX() z pakietu trackeR. '
# Usunąć zduplikowane względem czasu wpisy można wykorzystując 
# funcję duplicated().


install.packages("trackeR")
library(trackeR)

setwd("D:/Projekty/IntroductionToR/lab_05/bike/")
tcx <- readTCX("20200930_074725.tcx")
tcx



# # # # # # # # # # # # # # Zadanie 1
# 1. Zaprojektuj i zaimplementuj S3 klasę track.
#    Konstruktor ma dwa argumenty: plik z trasą oraz nazwa trasy
#    W przypadku gdy nazwa trasy nie jest podana, używa się domyślnej nazwy:
#     jeżeli początek trasy jest w godzinach 5:00–12:00, „Morning ride”,
#     jeżeli początek trasy jest w godzinach 12:00–18:00, „Afternoon ride”,
#     Jeżeli początek trasy jest w godzinach 18:00–23:00, „Evening ride”,
#     Jeżeli początek trasy jest w godzinach 23:00–5:00, „Night ride”. 
#    Proponowany nagłówek konstruktora:

#     track <- function(file, title=getTitle(ride)) {

track <- function(file, title=getTitle(ride)) {
  ride <- readTCX(file)
  
  getTitle <- function(ride) {
    hour <- as.numeric(format(ride$time[1], "%H"))
    if(hour >= 5 & hour < 12) {
      ride_name <- "Morning ride"
    }
    if(hour >= 12 & hour < 18) {
      ride_name <- "Afternoon ride"
    }
    if(hour >=18 & hour < 23) {
      ride_name <- "Evening ride"
    }
    if(hour >= 23 & hour < 5) {
      ride_name <- "Night ride"
    }
    ride_name
  }
  
  structure(list(ride=ride, title=title), class='track')
}

# 2. Zaimplementuj standardowe funkcje generyczne: 
#    print(), head(), tail(), summary(). 
print.track <- function(x, ...) {
  print("Track: ")
  print(x$ride, ...)
  print("=========================================")
  print("Name: ")
  print(x$title, ...)
}

head.track <- function(x, ...) {
  print("Name: ")
  print(x$title)
  print("=========================================")
  head(x$ride, ...)
}

tail.track <- function(x, ...) {
  print("Name: ")
  print(x$title)
  print("=========================================")
  tail(x$ride, ...)
}

summary.track <- function(x, ...) {
  print("Trasa: ")
  print(x$title)
  print("=========================================")
  print("Summary: ")
  summary(x$title)
}

track1 <- track(file = "20200930_074725.tcx")
track_moutain <- track(file = "20201002_155452.tcx", title = "Moutain ride")
print(track_moutain)
head(track_moutain, 2)
tail(track_moutain, 2)
summary(track_moutain)

# 3. Zaimplementuj funkcje, które zwracają części ride oraz title. 
#    Funkcja title() służy do zmiany etykiet wyrkesów. Zaproponuj dla nazwy 
#    trasy inną funkcję. Zaimplementuj odpowiednie funkcje zastępujące.
# Funkcja zwracająca część 'ride' (dane o trasie)
ride <- function(x) {
  x$ride
}

title <- function(x) {
  x$title
}

`ride<-` <- function(x, value) {
  x$ride <- value
  x
}

`title<-` <- function(x, value) {
  x$title <- value
  x
}

ride(track1)
ride(track1) <- track_moutain
title(track1)
title(track1) <- "new_name"
title(track1)

# 4. Zaimplementuj funkcję generyczną velocity(), 
#    która oblicza prędkość rowerzysty w każdym momencie. 
#    Wynikiem funkcji jest wektor.
velocity <- function(x) {
  UseMethod("velocity")
}

velocity.track <- function(x) {
  dt <- difftime(x$ride$time[-1], x$ride$time[length(x$ride$time)])
  ds <- x$ride$distance[-1] - x$ride$distance[length(x$ride$distance)]
  v <- (ds / as.numeric(dt)) * 3.6
  v
}

velocity.default <- function(x) {
  stop("Funkcja velocity stosowana jest tylko dla obiektów klasy track.")
}

velocity(track_moutain)
velocity(tcx)


# 5. Zaimplementuj funkcję plot(), która wyświetla wysokość lub prędkość 
#    rowerzysty w zależności od czasu jazdy lub przejechanego dystansu. 
#    Przykładowy domyślny wykres:
#    (https://wmii.uwm.edu.pl/~denisjuk/uwm/r/cw/ch05s01.html)
plot.track <- function(x, 
                       type = "l",
                       main = x$title,
                       xlab = getxlab(xtype),
                       ylab = getylab(ytype),
                       ytype = "speed",
                       xtype = "distance",
                       col = "green",
                       ...) {
  getxlab <- function(xtype) {
    if (xtype == "distance") {
      "Dystans km"
    } else {
      "Czas, h"
    } 
  }
  
  getylab <- function(ytype) {
    if (ytype == "speed") {
      "Prędkość km\\h"
    } else {
      "Altitude, m"
    } 
  }
  
  if (ytype == "speed") {
    yvalue <- velocity(x)
  } else {
    yvalue <- x$ride$altitude[-1]
  }
  
  if (xtype == "distance") {
    xvalue <- x$ride$distance[-1] / 1000
  } else {
    xvalue <- (x$ride$time[-1] - x$ride$time[1]) / 3600
  }
  
  plot(xvalue, 
       yvalue, 
       type = type,
       xlab = xlab,
       ylab = ylab,
       main = main,
       col = col,
       ...)
}

plot(track_moutain)
plot(track_moutain, ytype = "", xtype = "")
