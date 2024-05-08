$COL1 = 295                   # X coordinate of column 1 (in pixels)
$COL2 = 535                   # X coordinate of column 2 (in pixels)
$COL3 = 785                   # X coordinate of column 3 (in pixels)

$ROW1 = 1485                   # Y coordinate of row 1 (in pixels)
$ROW2 = 1735                   # Y coordinate of row 2 (in pixels)
$ROW3 = 1975                   # Y coordinate of row 3 (in pixels)

$WAKE_SCREEN_ENABLED = $true    # If true, the script will start by sending the power button press event

$SWIPE_UP_ENABLED = $true       # If true, the script will swipe upwards before drawing the pattern (e.g. for dismissing fingerprint screen lock and other things blocking pattern entry)

$SWIPE_UP_X = 500              # X coordinate for initial upward swipe. Only used if SWIPE_UP_ENABLED is true

$SWIPE_UP_Y_FROM = 2200        # Start Y coordinate for initial upward swipe. Only used if SWIPE_UP_ENABLED is true

$SWIPE_UP_Y_TO = 1400           # End Y coordinate for initial upward swipe. Only used if SWIPE_UP_ENABLED is true

# You may need to alter the above swipe up values to match your phone gui, so it actually swipes fully and not a half swipe.

# =======================================================================================================================

# Define X&Y coordinates for each of the 9 positions.
$coordinates = @(
    @{ x = $col1; y = $row1 }
    @{ x = $col2; y = $row1 }
    @{ x = $col3; y = $row1 }
    @{ x = $col1; y = $row2 }
	@{ x = $col2; y = $row2 }
	@{ x = $col3; y = $row2 }
	@{ x = $col1; y = $row3 }
	@{ x = $col2; y = $row3 }
	@{ x = $COL3; y = $row3 }
)

# Function definitions
function WakeScreen {
	if ($WAKE_SCREEN_ENABLED) {
		adb shell input keyevent 26
    }
}

function SwipeUp {
	if ($SWIPE_UP_ENABLED) {
		adb shell input swipe $SWIPE_UP_X $SWIPE_UP_Y_FROM $SWIPE_UP_X $SWIPE_UP_Y_TO 250
    }
}

function StartTouch {
    adb root
	adb shell sendevent /dev/input/event3  1 330 1
    adb shell sendevent /dev/input/event3 3 57 362
    adb shell sendevent /dev/input/event3 3 53 497
    adb shell sendevent /dev/input/event3 3 54 784
    adb shell sendevent /dev/input/event3 3 48 140
    adb shell sendevent /dev/input/event3 3 49 124
    adb shell sendevent /dev/input/event3 3 58 34
    adb shell sendevent /dev/input/event3 3 52 3890
    adb shell sendevent /dev/input/event3 0 0 0
}

function SendCoordinates {
    param ($1,$2)
	adb shell sendevent /dev/input/event3 3 53 $1
	adb shell sendevent /dev/input/event3 3 54 $2
	adb shell sendevent /dev/input/event3 3 58 57
	adb shell sendevent /dev/input/event3 0 0 0
}

function FinishTouch {
	adb shell sendevent /dev/input/event3 3 57 4294967295
	adb shell sendevent /dev/input/event3 0 0 0
}

function SwipePattern {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [int[]]
        $Pattern
    )

    foreach ($value in $Pattern) {
        # Zero based index
        $position = $coordinates[$value - 1]
        SendCoordinates $position.x $position.y
    }
}

# Actions

WakeScreen
Start-Sleep -Milliseconds 500
SwipeUp
Start-Sleep -Milliseconds 500
StartTouch
# For The Swipe Pattern Enter Your Pattern As Integers Betweem Comma's a single space after the SwipePattern function call. Pattern is as follows
# 1 2 3
# 4 5 6
# 7 8 0
SwipePattern 0,1,2,3,4,5,6,7,8
FinishTouch