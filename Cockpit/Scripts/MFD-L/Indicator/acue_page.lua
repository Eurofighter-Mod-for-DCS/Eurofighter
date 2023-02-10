dofile(LockOn_Options.script_path.."MFD-L/Indicator/base_page.lua")
dofile(LockOn_Options.script_path.."MFD-L/Device/device_defs.lua")
--Texture declaring
local BlackColor  = {0, 0, 0, 255}       --RGBA
local WhiteColor 	= {255, 255, 255, 100} --RGBA
local MainColor 	= {255, 255, 255, 255} --RGBA
local GreenColor 	= {05, 255, 10, 180}   --RGBA
local YellowColor = {255, 255, 0, 255}   --RGBA
local OrangeColor = {255, 102, 0, 255}   --RGBA
local RedColor 		= {255, 0, 0, 255}     --RGBA
local TealColor 	= {0, 255, 255, 255}   --RGBA
local BlueColor     = {0, 5, 255, 255}

MFDL_IND_TEX_PATH = LockOn_Options.script_path.."../Textures/MFD/ACUE Page/"

Backline = MakeMaterial(MFDL_IND_TEX_PATH.."Back_line.dds", BlueColor)
TextACUE = MakeMaterial(MFDL_IND_TEX_PATH.."Text.dds", WhiteColor)

local line                    = CreateElement "ceTexPoly"
line.vertices                 = mfdl_vert_gen(39000, 10000)
line.indices                  = {0,1,2,0,3,2}
line.tex_coords               = tex_coord_gen(0,0,512,512,512,512)
line.material                 = Backline
line.name                     = create_guid_string()
line.primitivetype            = "triangles"
line.init_pos                 = {0, 0, 0}
line.init_rot                 = {0, 0, 0}
line.collimated               = true
line.use_mipfilter            = true
line.additive_alpha           = true
line.h_clip_relation          = h_clip_relations.COMPARE
line.level                    = MFDL_DEFAULT_NOCLIP_LEVEL
line.element_params           = {"BATTERY"}
line.controllers              = {{"parameter_compare_with_number", 0, 1}}
line.parent_element           = "MFD_base_clip"
Add(line)

local Text                    = CreateElement "ceTexPoly"
Text.vertices                 = mfdl_vert_gen(39000, 10000)
Text.indices                  = {0,1,2,0,3,2}
Text.tex_coords               = tex_coord_gen(0,0,512,512,512,512)
Text.material                 = TextACUE
Text.name                     = create_guid_string()
Text.primitivetype            = "triangles"
Text.init_pos                 = {0, 0, 0}
Text.init_rot                 = {0, 0, 0}
Text.collimated               = true
Text.use_mipfilter            = true
Text.additive_alpha           = true
Text.h_clip_relation          = h_clip_relations.COMPARE
Text.level                    = MFDL_DEFAULT_NOCLIP_LEVEL
Text.element_params           = {"BATTERY"}
Text.controllers              = {{"parameter_compare_with_number", 0, 1}}
Text.parent_element           = "MFD_base_clip"
Add(Text)