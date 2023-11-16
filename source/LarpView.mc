import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Lang;
import Toybox.Timer;
import Toybox.Application;


class LarpView extends WatchUi.View {
    private var _TimerdelayElement; 
    private var _currentTimerElement;   
    private var _RepsElement;
    private var _totalTimeElement;
    private var countdownTimer as Timer.Timer; // Timer for the countdown
    private var countdownTime as Number; // Time remaining in the countdown
    private var secondTimerTime as Number; // Time for the second timer (replacement for currentTime)
    
     function initialize() {
        View.initialize();
        countdownTimer = new Timer.Timer();
        countdownTime = 30000; // 30 seconds for the first countdown
        secondTimerTime = 60000; // 60 seconds for the second timer
     }
    function onLayout(dc as Dc) as Void {
    setLayout(Rez.Layouts.MainLayout(dc));

    _TimerdelayElement = findDrawableById("Timer_delay") as WatchUi.Label;
    _currentTimerElement = findDrawableById("Current_timer") as WatchUi.Label;
    _RepsElement = findDrawableById("Reps") as WatchUi.Label;
    _totalTimeElement = findDrawableById("Total_time") as WatchUi.Label;

        setTimerDisplay(3, _TimerdelayElement);
        setTotalTimeValue(1329392);
        setCurrentTimeValue(13087);
        updateRepsValue(7);

        // Start the countdown timer
        countdownTimer.start(method(:countdownCallback), 1000, true); // Update every second
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

    function countdownCallback() as Void {
        countdownTime -= 1000; // Decrement by one second

        if (countdownTime <= 0) {
            countdownTime = secondTimerTime; // Reset the timer to the second timer duration
            countdownTimer.start(method(:countdownCallback), 1000, true); // Restart the timer
        }

        setCurrentTimeValue(countdownTime); // Update the current timer display
        setTimerDisplay(countdownTime, _TimerdelayElement); // Update the timer delay display
    }

    function setTimerDisplay(value as Number, labelElement as WatchUi.Label) as Void {
        var seconds = value / 1000;
        var formattedTime = (seconds < 10 ? "0" : "") + seconds.toString() as Toybox.WatchUi.Text;

    }

    function setTotalTimeValue(value as Number) as Void {
    // Code to set the total time
    var totalSeconds = value / 1000; // Convert milliseconds to seconds
    var hours = totalSeconds / 3600; // Calculate hours
    var minutes = (totalSeconds % 3600) / 60; // Calculate minutes
    var seconds = totalSeconds % 60; // Calculate seconds

    // Format the time components
    var formattedTime = (hours < 10 ? "0" : "") + hours.toString() + ":" +
                        (minutes < 10 ? "0" : "") + minutes.toString() + ":" +
                        (seconds < 10 ? "0" : "") + seconds.toString();

    _totalTimeElement.setText(formattedTime);
}

function setCurrentTimeValue(value as Number) as Void {
    // Code to set the current time
    var seconds = value / 1000; // Convert milliseconds to seconds
    var milliseconds = value % 1000; // Remainder milliseconds

    // Format the time components
    var formattedTime = (seconds < 10 ? "0" : "") + seconds.toString() + "." +
                        (milliseconds < 10 ? "0" : "") + (milliseconds < 10 ? "0" : "") + milliseconds.toString();

    _currentTimerElement.setText(formattedTime);
}


    function updateRepsValue(Reps as Number) as Void {

        // Correctly concatenate the number of reps with the singular or plural form of "rep"
        var multipleSign = Reps == 1 ? "" : "s";
        var formattedValue = Reps.toString() + " rep" + multipleSign;

        _RepsElement.setText(formattedValue);
    }
}