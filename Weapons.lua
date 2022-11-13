--/N/ jan 2015

-- Headtypes
-- // тип головки самонаведения ГСН:
-- const int InfraredSeeker = 1;    // Thermal IR (infrared seeker)
-- const int ActiveRadar        = 2;    //  (active radar (AR) (+ИНС)) 
-- const int AntiRadar          = 3;    // (Passive radar +INS)
-- const int LaserHoming        = 4;    // Laser illumination (+INS)
-- const int Autopilot          = 5;    // Autonmous (INS+ Card, GPS,TV,IIR...)
-- const int SemiActiveRadar    = 6;    // semi-active radar (SAR) 
-- const int SemiAutoAT	    = 7;	// semi-automatic control with a platform for anti-tank systems , fly to woPoint, coordinates woPoint change platform.

-- Highest possible number seems to be ~25772


local wsType_LYSBOMB = 11030
--11019 = A (01) J (10) S (19) + 11 => 11030
local wsType_BK90 = 11031
local wsType_BK90MJ1 = 11053
local wsType_BK90MJ2 = 11054
local wsType_BK90Test = 11032
local wsType_HEBOMB = 11033
local wsType_HEBOMBDrag = 11034
local wsType_Rb05 = 11035
local wsType_AKAN = 11036
local wsType_AKANPOD = 11055
local wsType_Irdiss = 11037
local wsType_Rb24J = 11038
local wsType_IrisT = 11062
local wsType_Meteor = 11061
local wsType_Aim_132 = 11063
local wsType_Rb04AI = 11042
local wsType_Rb15AI = 11043
local wsType_ARAK70HE = 11044
local wsType_ARAK70HEPOD = 11048
local wsType_KB = 11045
local wsType_U22 = 11046
local wsType_U22A = 11047
local wsType_Brimstone = 11050
local wsType_RB75T = 11051
local wsType_RB75B = 11052

local function calcPiercingMass(warhead)
	warhead.piercing_mass = warhead.mass;
	if (warhead.expl_mass/warhead.mass > 0.1) then
		warhead.piercing_mass = warhead.mass/5.0;
	end
end

local explosivePercent = 1--0.8

function simple_aa_warhead(power, caliber) 
 local res = {};

	res.mass = 1.1*power;
	res.expl_mass = power;
	res.other_factors = {1, 1, 1};
	res.obj_factors = {1, 1};
	res.concrete_factors = {1, 1, 1};
	res.cumulative_factor = 0;
	res.concrete_obj_factor = 0.0;
	res.cumulative_thickness = 0.0;
	res.caliber = caliber;

	calcPiercingMass(res)
 return res;
end

function enhanced_a2a_warhead(power, caliber)
 local res = {};

	res.expl_mass = 1.7*power;
	res.mass = res.expl_mass;
	res.other_factors = {1, 1, 1};
	res.obj_factors = {1, 1};
	res.concrete_factors = {1, 1, 1};
	res.cumulative_factor = 0;
	res.concrete_obj_factor = 0.0;
	res.cumulative_thickness = 0.0;
	res.caliber = caliber;

	calcPiercingMass(res)
 return res;
end

function simple_warhead(power, caliber)
 local res = {};

	res.caliber = caliber
	res.expl_mass = power*explosivePercent; 
	res.mass = res.expl_mass;
	res.other_factors = {1, 1, 1};
	res.obj_factors = {1, 1};
	res.concrete_factors = {1, 1, 1};
	res.cumulative_factor = 0;
	res.concrete_obj_factor = 0.0;
	res.cumulative_thickness = 0.0;

	calcPiercingMass(res)
 return res;
end

function cumulative_warhead(power)
 local res = {};

	res.expl_mass = power*explosivePercent;
	res.mass = res.expl_mass;
	res.other_factors = {1, 1, 1};
	res.obj_factors = {1, 1};
	res.concrete_factors = {1, 1, 1};
	res.cumulative_factor = 3.0;
	res.concrete_obj_factor = 0.0;
	res.cumulative_thickness = 0.2;

	calcPiercingMass(res)
 return res;
end

function penetrating_warhead(power, piercing_mass, caliber)
 local res = {};

	res.expl_mass = power*explosivePercent;
	res.mass = res.expl_mass;
	res.other_factors = {1, 1, 1};
	res.obj_factors = {1, 1};
	res.concrete_factors = {1, 1, 10};
	res.cumulative_factor = 5.0;
	res.concrete_obj_factor = 5.0;
	res.cumulative_thickness = 0.0;
	res.piercing_mass = piercing_mass;
	res.caliber = caliber;

	calcPiercingMass(res)
	return res;
end

function mbd3_full(shape)
	return 	{
		mbd3_u6_adapter,
		mbd3_u6_element(shape,6),
		mbd3_u6_element(shape,5),
		mbd3_u6_element(shape,4),
		mbd3_u6_element(shape,3),
		mbd3_u6_element(shape,2),
		mbd3_u6_element(shape,1),
	}
