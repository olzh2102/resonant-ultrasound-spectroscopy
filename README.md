# resonant-ultrasound-spectroscopy
That project is Olzhas Kurikov's master thesis project. The experiments are performed with Resonant Ultrasound Spectroscopy to characterize any material. In the first stage I am trying to characterise solid materials such as aluminium, glass and plastic, since I can easily compare my results with liturature/datasheet values and guarantee that experiment is running correctly. The next stage will be to move to living materials, so to say characterise plants, leaves and etc. 
The reposetory consist of two matlab files and improved Python file.
+ FFT matlab file is used to convert time axis into frequency
+ "Difference" matlab file is used to compute difference in phase and in magnitude for sample and without sample.
+ Python script is used to generate final output using Gradient Descent Algorithm which minimises the error when theoretical fit tries to fit with measured data.
