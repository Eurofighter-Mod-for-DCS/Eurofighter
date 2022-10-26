dofile(LockOn_Options.script_path.."MFD-L/Device/device_defs.lua")

local half_width = GetScale()
local half_height = GetAspect() * half_width

local aspect = GetAspect()

MFD_base_clip                   = CreateElement "ceMeshPoly"
MFD_base_clip.name              = "MFD_base_clip"
MFD_base_clip.primitivetype     = "triangles"
MFD_base_clip.vertices          = { {1, aspect}, { 1,-aspect}, { -1,-aspect}, {-1,aspect},}
MFD_base_clip.indices           = {0,1,2,0,2,3}
MFD_base_clip.init_pos          = {0, 0, 0}
MFD_base_clip.init_rot          = {0, 0, 0}
MFD_base_clip.material          = "DBG_GREEN"
MFD_base_clip.h_clip_relation   = h_clip_relations.REWRITE_LEVEL
MFD_base_clip.level             = MFDL_DEFAULT_NOCLIP_LEVEL + 1
MFD_base_clip.isdraw            = true
MFD_base_clip.change_opacity    = true
MFD_base_clip.element_params    = {"BATTERY"}
MFD_base_clip.controllers       = {{"parameter_compare_with_number", 0, 1}}
MFD_base_clip.isvisible         = true
Add(MFD_base_clip)

local MFDLFD_B                    = CreateElement "ceTexPoly"
MFDLFD_B.vertices                 = mfdl_vert_gen(122288,122288)
MFDLFD_B.indices                  = {0,1,2,0,3,2}
MFDLFD_B.tex_coords               = tex_coord_gen(0,0,512,512,512,512)
MFDLFD_B.material                 = FD_MATERIAL_B
MFDLFD_B.name                     = create_guid_string()
MFDLFD_B.init_pos                 = {0, 0, 0}
MFDLFD_B.init_rot                 = {0, 0, 0}
MFDLFD_B.collimated               = true
MFDLFD_B.use_mipfilter            = true
MFDLFD_B.additive_alpha           = true
MFDLFD_B.h_clip_relation          = h_clip_relations.COMPARE
MFDLFD_B.level                    = MFDL_DEFAULT_NOCLIP_LEVEL
MFDLFD_B.parent_element           = "MFD_base_clip"
Add(MFDLFD_B)