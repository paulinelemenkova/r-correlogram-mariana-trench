# ============================================================================
# Statistical correlogram of Mariana Trench environmental data (R).
# This produced figures in the peer-reviewed article:
#   Lemenkova, P. (2019). Computing and Plotting Correlograms by Python and R
#   Libraries for Correlation Analysis of the Environmental Data in Marine
#   Geomorphology. Journal of Geomorphological Researches
#   (Jeomorfolojik Arastirmalar Dergisi), 3, 1-16.
#   DOI:      https://doi.org/10.5281/zenodo.3516458
#   figshare: https://doi.org/10.6084/m9.figshare.10012808
#   HAL:      https://hal.science/hal-02327797
# Author: Polina Lemenkova | ORCID: 0000-0002-5759-1089
# ============================================================================

# ЧАСТЬ 1: делаем data.frame
	# шаг-1. вчитываем таблицу. делаем из нее датафрейм.
MDepths <- read.csv("Depths.csv", header=TRUE, sep = ",")
	# шаг-2. чистим датафрейм от NA значений
MDF <- na.omit(MDepths) 
row.has.na <- apply(MDF, 1, function(x){any(is.na(x))}) # проверяем, удалил ли все NA
sum(row.has.na) # суммируем все NA, должно получиться: [1] 0
head(MDF) # смотрим очищенный датафрейм. теперь с ним работаем.

# ЧАСТЬ 2. Создаем коррелограмму
	#  шаг-3. Делаем корреляционную матрицу з нашего датафрейма MDF, используя метод Пирсона, т.к. все данные нормально распределены. Т.к. данных много, то половину из них делаем NA. Сreate the correlation matrix using Pearson because all the variables are normally distributed. Since a correlation matrix has redundant information I’m setting half of it to NA.
thecor<-round(cor(MDF[,sort(c("profile1", "profile2", "profile3", "profile4", "profile5", "profile6", "profile7", "profile8", "profile9", "profile10","profile11", "profile12", "profile13", "profile14", "profile15", "profile16", "profile17", "profile18", "profile19", "profile20","profile21", "profile22", "profile23", "profile24", "profile25"))], method="pearson", use="pairwise.complete.obs"),2) 
thecor[lower.tri(thecor)]<- NA 
thecor
	# шаг-4. сшиваем все колонки "profile" используя функцию melt из библиотеки reshape2. удаляем NA значения // melting the columns of the matrix using the melt function from the reshape2 package and drop the records with NA values. 
library(reshape2)
thecor<-melt(thecor)
thecor$Var1<-as.character(thecor$Var1)
thecor$Var2<-as.character(thecor$Var2)
thecor<-na.omit(thecor)
head(thecor)
	#  шаг-5. рисуем кореллограмму используя функцию geom_tile
Correlogramm_Mariana <- ggplot(thecor, aes(Var2, Var1)) +  
	geom_tile(data=thecor, aes(fill=value), color="white") +  
	scale_fill_gradient2(low = "blue", high = "red", mid = "white", midpoint = 0, limit = c(-1,1), name = "Correlation\n(Pearson)") +  
	coord_equal() +
	labs(title="马里亚纳海沟。剖面1-25。Mariana Trench, Profiles Nr.1-25.", 
	subtitle = "统计图表。相关矩阵。Correlogram of Correlation Matrix",
	caption = "Statistics Processing and Graphs: \nR Programming. Data Source: QGIS") +
	theme(
		plot.margin = margin(5, 10, 20, 5),
		plot.title = element_text(family = "Kai", face = "bold", size = 12), # китайский шрифт "Кай"
		plot.subtitle = element_text(family = "Hei", face = "bold", size = 10), # китайский шрифт "Хэй"
		plot.caption = element_text(face = 2, size = 6),
		panel.background=ggplot2::element_rect(fill = "white"),
		legend.justification = "bottom", 
		legend.position = "bottom",
		legend.box.just = "right",
		legend.direction = "horizontal",
		legend.box = "horizontal",
		legend.box.background = element_rect(colour = "honeydew4",size=0.2),
		legend.background = element_rect(fill = "white"),
		legend.key.width = unit(1,"cm"),
		legend.key.height = unit(.5,"cm"),
		legend.spacing.x = unit(.2,"cm"),
		legend.spacing.y = unit(.1,"cm"),
		legend.text = element_text(colour="black", size=6, face=1),
		legend.title = element_text(colour="black", size=6, face=1),
		strip.text.x = element_text(colour = "white", size=6, face=1),
		panel.grid.major = element_line("gray24", size = 0.1, linetype = "solid"),
		panel.grid.minor = element_line("gray24", size = 0.1, linetype = "dotted"),
		axis.text.x = element_text(face = 3, color = "gray24", size = 6, angle = 45),
		axis.text.y = element_text(face = 3, color = "gray24", size = 6, angle = 15),
		axis.ticks.length=unit(.1,"cm"),
		axis.line = element_line(size = .3, colour = "grey80"),
		axis.title.y = element_text(margin = margin(t = 20, r = .3), face = 2, size = 8),
		axis.title.x = element_text(face = 2, size = 8, margin = margin(t = .2))) +
		guides(col = guide_legend(nrow = 1, ncol = 6, byrow = TRUE)) # подправляем дизайн легенды.
Correlogramm_Mariana
ggsave("Correlogramm_Mariana.pdf", device = cairo_pdf, fallback_resolution = 300)