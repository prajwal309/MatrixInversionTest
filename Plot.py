import numpy as numpy
import matplotlib.pyplot as plt
import numpy as np
import glob

FileNames = glob.glob("fort.*")

XPlot = np.linspace(2000,10000,100)
YPlot = 1e-11*XPlot**3
plt.figure(figsize=(12,8))
for FileCounter,FileItem in enumerate(FileNames):
    Data = np.loadtxt(FileItem)
    NCores = int(FileItem.split(".")[1])
    print("The shape of data is:", NCores)

    if FileCounter==0:
        LW= "-"
        
    elif FileCounter==1:
        LW= ":"
    elif FileCounter==2:
        LW= "--"
    elif FileCounter==3:
        LW= "-."
    elif FileCounter==4:
        LW= (0,(1,10))
        LW= (5,(10,3))
    
    plt.plot(Data[:,0], Data[:,1], marker="+", markersize=5, color="red", linestyle=LW, label=str(NCores)+" dgetri ")

    #plt.plot(Data[:,0], Data[:,2]/NCores, color="blue", linestyle=LW, label=str(NCores)+" MatInvNew ")
    plt.plot(Data[:,0], Data[:,3], marker="d", markersize=5, color="green", linestyle=LW, label=str(NCores)+" MatInv ")
    #plt.plot(Data[:,0], Data[:,4]/NCores, color="brown", linestyle=LW, label=str(NCores)+" dsytrf")

plt.plot(XPlot, YPlot, "k-", lw=4, alpha=0.5)
plt.xlabel("Matrix Dimension")
plt.ylabel("Time Taken")
plt.legend(ncols=2)
plt.xscale('log')
#plt.yscale('log')
plt.grid(True)
plt.show()

input("We will wait here...")