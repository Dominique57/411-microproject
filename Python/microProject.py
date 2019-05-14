import matplotlib.pyplot as plt
import numpy as np
from scipy.linalg import expm
from scipy.interpolate import BSpline, make_interp_spline

#project settings
#first point
ybegin=0
#how many points
ycount = 10
#step per point
unitPrecision = 0.1
#how many point generated per exising point (1 = raw values)
smoothenFactor = 5

#set matrix details and matrix infos
#matrixCols = 3
#matrixRows = 3
#matrix = np.array([[-3, 3, -3],[5, -5, 5], [-9, 9, -9]])
matrixCols = 2
matrixRows = 2
matrix = np.array([[-3, 3],[5, -5]])

#extract data and store in data array
data = [[] for _ in range(matrixCols*matrixRows)]
for i in range(ybegin, ybegin+ycount):
    matrixi = expm(i*unitPrecision * matrix)
    for y in range(matrixRows):
        for x in range(matrixCols):
            data[y*matrixCols + x].append(matrixi[y][x])

#creating x values with smoothenfactor
abscise = [i*unitPrecision for i in range(ybegin, ybegin+ycount)]
abscise_smooth = np.linspace(abscise[0], abscise[ycount-1], ycount*smoothenFactor)

#adding data lines after being smoothed
colorArr=["blue", "red", "green", "purple" "brown", "yellow"]
for i in range(matrixCols*matrixRows):
    #color=colorArr[i%matrixCols]
    color=colorArr[i//matrixCols]
    bsplineObj = make_interp_spline(abscise, data[i], k=3)
    data_smooth = bsplineObj(abscise_smooth)
    plt.plot(abscise_smooth, data_smooth, linewidth=1, color=color)
    #plt.plot(abscise, data[i], linewidth=1, color=color)

#graph settigns    
plt.title('Matrix exponential of given matrix')
plt.ylabel('Y-value')
plt.xlabel('X-value')

plt.grid(True)
plt.xlim(-1*unitPrecision,(ycount*unitPrecision)+1*unitPrecision)
#plt.ylim(0.0,17.0)
#plt.axis([-1, 10, -1, 17.0])

#attempt to stretch the graph so it is easier to read
#(if graph small, re-execute this cell)
fig_size = plt.rcParams["figure.figsize"]
fig_size[0] = 15
fig_size[1] = 5
plt.rcParams["figure.figsize"] = fig_size

filename = 'uProj1'
plt.savefig(filename+'.pdf')
plt.savefig(filename+'.jpg')