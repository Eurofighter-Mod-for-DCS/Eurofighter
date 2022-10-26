--	=================== BK-27 SHELLS  ================================================================================
declare_weapon({category = CAT_SHELLS, name = "BK_27_HE", user_name = _("27 mm HE"),	
	model_name    = "tracer_bullet_yellow",
	v0    = 1025.0,
	Dv0   = 0.0040,
	Da0     = 0.00005,
	Da1     = 0.0,
	mass      = 0.26,
	round_mass = 0.516,
	explosive     = 0.119,
	life_time     = 5,
	caliber     = 27.0,
	s         = 0.0,
	j         = 0.0,
	l         = 0.0,
	charTime    = 0,
	cx        = {1,0.605,0.8,0.22,1.9},
	k1        = 6.3e-09,
	tracer_off    = -1,
	scale_tracer  = 1,
	scale_smoke	= 1.5,
	cartridge = 0,
});

	declare_weapon({category = CAT_SHELLS, name = "BK_27_AP", user_name = _("27 mm AP"),
	model_name    = "tracer_bullet_yellow",
	v0    = 1025.0,
	Dv0   = 0.0040,
	Da0     = 0.00005,
	Da1     = 0.0,
	mass      = 0.26,
	round_mass = 0.516,
	explosive     = 0.0,
	life_time     = 5,
	caliber     = 27.0,
	AP_cap_caliber = 15.0,
	s         = 0.0,
	j         = 0.0,
	l         = 0.0,
	charTime    = 0,
	cx        = {1,0.605,0.8,0.22,1.9},
	k1        = 6.3e-09,
	tracer_off    = -1,
	scale_tracer  = 1,
	scale_smoke	= 1.5,	  
	cartridge = 0,
});

	declare_weapon({category = CAT_SHELLS, name = "BK_27_APHE", user_name = _("27 mm APHE"),
	model_name    = "tracer_bullet_yellow",
	v0    = 1025.0,
	Dv0   = 0.0040,
	Da0     = 0.00005,
	Da1     = 0.0,
	mass      = 0.26,
	round_mass = 0.516,
	explosive     = 0.033,
	life_time     = 5,
	caliber     = 27.0,
	AP_cap_caliber = 10.0,
	s         = 0.0,
	j         = 0.0,
	l         = 0.0,
	charTime    = 0,
	cx        = {1,0.605,0.8,0.22,1.9},
	k1        = 6.3e-09,
	tracer_off    = -1,
	scale_tracer  = 1,
	scale_smoke	= 1.5,
	cartridge = 0,
});

	declare_weapon({category = CAT_SHELLS, name = "BK_27_PELE", user_name = _("27 mm PELE"),
	model_name    = "tracer_bullet_yellow",
	v0    = 1025.0,
	Dv0   = 0.0040,
	Da0     = 0.00005,
	Da1     = 0.0,
	mass      = 0.26,
	round_mass = 0.516,
	explosive     = 0.0,
	life_time     = 5,
	caliber     = 27.0,
	subcalibre = true,	
	AP_cap_caliber = 15.0,
	piercing_mass = 0.150,
	s         = 0.0,
	j         = 0.0,
	l         = 0.0,
	charTime    = 0,
	cx        = {1,0.605,0.8,0.22,1.9},
	k1        = 6.3e-09,
	tracer_off    = -1,
	scale_tracer  = 1,
	scale_smoke	= 1.5,
	cartridge = 0,
});

	declare_weapon({category = CAT_SHELLS, name = "BK_27_PELET", user_name = _("27 mm PELE-T"),
	model_name    = "tracer_bullet_yellow",
	v0    = 1025.0,
	Dv0   = 0.0040,
	Da0     = 0.00005,
	Da1     = 0.0,
	mass      = 0.26,
	round_mass = 0.516,
	explosive     = 0.0,
	life_time     = 5,
	caliber     = 27.0,
	subcalibre = true,
	AP_cap_caliber = 15.0,
	piercing_mass = 0.150,
	s         = 0.0,
	j         = 0.0,
	l         = 0.0,
	charTime    = 0,
	cx        = {1,0.605,0.8,0.22,1.9},
	k1        = 6.3e-09,
	tracer_off    = 2,
	scale_tracer  = 1,
	scale_smoke	= 1.5,
	cartridge = 0,
});

--	=================== BK-27 CANNON ================================================================================
local function bk27_cannon(tbl)

    tbl.category = CAT_GUN_MOUNT
    tbl.name =  "bk_27"
    tbl.display_name =  _("BK-27 Cannon")
    tbl.supply      =
    {
        shells = {"BK_27_HE", "BK_27_AP", "BK_27_APHE", "BK_27_PELE", "BK_27_PELET"},
        mixes  = { {1,2,3},{4,4,4,4,5} },
        count  = 120, -- corrected amount
    }
    if tbl.mixes then
       tbl.supply.mixes = tbl.mixes
       tbl.mixes        = nil
    end
    tbl.gun =
    {
        max_burst_length    = 10,
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
