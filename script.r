source('./r_files/flatten_HTML.r')

############### Library Declarations ###############
libraryRequireInstall("ggplot2");
libraryRequireInstall("plotly")
libraryRequireInstall("purrr")

#libraryRequireInstall("stringi")
#Sys.setlocale(category = "LC_ALL", locale = 'Russian_Russia.1251')
#Sys.setlocale(category = "LC_ALL", locale = "Portuguese_Portugal.1252")
#libraryRequireInstall("showtext")
#powerbi_rEnableShowTextForCJKLanguages = 1
#powerbi_rEnableShowText = 1
#stri_encode(Values$X, "", "WINDOWS-1251")

####################################################


################### Actual code ####################
color_list <- rep(c('#1f77b4', '#ff7f0e', '#2ca02c', '#d62728', '#9467bd', '#8c564b', '#e377c2', '#7f7f7f', '#bcbd22',
                    '#17becf', '#1f77b4', '#a6cee3', '#1f78b4', '#b2df8a', '#33a02c', '#fb9a99', '#e31a1c', '#fdbf6f',
                    '#ff7f00', '#cab2d6', '#6a3d9a', '#ffff99', '#b15928', '#8dd3c7', '#ffffb3', '#bebada', '#fb8072',
                    '#80b1d3', '#fdb462', '#b3de69', '#fccde5', '#d9d9d9', '#bc80bd', '#ccebc5', '#ffed6f', '#e41a1c',
                    '#377eb8', '#4daf4a', '#984ea3', '#ff7f00', '#ffff33', '#a65628', '#f781bf', '#999999', '#a6cee3',
                    '#1f78b4', '#b2df8a', '#33a02c', '#fb9a99', '#e31a1c', '#fdbf6f', '#ff7f00', '#cab2d6', '#6a3d9a',
                    '#ffff99', '#b15928'), 100)

color <- function(max,min,res){
  if (!is.na(res)) {
    if (!is.na(max)){
      if (res>=max){
        color <- 'red'
      } else {
        color <- 'White'
      }
    }
    
    if (!is.na(min)){
      if (res<=min){
        color <- 'red'
      } else {
        color <- 'White'
      }
    }
  } else {
    color <- 'black'
  }
  return(color)
}

Values$valColor <- pmap(list(Values$max, Values$min, Values$result_float), color)
dec <- function(){
  from <- "utf-8"
  to <- "windows-1251"
  Values$X <- iconv(Values$X, to=to, from=from)
  Values$nom_title <- iconv(Values$nom_title, to=to, from=from)
  Values$point <- iconv(Values$point, to=to, from=from)
  Values$requirement <- iconv(Values$requirement, to=to, from=from)
}
dec()

x <- Values$X
trace_max <- Values$maxV
trace_min <- Values$minV
trace_res <- Values$result_float

fig <- plot_ly(x = ~x, y = ~trace_min,
               name = 'Min',
               type = 'scatter',
               mode = 'lines+markers',
               marker = list(color = "#444"),
               line = list(color = "#444", width = 1)
)

fig <- fig %>% add_trace(y = ~trace_max,
                         name = 'Max',
                         mode = 'lines+markers',
                         marker = list(color = "#444"),
                         line = list(color = "#444", width = 1),
                         fillcolor = 'rgba(68, 68, 68, 0.3)',
                         fill = 'tonexty'
)

fig <- fig %>% add_trace(y = ~trace_res,
                         name = 'Результат',
                         type = 'scatter',
                         mode = 'lines+markers',
                         marker = list(color = Values$valColor),
                         line = list(width = 2, color = 'rgb(31, 119, 180)'),
                         fillcolor = 'rgba(68, 68, 68, 0.3)',
                         hovertemplate = paste('<b>Y</b>: %{y:.2f}',
                                               '<br><b>X</b>: %{x}<br>',
                                               '<b>%{text}</b>'),
                         hoverlabel = list(align = 'left'),
                         text = map(1:nrow(Values), ~paste('Требование: ', Values$requirement[.], '<br>',
                                                           'Ном-ра: ', Values$nom_title[.], '<br>',
                                                           'Точка: ', Values$point[.], '<br>',
                                                           'Тест: ', Values$test_id[.]))
)

ProcNamelist <- unique(Values$nom_title)
ColorsProc <- color_list[-(1:(length(color_list)-length(ProcNamelist)))]
dictColorShape <- list()
for (p in 1:length(ProcNamelist)){
  dictColorShape[[ProcNamelist[[p]]]] <- ColorsProc[[p]]
}

shapes <- list()
for (i in 1:(nrow(Values)-1)){
  item <- list(type = "rect",
               xref = "x",
               yref = "paper",
               x0 = x[i],
               y0 = 0,
               x1 = x[i+1],
               y1 = 1,
               line = list(color = "white"),
               fillcolor = dictColorShape[[Values$nom_title[[i]]]],
               opacity=0.2,
               layer="below",
               line_width=0
  )
  shapes <- append(shapes, list(item))
}

fig <- fig %>% layout(
  xaxis = list(categoryarray = ~x, categoryorder = "array", title = ""),
  yaxis = list(title='Результаты'),
  shapes= shapes,
  title = sessionInfo()$locale,#unique(Values$batch),#sessionInfo()$locale,
  margin = list(b=250),
  hoverlabel = list(align = 'left')
)

####################################################

############# Create and save widget ###############
p = ggplotly(fig);
internalSaveWidget(p, 'out.html')

####################################################
