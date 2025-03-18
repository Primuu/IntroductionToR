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

