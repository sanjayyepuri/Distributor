library(ggplot2)
library("ggrepel")

data <- read.csv("Rgraphics/dataSets/EconomistData.csv")

pc1 <- ggplot(data, aes(x = CPI, y = HDI, color = Region))
pc1 + geom_point()

(pc2 <- pc1 + 
	geom_smooth(aes(group = 1), 
		method="lm",
		formula = y ~ log(x),
		se = FALSE, 
		color = "red")) + 
		geom_point(shape = 1, size = 4)+
		geom_point(shape = 1, size = 4.5)

