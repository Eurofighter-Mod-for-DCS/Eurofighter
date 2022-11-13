--Eurofighter Typhoon by Lechuzas Negras
mount_vfs_sound_path (current_mod_path.."/Sounds/")

--	=================== BK-27 CANNON ================================================================================
local function bk27_cannon(tbl)

    tbl.category = CAT_GUN_MOUNT
    tbl.name =  "bk_27"
    tbl.display_name =  _("BK-27 Cannon")
    tbl.supply      =
    {
        shells = {"BK_27_HE", "BK_27_AP", "BK_27_APHE", "BK_27_PELE", "BK_27_PELET"},
        mixes  = { {1,2,3},{4,4,4,4,5} },
        count  = 150, -- corrected amount
    }
    if tbl.mixes then
       tbl.supply.mixes = tbl.mixes
       tbl.mixes        = nil
    end
    tbl.gun =
    {
        max_burst_length    = 1700,
        rates               = {1700},
        recoil_coeff        = 0.7*1.3,
        barrels_count       = 1,
    }
    if tbl.rates then
       tbl.gun.rates        =  tbl.rates
       tbl.rates            = nil
    end

    tbl.ejector_pos             = tbl.ejector_pos or {0, 0, 0}
    tbl.ejector_pos_connector   = tbl.ejector_pos_connector     or  "Gun_point"
    tbl.ejector_dir             = tbl.ejector_dir or {0, 0, 0}
    tbl.supply_position         = tbl.supply_position   or {0,  0, 0}
    tbl.aft_gun_mount           = false
    tbl.effective_fire_distance = 2500
    tbl.drop_cartridge          = 203
    tbl.muzzle_pos              = tbl.muzzle_pos            or  {0,0,0}     -- all position from connector
    tbl.muzzle_pos_connector    = tbl.muzzle_pos_connector  or  "Gun_point" -- all position from connector
    tbl.azimuth_initial         = tbl.azimuth_initial       or  0
    tbl.elevation_initial       = tbl.elevation_initial     or  0
    tbl.smoke_dir               = tbl.smoke_dir             or  {0, 0, 0}
    if  tbl.effects == nil then
        tbl.effects = {{ name = "FireEffect", arg = tbl.effect_arg_number or 350 },{name = "SmokeEffect", smoke_exhaust = "PNT_GUN_SMOKE" , add_speed = {10,0,0}}}
    end
    return declare_weapon(tbl)
	
end


local function pylon(number, tp, x, y, z, params, wcs)
	local res = params;
	
	res.Number = number;
	res.Type = tp;
	res.X = x;
	res.Y = y;
	res.Z = z;
	res.Launchers = wcs or {};

	return res;
end

local function add_aircraft_prop()
    acprop = {
        { id = "LaserCode100", control = 'spinbox',  label = _('Laser code for ordnance, 1x11'), defValue = 6, min = 5, max = 7, dimension = ' ', playerOnly = true},
        { id = "LaserCode10",  control = 'spinbox',  label = _('Laser code for ordnance, 11x1'), defValue = 8, min = 1, max = 8, dimension = ' ', playerOnly = true},
        { id = "LaserCode1",   control = 'spinbox',  label = _('Laser code for ordnance, 111x'), defValue = 8, min = 1, max = 8, dimension = ' ', playerOnly = true},
    }

    return acprop
end

local mech_anime = make_default_mech_animation()
mech_anime["ServiceHatches"] = {
    {Transition = {"Close", "Open"}, Sequence = {{C = {{"PosType", 3}, {"Sleep", "for", 30.0}}}, {C = {{"Arg", 24, "set", 1.0}}}}},
    {Transition = {"Open", "Close"}, Sequence = {{C = {{"PosType", 6}, {"Sleep", "for", 5.0}}},  {C = {{"Arg", 24, "set", 0.0}}}}},
}

