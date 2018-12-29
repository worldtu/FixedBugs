# 1. 
# When the variable names in specific language and "-" can't be normally printed out in matplotlib package
# Solution: set parameters with option "plt.rcParams"

plt.rcParams['font.sans-serif'] = ['SimHei'] # set font in your language, make sure that this font EXISTS in your computer
plt.rcParams['axes.unicode_minus'] = False # used as print out "-" normally