end

function aircraft_gunpod(gunpod_name, ...)
    local type = _G[gunpod_name];
    if type == nil then
        error("Unknown type for "..gunpod_name);
    end
	aircraft_gunpod_with_wstype(gunpod_name,type,arg)
end

function aircraft_gunpod_with_wstype(gunpod_name,wstype,mounts)
	--print(gunpod_name)
    local res = dbtype("wAircraftGunpodEquipment", {
        ws_type     = wstype;
		gunpod_name  = gunpod_name;
    });
	if not res.short_name then 
		   res.short_name = gunpod_name
	end
	if not res.display_name then 
		   res.display_name = res.short_name
	end
    res.mounts = {};
	
    for i, v in ipairs(mounts) do
        res.mounts[i] = v;
    end
    weapons_table.aircraft_gunpods[gunpod_name] = res
end

warhead = {}
--AA MISSILES
warhead["IrisT"] =  enhanced_a2a_warhead(9.4, 127); 
warhead["Meteor"] =  enhanced_a2a_warhead(9.4, 227);
warhead["Aim_132"] =  enhanced_a2a_warhead(9.4, 127); 


-- ROCKETS
-- MISSILES



local IrisT = { 

	category		= CAT_AIR_TO_AIR,
	name			= "IrisT",
	user_name		= _("IrisT"),
	--/N/ wrong -> wsTypeOfWeapon = {4, 4, 11, WSTYPE_PLACEHOLDER},
	wsTypeOfWeapon = {wsType_Weapon,wsType_Missile,wsType_AA_Missile, wsType_IrisT},
	NatoName		=	"(IrisT)",
	

	shape_table_data =
	{
		{
			name	 = "IrisT";
			file  = "Iris-T"; -- <--/N/ replace this file name with proper one
			life  = 1;
			fire  = { 0, 1};
			username = "IrisT";
			index = wsType_IrisT,
		},
	},

	Escort = 0,
	Head_Type = 1,
	sigma = {2, 2, 2},
	M = 87.4,
	H_max = 20000.0,
	H_min = -1,
	Diam = 127.0,
	Cx_pil = 1.5,
	D_max = 25000.0,
	D_min = 200.0,
	Head_Form = 0,
	Life_Time = 100.0,
	Nr_max = 140,
	v_min = 140.0,
	v_mid = 400.0,
	Mach_max = 3,
	t_b = 0.0,
	t_acc = 4.5,
	t_marsh = 0.0,
	Range_max = 35000.0,
	H_min_t = 1.0,
	Fi_start = 3.14152,
	Fi_rak = 3.14152,
	Fi_excort = 1.57,
	Fi_search = 3.14152/2,
	OmViz_max = 1.1,
	warhead = warhead["IrisT"],
	exhaust = { 0.7, 0.7, 0.7, 0.08 };
	X_back = -1.455,
	Y_back = -0.067,
	Z_back = 0,
	Reflection = 0.03,
	KillDistance = 7.0,
	--seeker sensivity params
	SeekerSensivityDistance = 25000, -- The range of target with IR value = 1. In meters. In forward hemisphere.
	ccm_k0 = 0.12,  -- Counter Countermeasures Probability Factor. Value = 0 - missile has absolutely resistance to countermeasures. Default = 1 (medium probability)
	SeekerCooled			= true, -- True is cooled seeker and false is not cooled seeker.				
	PN_coeffs = {
		3,
		3000,
		1,
		5000,
		0.5,
		10000,
		0.2
	},
	ModelData = {   58 ,  -- model params count
					0.35 ,   -- characteristic square (õàðàêòåðèñòè÷åñêàÿ ïëîùàäü)
					
					-- ïàðàìåòðû çàâèñèìîñòè Ñx
					0.035 , -- Cx_k0 ïëàíêà Ñx0 íà äîçâóêå ( M << 1)
					0.08 , -- Cx_k1 âûñîòà ïèêà âîëíîâîãî êðèçèñà
					0.02 , -- Cx_k2 êðóòèçíà ôðîíòà íà ïîäõîäå ê âîëíîâîìó êðèçèñó
					0.05, -- Cx_k3 ïëàíêà Cx0 íà ñâåðõçâóêå ( M >> 1)
					1.2 , -- Cx_k4 êðóòèçíà ñïàäà çà âîëíîâûì êðèçèñîì 
					1.0 , -- êîýôôèöèåíò îòâàëà ïîëÿðû (ïðîïîðöèîíàëüíî sqrt (M^2-1))
					
					-- ïàðàìåòðû çàâèñèìîñòè Cy
					0.9 , -- Cy_k0 ïëàíêà Ñy0 íà äîçâóêå ( M << 1)
					0.8	 , -- Cy_k1 ïëàíêà Cy0 íà ñâåðõçâóêå ( M >> 1)
					1.2  , -- Cy_k2 êðóòèçíà ñïàäà(ôðîíòà) çà âîëíîâûì êðèçèñîì  
					
					0.7 , -- 7 Alfa_max  ìàêñèìàëüíûé áàëàíñèðîâà÷íûé óãîë, ðàäèàíû
					10.0, --óãëîâàÿ ñêîðîñòü ñîçäàâàéìàÿ ìîìåíòîì ãàçîâûõ ðóëåé
					
				-- Engine data. Time, fuel flow, thrust.	
				--	t_statr		t_b		t_accel		t_march		t_inertial		t_break		t_end			-- Stage
					-1.0,		-1.0,	5,  		0.0,		0.0,			0.0,		1000000000,         -- time of stage, sec
					 0.0,		0.0,	5.44,		0.0,		0.0,			0.0,		0.0,           -- fuel flow rate in second, kg/sec(ñåêóíäíûé ðàñõîä ìàññû òîïëèâà êã/ñåê)
					 0.0,		0.0,	12802.0,	0.0,	0.0,			0.0,		0.0,           -- thrust, newtons
				
					1.0e9, -- temporizador de autodestrucción, seg
					60.0, -- tiempo de funcionamiento del sistema de potencia, seg.
					0, -- абсолютная высота самоликвидации, м altura absoluta de autoliquidación, m
					0.3, -- tiempo de retardo de activación del control (maniobra de salida, seguridad), seg
					1.0e9, -- alcance al objetivo en el momento del lanzamiento, cuando se excede el cual el misil realiza una maniobra de "deslizamiento", m
					1.0e9, -- rango hasta el objetivo en el que se completa la maniobra de "deslizamiento" y el misil cambia a navegación proporcional pura (debe ser mayor o igual que el parámetro anterior), m
					0.0,  -- синус угла возвышения траектории набора горки 	seno del ángulo de elevación de la trayectoria de la montaña rusa
					30.0, -- продольное ускорения взведения взрывателя aceleración longitudinal del armado del fusible
					0.0, -- модуль скорости сообщаймый катапультным устройством, вышибным зарядом и тд módulo de velocidad comunicado por dispositivo de expulsión, expulsión de carga, etc.
					1.19, -- характристика системы САУ-РАКЕТА,  коэф фильтра второго порядка K0 característica del sistema SAU-Raketa, coeficiente de filtro de segundo orden K0
					1.0, -- характристика системы САУ-РАКЕТА,  коэф фильтра второго порядка K1 característica del sistema SAU-Raketa, coeficiente de filtro de segundo orden K1
					2.0, -- характристика системы САУ-РАКЕТА,  полоса пропускания контура управления característica del sistema SAU-RAKETA, ancho de banda del lazo de control

					-- DLZ. Данные для рассчета дальностей пуска (индикация на прицеле) Datos para calcular los rangos de lanzamiento (indicación en la mira)
					14.0, 
					-15.0, 
					-2.5, 
					15200, 
					5200, 
					25000,
					9800, 
					10300, 
					3000, 
					1500, 
					0.5, 
					-0.015, 
					0.5,
				},
		
		
	
}

