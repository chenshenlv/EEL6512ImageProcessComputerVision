# -*- coding: utf-8 -*-
"""
File:   hw01.py
Author: 
Date:   
Desc:   
    
"""


""" =======================  Import dependencies ========================== """

import numpy as np
import matplotlib.pyplot as plt
from scipy.stats import norm
import math as mat

plt.close('all') #close any open plots

"""
===============================================================================
===============================================================================
============================ Question 1 =======================================
===============================================================================
===============================================================================
"""
""" ======================  Function definitions ========================== """

def generateUniformData(N, l, u, gVar):
	'''generateUniformData(N, l, u, gVar): Generate N uniformly spaced data points 
   in the range [l,u) with zero-mean Gaussian random noise with variance gVar'''
	# x = np.random.uniform(l,u,N)
	step = (u-l)/(N);
	x = np.arange(l+step/2,u+step/2,step)
	e = np.random.normal(0,gVar,N)
	t = np.sinc(x) + e
	return x,t

def plotData(x1,t1,x2,t2,x3=None,t3=None,legend=[]):
   '''plotData(x1,t1,x2,t2,x3=None,t3=None,legend=[]): Generate a plot of the 
      training data, the true function, and the estimated function'''
   p1 = plt.plot(x1, t1, 'bo') #plot training data
   p2 = plt.plot(x2, t2, 'g') #plot true value
   if(x3 is not None):
       p3 = plt.plot(x3, t3, 'r') #plot training data

   #add title, legend and axes labels
   plt.ylabel('t') #label x and y axes
   plt.xlabel('x')
   
   if(x3 is None):
       plt.legend((p1[0],p2[0]),legend)
   else:
       plt.legend((p1[0],p2[0],p3[0]),legend)
       
   """
   This seems like a good place to write a function to learn your regression
   weights!
   
   """
""" ======================  Def regression weights ========================== """       
def fitdataReg(x,t,M):
	'''fitdataReg(x,t,M): Fit a polynomial of order M to the data (x,t)'''	
	X = np.array([x**m for m in range(M+1)]).T
	w = np.linalg.inv(X.T@X)@X.T@t
	return w
""" ======================  Variable Declaration ========================== """

l = 0 #lower bound on x
u = 10 #upper bound on x
N_train= 20 #number of samples to generate for trainning
N_val=150 #number of samples to generate for validation
gVar = .25 #variance of error distribution
#M =  3 #regression model order
#la=0 # Regula penalty
E_RMS_train=[0 for i in range(12)] #RMS error of train
E_RMS_val=[0 for i in range(12)] #RMS error of validation

""" =======================  Generate Training Data ======================= """
data_uniform  = np.array(generateUniformData(N_train, l, u, gVar)).T

x1 = data_uniform[:,0] #generate trainning input sets
t1 = data_uniform[:,1] #generate trainning output sets

x2 = np.arange(l,u,0.001)  #get equally spaced points in the xrange
t2 = np.sinc(x2) #compute the true function value
   
""" ========================  Train the Model ============================= """
for M in range(0,12): #set the model from 0 to 12
   w = fitdataReg(x1,t1,M) 
   X_train = np.array([x1**m for m in range(M+1)]).T #computer trainning matrix
   T_train = X_train@w #compute the predicted value
   E_RMS_train[M]=[mat.sqrt(sum((T_train-t1)**2)/N_train)] #computer the RMS error of trainning sets
   plt.figure()
   plotData(x1,t1,x2,t2,x1,T_train,['Training Data', 'True Function', 'Estimated\nPolynomial'])
   plt.title('Train plot M='+str(M))
   print(w)


""" ======================== Generate Test Data =========================== """


"""This is where you should generate a validation testing data set.  This 
should be generated with different parameters than the training data!   """
data_uniform_val  = np.array(generateUniformData(N_val, l, u, gVar)).T

x4 = data_uniform_val[:,0] #generate validation input sets
t4 = data_uniform_val[:,1] #generate validation output sets

