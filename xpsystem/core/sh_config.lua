--[[
    Parallax Framework
    Copyright (c) 2026 Parallax Framework Contributors

    This file is part of the Parallax Framework and is licensed under the MIT License.
    You may use, copy, modify, merge, publish, distribute, and sublicense this file
    under the terms of the LICENSE file included with this project.

    Attribution is required. If you use or modify this file, you must retain this notice.
]]

ax.config:Add("xp.time", ax.type.number, 600, {
    category = "xp",
    description = "Interval in seconds for XP gain.",
    min = 60,
    max = 3600
})

ax.config:Add("xp.gain.user", ax.type.number, 5, {
    category = "xp",
    description = "Amount of XP gained per interval for regular users.",
    min = 1,
    max = 100
})

ax.config:Add("xp.gain.donator", ax.type.number, 10, {
    category = "xp",
    description = "Amount of XP gained per interval for donators.",
    min = 1,
    max = 200
})
