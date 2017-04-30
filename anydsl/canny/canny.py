import cv2
import numpy as np
from matplotlib import pyplot as plt

img = cv2.imread('mon1.png', 0)
blur = cv2.GaussianBlur(img, (5, 5), 0)
sobel = cv2.Sobel(blur, cv2.CV_64F, 1, 1, ksize=5)

plt.subplot(121), plt.imshow(img, cmap='gray'), plt.title('Original')
plt.xticks([]), plt.yticks([])

plt.subplot(122), plt.imshow(sobel, cmap='gray'), plt.title('Filtered')
plt.xticks([]), plt.yticks([])

plt.show()
