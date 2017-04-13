# data-visualization-analysis-toolbox
MATLAB data visualization and analysis toolbox for Synchrotron X-ray and other scientific applications   

Data Analysis and Visualization Toolbox is a collection of GUI Matlab programs for managing, visualizing and analyzing data collected from various kinds of scientific experiments. While these programs were initially designed for X-ray SPEC files and Quantum Design devices, they can be easily adapted for wide range of applications. For example, the programs have been used to automate EDX data analysis, and to analyze high-magnetic-field transport data at Laboratoire National des Champs Magnétiques Intenses, France. 

Data Visualization

SPCPLOT provides data visualization, summation, subtraction and normalization. It can either be used as standalone program, or integrated into user programs via user supplied data loading functions. The selected raw data and processed data can be sent to SPCFIT for fitting. The unique feature of this program is to use simple log-style script to automate the data analysis. Together with SPCFIT, it makes routine analysis as simple as a few mouse clicks.

Data Fitting

SPCFIT provides simultaneous data fitting on multiple features, as well as simultaneous fitting on multiple data sets with independent or shared fitting parameters. It allows subtraction of the fits, and preforms subsequent fit on the 'background' removed data. The data can also be normalized or shifted by fitted values for comparison. All these can be automated via simple scripts. SPCFIT can also be called from user programs as a standard Matlab function.

http://webusers.spa.umn.edu/~yu/index.html
