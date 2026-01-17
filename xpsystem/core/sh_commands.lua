--[[
    Parallax Framework
    Copyright (c) 2026 Parallax Framework Contributors

    This file is part of the Parallax Framework and is licensed under the MIT License.
    You may use, copy, modify, merge, publish, distribute, and sublicense this file
    under the terms of the LICENSE file included with this project.

    Attribution is required. If you use or modify this file, you must retain this notice.
]]

ax.command:Add("AddXP", {
    description = "Add XP to a player.",
    adminOnly = true,
    arguments = {
        { name = "target", type = ax.type.player },
        { name = "amount", type = ax.type.number }
    },
    OnRun = function(self, client, target, amount)
        target:GiveXP(amount)
        client:Notify("Added " .. amount .. " XP to " .. target:Name() .. ".")
    end
})

ax.command:Add("TakeXP", {
    description = "Take XP from a player.",
    adminOnly = true,
    arguments = {
        { name = "target", type = ax.type.player },
        { name = "amount", type = ax.type.number }
    },
    OnRun = function(self, client, target, amount)
        target:TakeXP(amount)
        client:Notify("Took " .. amount .. " XP from " .. target:Name() .. ".")
    end
})

ax.command:Add("SetXP", {
    description = "Set a player's XP to a specific amount.",
    adminOnly = true,
    arguments = {
        { name = "target", type = ax.type.player },
        { name = "amount", type = ax.type.number }
    },
    OnRun = function(self, client, target, amount)
        target:SetXP(amount)
        client:Notify("Set " .. target:Name() .. "'s XP to " .. amount .. ".")
    end
})

ax.command:Add("CheckXP", {
    description = "Check your current XP.",
    arguments = {
        { name = "target", type = ax.type.player, optional = true }
    },
    OnRun = function(self, client, target)
        target = target or client

        local xp = target:GetXP()
        client:Notify((client == target and "You have " .. xp .. " XP.") or (target:Name() .. " has " .. xp .. " XP."))
    end
})

local function notifyOrPrint(client, message)
    if ( IsValid(client) ) then
        client:Notify(message)
    else
        print(message)
    end
end

concommand.Add("ax_xp_debug", function(client, command, arguments)
    if ( IsValid(client) and !client:IsSuperAdmin() or CLIENT ) then return end

    local target = client
    if ( arguments[1] ) then
        target = ax.util:FindPlayer(arguments[1])
        if ( !IsValid(target) ) then
            notifyOrPrint(client, "Player not found.")
            return
        end
    end

    print("XP Debug for " .. target:Name() .. ":")
    print("Current XP: " .. target:GetXP())
    local nextXPTime = target.axNextXP or "N/A"
    nextXPTime = (nextXPTime != "N/A") and string.NiceTime(nextXPTime - CurTime()) or nextXPTime
    print("Next XP Gain Time: " .. nextXPTime)
end)

concommand.Add("ax_xp_gain", function(client, command, arguments)
    if ( IsValid(client) and !client:IsSuperAdmin() or CLIENT ) then return end

    if ( !arguments[1] ) then
        notifyOrPrint(client, "Usage: ax_xp_gain <player>")
        return
    end

    local target = ax.util:FindPlayer(arguments[1])
    if ( !IsValid(target) ) then
        notifyOrPrint(client, "Player not found.")
        return
    end

    target:GainXP()
    notifyOrPrint(client, "Forced XP gain for " .. target:Name() .. ".")
end)

concommand.Add("ax_xp_setnext", function(client, command, arguments)
    if ( IsValid(client) and !client:IsSuperAdmin() or CLIENT ) then return end

    if ( !arguments[1] ) then
        notifyOrPrint(client, "Usage: ax_xp_setnext <player>")
        return
    end

    local target = ax.util:FindPlayer(arguments[1])
    if ( !IsValid(target) ) then
        notifyOrPrint(client, "Player not found.")
        return
    end

    target.axNextXP = CurTime() + ax.config:Get("xpTime", 600)
    notifyOrPrint(client, "Set next XP gain time for " .. target:Name() .. ".")
end)

concommand.Add("ax_xp_getnext", function(client, command, arguments)
    if ( IsValid(client) and !client:IsSuperAdmin() or CLIENT ) then return end

    if ( !arguments[1] ) then
        notifyOrPrint(client, "Usage: ax_xp_getnext <player>")
        return
    end

    local target = ax.util:FindPlayer(arguments[1])
    if ( !IsValid(target) ) then
        notifyOrPrint(client, "Player not found.")
        return
    end

    local nextXPTime = target.axNextXP or "N/A"
    nextXPTime = (nextXPTime != "N/A") and string.NiceTime(nextXPTime - CurTime()) or nextXPTime
    notifyOrPrint(client, "Next XP gain time for " .. target:Name() .. ": " .. nextXPTime)
end)

concommand.Add("ax_xp_reset", function(client, command, arguments)
    if ( IsValid(client) and !client:IsSuperAdmin() or CLIENT ) then return end

    if ( !arguments[1] ) then
        notifyOrPrint(client, "Usage: ax_xp_reset <player>")
        return
    end

    local target = ax.util:FindPlayer(arguments[1])
    if ( !IsValid(target) ) then
        notifyOrPrint(client, "Player not found.")
        return
    end

    target:SetXP(0)
    notifyOrPrint(client, "Reset XP for " .. target:Name() .. ".")
end)

concommand.Add("ax_xp_set", function(client, command, arguments)
    if ( IsValid(client) and !client:IsSuperAdmin() or CLIENT ) then return end

    if ( #arguments < 2 ) then
        notifyOrPrint(client, "Usage: ax_xp_set <player> <amount>")
        return
    end

    local target = ax.util:FindPlayer(arguments[1])
    if ( !IsValid(target) ) then
        notifyOrPrint(client, "Player not found.")
        return
    end

    local amount = tonumber(arguments[2])
    if ( !amount or amount < 0 ) then
        notifyOrPrint(client, "Invalid amount.")
        return
    end

    target:SetXP(amount)
    notifyOrPrint(client, "Set XP for " .. target:Name() .. " to " .. amount .. ".")
end)

concommand.Add("ax_xp_add", function(client, command, arguments)
    if ( IsValid(client) and !client:IsSuperAdmin() or CLIENT ) then return end

    if ( #arguments < 2 ) then
        notifyOrPrint(client, "Usage: ax_xp_add <player> <amount>")
        return
    end

    local target = ax.util:FindPlayer(arguments[1])
    if ( !IsValid(target) ) then
        notifyOrPrint(client, "Player not found.")
        return
    end

    local amount = tonumber(arguments[2])
    if ( !amount or amount <= 0 ) then
        notifyOrPrint(client, "Invalid amount.")
        return
    end

    target:AddXP(amount)
    notifyOrPrint(client, "Added " .. amount .. " XP to " .. target:Name() .. ".")
end)

concommand.Add("ax_xp_take", function(client, command, arguments)
    if ( IsValid(client) and !client:IsSuperAdmin() or CLIENT ) then return end

    if ( #arguments < 2 ) then
        notifyOrPrint(client, "Usage: ax_xp_take <player> <amount>")
        return
    end

    local target = ax.util:FindPlayer(arguments[1])
    if ( !IsValid(target) ) then
        notifyOrPrint(client, "Player not found.")
        return
    end

    local amount = tonumber(arguments[2])
    if ( !amount or amount <= 0 ) then
        notifyOrPrint(client, "Invalid amount.")
        return
    end

    target:TakeXP(amount)
    notifyOrPrint(client, "Took " .. amount .. " XP from " .. target:Name() .. ".")
end)
