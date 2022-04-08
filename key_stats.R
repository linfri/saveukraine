# The code chunks which plot the key statistics

suppressMessages({
  suppressWarnings({
    # Loading the necessary library
    library(tidyverse)
    
    # Creating the tibble
    key_stats <- tibble(
      x = c(2, 8.5, 2, 8.5),
      y = c(4.8, 4.8, 7.8, 7.8),
      h = c(2, 2, 2, 2),
      w = c(6.25, 6.25, 6.25, 6.25),
      val = c("99", "700", "4504", "56"),
      text = c(
        "Purchases (whole album)", "Donations collected (€)",
        "Plays (whole album)", "Downloads (whole album)"
      ),
      color = factor(c(1, 2, 3, 4))
    )
    
    # Plotting the data
    ggplot(data = key_stats, aes(x, y, height = h, width = w, label = text)) +
      geom_tile(aes(fill = color)) +
      geom_text(
        color = "white", fontface = "bold", size = 16, family = "sans",
        aes(label = val, x = x - 2.9, y = y + 0.4), hjust = 0
      ) +
      geom_text(
        color = "white", fontface = "bold", size = 5, family = "sans",
        aes(label = text, x = x - 2.9, y = y - 0.6), hjust = 0
      ) +
      coord_fixed() +
      scale_fill_manual(values = c(
        "darkslategrey", "dark orange",
        "deepskyblue4", "darkslategray"
      )) +
      theme(plot.margin = unit(c(-0.30, 0, 0, 0), "null")) +
      theme_void() +
      labs(caption = "Source: Kalamine Records
       Retrieved on 9 April 2022") +
      guides(fill = FALSE)
  })
})

suppressMessages({
  suppressWarnings({
    # Function for calculating mode
    getmode <- function(x) {
      uqv <- unique(x)
      uqv[which.max(tabulate(match(x, uqv)))]
    }
    
    # Preparing the data frame and calculating mean/median/mode
    c_data <- c(
      14, 14, 17, 14, 10, 10, 14, 15, 17, 14, 20, 11, 10, 14, 10,
      10, 10, 18, 4, 11, 10, 6, 12, 15, 13, 10, 10, 12, 9, 1, 9,
      9, 9, 10
    )
    c_mean <- round(mean(c_data), digits = 1)
    c_median <- round(median(c_data))
    c_mode <- getmode(c_data)
    
    # Creating the tibble
    key_means <- tibble(
      x = c(2, 8.5, 2, 8.5),
      y = c(4.8, 4.8, 7.8, 7.8),
      h = c(2, 2, 2, 2),
      w = c(6.25, 6.25, 6.25, 6.25),
      val = c(c_mode, "85", c_mean, c_median),
      text = c(
        "Mode, past compilations", "Total tracks, #SaveUkraine",
        "Mean, past compilations", "Median, past compilations"
      ),
      color = factor(c(1, 2, 3, 4))
    )
    rm(c_data, c_mean, c_median, c_mode)
    
    # Plotting the data
    ggplot(data = key_means, aes(x, y, height = h, width = w, label = text)) +
      geom_tile(aes(fill = color)) +
      geom_text(
        color = "white", fontface = "bold", size = 16, family = "sans",
        aes(label = val, x = x - 2.9, y = y + 0.4), hjust = 0
      ) +
      geom_text(
        color = "white", fontface = "bold", size = 5, family = "sans",
        aes(label = text, x = x - 2.9, y = y - 0.6), hjust = 0
      ) +
      coord_fixed() +
      scale_fill_manual(values = c(
        "darkslategrey", "dark orange",
        "deepskyblue4", "darkslategray"
      )) +
      theme(plot.margin = unit(c(-0.30, 0, 0, 0), "null")) +
      theme_void() +
      labs(caption = "Source: Kalamine Records
       Retrieved on 9 April 2022") +
      guides(fill = FALSE)
  })
})

suppressMessages({
  suppressWarnings({
    # Creating the tibble
    key_artists <- tibble(
      x = c(2, 8.5, 2, 8.5),
      y = c(4.8, 4.8, 7.8, 7.8),
      h = c(2, 2, 2, 2),
      w = c(6.25, 6.25, 6.25, 6.25),
      val = c(sum(acsu_artists$Frequency), "USA", sum(new_artists$Frequency), "Germany"),
      text = c(
        "Artists on both compilations", "Most common country",
        "New artists on #SaveUkraine", "Most common country"
      ),
      color = factor(c(1, 2, 3, 4))
    )
    
    # Plotting the data
    ggplot(data = key_artists, aes(x, y, height = h, width = w, label = text)) +
      geom_tile(aes(fill = color)) +
      geom_text(
        color = "white", fontface = "bold", size = 16, family = "sans",
        aes(label = val, x = x - 2.9, y = y + 0.4), hjust = 0
      ) +
      geom_text(
        color = "white", fontface = "bold", size = 5, family = "sans",
        aes(label = text, x = x - 2.9, y = y - 0.6), hjust = 0
      ) +
      coord_fixed() +
      scale_fill_manual(values = c(
        "darkslategrey", "deepskyblue4",
        "deepskyblue4", "darkslategray"
      )) +
      theme(plot.margin = unit(c(-0.30, 0, 0, 0), "null")) +
      theme_void() +
      labs(caption = "Source: Kalamine Records, Attenuation Circuit
       Retrieved on 9 April 2022") +
      guides(fill = FALSE)
  })
})

suppressMessages({
  suppressWarnings({
    # Calculating p-values
    MC <- chisq.test(group_test$Freq.x, group_test$Freq.y, simulate.p.value = TRUE)
    nonMC <- chisq.test(group_test$Freq.x, group_test$Freq.y)
    
    # Creating the tibble
    key_artists <- tibble(
      x = c(2, 8.5),
      y = c(4.8, 4.8),
      h = c(2, 2),
      w = c(6.25, 6.25),
      val = c(round(MC$p.value, digits = 3), round(nonMC$p.value, digits = 3)),
      text = c(
        "p-value (with simulation)", "p-value (without simulation)"
      ),
      color = factor(c(1, 2))
    )
    
    # Plotting the data
    ggplot(data = key_artists, aes(x, y, height = h, width = w, label = text)) +
      geom_tile(aes(fill = color)) +
      geom_text(
        color = "white", fontface = "bold", size = 16, family = "sans",
        aes(label = val, x = x - 2.9, y = y + 0.4), hjust = 0
      ) +
      geom_text(
        color = "white", fontface = "bold", size = 5, family = "sans",
        aes(label = text, x = x - 2.9, y = y - 0.6), hjust = 0
      ) +
      coord_fixed() +
      scale_fill_manual(values = c(
        "darkslategrey", "deepskyblue4"
      )) +
      theme(plot.margin = unit(c(-0.30, 0, 0, 0), "null")) +
      theme_void() +
      guides(fill = FALSE)
  })
})
