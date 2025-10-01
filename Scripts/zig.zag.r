# zig zag jawn ####
library(tidyverse)
library(RColorBrewer)
axis_min <- 0
axis_max <- 10
base_2 <- tibble(x = axis_min:axis_max, #0-10
                 y = axis_min) #horizontal line
base_2 %>% 
  ggplot(aes(x,y))+
  geom_point()+
  geom_path()

# bumping up the points ####

bumps <- rep_along(1:nrow(base_2), c(0,1))
bumps

zigs <- base_2 %>% 
  mutate(y = y + bumps) %>% 
  print(n = 10)

zigs %>% 
  ggplot(aes(x,y))+
  geom_path()

# iterating ####
n <- 1:6 # create six lines

# creating 6 different groups of lines by mutating the y
# aka add value of 1 to each line
zigzags <- map_df(n, ~zigs %>% 
                    mutate(y = y + .x))

zigzags %>% 
  ggplot(aes(x,y))+
  geom_path()

# BUT we need a grouping var ####

# make each line its own entity
zigzags <- map_df(n, ~ zigs %>% 
                    mutate(y = y + .x, 
                           group = paste0("line", .x)))
zigzags %>% 
  ggplot(aes(x,y, group = group))+
  geom_path()

# aes ####
line_size <- 10


brewer.pal(n = 8, name = "Dark2")

line_colors <- c("#1B9E77", "#D95F02", "#7570B3", "#E7298A", "#66A61E", "#E6AB02")
background_col <- c("#666666")

#assign colors to df 
# CORRECT 
col_zig <- map2_df(n, line_colors, ~zigs %>% 
                     mutate(y = y + .x, 
                            group = paste0("line", .x),
                            color = .y))


# color argument has to be the same length, map will not recycle
# let's create an error to see that 
line_5_col <- c("#1B9E77", "#D95F02", "#7570B3", "#E7298A", "#66A61E")

map2_df(n, line_5_col, ~zigs %>% 
          mutate(y = y + .x, 
                 group = paste0("line", .x),
                 color = .y))


# art time 

col_zig %>% 
  ggplot(aes(x,y, group = group))+
  theme_void()+
  geom_path(linewidth = line_size,
            lineend = "square",
            linejoin = "mitre",
            color = col_zig$color)+
  theme(plot.background = element_rect(fill = background_col))+
