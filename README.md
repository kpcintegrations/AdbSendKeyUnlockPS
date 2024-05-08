# AdbSendKeyUnlockPS
A powershell script that will turn on the screen swipe up and enter a custom pattern lock.
# Usage
Read the script first. You have to enter custom values from you're phone. For variables Row 1-3 that's the y position shown when show pointer location is enabled in develeoper settings. For Columns 1-3 that the x value at each pattern dot. Finally you must put in your pattern to unlock. it goes from left to right top to bottom: 
1,2,3
4,5,6
7,8,0

So add your phones specfic pattern as integers between commas after the SwipePattern function call at the end of the script.

This was developed based off an old bash shell script on a Google Pixel 6a. It should work for most phones, you might have to tweak other things but here's a base at least.
