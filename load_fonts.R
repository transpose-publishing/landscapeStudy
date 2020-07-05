library(ggplot2)
library(extrafont)

# download fonts from https://fonts.google.com/?selection.family=Hind
# install fonts manually
# register fonts with extrafont
extrafont::font_import(paths = "c:/Users/ThomasKlebel/AppData/Local/Microsoft/Windows/Fonts/")

# depending on the device you are using, you might need to load them explicitly
extrafont::loadfonts(device = "win")
# or
extrafont::loadfonts()


# try it out
ggplot(mtcars, aes(mpg)) +
  geom_histogram() +
  theme_bw(base_family = "Hind")


# this may work to automatically detect the device to load font if on windows
# if (.Platform$OS.type == "windows") extrafont::loadfonts(device = "win")
