dofile(LockOn_Options.script_path.."command_defs.lua")

local dev = GetSelf()


local update_time_step = 0.02
make_default_activity(update_time_step)

local BATTERY = get_param_handle("BATTERY")

function post_initialize()--Causes error
    -- HUD_FD_x:set(0)
    -- HUD_enable:set(1)
end

function SetCommand(command,value)

end

function update()
end