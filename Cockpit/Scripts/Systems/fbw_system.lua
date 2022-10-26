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

function SetCommand(command,value)
	if command == 2001 then
        PITCH_INPUT = value
    else
        PITCH_INPUT = 0
		--print_message_to_user(value)
	end
	if command == 2002 then
		ROLL_INPUT = value
    else
        ROLL_INPUT = 0
	end
	if command == 2003 then
		RUDDER_INPUT = value	
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
	PITCH = sensor_data.getPitch() * 57.29577951308233
    ROLL = sensor_data.getRoll() * 57.29577951308233
    GZ = sensor_data.getVerticalAcceleration()
    GERROR = 1 - GZ
    PITCH_ERROR = PITCH_TARGET - PITCH
    ROLL_ERROR = ROLL_TARGET - ROLL
    ias_knots = sensor_data.getIndicatedAirSpeed() * 1.94384
end

function time_counter()
    T = T + update_time_step
    if T == 1 then
        T = 0
        PITCH_PAST = PITCH_ERROR
        -- dispatch_action(nil,97)
    end
end

  

function update()

    time_counter()

    Sensor_data()
    
    -- local i = 100
    -- for i =  100, 1, -1 do 
    --     dispatch_action(nil, 957)

    -- end

    local PITCH_DELTA = PITCH_ERROR - PITCH_PAST

    local Kp = PITCH_ERROR/(10 * ias_knots)
    local kd = 0 --PITCH_ERROR * update_time_step / 10
    local Ki = 0

    PITCH_TARGET = PITCH_INPUT

    PITCH_Diff1 = PITCH_TARGET - PITCH_STATE  			-- Difference between desired and current angle
    PITCH_Diff2 = PITCH_STATE - PITCH_TARGET				-- Difference between current and desired angle
    -- dispatch_action(nil, Keys.PlaneTrimCancel)
    WOW = sensor_data.getWOW_NoseLandingGear()

    -- if ROLL_INPUT + PITCH_INPUT <= 0.01 and ROLL_INPUT + PITCH_INPUT >= -0.01  and ROLL < 60 and ROLL > -60 and PITCH < 70 and PITCH > -50 and WOW == 0 then
    --     if T == update_time_step * 2 then
    --         PITCH_TARGET = PITCH
    --     end

    --     if PITCH_ERROR > 0 then 
    --         dispatch_action(nil, 2019, Kp + Kd + Ki)
    --         -- print_message_to_user("DOWN")
    --     elseif PITCH_ERROR < 0 then
    --         dispatch_action(nil, 2019, Kp + Kd + Ki)  
    --         -- print_message_to_user("UP")
    --     elseif PITCH_ERROR == 0 then
    --         -- print_message_to_user("STABLE")
    --     end
    --     -- dispatch_action(nil,97)
    -- elseif PITCH_INPUT == 0 and WOW == 0 and ROLL > 60 and ROLL < -60 then
    --     if GERROR < 0 then 
    --         dispatch_action(nil, 2019, 10*GERROR/ias_knots + Kd + Ki)
    --         -- print_message_to_user("DOWN")
    --     elseif GERROR > 0 then
    --         dispatch_action(nil, 2019, 10*GERROR/ias_knots + Kd + Ki)  
    --         -- print_message_to_user("UP")
    --     elseif GERROR == 0 then
    --         -- print_message_to_user("STABLE")
    --     end
    -- elseif PITCH > 70 or PITCH < -50 then
    --     dispatch_action(nil,2019,0)
    -- end

    -- local Kp = ROLL_ERROR/(60*ias_knots) 
    -- local kd = update_time_step / 13
    -- local Ki = 0

    -- if ROLL_INPUT + PITCH_INPUT <= 0.02 and ROLL_INPUT + PITCH_INPUT >= -0.02  and WOW == 0 and ROLL < 90 and ROLL > -90 and ias_knots<450 then
    --     if T == update_time_step * 2 then
    --         ROLL_TARGET = ROLL
    --     end

    --     if ROLL_ERROR > 0 then 
    --         dispatch_action(nil, 2020, Kp + Kd + Ki)
    --         -- print_message_to_user("DERECHA")
    --     elseif ROLL_ERROR < 0 then
    --         dispatch_action(nil, 2020, Kp - Kd - Ki)  
    --         -- print_message_to_user("IZQUIERDA")
    --     elseif ROLL_ERROR == 0 then
    --         -- print_message_to_user("STABLE")
    --     end
    --     -- dispatch_action(nil,97)

    -- -- end
    -- print_message_to_user("PITCH ERROR")
    -- print_message_to_user(PITCH_ERROR)

    -- print_message_to_user("PITCH DELTA")
    -- print_message_to_user(PITCH_DELTA)

    if PITCH_INPUT+ROLL_INPUT <= -0.03 or PITCH_INPUT+ROLL_INPUT>= 0.03 and WOW == 0 then
        T = 0 
        dispatch_action(nil,2019, PITCH_STATE)
        dispatch_action(nil,2020, 0)
        PITCH_ERROR = 0
        ROLL_ERROR = 0
    end

--EN PRINCIPIO ASÍ VA BIEN


    -- dispatch_action(nil, 174)	--PITCH

    -- dispatch_action(nil, 2002, ROLL_INPUT)	--ROLL



    -- dispatch_action(nil, 174, YAW_STATE) 	--RUDDER/YAW
end