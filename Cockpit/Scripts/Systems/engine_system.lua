dofile(LockOn_Options.script_path.."devices.lua")
dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."device_class.lua")

local device = GetSelf()
local sensor_data = get_base_data()

local update_time_step = 0.005 --0.006
make_default_activity(update_time_step)

local PARAMETERS = 
{
    APU                     = get_param_handle("APU"),
    APU_IND                 = get_param_handle("APU_IND"),
    BOOST_L                 = get_param_handle("BOOST_L"),
    BOOST_R                 = get_param_handle("BOOST_R"),
    AIR_DRIVE               = get_param_handle("AIR_DRIVE"),
    ECS                     = get_param_handle("ECS"),
    COCK_L                  = get_param_handle("COCK_L"),
    COCK_R                  = get_param_handle("COCK_R"),
}

engine_system = Device:new()
engine_system:AddBool("BleedLeft")
engine_system:AddBool("BleedRight")
engine_system:AddBool("OilCooler")
engine_system:AddInt("OilTempLeft")
engine_system:AddInt("OilTempRight")
engine_system:AddBool("AerobaticsOilBasket")
engine_system:AddBool("OilPumpLeft")
engine_system:AddBool("OilPumpRight")
engine_system:AddInt("ThrottleLeft")
engine_system:AddInt("ThrottleRight")
engine_system:AddBool("APU")
engine_system:AddBool("APUStandby")
engine_system:AddBool("BoostLeft")
engine_system:AddBool("BoostRight")
engine_system:AddBool("Airdrive")
engine_system:AddBool("ECS")
engine_system:AddBool("CockLeft")
engine_system:AddBool("CockRight")

device:listen_command(rcover)
device:listen_command(lcover)
device:listen_command(lvalve)
device:listen_command(rvalve)
device:listen_command(apuon)
device:listen_command(apustandbyoff)
device:listen_command(ecs)
device:listen_command(airdrive)

------------------------------------------------------------------FUNCTION-POST-INIT---------------------------------------------------------------------------------------------------
function post_initialize()

    local birth = LockOn_Options.init_conditions.birth_place
    if birth == "GROUND_HOT" or birth == "AIR_HOT" then
        engine_system.BoostLeft:Set(1)
        engine_system.BoostRight:Set(1)
        engine_system.Airdrive:Set(1)
        engine_system.ECS:Set(1)
        engine_system.CockLeft:Set(1)
        engine_system.CockRight:Set(1)
    end
	
end
------------------------------------------------------------------FUNCTION-SETCOMMAND---------------------------------------------------------------------------------------------------
function SetCommand(command,value)

    

end
------------------------------------------------------------------FUNCTION-UPDATE---------------------------------------------------------------------------------------------------
function update()

    local current_throtte_l = sensor_data.getThrottleLeftPosition() * 100
    local current_throtte_r = sensor_data.getThrottleRightPosition() * 100

    local RPML = sensor_data.getEngineLeftRPM()
    local RPMR = sensor_data.getEngineRightRPM()

    local Engine_left_fuelconsumption  = sensor_data.getEngineLeftFuelConsumption()
    local Engine_right_fuelconsumption = sensor_data.getEngineRightFuelConsumption()

end