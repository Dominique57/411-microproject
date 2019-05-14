library(Matrix)

nrow <- 2
ncol <- 2
mdat <- matrix(c(-3, 5, 3, -5), nrow = nrow, ncol = ncol)

start <- 0
count <- 100
step <- 0.01

data <- list()
for(i in 1:(nrow*ncol))
{
    data[[i]] <- vector(mode="numeric", length=count)
}

for(i in start:(start+count-1))
{
    yindex <- i - start + 1
    xindex <- 0
    tempMatrix = Matrix::expm(mdat*(step*i))
    for(y in 1:nrow)
    {
        for(x in 1:ncol)
        {
            xindex <- xindex + 1
            data[[xindex]][yindex] <- tempMatrix[y,x]
        }
    }
}

colors <- c("blue","red")
x <- seq(0,count*step - step, step)

CreatePlot <- function() {
    plot(x, data[[1]], type ="l", main = "Matrix exponential of given Matrix", 
      col = colors[1],
      xlab = "x-value", ylab = "Y-value",
      xlim = c(-0.2, count*step), ylim = c(0, 1))
    for(i in (2:(nrow*ncol)))
        lines(x, data[[i]], col=colors[i%/%(ncol+1)+1])
    abline(v = 0:130,  lty = 2, col = "grey")
    abline(h = 0:3,  lty = 2, col = "grey")
    options(repr.plot.width=14, repr.plot.height=9)
}


jpeg('uProj1.jpg')
CreatePlot()
result = dev.off()


pdf('uProj1.pdf')
CreatePlot()
result = dev.off()