declare_weapon(IrisT)

declare_loadout(
	{		
		category			= CAT_AIR_TO_AIR,
		CLSID				= "{irist}",
		attribute			= {wsType_Weapon, wsType_Missile, wsType_Container, wsType_IrisT},
		wsTypeOfWeapon		= IrisT.wsTypeOfWeapon,
		Count				= 1,
		Picture				= "irist.png",
		displayName			= IrisT.user_name.._(""), --<-- /N/  put the launcher name here if any
		Weight				= 85, --<--/N/ missile + launcher weight (if any), this is important since the launcher stays on  aircraft! So this weight should be higher than a missile itself!
		Cx_pil				= 0.0001, --<--/N/ this is too low, you might have difficulties later to set up the human and AI FM (ignore the 21 code when it comes to weapons Cx, it is a special case) -- edited Jedi
		Elements			={
			[1]	=
			{
				Position	=	{0.0,	0.0,	0}, 
				ShapeName	=	"Iris-T", --<-- /N/  put the missile shape name here
			},
		},
	}
)

--test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...--
--test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...--
--test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...--
local Meteor = { 

	category		= CAT_AIR_TO_AIR,
	name			= "Meteor",
	user_name		= _("Meteor"),
	--/N/ wrong -> wsTypeOfWeapon = {4, 4, 11, WSTYPE_PLACEHOLDER},
	wsTypeOfWeapon = {wsType_Weapon,wsType_Missile,wsType_AA_Missile, wsType_Meteor},
	NatoName		=	"(Meteor)",
	

	shape_table_data =
	{
		{
			name	 = "EF_Meteor";
			file  = "EF_Meteor"; -- <--/N/ replace this file name with proper one
			life  = 1;
			fire  = { 0, 1};
			username = "Meteor";
			index = wsType_Meteor,
		},
	},

    Escort = 0,
    Head_Type = 2,
    sigma = {4, 4, 4},
    M = 190.0,
    H_max           = 20000.0,
    H_min           = 1.0,
    Diam            = 203.0,
    Cx_pil          = 2.5,
    D_max           = 80000.0,
    D_min           = 1000.0,
    Head_Form       = 1,
    Life_Time       = 297.0,
    Nr_max          = 35,
    v_min           = 140.0,
    v_mid           = 2575.0,
    Mach_max        = 4.5,
    t_b             = 0.0,
    t_acc           = 6.0,
    t_marsh         = 50.0,
    Range_max       = 160000.0,
    H_min_t         = 1.0,
    Fi_start        = 0.780,
    Fi_rak          = 3.14152,
    Fi_excort       = 1.0472,
    Fi_search       = 1.05,
    OmViz_max       = 0.6981,
	X_back          = -1.54,
    Y_back          = 0.0, -- -0.11
    Z_back          = 0.0,
    Reflection      = 0.03,
    KillDistance    = 20.0,
	loft 			= 0,
	hoj 			= 1,
	ccm_k0 			= 0.025,

	active_radar_lock_dist	= 20000.0,
	go_active_by_default	= 1,

	PN_coeffs = {11,
				0.0, 1.0,
				4000.0, 0.995,
				5000.0, 0.99,
				6000.0, 0.97,
				7000.0, 0.94,
				10000.0, 0.80,
				15000.0, 0.50,
				20000.0, 0.35,
				30000.0, 0.20,
				40000.0, 0.14,
				100000.0, 0.05,
			};

        warhead = warhead["Meteor"],
		Engine_Type = 3,
        exhaust = { 0.8, 0.8, 0.8, 0.8 }; --RGB+Intensity
        X_back = -1.85,   	--pos in X axis(F/B)
        Y_back = -0.145,	--pos in Y axis(U/D)
        Z_back = 0.0,		--pos in Z axis(L/R)
			
		ModelData = {   58 ,  -- model params count
					0.4 ,   -- characteristic square (характеристическая площадь) -- 4

					-- параметры зависимости Сx
					0.015 , -- планка Сx0 на дозвуке ( M << 1) cx_k0
					0.050 , -- высота пика волнового кризиса cx_k1
					0.012 , -- крутизна фронта на подходе к волновому кризису cx_k2
					0.004 , -- планка Cx0 на сверхзвуке ( M >> 1) cx_k3
					1.20  , -- крутизна спада за волновым кризисом cx_k4
					0.90  , -- коэффициент отвала поляры

					-- параметры зависимости Cy
					0.90 , -- планка Сy0 на дозвуке ( M << 1)
					0.75 , -- планка Cy0 на сверхзвуке ( M >> 1)
					1.20 , -- крутизна спада(фронта) за волновым кризисом

					0.5 , -- 7 Alfa_max  максимальный балансировачный угол, радианы
					0.00, --угловая скорость создаваймая моментом газовых рулей

					--    t_statr   t_b      t_accel  t_march   t_inertial   t_break  t_end
					-1.0,   -1.0,       8.0,     34.0,      0.0,          0.0,      1.0e9,           -- time interval
					0.0,    0.0,       6.0,     0.4,      0.0,          0.0,        0.0,           -- fuel flow rate in second kg/sec(секундный расход массы топлива кг/сек)
					0.0,    0.0,   19000.0,  5194.0,      0.0,          0.0,        0.0,           -- thrust

					1.0e9, -- таймер самоликвидации, сек  Self-destructive time, sec
					180.0, -- время работы энергосистемы, сек  Working time of power system, sec
					0, -- абсолютная высота самоликвидации, м  Absolute height of self-destruction, M
					0.2, -- время задержки включения управления (маневр отлета, безопасности), сек  Connection delay time (shunting departure, safety), sec
					30000, -- дальность до цели в момент пуска, при превышении которой ракета выполняется маневр 'горка', м
					30000, -- дальность до цели, при которой маневр 'горка' завершается и ракета переходит на чистую пропорциональную навигацию (должен быть больше или равен предыдущему параметру), м
					0.17,  -- синус угла возвышения траектории набора горки
					50.0, -- продольное ускорения взведения взрывателя  Longitudinal acceleration of fuze arming
					0.0, -- модуль скорости сообщаймый катапультным устройством, вышибным зарядом и тд
					1.19, -- характристика системы САУ-РАКЕТА,  коэф фильтра второго порядка K0
					1.0, -- характристика системы САУ-РАКЕТА,  коэф фильтра второго порядка K1
					2.0, -- характристика системы САУ-РАКЕТА,  полоса пропускания контура управления

					-- DLZ. Данные для рассчета дальностей пуска (индикация на прицеле)
					21.0, -- производная дальности по скорости носителя на высоте 1км, ППС
					-23.0, -- производная дальности по скорости цели на высоте 1км, ЗПС
					-3.0, -- производная по высоте производной дальности по скорости цели, ЗПС
					164250.0,-- 73000.0,
					56250.0,-- 25000.0, 
					270000.0,-- 120000.0,
					105750.0,-- 47000.0, 
					111375.0,-- 49500.0, 
					32625.0,-- 14500.0, 
					9000.0,-- 4000.0,
					0.4,
					-0.015,
					0.5,
					},
}

