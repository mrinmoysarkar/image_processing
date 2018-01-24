# -*- coding: utf-8 -*-
"""
Created on Wed Jan 10 16:08:31 2018

@author: msarkar
"""

import numpy as np
import cv2

img = cv2.imread('img.jpg',cv2.IMREAD_GRAYSCALE)
cv2.imshow('window1',img)
cv2.waitKey(0)
cv2.destroyAllWindows()
cv2.imwrite('img_gray.jpg',img)