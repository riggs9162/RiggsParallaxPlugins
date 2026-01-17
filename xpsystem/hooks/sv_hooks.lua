--[[
    Parallax Framework
    Copyright (c) 2026 Parallax Framework Contributors

    This file is part of the Parallax Framework and is licensed under the MIT License.
    You may use, copy, modify, merge, publish, distribute, and sublicense this file
    under the terms of the LICENSE file included with this project.

    Attribution is required. If you use or modify this file, you must retain this notice.
]]

local MODULE = MODULE

function MODULE:PlayerInitialSpawn(client)
    client.axNextXP = CurTime() + ax.config:Get("xp.time", 600)
end

function MODULE:GetXPGainAmount(client)
    return ax.config:Get("xp.gain.user", 5)
end

function MODULE:PlayerPostThink(client)
    if ( client.axNextXP and CurTime() >= client.axNextXP ) then
        client:GainXP()
        client.axNextXP = CurTime() + ax.config:Get("xp.time", 600)
    end
end
