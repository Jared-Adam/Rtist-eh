library(tidyverse)
library(RColorBrewer)
library(gganimate)

# calculate a circle from scratch
#ggplot works on cartesian (x,y) scale

# vector with angles all possible angles of a circle create a circle 
# in radiants!
angles <- seq(0, 2*pi, length.out = 1000) # length adjusts how smooth the circle is 

# create full circle with converted equations
circle <- tibble(x = cos(angles), 
                 y = sin(angles))
circle

# plot 
circle %>% 
  ggplot(aes(x,y))+
  geom_path()+
  coord_equal()

# now we need multiple circles ####
# time to iterate 
n = 60 

dark <- brewer.pal(n = 8, name = "Dark2")
?colorRampPalette
colors <- colorRampPalette(dark)(n) # take these colors and make 20 color options for each circle 
circle_now <- map2_df(1:n, colors, ~circle %>% 
                        mutate(x = x + .x, # shifting circles left to right, so adding value of first argument
                               color = .y, # for each circle, iterate the colors  
                               group = paste0("group", .x))) # grouping variable

# adding circles on the line 
circle_now %>% 
  ggplot(aes(x,y, group = group))+
  geom_polygon()


# tweak aes ####

line_style <- 2
line_color <- "#ffffff"
backg_col <- "#000000"

circle_now %>% 
  ggplot(aes(x,y, group = group))+
  theme_void()+
  geom_polygon(fill = circle_now$color,
               color = line_color,
               linetype = line_style)+
  theme(plot.background = element_rect(fill = backg_col))

# finesse ggplot ####
circle_now %>% 
  ggplot(aes(x,y, group = group))+
  theme_void()+
  geom_polygon(fill = circle_now$color,
               color = line_color,
               linetype = line_style)+
  theme(plot.background = element_rect(fill = backg_col))+
  coord_polar() # warps plot into a wheel

# can you make this roate? ####
# 
circle_now %>%
  mutate(move = 1:60000) %>%
  transition_manual(move, cumulative = TRUE)
# 
# 
# ?gganimate

