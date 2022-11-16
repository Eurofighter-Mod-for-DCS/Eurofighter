dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."utils.lua")

electric_system = GetSelf()
local dev = electric_system

local update_time_step = 0.02-- 1/0.02 = 50 times per second  
make_default_activity(update_time_step)

local sensor_data = get_base_data()


start_value = 0
electric_system.AC_Generator_1 = start_value
electric_system.AC_Generator_2 = start_value
electric_system.Bat = start_value

function electric_system:set_Bat(value)
    electric_system.DC_Bat = value
end
function electric_system:get_Bat()
    return electric_system.DC_Bat
end
function electric_system:invert_Bat()
    electric_system.DC_Bat = getOtherValue(electric_system.DC_Bat)
end

function electric_system:set_AC_Generator_2(value)
    self.AC_Generator_2 = value
end
function electric_system:get_AC_Generator_2()
    return self.AC_Generator_2
end
function electric_system:invert_AC_Generator_2()
    self.DC_Bat = getOtherValue(self.AC_Generator_2)
end

function electric_system:set_AC_Generator_1(value)
    self.AC_Generator_1 = value
end
function electric_system:get_AC_Generator_1()
    return self.AC_Generator_1
end
function electric_system:invert_AC_Generator_1()
    self.DC_Bat = getOtherValue(self.AC_Generator_1)
end


electric_system:listen_command(Keys.PowerOnOff) --listen command needs to be here to work in set command
electric_system:listen_command(device_commands.BatterySwitchClick)

electric_system:listen_command(Keys.PowerGeneratorLeft) --listen command needs to be here to work in set command
electric_system:listen_command(device_commands.GenLeftSwitch)

electric_system:listen_command(Keys.PowerGeneratorRight) --listen command needs to be here to work in set command
electric_system:listen_command(device_commands.GenRightSwitch)
------------------------------------------------------------------FUNCTION-POST-INIT---------------------------------------------------------------------------------------------------
function post_initialize()
	-- print_message_to_user("Electrical System Initialize")
    local birth = LockOn_Options.init_conditions.birth_place

    if birth == "GROUND_HOT" or birth == "AIR_HOT" then
        electric_system:set_Bat(1)
        electric_system:set_AC_Generator_1(1)
        electric_system:set_AC_Generator_2(1)
    end
end
------------------------------------------------------------FUNCTION-SETCOMMAND---------------------------------------------------------------------------------------------------
function SetCommand(command,value)
    if command == Keys.PowerOnOff then
        --electric_system:invert_DC_Bat()
        electric_system:invert_Bat()
    end

    if command == device_commands.BatterySwitchClick then
        dispatch_action(nil,Keys.PowerOnOff)-- this is used to push a keyboad/icommand with a mouse click
    end
    
    if command == Keys.PowerGeneratorLeft then
        electric_system:invert_AC_Generator_1()
    end

    if command == device_commands.GenLeftSwitch then
        dispatch_action(nil,LeftGen)-- this is used to push a keyboad/icommand with a mouse click
    end

    if command == Keys.PowerGeneratorRight then
        electric_system:invert_AC_Generator_2()
    end

    if command == device_commands.GenRightSwitch then
        dispatch_action(nil,RightGen)-- this is used to push a keyboad/icommand with a mouse click
    end
end--END SETCOMMAND
------------------------------------------------------------------FUNCTION-UPDATE---------------------------------------------------------------------------------------------------
local PARAMETERS = 
{
    BATTERY           = get_param_handle("BATTERY"),
    ACGEN1            = get_param_handle("ACGEN1"),
    ACGEN2            = get_param_handle("ACGEN2"),
}

function update()
    PARAMETERS.BATTERY:set(electric_system.Bat)--this will set the BATTERY param to the battery_state local variable # so 0 or 1
    PARAMETERS.ACGEN1:set(electric_system:get_AC_Generator_1())
    PARAMETERS.ACGEN2:set(electric_system:get_AC_Generator_2())

end --END UPDATE

need_to_be_closed = false 