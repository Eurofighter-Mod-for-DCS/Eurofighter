dofile(LockOn_Options.script_path.."command_defs.lua")
-- dofile(LockOn_Options.script_path.."System/Parameters.lua")

-- dofile("D:/Program Files/DCS World OpenBeta/Config/Input/Aircrafts/base_joystick_binding.lua") --D:\Program Files\DCS World OpenBeta\Config\Input\Aircrafts
local update_time_step = 0.0125
make_default_activity(update_time_step)
local FBW = GetSelf()
local sensor_data = get_base_data()


-- ===== Local variables =====
local ROLL_INPUT = 0
local PITCH_INPUT = 0
local RUDDER_INPUT = 0
local THROTTLE_INPUT = 0

local GERROR = 0
local T = 0

local ias_knots = 0

local PITCH_TARGET = 0
local PITCH_ERROR = 0
local PITCH_STATE=0

local PITCH_Diff1 = 0
local PITCH_Diff2 = 0

local PITCHTimeSec = 0.1
local PITCHIncrement = update_time_step / PITCHTimeSec

local ROLL_TARGET = 0 
local ROLL_ERROR = 0
local ROLL_STATE =0

local ROLLTimeSec = 0.15
local ROLLIncrement = update_time_step / ROLLTimeSec

local YAW_STATE = 0 
local YAW_TARGET = 0

local YAW_Diff1 = 0
local YAW_Diff2 = 0
local RudderTimeSec = 1
local RudderIncrement = update_time_step / RudderTimeSec

local PITCH_OUTPUT = get_param_handle("CURRENT_PITCH_OUTPUT")
local ROLL_OUTPUT = get_param_handle("CURRENT_ROLL_OUTPUT")
local YAW_OUTPUT = get_param_handle("CURRENT_YAW_OUTPUT")

local PITCH_PAST = 0
local GTARGET = 0

local Kp = 0
local Kd = 0 
local Ki = 0



FBW:listen_command(Keys.PlaneTrimUp)
FBW:listen_command(Keys.PlaneTrimDown)
FBW:listen_command(Keys.PlaneTrimRight)
FBW:listen_command(Keys.PlaneTrimLeft)
FBW:listen_command(Keys.PlaneTrimCancel)

FBW:listen_command(2001)--Pitch axis
FBW:listen_command(2002)--roll
FBW:listen_command(2003)--rudder/yaw

FBW:listen_command(10061)--Pitch axis
FBW:listen_command(10062)--roll
FBW:listen_command(RUDDER_INPUT)--rudder/yaw
FBW:listen_command(THROTTLE_INPUT)--throttle

function SetCommand(command,value)
	if command == 10061 then
        PITCH_INPUT = value
	end
	if command == 10062 then
		ROLL_INPUT = value
	end
	if command == RUDDER_INPUT then
		RUDDER_OUTPUT = value	
    else
        RUDDER_INPUT = 0	
	end

    if command == 2019 then
        PITCH_STATE = value
    end
    
    if command == 2020 then 
        ROLL_STATE =value
    end 
	

	
end

function Sensor_data() 

	PITCH = sensor_data.getPitch()
    ROLL = sensor_data.getRoll()
    NY = sensor_data.getVerticalAcceleration()
    NX = sensor_data.getHorizontalAcceleration()
    NZ = sensor_data.getLateralAcceleration()
    ROLLRATE = sensor_data.getRateOfRoll()* 57.29577951308233
    PITCH_RATE = sensor_data.getRateOfPitch()* 57.29577951308233
    YATRATE = sensor_data.getRateOfYaw()* 57.29577951308233
    GTARGET = (1 + PITCH_INPUT* 100 / 12.5)
    GERROR = GTARGET - NY
    PITCH_ERROR = PITCH_TARGET - PITCH
    ROLL_ERROR = ROLL_TARGET - ROLL
    ias_knots = sensor_data.getIndicatedAirSpeed() * 1.94384
end

function time_counter()
    T = T + update_time_step
    if T == 1 then
        T = 0
    end
end

  

function update()

    time_counter()

    Sensor_data()
    

    -- print_message_to_user("EUROFIGHTER PITCH OUTPUT"..GERROR / GTARGET)

    --EN PRINCIPIO ASÍ VA BIEN
    -- ESTABLECER MODOS.

    if GTARGET < 0 then 
        PITCH_OUTPUT = -1 * (GERROR / GTARGET)
    else
        PITCH_OUTPUT = GERROR / GTARGET
    end

    ROLL_OUTPUT = ROLL_INPUT

    if GERROR > 0 then
        dispatch_action(nil, 2001, PITCH_OUTPUT)	--PITCH
        -- print_message_to_user(PITCH_OUTPUT)
    elseif GERROR < 0 then
        dispatch_action(nil, 2001, PITCH_OUTPUT)	--PITCH
        -- print_message_to_user(PITCH_OUTPUT)
    end 

    dispatch_action(nil, 2002, ROLL_OUTPUT)	--ROLL



    -- dispatch_action(nil, 174, YAW_STATE) 	--RUDDER/YAW
end