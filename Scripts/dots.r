# Art? 

library(tidyverse)
library(RColorBrewer)

# blank canvas ####

axis_min <- 0
axis_max <- 10

base_data <- tibble(x = axis_min:axis_max,
                    y =x)
base_data %>% 
  ggplot(aes(x,y))

# add points ####

base_data %>% 
  ggplot(aes(x,y))+ 
  geom_point()

grid_points <- expand.grid(base_data)

grid_points %>% 
  ggplot(aes(x,y))+
  geom_point()

# spacing ####

polk <- grid_points %>% 
  mutate( x = case_when(y %% 2 == 0 & x %% 2 > 0 ~ NA_integer_,
                        TRUE ~ x),
          y = case_when( x %% 2 == 0 & y %% 2 > 0 ~ NA_integer_,
                         TRUE ~ y)) %>% 
  filter(if_all(everything(), ~!is.na(.)))

polk %>% 
  ggplot(aes(x,y))+
  geom_point()

# aes ####

dot_size <- 10
dot_color <- "#ffffff"
back_col <- "#598c4c"

polk %>% 
  ggplot(aes(x,y))+
  theme_void()+ # remove axes and labels
  geom_point(size = 10, 
             color = dot_color)+
  theme(plot.background = element_rect(fill = back_col))


