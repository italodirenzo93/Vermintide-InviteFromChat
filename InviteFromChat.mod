return {
	run = function()
		fassert(rawget(_G, "new_mod"), "`InviteFromChat` mod must be lower than Vermintide Mod Framework in your launcher's load order.")

		new_mod("InviteFromChat", {
			mod_script       = "scripts/mods/InviteFromChat/InviteFromChat",
			mod_data         = "scripts/mods/InviteFromChat/InviteFromChat_data",
			mod_localization = "scripts/mods/InviteFromChat/InviteFromChat_localization",
		})
	end,
	packages = {
		"resource_packages/InviteFromChat/InviteFromChat",
	},
}
