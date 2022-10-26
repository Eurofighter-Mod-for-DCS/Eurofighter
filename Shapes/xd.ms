folder = getSavePath ()
if folder != undefined then (
	local files = getFiles (folder+"/*.fx")
	if files.count > 0 then (
		local mats = materiallibrary()
		for f in files do (
			local dx = DirectX_9_Shader effectfile:f
			append mats dx
		)
		if mats.count > 0 then (
			local newFile = getSaveFileName types:"Material Library File(*.mat)|*.mat"
			
			if newFile != undefined then (
				saveTempMaterialLibrary mats newFile
			)
		)
	) else messagebox "No FX files found"
)