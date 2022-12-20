dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."device_class.lua")

local device = GetSelf()

local update_time_step = 0.02-- 1/0.02 = 50 times per second  
make_default_activity(update_time_step)

local sensor_data = get_base_data()

electric_system = Device:new()
electric_system:AddBool("AC_Generator_1")
electric_system:AddBool("AC_Generator_2")
electric_system:AddBool("Bat")

device:listen_command(Keys.PowerOnOff) --listen command needs to be here to work in set command
device:listen_command(device_commands.BatterySwitchClick)

device:listen_command(Keys.PowerGeneratorLeft) --listen command needs to be here to work in set command
device:listen_command(device_commands.GenLeftSwitch)

device:listen_command(Keys.PowerGeneratorRight) --listen command needs to be here to work in set command
device:listen_command(device_commands.GenRightSwitch)
------------------------------------------------------------------FUNCTION-POST-INIT---------------------------------------------------------------------------------------------------
function post_initialize()
	-- print_message_to_user("Electrical System Initialize")
    local birth = LockOn_Options.init_conditions.birth_place

    if birth == "GROUND_HOT" or birth == "AIR_HOT" then
        electric_system.Bat.Set(1)
        electric_system.AC_Generator_1.Set(1)
        electric_system.AC_Generator_2.Set(1)
    end
end
------------------------------------------------------------FUNCTION-SETCOMMAND---------------------------------------------------------------------------------------------------
function SetCommand(command,value)
    if command == Keys.PowerOnOff then
        --electric_system:invert_DC_Bat()
        electric_system.Bat:Invert()
    end

    if command == device_commands.BatterySwitchClick then
        dispatch_action(nil,Keys.PowerOnOff)-- this is used to push a keyboad/icommand with a mouse click
    end
    
    if command == Keys.PowerGeneratorLeft then
        electric_system.AC_Generator_1:Invert()
    end

    if command == device_commands.GenLeftSwitch then
        dispatch_action(nil,LeftGen)-- this is used to push a keyboad/icommand with a mouse click
    end

    if command == Keys.PowerGeneratorRight then
        electric_system.AC_Generator_2:Invert()
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
    PARAMETERS.BATTERY:set(electric_system.Bat:Get())--this will set the BATTERY param to the battery_state local variable # so 0 or 1
    PARAMETERS.ACGEN1:set(electric_system.AC_Generator_1:Get())
    PARAMETERS.ACGEN2:set(electric_system.AC_Generator_2:Get())

end --END UPDATE

need_to_be_closed = false 