""" ========================  Test the Model ============================== """

""" This is where you should test the validation set with the trained model """
for M in range(0,12): #set the model from 0 to 12
   w = fitdataReg(x1,t1,M) # computer the w from trainning sets
   X_Val = np.array([x4**m for m in range(M+1)]).T #validation input matrix
   est_Val = X_Val@w #compute the predicted value
   E_RMS_val[M]=[mat.sqrt(sum((t4-est_Val)**2)/N_val)] #computer Rms error of validation sets
   plt.figure()
   plotData(x4,t4,x2,t2,x4,est_Val,legend=['Validation Data','True Function','Estimated\nPolynomial'])
   plt.title('Validation plot M='+str(M))
   print(w)

M=np.arange(0,12,1)
plt.figure()
plt.plot(M,E_RMS_train,'bo-',label='Trainning')
plt.plot(M,E_RMS_val,'ro-',label='Validation')
plt.xlabel('M')
plt.ylabel('E_Rms')
plt.legend(loc=1)


"""
===============================================================================
===============================================================================
============================ Question 2 =======================================
===============================================================================
===============================================================================
"""
""" ======================  Variable Declaration ========================== """

#True distribution mean and variance 
trueMu = 4
trueVar = 2 #sigma^2

#Initial prior distribution mean and variance (You should change these parameters to see how they affect the ML and MAP solutions)
priorMu = 8
priorVar = 0.2 #sigma^2

numDraws = 200 #Number of draws from the true distribution


"""========================== Plot the true distribution =================="""
#plot true Gaussian function
step = 0.01
l = -20
u = 20
x = np.arange(l+step/2,u+step/2,step)
plt.figure(0)
p1 = plt.plot(x, norm(trueMu,trueVar).pdf(x), color='b')
plt.title('Known "True" Distribution with Var='+str(trueVar))

"""========================= Perform ML and MAP Estimates =================="""
#Calculate posterior and update prior for the given number of draws

  
Dw=np.arange(0,200,1)
PM=np.arange(0,9,1)
Mu_ML_ss=[] #store mu of ML that 200th draws of different priorMU
Mu_MAP_ss=[] #store mu of MAP that 200th draws of different priorMU
Mu_lh=7 #mu of likelihood
Var_lh=5 #variance of likelihood
## with fixed initial Prior variance of 0.2 run Mu_ML and MU_MAP, varing priorMu ranging from 0~9##
for priorMu in range(0,9):
    DrawResult = [] #store each draw result
    Mu_ML=[] #store Mu of ML after each draw result
    Mu_MAP=[] #store Mu of MAP after each draw result
    Var_MAP=[] #store Var of MAP after each draw result
    Mu_MAP_itera=priorMu # MAP MU and Var for iteration
    Var_MAP_itera=priorVar
    
    for Draw in range(200):
        DrawResult.append(np.random.normal(trueMu,mat.sqrt(trueVar),1)[0]) #generate each draw
        Mu_ML.append(sum(DrawResult)/len(DrawResult)) #computer ML result

        ## computer the const in Mu_MAP formulation ##
        MAP_const_1=Var_lh/(len(DrawResult)*Var_MAP_itera+Var_lh) 
        MAP_const_2=Var_MAP_itera/(len(DrawResult)*Var_MAP_itera+Var_lh)
        
        ##computer MAP result##
        Mu_MAP_itera=MAP_const_1*Mu_MAP_itera+MAP_const_2*sum(DrawResult) 
        Var_MAP_itera=(Var_MAP_itera*Var_lh)/(Var_lh+len(DrawResult)*Var_MAP_itera)
        Mu_MAP.append(Mu_MAP_itera) 
        Var_MAP.append(Var_MAP_itera)        
        
    Mu_ML_ss.append(Mu_ML[199]) #steady state Mu of ML
    Mu_MAP_ss.append(Mu_MAP[199]) #steady state Mu of MAP
