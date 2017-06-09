import numpy as np
import time
start_time = time.time()

""" ------------- Creating class of Transmission Coefficient --------------- """
class TransCoeff:
    """ -- whenever this class used initialize it with CT -- """
    def __init__(self,CT):
        self.CT = CT

    def str(self):       """ -- to make it human readable output -- """
        return self.CT

    " -- input data array --"
    def frequency(self):
        return self.CT[:,0]

    def amplitude(self):
        return self.CT[:,1]

    def phase(self):
        return self.CT[:,2]

    " -- Square minima between measured and calculated magnitude and phase -- "
    def magnitude_error(self,calculated):
        return(sum(((self.amplitude() - calculated.amplitude()) /
        self.amplitude()) ** 2)) ** (1.0/2.0)/ len(self.CT[:,1])*1000
    " ----------------------------------------------------------------------- "
    def phase_error(self, calculated):
        return(sum(((self.phase() - calculated.phase()) ) ** 2)) ** (1.0/2.0) /
        len(self.CT[:,2]) * 1000

    " -- Frequency function goes through all the values until it finds the max."
    " value of frequency and return freq, magn, phase and index"
    def maxfreq(self): #function to find maximum value of amplitude (Fr)
        n = 0 #start counting from 0
        while not (self.amplitude()[n] == max(self.amplitude()) ): #if it is not max, then keep counting
            n+= 1
            return [self.frequency()[n], self.amplitude()[n], self.phase()[n], n]

    " - This function determines Q factor of the resonance peak ------------- "
    " - It consider the cases when not all the resonance peaks are in range of"
    " - experiment"
    def qfactor(self):
        #gets the highest freq. values around the highest amplitude (peak)
        index = self.frequency()[3] #that is from maxfreq function last in the row (n)
        indexRight = index
        indexLeft = index
        limit1 = 0
        limit2 = 0
        " - Leftside from resonance peak - "
        if self.amplitude()[index] - self.amplitude[indexLeft] < 3:
            indexLeft -= 1 #(Z.b.: 10-9=1/10-8=2/10-7=3/10-6=4) then it breaks

        elif indexLeft == 0: #if it initally already equal to 0 then flag
            limit1 = 1
        " - Rightside from resonance peak - "

        if self.amplitude()[indexRight] - self.amplitude()[index] < 3:
            indexLeft += 1 #same principle as before but other side

        elif indexRight == (self.amplitude()): #that is max freq = max amplitude
            limit2 = 1
        " ------------------------------------------------------------------- "
        if limit1 + limit2 == 0:
            return[(self.frequency()[indexLeft]-self.frequency()[indexRight])/
            self.frequency()[0],(indexLeft+indexRight)/2]

        elif limit1 == 1:
            return[2*(self.frequency()[indexLeft]-self.frequency()[0],
            self.frequency()[3]]

        elif limit2 == 1:
            return [2 * (self.maxfreq()[0] - self.frequency()[indexLeft]) /
            self.maxfreq()[0], self.maxfreq()[3]]

        elif limit1 + limit2 == 2:
            return NameError("Unfortunately, no resonance found")

    " - This function corresponds to calculation of parameters for sample from"
    " - measured trans. coeff."
    def parameters(self,otherMedium):
               #phase at max peak               #freq. at max peak
        time = self.maxfreq()[2]/(2 * 3.14159 * self.maxfreq()[0])
        thickness = otherMedium.Vel * (time + 1/(2 * self.maxfreq()[0]))
        velocity = 2 * thickness * self.maxfreq()[0]
        impedance1 = otherMedium.Vel * otherMedium.Dens
        attenuation = 3.14159 * self.maxfreq()[0]/(velocity/self.qfactor()[0])
        c = attyDen(attenuation,thickness,10**(self.maxfreq()[1]/20))
