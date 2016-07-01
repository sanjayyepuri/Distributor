setwd("/Users/sanjayyepuri/Dropbox/Programming/R")
housing <- read.csv("Rgraphics/dataSets/landdata-states.csv")
head(housing[1:5])
hist(housing$Home.Value)

library(ggplot2)
library("ggrepel")
ggplot(housing, aes(x = Home.Value)) + geom_histogram()

plot(Home.Value ~ Date, 
	data=subset(housing, State == "MA"))
points(Home.Value ~ Date, col="red", 
	data=subset(housing, State == "TX"))
legend(19750, 400000, 
	c("MA", "TX"), title="State",
	col=c("black", "red"), 
	pch=c(1, 1))

ggplot(subset(housing, State %in% c("MA", "TX")), 
	aes(x=Date, 
		y=Home.Value,
		color=State)) + 
geom_point()

hp2001Q1 <- subset(housing, Date == 20011)
hp2001Q1$pred.SC <- predict(lm(Structure.Cost ~ Land.Value, data = hp2001Q1))
p1 <- ggplot(hp2001Q1, aes(y = Structure.Cost, x = Land.Value))

p1 + geom_point(aes(color = Home.Value)) + geom_line(aes(y = pred.SC))
p1 + geom_point(aes(color = Home.Value)) + geom_smooth()
p1 + geom_text(aes(label=State), size=3)

p1 + geom_point() + geom_text_repel(aes(label=State), size = 3)
p1 + geom_point(aes(color=Home.Value, shape = region))

#Exercise 1 
dat <- read.csv("Rgraphics/dataSets/EconomistData.csv")
CPIvsHDI <- ggplot(dat, aes(x = CPI, y = HDI))
CPIvsHDI + geom_point(color = "blue")
CPIvsHDI + geom_point(aes(color = Region))
ggplot(dat, aes(x = Region, y = CPI)) + geom_boxplot()
ggplot(dat, aes(x = Region, y = CPI)) + geom_boxplot() + geom_point()


p2 <- ggplot(housing, aes(x = Home.Value))
p2 + geom_histogram(stat = "bin", binwidth=4000)

housing.sum <- aggregate(housing["Home.Value"], housing["State"], FUN=mean)
rbind(head(housing.sum), tail(housing.sum))
ggplot(housing.sum, aes(x=State, y=Home.Value)) + geom_bar(stat="identity")

#Exercise 2 
ggplot(dat, aes(x = CPI, y = HDI)) + geom_point() + geom_smooth(span=0.3)

p3 <- ggplot(housing, 
	aes(x = State, 
		y = Home.Price.Index))  +
theme(legend.position="top", 
	axis.text = element_text(size = 6))
(p4 <- p3 + geom_point(aes(color = Date), 
	alpha = 0.5, 
	size = 1.5, 
	position = position_jitter(width = 0.25, height = 0)))

p4 + scale_x_discrete(name="State Abbreviation") + scale_color_continuous(name="", 
	breaks= c(19751, 19941, 20131), 
	labels= c(1971, 1994, 2013), 
	low = "blue", high = "red")

#Exercise
ggplot(dat, aes(x = CPI, y = HDI)) + geom_point(aes(color=Region)) + 
scale_x_continuous(name = "Consumer Price Index") +
scale_y_continuous(name = "Human Development Index") + 
scale_color_manual(name = "Region of the world",
                     values = c("#24576D",
                                "#099DD7",
                                "#28AADC",
                                "#248E84",
                                "#F2583F",
                                "#96503F"))


p5 <- ggplot(housing, aes(x = Date, y = Home.Value))
p5 + geom_line(aes(color = State))

(p5 <- p5 + geom_line() + facet_wrap(~State, ncol = 10))
p5 + theme_minimal() + theme(text = element_text(color = "turquoise"))