declare_weapon(Meteor)

declare_loadout(
	{		
		category			= CAT_AIR_TO_AIR,
		CLSID				= "{Meteor}",
		attribute			= {wsType_Weapon, wsType_Missile, wsType_Container, wsType_Meteor},
		wsTypeOfWeapon		= Meteor.wsTypeOfWeapon,
		Count				= 1,
		Picture				= "meteor.png",
		displayName			= Meteor.user_name.._(""), --<-- /N/  put the launcher name here if any
		Weight				= 90, --<--/N/ missile + launcher weight (if any), this is important since the launcher stays on  aircraft! So this weight should be higher than a missile itself!
		Cx_pil				= 0.0001, --<--/N/ this is too low, you might have difficulties later to set up the human and AI FM (ignore the 21 code when it comes to weapons Cx, it is a special case) -- edited Jedi
		Elements			={
			[1]	=
			{
				Position	=	{0.0,	0.01,	0}, 
				ShapeName	=	"EF_Meteor", --<-- /N/  put the missile shape name here
			},
		},
	}
)
--test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...--
--test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...--
--test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...--


local Aim_132 = { 

	category		= CAT_AIR_TO_AIR,
	name			= "Aim_132",
	user_name		= _("Aim_132"),
	--/N/ wrong -> wsTypeOfWeapon = {4, 4, 11, WSTYPE_PLACEHOLDER},
	wsTypeOfWeapon = {wsType_Weapon,wsType_Missile,wsType_AA_Missile, wsType_Aim_132},
	NatoName		=	"(Aim_132)",
	

	shape_table_data =
	{
		{
			name	 = "Aim_132";
			file  = "Aim_132"; -- <--/N/ replace this file name with proper one
			life  = 1;
			fire  = { 0, 1};
			username = "Aim_132";
			index = wsType_Aim_132,
		},
	},

        Escort = 0,
        Head_Type = 1,
		sigma = {2, 2, 2},
        M = 88.0,
        H_max = 20000.0, 
        H_min = -1,
        Diam = 166.0,
        Cx_pil = 2.1,
        D_max = 28000.0,
        D_min = 200.0,
        Head_Form = 0,
        Life_Time = 80.0,
        Nr_max = 60,
        v_min = 140.0,
        v_mid = 400.0,
        Mach_max = 3.5,
        t_b = 0.0,
        t_acc = 8.0,
        t_marsh = 0.0,
        Range_max = 35000.0,
        H_min_t = 1.0,
        Fi_start = 3.14152,
        Fi_rak = 3.14152,
        Fi_excort = 3.14152, 
        Fi_search = 0.09, 
        OmViz_max = 1.10,
        warhead = warhead["Aim_132"],
        exhaust = {0.78, 0.78, 0.78, 0.3};
        X_back = -1.8,
        Y_back = -0.11, --0.0,
        Z_back = 0.0, -- -0.1,
		Reflection = 0.040,
        KillDistance = 8.0,

    --seeker sensivity params
    SeekerSensivityDistance = 35000, -- The range of target with IR value = 1. In meters.
    ccm_k0        = 0.15,  -- Counter Countermeasures Probability Factor. Value = 0 - missile has absolutely resistance to countermeasures. Default = 1 (medium probability)
    SeekerCooled  = true, -- True is cooled seeker and false is not cooled seeker.

		ModelData = {
			58 ,  -- model params count
			0.4 ,   -- characteristic square (характеристическая площадь)
			
			-- параметры зависимости Сx
			0.040 , -- Cx_k0 планка Сx0 на дозвуке ( M << 1)
			0.080 , -- Cx_k1 высота пика волнового кризиса
			0.020 , -- Cx_k2 крутизна фронта на подходе к волновому кризису
			0.050, -- Cx_k3 планка Cx0 на сверхзвуке ( M >> 1)
			1.0 , -- Cx_k4 крутизна спада за волновым кризисом 
			0.8 , -- коэффициент отвала поляры (пропорционально sqrt (M^2-1))
			
			-- параметры зависимости Cy
			0.9 , -- Cy_k0 планка Сy0 на дозвуке ( M << 1)
			0.8     , -- Cy_k1 планка Cy0 на сверхзвуке ( M >> 1)
			1.2  , -- Cy_k2 крутизна спада(фронта) за волновым кризисом  
			
			0.7 , -- 7 Alfa_max  максимальный балансировачный угол, радианы
			10.0, --угловая скорость создаваймая моментом газовых рулей
			
			-- Engine data. Time, fuel flow, thrust.    
			--    t_statr        t_b        t_accel        t_march        t_inertial        t_break        t_end            -- Stage
					-1.0,        -1.0,    8,          0.0,        0.0,            0.0,        1.0e9,         -- time of stage, sec
					0.0,        0.0,    5.5,        0.0,        0.0,            0.0,        0.0,           -- fuel flow rate in second, kg/sec(секундный расход массы топлива кг/сек)
					0.0,        0.0,    17800.0,    0.0,    0.0,            0.0,        0.0,           -- thrust, newtons
		
			1.0e9, -- таймер самоликвидации, сек
			60.0, -- время работы энергосистемы, сек
			0, -- абсолютная высота самоликвидации, м
			0.5, -- время задержки включения управления (маневр отлета, безопасности), сек
			1.0e9, -- дальность до цели в момент пуска, при превышении которой ракета выполняется маневр "горка", м
			1.0e9, -- дальность до цели, при которой маневр "горка" завершается и ракета переходит на чистую пропорциональную навигацию (должен быть больше или равен предыдущему параметру), м 
			0.0,  -- синус угла возвышения траектории набора горки
			50.0, -- продольное ускорения взведения взрывателя
			0.0, -- модуль скорости сообщаймый катапультным устройством, вышибным зарядом и тд
			1.19, -- характристика системы САУ-РАКЕТА,  коэф фильтра второго порядка K0
			1.0, -- характристика системы САУ-РАКЕТА,  коэф фильтра второго порядка K1
			2.0, -- характристика системы САУ-РАКЕТА,  полоса пропускания контура управления

			-- DLZ. Данные для рассчета дальностей пуска (индикация на прицеле)
			14.0, 
			-15.0, 
			-2.5, 
			21300, 
			7300, 
			35500,
			13700, 
			14500, 
			4200, 
			1500, 
			0.5, 
			-0.015, 
			0.5,
			},
		
		
	
}

