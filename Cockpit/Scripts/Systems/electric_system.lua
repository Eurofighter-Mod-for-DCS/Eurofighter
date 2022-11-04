dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."utilites.lua")

local electric_system = GetSelf()
local dev = electric_system

local update_time_step = 0.02-- 1/0.02 = 50 times per second  
make_default_activity(update_time_step)

local sensor_data = get_base_data()

function post_initialize()  

   value = 0
   electric_system:AC_Generator_1_on(value > 0)
   electric_system:AC_Generator_2_on(value > 0)
   electric_system:DC_Battery_on(value > 0)
  
end

local PARAMETERS = 
{
    BATTERY           = get_param_handle("BATTERY"),
    LGEN              = get_param_handle("LGEN"),
    RGEN              = get_param_handle("RGEN"),
}


afterbunr_state = 0
afterburne_val = 0
afterburne_dir = 0.5


local PowerOnOff        = Keys.PowerOnOff --setting the iCommands from command defs 
local battery_click     = device_commands.BatterySwitchClick--Track mouse clicks

local LeftGen           = Keys.PowerGeneratorLeft --setting the iCommands from command defs 
local lgen_click        = device_commands.GenLeftSwitch--Track mouse clicks

local RightGen          = Keys.PowerGeneratorRight --setting the iCommands from command defs 
local rgen_click        = device_commands.GenRightSwitch--Track mouse clicks

electric_system:listen_command(PowerOnOff) --listen command needs to be here to work in set command
electric_system:listen_command(battery_click)

electric_system:listen_command(LeftGen) --listen command needs to be here to work in set command
electric_system:listen_command(lgen_click)

electric_system:listen_command(RightGen) --listen command needs to be here to work in set command
electric_system:listen_command(rgen_click)

battery_state = 0 -- I tend to make local vars all lower case
left_gen_state = 0 
right_gen_state = 0 
------------------------------------------------------------------FUNCTION-POST-INIT---------------------------------------------------------------------------------------------------
function post_initialize()
	-- print_message_to_user("Electrical System Initialize")
    local birth = LockOn_Options.init_conditions.birth_place

    if birth == "GROUND_HOT" or birth == "AIR_HOT" then
        battery_state = 1
        right_gen_state = 1
        left_gen_state = 1
    end
end
------------------------------------------------------------FUNCTION-SETCOMMAND---------------------------------------------------------------------------------------------------
function SetCommand(command,value)
    if command == PowerOnOff then
        battery_state = getOtherValue(battery_state)
    end

    if command == battery_click then
        dispatch_action(nil,PowerOnOff)-- this is used to push a keyboad/icommand with a mouse click
    end
    
    if command == LeftGen then
        left_gen_state = get_otherValue(left_gen_state)
    end

    if command == lgen_click then
        dispatch_action(nil,LeftGen)-- this is used to push a keyboad/icommand with a mouse click
    end

    if command == RightGen then
        right_gen_state = getOtherValue(right_gen_state)
    end

    if command == rgen_click then
        dispatch_action(nil,RightGen)-- this is used to push a keyboad/icommand with a mouse click
    end
end--END SETCOMMAND
------------------------------------------------------------------FUNCTION-UPDATE---------------------------------------------------------------------------------------------------
function update()
    PARAMETERS.BATTERY:set(battery_state)--this will set the BATTERY param to the battery_state local variable # so 0 or 1
    PARAMETERS.RGEN:set(right_gen_state)
    PARAMETERS.LGEN:set(left_gen_state)

end --END UPDATE

need_to_be_closed = false 