#### plot ML and MAP iteration of each draws with variable PriorMU ###
    plt.figure() 
    plt.plot(Dw,Mu_ML,'b-',label='ML')
    plt.plot(Dw,Mu_MAP,'r-',label='MAP')
    plt.xlabel('Draws')
    plt.ylabel('MEAN')
    plt.legend(loc=1)
    plt.title('ML and MAP EST change with PriorMu='+str(priorMu))

# with fixed priorMu of 7 run Mu_ML and MU_MAP, varing priorVar ranging from 0.1~10.1
# with fixed priorMu of 7 run Mu_ML and MU_MAP, varing priorVar ranging from 0.1~10.1
priorMu=7
priorVar=np.arange(0.1,10.1,0.5)
priorVar_big=5
#####
Mu_ML_ss=[] #store mu of ML that 200th draws of different priorMU
Mu_MAP_ss=[] #store mu of MAP that 200th draws of different priorMU
Mu_lh=7 #mu of likelihood
Var_lh=5 #variance of likelihood
for i in range(20):
    DrawResult = [] #store each draw result
    Mu_ML=[] #store Mu of ML after each draw result
    Mu_MAP_small=[] #store Mu of MAP after each draw result
    Var_MAP_small=[] #store Var of MAP after each draw result
    Mu_MAP_big=[] #store Mu of MAP after each draw result
    Var_MAP_big=[] #store Var of MAP after each draw result
    Mu_MAP_itera_small=priorMu # MAP MU and Var for iteration
    Var_MAP_itera_small=priorVar[i]
    Mu_MAP_itera_big=priorMu # MAP MU and Var for iteration
    Var_MAP_itera_big=priorVar_big
    for Draw in range(200):
        DrawResult.append(np.random.normal(trueMu,mat.sqrt(trueVar),1)[0]) #generate each draw
        Mu_ML.append(sum(DrawResult)/len(DrawResult)) #computer ML result

        ## computer the const in Mu_MAP formulation ##
        MAP_const_1_small=Var_lh/(len(DrawResult)*Var_MAP_itera_small+Var_lh) 
        MAP_const_2_small=Var_MAP_itera_small/(len(DrawResult)*Var_MAP_itera_small+Var_lh)
        
        MAP_const_1_big=Var_lh/(len(DrawResult)*Var_MAP_itera_big+Var_lh) 
        MAP_const_2_big=Var_MAP_itera_big/(len(DrawResult)*Var_MAP_itera_big+Var_lh)
        ##computer MAP result##
        Mu_MAP_itera_small=MAP_const_1_small*Mu_MAP_itera_small+MAP_const_2_small*sum(DrawResult) 
        Var_MAP_itera_small=(Var_MAP_itera_small*Var_lh)/(Var_lh+len(DrawResult)*Var_MAP_itera_small)
        
        Mu_MAP_itera_big=MAP_const_1_big*Mu_MAP_itera_big+MAP_const_2_big*sum(DrawResult) 
        Var_MAP_itera_big=(Var_MAP_itera_big*Var_lh)/(Var_lh+len(DrawResult)*Var_MAP_itera_big)
        
        Mu_MAP_small.append(Mu_MAP_itera_small) 
        Var_MAP_small.append(Var_MAP_itera_small)
        Mu_MAP_big.append(Mu_MAP_itera_big) 
        Var_MAP_big.append(Var_MAP_itera_big)  
        
    Mu_ML_ss.append(Mu_ML[199]) #steady state Mu of ML
    Mu_MAP_ss.append(Mu_MAP[199]) #steady state Mu of MAP
#### plot ML and MAP iteration of each draws with variable PriorVar ###
    plt.figure() 
    plt.plot(Dw,Mu_ML,'b-',label='ML')
    plt.plot(Dw,Mu_MAP_small,'r-',label='MAP_smallVar')
    plt.plot(Dw,Mu_MAP_big,'g-',label='MAP_bigVar')
    plt.xlabel('Draws')
    plt.ylabel('MEAN')
    plt.legend(loc=1)
    plt.title('ML and MAP EST change with small PriorVar='+str(priorVar[i])+' big PriorVar='+str(priorVar_big)+'\nPriorMu='+str(priorMu))