declare_weapon(Aim_132)

declare_loadout(
	{		
		category			= CAT_AIR_TO_AIR,
		CLSID				= "{aim132}",
		attribute			= {wsType_Weapon, wsType_Missile, wsType_Container, wsType_Aim_132},
		wsTypeOfWeapon		= Aim_132.wsTypeOfWeapon,
		Count				= 1,
		Picture				= "aim9m.png",
		displayName			= Aim_132.user_name.._(""), --<-- /N/  put the launcher name here if any
		Weight				= 90, --<--/N/ missile + launcher weight (if any), this is important since the launcher stays on  aircraft! So this weight should be higher than a missile itself!
		Cx_pil				= 0.0001, --<--/N/ this is too low, you might have difficulties later to set up the human and AI FM (ignore the 21 code when it comes to weapons Cx, it is a special case) -- edited Jedi
		Elements			={
			[1]	=
			{
				Position	=	{0.0,	0.0,	0}, 
				ShapeName	=	"Aim_132", --<-- /N/  put the missile shape name here
			},
		},
	}
)







-- AG MISSILES

warhead["huge"] = simple_warhead(700*12,450)

warhead["m71"] = simple_warhead(125,450); -- Explosive 60 kg + fragments bonus

warhead["none"] = simple_warhead(1,1)

