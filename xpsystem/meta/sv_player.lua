--[[
    Parallax Framework
    Copyright (c) 2026 Parallax Framework Contributors

    This file is part of the Parallax Framework and is licensed under the MIT License.
    You may use, copy, modify, merge, publish, distribute, and sublicense this file
    under the terms of the LICENSE file included with this project.

    Attribution is required. If you use or modify this file, you must retain this notice.
]]

local PLAYER = FindMetaTable("Player")

function PLAYER:AddXP(amount)
    if ( !tonumber(amount) ) then return end
    if ( tonumber(amount) <= 0 ) then return end

    local currentXP = self:GetXP()
    self:SetXP(currentXP + tonumber(amount))
end

function PLAYER:TakeXP(amount)
    if ( !tonumber(amount) ) then return end
    if ( tonumber(amount) <= 0 ) then return end

    local currentXP = self:GetXP()
    local newXP = math.max(0, currentXP - tonumber(amount))
    self:SetXP(newXP)
end

function PLAYER:GainXP()
    local amount = hook.Run("GetXPGainAmount", self)

    self:AddXP(amount)
    self:Notify("For playing on our server for 10 minutes, you have gained " .. amount .. " XP!")
end
