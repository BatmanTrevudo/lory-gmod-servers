print("Loading Config...")
DR = DR or {}
print("Creating global table DR...")

DR.Colors = {
    GhostTeam = HexColor("#ffcc00"),
    DeathTeam = HexColor("#F26C4F"),
    RunnerTeam = HexColor("#3A89C9"),
    Clouds = HexColor("#E9F2F9"),
    Silver = HexColor("#bdc3c7"),
    Concrete = HexColor("#95a5a6"),
    Alizarin = HexColor("#e74c3c"),
    Peter = HexColor("#3498db"),
    Turq = HexColor("#1abc9c"),
    DarkBlue = HexColor("#1B325F"),
    LightBlue = HexColor("#9CC4E4"),
    Sunflower = HexColor("#f1c40f"),
    Orange = HexColor("#f39c12"),
    Text = {
        GhostTeam = HexColor("#ffcc00"),
        DeathTeam = HexColor("#F26C4F"),
        RunnerTeam = HexColor("#3A89C9"),
        Clouds = HexColor("#E9F2F9"),
        Silver = HexColor("#bdc3c7"),
        Concrete = HexColor("#95a5a6"),
        Alizarin = HexColor("#e74c3c"),
        Peter = HexColor("#3498db"),
        Turq = HexColor("#1abc9c"),
        DarkBlue = HexColor("#1B325F"),
        LightBlue = HexColor("#9CC4E4"),
        Sunflower = HexColor("#f1c40f"),
        Orange = HexColor("#f39c12"),
        Grey3 = HexColor("#303030")
    }
}

DR.DermaColors = {}
DR.AirAccelerate = 1000 -- does nothing

function DR:SetMainColor(col)
    DR.Colors.Turq = col
end

function DR:SetMainTextColor(col)
    DR.Colors.Text.Turq = col
end

--[[
	
	MOTD

	To change the MOTD behaviour, use the following functions ON THE CLIENT:

	DR:SetMOTDEnabled( BOOLEAN enabled ) -- False to disable globally, True to enable globally (clients can still disable for themselves using F2 menu )
	DR:SetMOTDTitle( STRING title ) -- Title of the MOTD Window
	DR:SetMOTDSize( NUMBER w, NUMBER h ) -- Size of the MOTD window
	DR:SetMOTDPage( STRING url ) -- the URL to open in the MOTD window, e.h. http://www.MyCommunityIsCool.com
	
]]
-- don't touch this otherwise shit will hit the fan and your custom colors won't work
hook.Add("InitPostEntity", "DeathrunChangeColors", function()
    hook.Call("DeathrunChangeColors", nil, nil)
end)

-- 1 = user, 2 = moderator, 3 = admin
-- 2 will inherit from 1, 3 will inherit from 2
-- to access a command, player must have access level >= permission level
DR.Ranks = {}
DR.Ranks["user"] = 1 -- access levels
DR.Ranks["regular"] = 1 -- ranks are case sensitive, Admin /= admin
DR.Ranks["moderator"] = 2
DR.Ranks["mod"] = 2
DR.Ranks["admin"] = 3
DR.Ranks["superadmin"] = 3
DR.Ranks["owner"] = 3
DR.Ranks["atari"] = 2
DR.Ranks["commodore 64"] = 3
DR.Ranks["sega dreamcast"] = 3
DR.PlayerAccess = {}
DR.PlayerAccess["gamefresh_steamid"] = 2
DR.PlayerAccess["bobbis_steamid"] = 3

DR.Permissions = {
    ["deathrun_respawn"] = 3, -- permission levels
    ["deathrun_cleanup"] = 3,
    ["deathrun_open_zone_editor"] = 3,
    ["deathrun_punish"] = 2,
    ["zone_create"] = 3,
    ["zone_remove"] = 3,
    ["zone_setpos1"] = 3,
    ["zone_setpos2"] = 3,
    ["zone_setcolor"] = 3,
    ["zone_settype"] = 3,
    ["deathrun_force_spectate"] = 2,
    -- mapvote
    ["mapvote_list_maps"] = 1,
    ["mapvote_begin_mapvote"] = 3,
    ["mapvote_vote"] = 1,
    ["mapvote_nominate_map"] = 1,
    ["mapvote_update_mapvote"] = 3, -- debug tool
    ["mapvote_rtv"] = 1
}