warhead["brimstone"] = penetrating_warhead(97,305)

declare_loadout(
    {
        category = CAT_FUEL_TANKS,
        CLSID = "{EF_CENTRAL_TANK}",
        attribute = {wsType_Air,wsType_Free_Fall,wsType_FuelTank,WSTYPE_PLACEHOLDER},
        Picture = "Xtank.png",
		Diam = 606.0,
        displayName = _("Tanque_1000L"),
        Weight_Empty = 195,
        Weight = 1190,
        Cx_pil            = 0.00016,--0.002197266, -- Ragnar: I've calculated it to be exactly this much // changed to F-5 tank Cx -- Teo// testing
        shape_table_data =
            {
                {
                    file = "EF_CENTRAL_TANK",
                    life = 1,
                    fire = { 0, 1},
                    username = "EF_CENTRAL_TANK",
                    index = WSTYPE_PLACEHOLDER,
                },
            },
        Elements =
            {
                {
                DrawArgs =
                    {
                        [1] = {1, 1},
                        [2] = {2, 1},
                    },
                        Position = {0, 0, 0},
                        ShapeName = "EF_CENTRAL_TANK",
                    },
                },
            }
)
------------------------------------------------------------------------------------------------------------
local agm84_warhead = {
	caliber = 343,
			 concrete_factors = { 1, 1, 1 },
			 concrete_obj_factor = 2,
			 cumulative_factor = 2,
			 cumulative_thickness = 0.2,
			 expl_mass = 97.5,
			 fantom = 0,
			 mass = 225,
			 obj_factors = { 2, 1 },
			 other_factors = { 1, 1, 1 },
			 piercing_mass = 45
 }
 
 local mass = 629.5
 