EurofighterT =  {
      
		Name 			=  	 'EurofighterT',
		DisplayName		= _('EurofighterT'),
        Picture 		= "Eurofighter.png",
        Rate 			= "50",
        Shape			= "EurofighterT",		
		WorldID			=  WSTYPE_PLACEHOLDER, 
		Cannon = "yes",
		-- HumanCockpit 		= true,
		-- HumanCockpitPath    = current_mod_path..'/Cockpit/Scripts/',
        
	shape_table_data 	= 
	{
		{
			file  	 	= 'EurofighterT';--AG
			life  	 	= 20; -- lifebar
			vis   	 	= 3; -- visibility gain.
			desrt    	= 'Eurofighter-oblomok'; -- Name of destroyed object file name
			fire  	 	= { 300, 2}; -- Fire on the ground after destoyed: 300sec 2m
			username	= 'EurofighterT';--AG
			index       =  WSTYPE_PLACEHOLDER;
			classname   = "lLandPlane";
			positioning = "BYNORMAL";
		},
		{
			name  		= "Eurofighter-oblomok";
			file  		= "Eurofighter-oblomok";
			fire  		= { 240, 2};
		},
	},

	net_animation ={
		13, -- right slat
        14, -- left slat
        0, -- front gear
        3, -- right gear
        5, -- left gear
        9, -- right flap
        10, -- left flap
        11, -- right aileron
        12, -- left aileron
        15, -- right elevator
        16, -- left elevator
        17, -- rudder
		18,
		19,

        2,  -- nose wheel steering
        21, -- SFM air brake
        25, -- tail hook
		35,
		36,
		37,
        38, -- canopy
        120, -- right spoiler
        123, -- left spoiler
        190, -- left (red) navigation wing-tip light
        191, -- right (green) navigation wing-tip light
        192, -- tail (white) light

        198, -- anticollision (flashing red) top light
        199, -- anticollision (flashing red) bottom light
        208, -- taxi light (white) right main gear door
        402, -- huffer
        500, -- model air brake
        501, -- RAT
        499, -- wheel chocks
		117, -- stabilizer

		600,
		1049,
		1050,
		1053,
		1054,
		

    },
	
	LandRWCategories = 
        {
        [1] = 
        {
			Name = "AircraftCarrier",
        },
        [2] = 
        {
            Name = "AircraftCarrier With Catapult",
        }, 
        [3] = 
        {
            Name = "AircraftCarrier With Tramplin",
        }, 
    }, -- end of LandRWCategories
        TakeOffRWCategories = 
        {
        [1] = 
        {
			Name = "AircraftCarrier",
        },
        [2] = 
        {
            Name = "AircraftCarrier With Catapult",
        }, 
        [3] = 
        {
            Name = "AircraftCarrier With Tramplin",
        }, 
    }, -- end of TakeOffRWCategories
	
	mapclasskey 		= "P0091000024",
	attribute  			= {wsType_Air, wsType_Airplane, wsType_Fighter, WSTYPE_PLACEHOLDER, "Fighters", "Refuelable",},--AG
	Categories= {"{78EFB7A2-FD52-4b57-A6A6-3BF0E1D6555F}", "Interceptor",},
	
		M_empty						=	11000,	-- kg  with pilot and nose load, F15
		M_nominal					=	16500,	-- kg (Empty Plus Full Internal Fuel)
		M_max						=	23500,	-- kg (Maximum Take Off Weight)
		M_fuel_max					=	4996,	-- kg (Internal Fuel Only)
		H_max						=	18300,	-- m  (Maximum Operational Ceiling)
		average_fuel_consumption	=	0.0001,   -- Kg/h? Kg/s?
		CAS_min						=	61,		-- Minimum CAS speed (m/s) (for AI)
		V_opt						=	220,	-- Cruise speed (m/s) (for AI)
		V_take_off					=	66,		-- Take off speed in m/s (for AI)
		V_land						=	74,		-- Land speed in m/s (for AI)
		has_afteburner				=	true,
		has_speedbrake				=	true,
		radar_can_see_ground		=	true,

		nose_gear_pos 				                = {4.59,	-2.150,	0},   -- nosegear coord 
	    nose_gear_amortizer_direct_stroke   		=  0,      -- down from nose_gear_pos !!!
	    nose_gear_amortizer_reversal_stroke  		=  -0.43,  -- up 
	    nose_gear_amortizer_normal_weight_stroke 	=  -0.215,   -- up 
	    nose_gear_wheel_diameter 	                =  0.754,  -- in m
	
	    main_gear_pos 						 	    = {-0.8,	-2.000,	1.425}, -- main gear coords 
	    main_gear_amortizer_direct_stroke	 	    =   0,     --  down from main_gear_pos !!!
	    main_gear_amortizer_reversal_stroke  	    =   -0.228, --  up 
	    main_gear_amortizer_normal_weight_stroke    =   -0.114,-- down from main_gear_pos
	    main_gear_wheel_diameter 				    =   0.972, --  in m

		AOA_take_off				=	0.16,	-- AoA in take off (for AI)
		stores_number				=	13,
		bank_angle_max				=	90,		-- Max bank angle (for AI)
		Ny_min						=	-3,		-- Min G (for AI)
		Ny_max						=	10,		-- Max G (for AI)
		V_max_sea_level				=	540,	-- Max speed at sea level in m/s (for AI)
		V_max_h						=	736.11,	-- Max speed at max altitude in m/s (for AI)
		wing_area					=	50,	-- wing area in m2
		thrust_sum_max				=	18347,	-- thrust in kgf (60.0 kN)
		thrust_sum_ab				=	27952,	-- thrust in kgf (90.0 kN)
		Vy_max						=	275,	-- Max climb speed in m/s (for AI)
		flaps_maneuver				=	1,
		Mach_max					=	2,	-- Max speed in Mach (for AI)
		range						=	2540,	-- Max range in km (for AI)
		RCS							=	1,		-- Radar Cross Section m2
		Ny_max_e					=	9,		-- Max G (for AI)
		detection_range_max			=	500,
		IR_emission_coeff			=	0.91,	-- Normal engine -- IR_emission_coeff = 1 is Su-27 without afterburner. It is reference.
		IR_emission_coeff_ab		=	4,		-- With afterburner
		tand_gear_max				=	3.73,--XX  1.732 FA18 3.73, 
		tanker_type					=	2,-- F14=2/S33=4/M29=0/S27=0/F15=1/F16=1/To=0/F18=2/A10A=1/M29K=4/M2000=2/F4=0/F5=0/
		wing_span					=	10.95,
		wing_type 					= 	0,-- FIXED_WING = 0/VARIABLE_GEOMETRY = 1/FOLDED_WING = 2/ARIABLE_GEOMETRY_FOLDED = 3
		length						=	15.96,
		height						=	5.29,
		crew_size					=	1,
		engines_count				=	2,
		wing_tip_pos 				= 	{-4.466,	0.0,	5.707},
		engines_nozzles = 
		{
			[1] = 
			{
				pos = 	{-4.549,	0.468,	-0.001},---6.051,	-0.347,	-0.705
				elevation	=	0.0,
				diameter	=	1.1,
				exhaust_length_ab	= 8,
				exhaust_length_ab_K	= 0.707,
				smokiness_level     = 	0.01, 
				-- afterburner_effect_texture = "VSN_EF_Nachbrenner",
				afterburner_circles_count = 7,
				afterburner_circles_pos = {0.2, 0.8},
				afterburner_circles_scale = 0.95,
			}, -- end of [1]
			[2] = 
			{
				pos = 	{-4.549,	-0.468,	-0.001},
				elevation	=	0.0,
				diameter	=	1.1,
				exhaust_length_ab	= 8,
				exhaust_length_ab_K	= 0.707, 
				smokiness_level     = 	0.01, 
				-- afterburner_effect_texture = "VSN_EF_Nachbrenner",
				afterburner_circles_count = 7,
				afterburner_circles_pos = {0.2, 0.8},
				afterburner_circles_scale = 0.95,
			}, -- end of [2]
		}, -- end of engines_nozzles
		crew_members = 
		{
			[1] = 
			{
                ejection_seat_name    =    9,
                drop_canopy_name    =    "vsn_eurofighter_fonar",
                pos =  {4.750,	1.42,	0},
                canopy_pos = {4.5,    1,    0},
                ejection_order         = 1,
                canopy_arg          = 38, 
                can_be_playable     = true,
                ejection_added_speed = {-5,15,0},
                role                  = "pilot",
                role_display_name    = _("Pilot"),
            }, -- end of [1]
            [2] = 
            {
            },-- end of [2]
		}, -- end of crew_members
		brakeshute_name	=	4,
		is_tanker	=	false,
		air_refuel_receptacle_pos = 	{8.35,	1.37,	1.42},--{1.512,	0.805,	0},
		fires_pos = 
		{
			[1] = 	{-1.842,	0.563,	0},
			[2] = 	{-1.644,	0.481,	2.87},
			[3] = 	{-1.389,	0.461,	-3.232},
			[4] = 	{-0.82,	0.265,	2.774},
			[5] = 	{-0.82,	0.265,	-2.774},
			[6] = 	{-0.82,	0.255,	4.274},
			[7] = 	{-0.82,	0.255,	-4.274},
			[8] = 	{-5.753,	0.06,	0.705},
			[9] = 	{-5.753,	0.06,	-0.705},
			[10] = 	{-0.992,	0.85,	0},
			[11] = 	{-1.683,	0.507,	-2.91},
		}, -- end of fires_pos
		
		effects_presets = {
			{effect = "OVERWING_VAPOR", file = current_mod_path.."/Effects/VSN_EF_overwingVapor.lua"},
			-- {effect = "VAPOR_CONE"    , file = current_mod_path.."/Effects/VSN_EF_Vapor_Cone.lua", preset = "VSNEF_VAPOR_CONE",},
		},

        -- Countermeasures
	passivCounterm 		= {
		CMDS_Edit 			= true,
		SingleChargeTotal 	= 356,
		chaff 				= {default = 320, increment = 1, chargeSz = 1},
		flare 				= {default = 32,  increment = 1, chargeSz = 1},
	},
		
		chaff_flare_dispenser 	= {
			{ dir =  {0, -1,  0}, pos =  {-1.949,  -0.538, -2.029}, }, -- Flares L	
			{ dir =  {0, -1,  0}, pos =  {-1.962,  -0.538,  2.035}, }, -- Flares R
			-- { dir =  {0, -1,  0}, pos =  {-3.415,  -0.307, -4.523}, }, -- Chaff L
			-- { dir =  {0, -1,  0}, pos =  {-3.415,  -0.307,  4.523}, }, -- Chaff R
		},

CanopyGeometry 	= {
	azimuth 	= {-165.0, 165.0},-- pilot view horizontal (AI)
	elevation 	= {-20.0, 120.0}-- pilot view vertical (AI)
},

Sensors = {
	detection_range_max		 = 350,               
	radar_can_see_ground 	 = true,  
	RADAR = "Shmel",
	--RADAR = "Byelka Radar", 
	IRST = "OLS-27",
	RWR 			= "Abstract RWR"--F15
},
Countermeasures = {
ECM 			= "AN/ALQ-135"--F15
},
Failures = {
		{ id = 'asc', 		label = _('ASC'), 		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'autopilot', label = _('AUTOPILOT'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'hydro',  	label = _('HYDRO'), 	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'l_engine',  label = _('L-ENGINE'), 	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'r_engine',  label = _('R-ENGINE'), 	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'radar',  	label = _('RADAR'), 	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
--			{ id = 'eos',  		label = _('EOS'), 		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
--			{ id = 'helmet',  	label = _('HELMET'), 	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'mlws',  	label = _('MLWS'), 		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'rws',  		label = _('RWS'), 		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'ecm',   	label = _('ECM'), 		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'hud',  		label = _('HUD'), 		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'mfd',  		label = _('MFD'), 		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },		
},
HumanRadio = {
	frequency 		= 127.5,  -- Radio Freq
	editable 		= true,
	minFrequency	= 100.000,
	maxFrequency 	= 156.000,
	modulation 		= MODULATION_AM
},

Guns = {
	bk27_cannon({muzzle_pos_connector   = "Gun_point",
		supply_position        = {2.6, -0.4, 0.0},
		-- drop_cartridge         = 204,
		ejector_pos_connector  = "Gun_point",
		ejector_dir            = {2,-2,0},
		elevation_initial = 0.0,
		-- elevation_initial = -1.50,
	}),
	
},

ammo_type_default = 2,
ammo_type ={
	_("HE/AP/APHE"),
	_("PELE/PELE-T"),	
},

pylons_enumeration = {1, 13, 12, 11, 2, 3, 4, 10, 5, 6, 9, 8, 7},

	Pylons =	{

		pylon(1, 0, -2.15, 0.395, -6.405,
			{
				use_full_connector_position = true,
				connector 	  = "Pylon1",
				DisplayName   = "1",
				arg 	  	  = 308,
				arg_increment = 0.0,
			},
			{
				{ CLSID = "{irist}" },
				{ CLSID = "{aim132}" },
				{ CLSID = "{6CEB49FC-DED8-4DED-B053-E1F033FF72D3}" }, --AIM-9M
				{ CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E741}"},        --Smoke Generator - red
				{ CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E742}"},        --Smoke Generator - green
				{ CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E743}"},        --Smoke Generator - blue
				{ CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E744}"},        --Smoke Generator - white
				{ CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E745}"},    --Smoke Generator - yellow
				{ CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E746}"},    --Smoke Generator - orange				
				{ CLSID = "{AIS_ASQ_T50}" ,arg_increment = -0.1, attach_point_position = {0.30,  0.0,  0.0}},			-- ACMI pod
				{ CLSID = "<CLEAN>"									,arg_increment = 1},
			}
		),
		pylon(2, 0, -1.87, 0.075, -4.27,
			{
				use_full_connector_position = true,
				connector 	  = "Pylon3",
				DisplayName   = "2",
				arg 	  	  = 310,
				arg_increment = 0.0,
			},
			{
				--Bombs
				{ CLSID = "{DB769D48-67D7-42ED-A2BE-108D566C8B1E}" },	-- GBU-12 
				{ CLSID = "{BRU33_2X_GBU-12}" },						-- GBU-12 X2
				{ CLSID = "{BRU-42_3*GBU-12}" },						-- GBU-12 X3
				{ CLSID = "{51F9AAE5-964F-4D21-83FB-502E3BFE5F8A}" },	-- GBU-10	
				{ CLSID = "{0D33DDAE-524F-4A4E-B5B8-621754FE3ADE}" },	-- GBU-16	
				{ CLSID = "{34759BBC-AF1E-4AEE-A581-498FF7A6EBCE}" },   -- GBU-24
				{ CLSID = "{BCE4E030-38E9-423E-98ED-24BE3DA87C32}" },   -- MK-82
				{ CLSID = "{7A44FF09-527C-4B7E-B42B-3F111CFE50FB}" },   -- MK-83
				{ CLSID = "{BRU33_2X_MK-82}" },						 	-- MK-82 X2
				{ CLSID = "{BRU33_2X_MK-82_Snakeye}" },				 	-- MK-82 SNAKEAYE X2
				{ CLSID = "{BRU33_2X_MK-82Y}" },						-- MK-82 Y X2
				{ CLSID = "{BRU33_2X_MK-83}" },						 	-- MK-83 X2
				{ CLSID = "{60CC734F-0AFA-4E2E-82B8-93B941AB11CF}" },	-- MK-82 X3
				{ CLSID = "{BRU-42_3*Mk-82SNAKEYE}" }, 					-- MK-82 SNAKEAYE X3
				{ CLSID = "{BRU-42_3*Mk-82AIR}" }, 						-- MK-82 AIR X3
				{ CLSID = "{GBU-31}" }, 								-- GBU-31 JDAM
				{ CLSID = "{GBU-38}" }, 								-- GBU-31 JDAM
				-- { CLSID = "{BK90}" },   -- BK90
				-- { CLSID = "{BK90MJ1}" },   -- BK90
				-- { CLSID = "{EF_BK90MJ2}" },   -- BK90
				--AGM
				{ CLSID = "{B06DD79A-F21E-4EB9-BD9D-AB3844618C9C}" },   -- HARM
				{ CLSID = "{E6747967-B1F0-4C77-977B-AB2E6EB0C102}" },   -- ALARM
				-- { CLSID = "{brimstone}" },
				--AAMissiles
				{ CLSID = "{40EF17B7-F508-45de-8566-6FFECC0C1AB8}" }, 	--AIM-120C
				{ CLSID = "{irist}" },
				{ CLSID = "{aim132}" },
				{ CLSID = "{6CEB49FC-DED8-4DED-B053-E1F033FF72D3}" }, --AIM-9M
				{ CLSID = "{Meteor}" },
				{ CLSID = "<CLEAN>"	,arg_increment = 1},
				--AntiShip
				{ CLSID = "{EF_AGM_84}" },					--RB15
			}
		),
		pylon(3, 0, -1.22, -0.074, -3.325,
			{
				use_full_connector_position = true,
				connector 	  = "Pylon2",
				DisplayName   = "3",
				arg 	  	  = 309,
				arg_increment = 0.0,
			},
			{
				{ CLSID = "{EF_FuelTank_1000L}" ,arg_increment = 0.0,Cx_gain = 1/2.2},
				--Bombs
				{ CLSID = "{DB769D48-67D7-42ED-A2BE-108D566C8B1E}" },	-- GBU-12 
				{ CLSID = "{BRU33_2X_GBU-12}" },						-- GBU-12 X2
				{ CLSID = "{BRU-42_3*GBU-12}" },						-- GBU-12 X3
				{ CLSID = "{51F9AAE5-964F-4D21-83FB-502E3BFE5F8A}" },	-- GBU-10	
				{ CLSID = "{0D33DDAE-524F-4A4E-B5B8-621754FE3ADE}" },	-- GBU-16	
				{ CLSID = "{34759BBC-AF1E-4AEE-A581-498FF7A6EBCE}" },   -- GBU-24
				{ CLSID = "{BCE4E030-38E9-423E-98ED-24BE3DA87C32}" },   -- MK-82
				{ CLSID = "{7A44FF09-527C-4B7E-B42B-3F111CFE50FB}" },   -- MK-83
				{ CLSID = "{BRU33_2X_MK-82}" },						 	-- MK-82 X2
				{ CLSID = "{BRU33_2X_MK-82_Snakeye}" },				 	-- MK-82 SNAKEAYE X2
				{ CLSID = "{BRU33_2X_MK-82Y}" },						-- MK-82 Y X2
				{ CLSID = "{BRU33_2X_MK-83}" },						 	-- MK-83 X2
				{ CLSID = "{60CC734F-0AFA-4E2E-82B8-93B941AB11CF}" },	-- MK-82 X3
				{ CLSID = "{BRU-42_3*Mk-82SNAKEYE}" }, 					-- MK-82 SNAKEAYE X3
				{ CLSID = "{BRU-42_3*Mk-82AIR}" }, 						-- MK-82 AIR X3
				{ CLSID = "{GBU-31}" }, 								-- GBU-31 JDAM
				{ CLSID = "{GBU-38}" }, 								-- GBU-31 JDAM
				-- { CLSID = "{BK90}" },   -- BK90
				-- { CLSID = "{BK90MJ1}" },   -- BK90
				-- { CLSID = "{BK90MJ2}" },   -- BK90
				--AGM
				{ CLSID = "{B06DD79A-F21E-4EB9-BD9D-AB3844618C9C}" },   -- HARM
				{ CLSID = "{E6747967-B1F0-4C77-977B-AB2E6EB0C102}" },   -- ALARM
				-- { CLSID = "{brimstone}" },
				--AAMissiles
				{ CLSID = "{40EF17B7-F508-45de-8566-6FFECC0C1AB8}" }, 	--AIM-120C
				{ CLSID = "{irist}" },
				{ CLSID = "{aim132}" },
				{ CLSID = "{6CEB49FC-DED8-4DED-B053-E1F033FF72D3}" }, --AIM-9M
				{ CLSID = "{Meteor}" },
				{ CLSID = "<CLEAN>"	,arg_increment = 1},
				--AntiShip
				{ CLSID = "{EF_AGM_84}" },					
				-- { CLSID = "{EF_rb15_antiship}" },					--RB15
			}
		),
		pylon(4, 0, -1.22, -0.074, -3.325,
			{
				use_full_connector_position = true,
				connector 	  = "Pylon4.2",
				DisplayName   = "4",
				arg 	  	  = 311,
				arg_increment = 0.0,
			},
			{
				--Bombs
				{ CLSID = "{DB769D48-67D7-42ED-A2BE-108D566C8B1E}" },	-- GBU-12 
				{ CLSID = "{BRU33_2X_GBU-12}" },						-- GBU-12 X2
				{ CLSID = "{BRU-42_3*GBU-12}" },						-- GBU-12 X3
				{ CLSID = "{51F9AAE5-964F-4D21-83FB-502E3BFE5F8A}" },	-- GBU-10	
				{ CLSID = "{0D33DDAE-524F-4A4E-B5B8-621754FE3ADE}" },	-- GBU-16	
				{ CLSID = "{34759BBC-AF1E-4AEE-A581-498FF7A6EBCE}" },   -- GBU-24
				{ CLSID = "{BCE4E030-38E9-423E-98ED-24BE3DA87C32}" },   -- MK-82
				{ CLSID = "{7A44FF09-527C-4B7E-B42B-3F111CFE50FB}" },   -- MK-83
				{ CLSID = "{BRU33_2X_MK-82}" },						 	-- MK-82 X2
				{ CLSID = "{BRU33_2X_MK-82_Snakeye}" },				 	-- MK-82 SNAKEAYE X2
				{ CLSID = "{BRU33_2X_MK-82Y}" },						-- MK-82 Y X2
				{ CLSID = "{BRU33_2X_MK-83}" },						 	-- MK-83 X2
				{ CLSID = "{60CC734F-0AFA-4E2E-82B8-93B941AB11CF}" },	-- MK-82 X3
				{ CLSID = "{BRU-42_3*Mk-82SNAKEYE}" }, 					-- MK-82 SNAKEAYE X3
				{ CLSID = "{BRU-42_3*Mk-82AIR}" }, 						-- MK-82 AIR X3
				{ CLSID = "{GBU-31}" }, 								-- GBU-31 JDAM
				{ CLSID = "{GBU-38}" }, 								-- GBU-31 JDAM
				-- { CLSID = "{BK90}" },   -- BK90
				-- { CLSID = "{BK90MJ1}" },   -- BK90
				-- { CLSID = "{BK90MJ2}" },   -- BK90
				--AGM
				{ CLSID = "{B06DD79A-F21E-4EB9-BD9D-AB3844618C9C}" },   -- HARM
				{ CLSID = "{E6747967-B1F0-4C77-977B-AB2E6EB0C102}" },   -- ALARM
				-- { CLSID = "{brimstone}" },
				--AAMissiles
				{ CLSID = "<CLEAN>"	,arg_increment = 1},
				--AntiShip
				{ CLSID = "{EF_AGM_84}" },					
				-- { CLSID = "{EF_rb15_antiship}" },					--RB15
			}
		),
		pylon(5, 1, -0.77, -0.066, -2.297,
			{
				use_full_connector_position = true,
				connector 	  = "Pylon4",-- Doppelfunktion  Arg.0.0 und Arg. 0.80 f�r Bomben
				DisplayName   = "5",
				-- arg 	  	  = 311,
				-- arg_increment = 1,
			},
			{
				{ CLSID = "{40EF17B7-F508-45de-8566-6FFECC0C1AB8}" }, -- AIM-120C
				{ CLSID = "{Meteor}" },
				{ CLSID = "{aim132}" },	
				--{ CLSID = "{AAQ-28_LEFT}",arg_increment = 0.6},	--Litening
			}
		),
		pylon(6, 1, -2.47, -0.45, -1.165,--2.47, -0.5, -1.215
			{
				use_full_connector_position = true,
				connector 	  = "Pylon5",
				DisplayName   = "6",
			},
			{
				{ CLSID = "{40EF17B7-F508-45de-8566-6FFECC0C1AB8}" }, -- AIM-120C
				{ CLSID = "{Meteor}" },
				{ CLSID = "{aim132}" },
			}
		),
		pylon(7, 1,  0.93, -0.466, 0,
			{
				use_full_connector_position = true,
				connector 	  = "Pylon6",
				DisplayName   = "C",
				arg 	  	  = 313,
				arg_value     = 0.0,
			},
			{
				{ CLSID = "{EF_FuelTank_1000L}" ,arg_increment = 0.0,Cx_gain = 1/2.2},
				{ CLSID = "{51F9AAE5-964F-4D21-83FB-502E3BFE5F8A}" }, -- GBU-10	
				{ CLSID = "{0D33DDAE-524F-4A4E-B5B8-621754FE3ADE}" }, -- GBU-16	
				{ CLSID = "{34759BBC-AF1E-4AEE-A581-498FF7A6EBCE}" }, -- GBU-24
				{ CLSID = "{GBU-31}" }, -- GBU-38 JDAM
				{ CLSID = "{BRU-42_3*Mk-83}" }, -- MK- 83
				{ CLSID = "{60CC734F-0AFA-4E2E-82B8-93B941AB11CF}" }, -- MK- 82 X3
				{ CLSID = "{BRU-42_3*Mk-82SNAKEYE}" }, -- MK-82 SNAKEAYE X3
				{ CLSID = "{BRU-42_3*Mk-82AIR}" }, -- MK-82 AIR X3
				{ CLSID = "{5335D97A-35A5-4643-9D9B-026C75961E52}" }, -- CBU-97
				{ CLSID = "{CBU-87}" }, -- CBU-87
				{ CLSID = "{AAQ-28_LEFT}"},	--Litening	
				{ CLSID = "<CLEAN>"									,arg_increment = 1},
			}
		),
		pylon(8, 1, 2.47, -0.45, 1.165,--2.47, -0.5, 1.215
			{
				use_full_connector_position = true,
				connector 	  = "Pylon7",
				DisplayName   = "8",
			},
			{
				{ CLSID = "{40EF17B7-F508-45de-8566-6FFECC0C1AB8}" }, -- AIM-120C
				{ CLSID = "{Meteor}" },
				{ CLSID = "{aim132}" },	
			}
		),
		pylon(9, 1,  -0.77, -0.066, 2.297,
			{
				use_full_connector_position = true,
				connector 	  = "Pylon8",-- Doppelfunktion  Arg.0.0 und Arg. 0.80 f�r Bomben
				DisplayName   = "9",
				-- arg 	  	  = 315,
				-- arg_increment = 1,
			},
			{
				{ CLSID = "{40EF17B7-F508-45de-8566-6FFECC0C1AB8}" }, -- AIM-120C
				{ CLSID = "{Meteor}" },
				{ CLSID = "{aim132}" },	
				--{ CLSID = "{AAQ-28_LEFT}",arg_increment = 0.6},	--Litening
			}
		),
		pylon(10, 0, -1.22, -0.074, -3.325,
			{
				use_full_connector_position = true,
				connector 	  = "Pylon8.2",
				DisplayName   = "10",
				arg 	  	  = 315,
				arg_increment = 0.0,
			},
			{
				--Bombs
				{ CLSID = "{DB769D48-67D7-42ED-A2BE-108D566C8B1E}" },	-- GBU-12 
				{ CLSID = "{BRU33_2X_GBU-12}" },						-- GBU-12 X2
				{ CLSID = "{BRU-42_3*GBU-12}" },						-- GBU-12 X3
				{ CLSID = "{51F9AAE5-964F-4D21-83FB-502E3BFE5F8A}" },	-- GBU-10	
				{ CLSID = "{0D33DDAE-524F-4A4E-B5B8-621754FE3ADE}" },	-- GBU-16	
				{ CLSID = "{34759BBC-AF1E-4AEE-A581-498FF7A6EBCE}" },   -- GBU-24
				{ CLSID = "{BCE4E030-38E9-423E-98ED-24BE3DA87C32}" },   -- MK-82
				{ CLSID = "{7A44FF09-527C-4B7E-B42B-3F111CFE50FB}" },   -- MK-83
				{ CLSID = "{BRU33_2X_MK-82}" },						 	-- MK-82 X2
				{ CLSID = "{BRU33_2X_MK-82_Snakeye}" },				 	-- MK-82 SNAKEAYE X2
				{ CLSID = "{BRU33_2X_MK-82Y}" },						-- MK-82 Y X2
				{ CLSID = "{BRU33_2X_MK-83}" },						 	-- MK-83 X2
				{ CLSID = "{60CC734F-0AFA-4E2E-82B8-93B941AB11CF}" },	-- MK-82 X3
				{ CLSID = "{BRU-42_3*Mk-82SNAKEYE}" }, 					-- MK-82 SNAKEAYE X3
				{ CLSID = "{BRU-42_3*Mk-82AIR}" }, 						-- MK-82 AIR X3
				{ CLSID = "{GBU-31}" }, 								-- GBU-31 JDAM
				{ CLSID = "{GBU-38}" }, 								-- GBU-31 JDAM
				-- { CLSID = "{BK90}" },   -- BK90
				-- { CLSID = "{BK90MJ1}" },   -- BK90
				-- { CLSID = "{BK90MJ2}" },   -- BK90
				--AGM
				{ CLSID = "{B06DD79A-F21E-4EB9-BD9D-AB3844618C9C}" },   -- HARM
				{ CLSID = "{E6747967-B1F0-4C77-977B-AB2E6EB0C102}" },   -- ALARM
				-- { CLSID = "{brimstone}" },
				--AAMissiles
				{ CLSID = "<CLEAN>"	,arg_increment = 1},
				--AntiShip
				{ CLSID = "{EF_AGM_84}" },					
				-- { CLSID = "{EF_rb15_antiship}" },					--RB15
			}
		),
		pylon(11, 0, -1.22, -0.074, 3.325, 
			{
				use_full_connector_position = true,
				connector 	  = "Pylon10",
				DisplayName   = "11",
				arg 	      = 317,
				arg_increment = 0.0,
			},
			{
				{ CLSID = "{EF_FuelTank_1000L}" ,arg_increment = 0.0,Cx_gain = 1/2.2},
				--Bombs
				{ CLSID = "{DB769D48-67D7-42ED-A2BE-108D566C8B1E}" },	-- GBU-12 
				{ CLSID = "{BRU33_2X_GBU-12}" },						-- GBU-12 X2
				{ CLSID = "{BRU-42_3*GBU-12}" },						-- GBU-12 X3
				{ CLSID = "{51F9AAE5-964F-4D21-83FB-502E3BFE5F8A}" },	-- GBU-10	
				{ CLSID = "{0D33DDAE-524F-4A4E-B5B8-621754FE3ADE}" },	-- GBU-16	
				{ CLSID = "{34759BBC-AF1E-4AEE-A581-498FF7A6EBCE}" },   -- GBU-24
				{ CLSID = "{BCE4E030-38E9-423E-98ED-24BE3DA87C32}" },   -- MK-82
				{ CLSID = "{7A44FF09-527C-4B7E-B42B-3F111CFE50FB}" },   -- MK-83
				{ CLSID = "{BRU33_2X_MK-82}" },						 	-- MK-82 X2
				{ CLSID = "{BRU33_2X_MK-82_Snakeye}" },				 	-- MK-82 SNAKEAYE X2
				{ CLSID = "{BRU33_2X_MK-82Y}" },						-- MK-82 Y X2
				{ CLSID = "{BRU33_2X_MK-83}" },						 	-- MK-83 X2
				{ CLSID = "{60CC734F-0AFA-4E2E-82B8-93B941AB11CF}" },	-- MK-82 X3
				{ CLSID = "{BRU-42_3*Mk-82SNAKEYE}" }, 					-- MK-82 SNAKEAYE X3
				{ CLSID = "{BRU-42_3*Mk-82AIR}" }, 						-- MK-82 AIR X3
				{ CLSID = "{GBU-31}" }, 								-- GBU-31 JDAM
				{ CLSID = "{GBU-38}" }, 								-- GBU-31 JDAM
				-- { CLSID = "{BK90}" },   -- BK90
				-- { CLSID = "{BK90MJ1}" },   -- BK90
				-- { CLSID = "{BK90MJ2}" },   -- BK90
				--AGM
				{ CLSID = "{B06DD79A-F21E-4EB9-BD9D-AB3844618C9C}" },   -- HARM
				{ CLSID = "{E6747967-B1F0-4C77-977B-AB2E6EB0C102}" },   -- ALARM
				-- { CLSID = "{brimstone}" },
				--AAMissiles
				{ CLSID = "{40EF17B7-F508-45de-8566-6FFECC0C1AB8}" }, 	--AIM-120C
				{ CLSID = "{irist}" },
				{ CLSID = "{aim132}" },
				{ CLSID = "{6CEB49FC-DED8-4DED-B053-E1F033FF72D3}" }, --AIM-9M
				{ CLSID = "{Meteor}" },
				{ CLSID = "<CLEAN>"	,arg_increment = 1},
				--AntiShip
				{ CLSID = "{EF_AGM_84}" },					
				-- { CLSID = "{EF_rb15_antiship}" },					--RB15
			}
		),
		pylon(12, 0, -1.87, 0.075, 4.27,
			{
				use_full_connector_position = true,
				connector 	  = "Pylon9",
				DisplayName   = "12",
				arg 	      = 316,
				arg_increment = 0.0,
			},
			{
				--Bombs
				{ CLSID = "{DB769D48-67D7-42ED-A2BE-108D566C8B1E}" },	-- GBU-12 
				{ CLSID = "{BRU33_2X_GBU-12}" },						-- GBU-12 X2
				{ CLSID = "{BRU-42_3*GBU-12}" },						-- GBU-12 X3
				{ CLSID = "{51F9AAE5-964F-4D21-83FB-502E3BFE5F8A}" },	-- GBU-10	
				{ CLSID = "{0D33DDAE-524F-4A4E-B5B8-621754FE3ADE}" },	-- GBU-16	
				{ CLSID = "{34759BBC-AF1E-4AEE-A581-498FF7A6EBCE}" },   -- GBU-24
				{ CLSID = "{BCE4E030-38E9-423E-98ED-24BE3DA87C32}" },   -- MK-82
				{ CLSID = "{7A44FF09-527C-4B7E-B42B-3F111CFE50FB}" },   -- MK-83
				{ CLSID = "{BRU33_2X_MK-82}" },						 	-- MK-82 X2
				{ CLSID = "{BRU33_2X_MK-82_Snakeye}" },				 	-- MK-82 SNAKEAYE X2
				{ CLSID = "{BRU33_2X_MK-82Y}" },						-- MK-82 Y X2
				{ CLSID = "{BRU33_2X_MK-83}" },						 	-- MK-83 X2
				{ CLSID = "{60CC734F-0AFA-4E2E-82B8-93B941AB11CF}" },	-- MK-82 X3
				{ CLSID = "{BRU-42_3*Mk-82SNAKEYE}" }, 					-- MK-82 SNAKEAYE X3
				{ CLSID = "{BRU-42_3*Mk-82AIR}" }, 						-- MK-82 AIR X3
				{ CLSID = "{GBU-31}" }, 								-- GBU-31 JDAM
				{ CLSID = "{GBU-38}" }, 								-- GBU-31 JDAM
				-- { CLSID = "{BK90}" },   -- BK90
				-- { CLSID = "{BK90MJ1}" },   -- BK90
				-- { CLSID = "{BK90MJ2}" },   -- BK90
				--AGM
				{ CLSID = "{B06DD79A-F21E-4EB9-BD9D-AB3844618C9C}" },   -- HARM
				{ CLSID = "{E6747967-B1F0-4C77-977B-AB2E6EB0C102}" },   -- ALARM
				-- { CLSID = "{brimstone}" },
				--AAMissiles
				{ CLSID = "{40EF17B7-F508-45de-8566-6FFECC0C1AB8}" }, 	--AIM-120C
				{ CLSID = "{irist}" },
				{ CLSID = "{aim132}" },
				{ CLSID = "{6CEB49FC-DED8-4DED-B053-E1F033FF72D3}" }, --AIM-9M
				{ CLSID = "{Meteor}" },
				{ CLSID = "<CLEAN>"	,arg_increment = 1},
				--AntiShip
				{ CLSID = "{EF_AGM_84}" },					
				-- { CLSID = "{EF_rb15_antiship}" },					--RB15
			}
		),
		pylon(13, 0, -2.15, 0.395, 6.405,--2.15, 0.475, 6.455
			{
				use_full_connector_position = true,
				connector 	  = "Pylon11",
				DisplayName   = "13",
				arg 	 	  = 318,
				arg_increment = 0.0,
			},
			{
				{ CLSID = "{irist}" },
				{ CLSID = "{aim132}" },
				{ CLSID = "{6CEB49FC-DED8-4DED-B053-E1F033FF72D3}" }, --AIM-9M
				{ CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E741}"},        --Smoke Generator - red
				{ CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E742}"},        --Smoke Generator - green
				{ CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E743}"},        --Smoke Generator - blue
				{ CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E744}"},        --Smoke Generator - white
				{ CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E745}"},    --Smoke Generator - yellow
				{ CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E746}"},    --Smoke Generator - orange
				{ CLSID = "<CLEAN>"									,arg_increment = 1},
			
			}
		),
	},


	Tasks = {
        aircraft_task(CAP),
     	aircraft_task(Escort),
      	aircraft_task(FighterSweep),
		aircraft_task(Intercept),
		aircraft_task(Reconnaissance),
    	aircraft_task(GroundAttack),
     	aircraft_task(CAS),
        aircraft_task(AFAC),
		aircraft_task(SEAD),
	    aircraft_task(RunwayAttack),
    	aircraft_task(AntishipStrike),
    },	
	DefaultTask = aircraft_task(CAP),
	SFM_Data = {
		aerodynamics = --Eurofighter
			{
				Cy0	=	0,
				Mzalfa	=	8, --pitch surface deflection. If = 0 tjhen no pitch input exist
				Mzalfadt	=	0.8, --0.8 too high values make the aircraft shake and underperform
				kjx = 3.0,
				kjz = 0.00125,
				Czbe = -0.05,  ---0.016,  .25 IS STRONG
				cx_gear = 0.005,
				cx_flap = 0.05,
				cy_flap = 0.1,
				cx_brk = 0.08,
				table_data = 
				{
				--    		M	     CDmin		 CL		      K		 	K2	    	Omxmax		Aldop		CLmax 			 Alfadop = the aoa at wich control surfaces stop working
				[1]  = { 0.0,	    0.02435,	 0.065,		0.1,		0.032,		2.20,	    30.0,	    2.10,	},
				[2]  = { 0.1,	    0.02438,	 0.068,		0.1,		0.032,		2.44,	    30.0,	    2.10,	},
				[3]  = { 0.2,	    0.02448,	 0.070,		0.1,		0.032,		2.66,	    30.0,	    2.10,	},
				[3]  = { 0.3,	    0.02487,	 0.072,		0.1,		0.032,		2.95,	    30.0,	    2.10,	},
				[4]  = { 0.4,	    0.02497,	 0.076,		0.1,	   	0.032,		3.23,	    30.0,	    2.10,	},
				[5]  = { 0.5,	    0.02512,	 0.080,		0.1,	   	0.032,		3.75,	    28.0,	    2.06,	},
				[6]  = { 0.6,	    0.02526,	 0.083,		0.094,		0.043,		3.96,	    25.0,	    1.9,	},
				[7]  = { 0.7,	    0.02567,	 0.087,		0.094,		0.045,		4.14,	    22.6,	    1.7,	},
				[8]  = { 0.8,	    0.02618,	 0.090,		0.094,		0.048,		4.16,	    21.4,	    1.6,    },
				[9]  = { 0.9,	    0.02851,	 0.094,		0.11,		0.050,		4.20,	    20.2,	    1.5,    },
				[10] = { 1.000, 	0.036, 		 0.094, 	0.252, 		0.10, 		3.5, 		21.250, 	1.12,   },
				[11] = { 1.050, 	0.035, 		 0.094, 	0.320, 		0.095,		3.040, 		20.375, 	1.1,    },
				[12] = { 1.100, 	0.037, 		 0.095, 	0.387, 		0.09, 		2.461, 		20.000,   	1.05,   },
				[13] = { 1.200, 	0.0367, 	 0.095, 	0.410, 		0.12, 		2.178, 		20.000,   	1.00,   },
				[14] = { 1.300, 	0.035, 		 0.096, 	0.427, 		0.17, 		1.979, 		20.000,  	0.912,  },
				[15] = { 1.500, 	0.035, 		 0.090, 	0.452, 		0.20, 		1.609, 		20.000, 	0.740,  },
				[16] = { 1.700, 	0.034, 		 0.093, 	0.432, 		0.30, 		1.469, 		20.000, 	0.800,  },
				[17] = { 1.800, 	0.033,		 0.092, 	0.432, 		0.38, 		1.401, 		20.000, 	0.700,  },
				[18] = { 2.000, 	0.033, 		 0.090, 	0.400, 		0.20, 		1.269, 		20.000, 	0.600,  },
				[19] = { 2.200,		0.030,		 0.039,		0.222,		0.2,		0.78,		20.2,		0.52,   },
				[20] = { 2.400,		0.040,		 0.034,		0.227,		0.17,		0.7,		19,			0.4,    },
				[21] = { 2.500,		0.045,		 0.033,		0.25,		0.13,		0.7,		19,			0.4,    },
				[22] = { 3.900,		0.050,		 0.033,		0.35,		0.1 ,		0.7,		19,			0.4,    },
				}, -- end of table_data
			}, -- end of aerodynamics
		engine = 
		{
			Nmg	=	67,
			MinRUD	=	0,
			MaxRUD	=	1,
			MaksRUD	=	0.85,
			ForsRUD	=	0.91,
			type	=	"TurboJet",
			hMaxEng	=	19.5,
			dcx_eng	=	0.0114,
			cemax	=	1.134,
			cefor	=	2.30,
			dpdh_m	=	5000,
			dpdh_f	=	8000.0,
			table_data = {
			--   M		Pmax		 Pfor
			{0.0,   120000,		210000},
			{0.2,	120000,		210000},
			{0.4,	120000,		210000},
			{0.5,	120000,		210000},
			{0.6,	120000,		210000},
			{0.7,	120000,		210000},
			{0.8,	120000,		210000},
			{0.9,	120000,		210000},
			{1.0,	120000,		230000},
			{1.1,	120000,		230000},
			{1.2,	120000,		230000},
			{1.3,	120000,		230000},
			{1.4,	120000,		230000},
			{1.6,	120000,		230000},
			{1.8,	120000,		230000},
			{2.2,	120000,		210000},
			{2.5,	120000,		210000},
		}, -- end of table_data
		}, -- end of engine
	},


	--damage , index meaning see in  Scripts\Aircrafts\_Common\Damage.lua
	Damage = {
	[0]  = {critical_damage = 5,  args = {146}},
	[1]  = {critical_damage = 3,  args = {296}},
	[2]  = {critical_damage = 3,  args = {297}},
	[3]  = {critical_damage = 8, args = {65}},
	[4]  = {critical_damage = 2,  args = {298}},
	[5]  = {critical_damage = 2,  args = {301}},
	[7]  = {critical_damage = 2,  args = {249}},
	[8]  = {critical_damage = 3,  args = {265}},
	[9]  = {critical_damage = 3,  args = {154}},
	[10] = {critical_damage = 3,  args = {153}},
	[11] = {critical_damage = 1,  args = {167}},
	[12] = {critical_damage = 1,  args = {161}},
	[13] = {critical_damage = 2,  args = {169}},
	[14] = {critical_damage = 2,  args = {163}},
	[15] = {critical_damage = 2,  args = {267}},
	[16] = {critical_damage = 2,  args = {266}},
	[17] = {critical_damage = 2,  args = {168}},
	[18] = {critical_damage = 2,  args = {162}},
	[20] = {critical_damage = 2,  args = {183}},
	[23] = {critical_damage = 5, args = {223}},
	[24] = {critical_damage = 5, args = {213}},
	[25] = {critical_damage = 2,  args = {226}},
	[26] = {critical_damage = 2,  args = {216}},
	[29] = {critical_damage = 5, args = {224}, deps_cells = {23, 25}},
	[30] = {critical_damage = 5, args = {214}, deps_cells = {24, 26}},
	[35] = {critical_damage = 6, args = {225}, deps_cells = {23, 29, 25, 37}},
	[36] = {critical_damage = 6, args = {215}, deps_cells = {24, 30, 26, 38}}, 
	[37] = {critical_damage = 2,  args = {228}},
	[38] = {critical_damage = 2,  args = {218}},
	[39] = {critical_damage = 2,  args = {244}, deps_cells = {53}}, 
	[40] = {critical_damage = 2,  args = {241}, deps_cells = {54}}, 
	[43] = {critical_damage = 2,  args = {243}, deps_cells = {39, 53}},
	[44] = {critical_damage = 2,  args = {242}, deps_cells = {40, 54}}, 
	[51] = {critical_damage = 2,  args = {240}}, 
	[52] = {critical_damage = 2,  args = {238}},
	[53] = {critical_damage = 2,  args = {248}},
	[54] = {critical_damage = 2,  args = {247}},
	[56] = {critical_damage = 2,  args = {158}},
	[57] = {critical_damage = 2,  args = {157}},
	[59] = {critical_damage = 3,  args = {148}},
	[61] = {critical_damage = 2,  args = {147}},
	[82] = {critical_damage = 2,  args = {152}},
	},
	
	DamageParts = 
	{  
		[1] = "VSN_Eurofighter-oblomok-wing-r", -- wing R
		[2] = "VSN_Eurofighter-oblomok-wing-l", -- wing L
--		[3] = "VSN_Eurofighter-oblomok-noise", -- nose
--		[4] = "VSN_Eurofighter-oblomok-tail-r", -- tail
--		[5] = "VSN_Eurofighter-oblomok-tail-l", -- tail
	},
-- VSN DCS World\Scripts\Aircrafts\_Common\Lights.lua
	lights_data = {
		typename = "collection",
		lights = {
			-- STROBES
			[WOLALIGHT_STROBES] = { 
					typename = "collection",
					lights = {
						{typename = "natostrobelight", argument = 193, period = 1.5, phase_shift = 0.5, color = {0.9, 1, 0.7}, connector = "BANO_0_BACK",intensity_max = 35},
					}
			},
			-- SPOTS
			[WOLALIGHT_LANDING_LIGHTS] = { 
					typename = "collection",
					lights = {
						{ typename  = "argumentlight",	argument  = 208, },
					},
			},
			[WOLALIGHT_TAXI_LIGHTS] = { 
					typename = "collection",
					lights = {
						{ typename  = "argumentlight",	argument  = 209, },
					},
			},
			-- NAVLIGHTS
			[WOLALIGHT_NAVLIGHTS]	= {	
					typename = "collection", -- nav_lights_default
					lights = {
						{typename = "natostrobelight", argument = 190, period = 1.5, phase_shift = 0, color = {1, 0, 0}, connector = "BANO_0_UP",intensity_max = 25},
						{typename = "natostrobelight", argument = 194, period = 1.5, phase_shift = 0.5, color = {1, 0, 0}, connector = "BANO_0_DOWN",intensity_max = 25},
						-- {typename = "argumentlight",argument = 190}, -- Left Position(red)
						{typename = "argumentlight",argument = 191}, -- Right Position(green)
						{typename = "argumentlight",argument = 192}, -- Tail Position white)
					},
			},
			-- FORMATION
			[WOLALIGHT_FORMATION_LIGHTS] = { 
					typename = "collection",
					lights = {
						{typename  = "argumentlight" ,argument  = 200,},--formation_lights_tail_1 = 200;
						{typename  = "argumentlight" ,argument  =  88,},--old aircraft arg 
					},
			},
	[WOLALIGHT_REFUEL_LIGHTS]	= {},-- REFUEL
	[WOLALIGHT_BEACONS]	= {},-- STROBE / ANTI-COLLISION
	[WOLALIGHT_CABIN_NIGHT]	= {},--
	}},
}

add_aircraft(EurofighterT)