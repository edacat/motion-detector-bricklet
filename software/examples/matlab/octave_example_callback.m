function octave_example_callback()
    more off;
    
    HOST = "localhost";
    
    PORT = 4223;
    UID = "kYD"; % Change to your UID

    ipcon = java_new("com.tinkerforge.IPConnection"); % Create IP connection
    md = java_new("com.tinkerforge.BrickletMotionDetector", UID, ipcon); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Register detected callback to function cb_motion_detected
    md.addMotionDetectedCallback(@cb_motion_detected);

    % Register detection cycle ended callback to function cb_detection_cycle_ended
    md.addDetectionCycleEndedCallback(@cb_detection_cycle_ended);

    input("Press any key to exit...\n", "s");
    ipcon.disconnect();
end

% Callback function for end of detection cycle
function cb_detection_cycle_ended(e)
    fprintf("Detection Cycle Ended (next detection possible in ~3 seconds)\n");
end
% Callback function for detected motion
function cb_motion_detected(e)
    fprintf("Motion Detected\n");
end