# with fixed priorMu of 8, fixed priorVal of 0.2 run Mu_ML and MU_MAP, varing likelihoo Var ranging from 0.1~10.1
priorMu=8
priorVar=0.2
#####
Mu_ML_ss=[] #store mu of ML that 200th draws of different priorMU
Mu_MAP_ss=[] #store mu of MAP that 200th draws of different priorMU
Mu_lh=7 #mu of likelihood
Var_lh_small=np.arange(0.1,10.1,0.5)
Var_lh_big=5 #variance of likelihood
for i in range(20):
    DrawResult = [] #store each draw result
    Mu_ML=[] #store Mu of ML after each draw result
    Mu_MAP_small=[] #store Mu of MAP after each draw result
    Var_MAP_small=[] #store Var of MAP after each draw result
    Mu_MAP_big=[] #store Mu of MAP after each draw result
    Var_MAP_big=[] #store Var of MAP after each draw result
    Mu_MAP_itera_small=priorMu # MAP MU and Var for iteration
    Var_MAP_itera_small=priorVar
    Mu_MAP_itera_big=priorMu # MAP MU and Var for iteration
    Var_MAP_itera_big=priorVar
    for Draw in range(200):
        DrawResult.append(np.random.normal(trueMu,mat.sqrt(trueVar),1)[0]) #generate each draw
        Mu_ML.append(sum(DrawResult)/len(DrawResult)) #computer ML result

        ## computer the const in Mu_MAP formulation ##
        MAP_const_1_small=Var_lh_small[i]/(len(DrawResult)*Var_MAP_itera_small+Var_lh_small[i]) 
        MAP_const_2_small=Var_MAP_itera_small/(len(DrawResult)*Var_MAP_itera_small+Var_lh_small[i])
        
        MAP_const_1_big=Var_lh_big/(len(DrawResult)*Var_MAP_itera_big+Var_lh_big) 
        MAP_const_2_big=Var_MAP_itera_big/(len(DrawResult)*Var_MAP_itera_big+Var_lh_big)
        ##computer MAP result##
        Mu_MAP_itera_small=MAP_const_1_small*Mu_MAP_itera_small+MAP_const_2_small*sum(DrawResult) 
        Var_MAP_itera_small=(Var_MAP_itera_small*Var_lh_small[i])/(Var_lh_small[i]+len(DrawResult)*Var_MAP_itera_small)
        
        Mu_MAP_itera_big=MAP_const_1_big*Mu_MAP_itera_big+MAP_const_2_big*sum(DrawResult) 
        Var_MAP_itera_big=(Var_MAP_itera_big*Var_lh_big)/(Var_lh_big+len(DrawResult)*Var_MAP_itera_big)
        
        Mu_MAP_small.append(Mu_MAP_itera_small) 
        Var_MAP_small.append(Var_MAP_itera_small)
        Mu_MAP_big.append(Mu_MAP_itera_big) 
        Var_MAP_big.append(Var_MAP_itera_big)  
        
    Mu_ML_ss.append(Mu_ML[199]) #steady state Mu of ML
    Mu_MAP_ss.append(Mu_MAP[199]) #steady state Mu of MAP
#### plot ML and MAP iteration of each draws with variable PriorVar ###
    plt.figure() 
    plt.plot(Dw,Mu_ML,'b-',label='ML')
    plt.plot(Dw,Mu_MAP_small,'r-',label='MAP_smallVar')
    plt.plot(Dw,Mu_MAP_big,'g-',label='MAP_bigVar')
    plt.xlabel('Draws')
    plt.ylabel('MEAN')
    plt.legend(loc=1)
    plt.title('ML and MAP EST change with small likelihood variance='+str(Var_lh_small[i])+' big likelihood variance='+str(Var_lh_big)+'\nPriorMu='+str(priorMu)+' PriorVar='+str(priorVar))
### plot ML and MAP steady state trends with variable PriorVar