--  local agm84 = {
 
-- 	 category		= CAT_MISSILES,
-- 	 name			= "AGM-84-D",
-- 	 user_name		= _("ef-agm-84d"),
-- 	 wsTypeOfWeapon	= {wsType_Weapon, wsType_Missile, wsType_AS_Missile, WSTYPE_PLACEHOLDER},
-- 	 scheme			= "anti_radiation_missile",
-- 	 class_name		= "wAmmunitionSelfHoming",
-- 	 model			= "ef-agm-84d",
-- 	 NatoName		= "(Harpoon)",
 
-- 	 shape_table_data =
-- 	 {
-- 		 {
-- 			 name	 = "ef-agm-84d",
-- 			 file	 = "ef-agm-84d",
-- 			 life	 = 1,
-- 			 fire	 = { 0, 1},
-- 			 username = _("AGM-84-D"),
-- 			 index	 = WSTYPE_PLACEHOLDER,
-- 		 },
-- 	 },
 
-- 		 Escort = 0,
-- 		 Head_Type = 3,
-- 		 sigma = {5, 5, 5},
-- 		 M = mass,
-- 		 H_max = 12000.0,
-- 		 H_min = -1,
-- 		 Diam = 343.0,
-- 		 Cx_pil = 8,			-- Drag on pylon
-- 		 D_max = 270000.0,
-- 		 D_min = 10000.0,
-- 		 Head_Form = 1,
-- 		 Life_Time = 100000,
-- 		 Nr_max = 6,
-- 		 v_min = 170.0,
-- 		 v_mid = 237.5,
-- 		 Mach_max = 0.95,
-- 		 t_b = 5.0,
-- 		 t_acc = 0.0,
-- 		 t_marsh = 10000.0,
-- 		 Range_max = 270000.0,
-- 		 H_min_t = 0.0,
-- 		 Fi_start = 0.25,
-- 		 Fi_rak = 3.14152,
-- 		 Fi_excort = 3.14152,
-- 		 Fi_search = 99.9,
-- 		 OmViz_max = 99.9,
		 
		 
-- 		 X_back = -2.0,
-- 		 Y_back = -0.2,
-- 		 Z_back = 0.0,
-- 		 Reflection = 0.1,		-- Probability of missile getting shot down before impact
-- 		 KillDistance = 25.0, 
-- 		 add_attributes = {"Cruise missiles"},
		 
-- 		 warhead		= agm84_warhead,
-- 		 warhead_air = agm84_warhead,
 
 
--  -- Missile Flight Model Data
-- 	 fm = {
-- 		 mass		= mass, 
-- 		 caliber		= 0.343,
-- 		 cx_coeff	= {1, 0.3, 0.65, 0.010, 1.6},
-- 		 L			= 4.49,
-- 		 I			= 1055.0452333333, --  moment of inertia
-- 		 Ma			= 0.68,
-- 		 Mw			= 1.116,
-- 		 wind_sigma	= 0.0,
-- 		 wind_time	= 1000.0,
-- 		 Sw			= 0.85,			--Lift or something alike, if missile crashes into the ground make this value higher
-- 		 dCydA		= {0.07, 0.036},
-- 		 A			= 0.5,
-- 		 maxAoa		= 0.30,
-- 		 finsTau		= 0.02,	-- !	?????? ????? / wingspan
-- 		 Ma_x		= 3,
-- 		 Ma_z		= 3,
-- 		 Kw_x		= 0.05,
-- 		 addDeplSw		= 1.0,
-- 		 wingsDeplDelay	= 1.0,
-- 	 },
 
--  -- Missile Engine Data
-- 	 controller = {
-- 		 boost_start = 0.01,  --0.001
-- 		 march_start = 0.5,
-- 	 },
 
-- 	 booster = {
-- 		 impulse								= 2800,		-- added some initial boost to avoid collision with aircraft
-- 		 fuel_mass							= 1,
-- 		 work_time							= 1,
-- 		 boost_time							= 0,
-- 		 boost_factor						= 0,
-- 		 nozzle_position						= {{-2.3, 0.0, 0.0}},
-- 		 nozzle_orientationXYZ				= {{0.0, 0.0, 0.0}},  
-- 		 tail_width							= 0.0,
-- 		 smoke_color							= {0.0, 0.0, 0.0},
-- 		 smoke_transparency					= 0.0,          
-- 		 custom_smoke_dissipation_factor		= 0.0,
-- 	 },
 
-- 	 march = {
-- 		 impulse								= 2890,
-- 		 fuel_mass							= 24,   
-- 		 work_time							= 9999,
-- 		 boost_time							= 0,
-- 		 boost_factor						= 0,
-- 		 nozzle_position						= {{-2.3, 0.0, 0.0}},
-- 		 nozzle_orientationXYZ				= {{0.0, 0.0, 0.0}},
-- 		 tail_width 							= 0.5,
-- 		 smoke_color							= {0.0, 0.0, 0.0},
-- 		 smoke_transparency					= 0.05,    --0.3,
-- 		 custom_smoke_dissipation_factor		= 0.2,    
-- 	 },
 
--  -- Missile Radar Homing Data   
-- 	 radio_seeker = {
-- 		 FOV					= math.rad(60.0),   --0
-- 		 op_time				= 9999.0,
-- 		 keep_aim_time		= 5,
-- 		 pos_memory_time		= 200,
-- 		 sens_near_dist		= 300.0,
-- 		 sens_far_dist		= 300000.0,
-- 		 err_correct_time	= 2.5,
-- 		 err_val				= 0.0025,
-- 		 calc_aim_dist		= 500000,
-- 		 blind_rad_val		= 0.1,
-- 		 blind_ctrl_dist		= 2100,
-- 		 aim_y_offset		= 3.0,
-- 	 },
 
-- 	 simple_seeker =	{
-- 		 sensitivity = 0,
-- 		 delay		= 0.0,
-- 		 FOV			= math.rad(60.0),    --0
-- 		 maxW		= 500,
-- 		 opTime		= 9999,
-- 	 },
 
-- 	 simple_gyrostab_seeker = {
-- 		 omega_max	= math.rad(10)
-- 	 },
 
-- 	 fuze_proximity = {
-- 		 ignore_inp_armed	= 1,
-- 		 arm_delay			= 10,
-- 		 radius				= 0,
-- 	 },
 
--  -- Missile Flight Control Data 
-- 	 autopilot = {
-- 		 delay			 = 1.0,
-- 		 K				 = 500.0,  
-- 		 Kg				 = 15.0,  
-- 		 Ki				 = 0.0,  
-- 		 finsLimit		 = 0.68, 
-- 		 useJumpByDefault = 1, 
-- 		 J_Power_K		 = 2.2,  
-- 		 J_Diff_K		 = 0.8,  
-- 		 J_Int_K			 = 0.0,
-- 		 J_Angle_K		 =  math.rad(05),   
-- 		 J_FinAngle_K	 =  math.rad(15),  
-- 		 J_Angle_W		 = 0.5,  
-- 		 glide_height              = 1524,
-- 		 skim_glide_height         = 5.0,
				 
-- 	 },
 
-- 	 start_helper = {
-- 		 delay				= 1.0,
-- 		 power				= 0.1,
-- 		 time				= 1,
-- 		 use_local_coord		= 0,
-- 		 max_vel				= 200,
-- 		 max_height			= 200,
-- 		 vh_logic_or			= 0,
-- 	 },
 
--  triggers_control = {
-- 		 action_wait_timer               = 5,    -- wait for dist functions n sen, then set default values
-- 		 default_sensor_tg_dist          = 30000, -- turn on seeker and start horiz. correction if target is locked
-- 		 default_final_maneuver_tg_dist  = 5000,
-- 		 default_straight_nav_tg_dist    = 750,
-- 		 default_destruct_tg_dist        = 280000, -- if seeker still can not find a target explode warhead after reaching pred. target point + n. km
-- 		 trigger_by_path                 = 1,
-- 		 pre_maneuver_glide_height       = 5,    -- triggers st nav instead of fin. maneuver if h>2*pre_maneuver_glide_height at fin. maneuver distance --19
-- 		 use_horiz_dist                  = 1,
-- 	 },
	 
	 
		 
--  }
 
--  declare_weapon(agm84, { mass = 555 })
 
--  declare_loadout(
-- 	 {
-- 		 category		= CAT_MISSILES,
-- 		 Picture			= "agm84a.png",
-- 		 displayName		= agm84.user_name,
-- 		 Weight			= agm84.mass,
-- 		 CLSID			= "{EF_AGM_84}",
-- 		 attribute		= agm84.wsTypeOfWeapon,
-- 		 Count			= 1,
-- 		 Cx_pil			= 0.0018,
-- 		 ejectImpulse	= 50,
-- 		 Elements		=
-- 		 {
-- 			 [1]	=
-- 			 {
-- 				 DrawArgs	=
-- 				 {
-- 					 [1]	=	{1,	1},
-- 					 [2]	=	{2,	1},
-- 				 }, -- end of DrawArgs
-- 				 Position	=	{0,	0,	0},
-- 				 ShapeName	=	"ef-agm-84d",
-- 					 },
-- 		 }, -- end of Elements
-- 	 }
--  )

 