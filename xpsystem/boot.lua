--[[
    Parallax Framework
    Copyright (c) 2026 Parallax Framework Contributors

    This file is part of the Parallax Framework and is licensed under the MIT License.
    You may use, copy, modify, merge, publish, distribute, and sublicense this file
    under the terms of the LICENSE file included with this project.

    Attribution is required. If you use or modify this file, you must retain this notice.
]]

local MODULE = MODULE

MODULE.name = "XP System"
MODULE.description = "Apex Gamemode & Impulse like based XP System made from the ground up."
MODULE.author = "Riggs"

ax.localization:Register("en", {
    ["category.xp"] = "XP System",
    ["config.xp.time"] = "XP Gain Interval",
    ["config.xp.gain.user"] = "User XP Gain Amount",
    ["config.xp.gain.donator"] = "Donator XP Gain Amount"
})
