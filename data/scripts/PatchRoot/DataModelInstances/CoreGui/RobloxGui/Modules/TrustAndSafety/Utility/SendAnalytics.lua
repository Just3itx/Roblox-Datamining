-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:20:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local UserInputService = game:GetService("UserInputService")
local EventIngestService = game:GetService("EventIngestService")

local getPlatformTarget = not require(CorePackages.Workspace.Packages.SharedFlags).GetFFlagShareGetPlatformTargetImpl() and function(): string -- name: getPlatformTarget
    local str1 = "unknownLua"
    local none = Enum.Platform.None

    pcall(function()
        none = UserInputService:GetPlatform()
    end)

    local windows = Enum.Platform.Windows
    local bool1

    if none == windows then
        bool1 = true
    else
        local osx = Enum.Platform.OSX
        bool1 = none == osx
    end
    local ios = Enum.Platform.IOS
    local bool2

    if none == ios then
        bool2 = true
    else
        local android = Enum.Platform.Android
        bool2 = none == android
    end

    if not bool2 then
        local uwp = Enum.Platform.UWP
        bool2 = none == uwp
    end
    local xBox360 = Enum.Platform.XBox360
    local bool3

    if none == xBox360 then
        bool3 = true
    else
        local xBoxOne = Enum.Platform.XBoxOne
        bool3 = none == xBoxOne
    end

    if not bool3 then
        local ps3 = Enum.Platform.PS3

        if none == ps3 then
            bool3 = true
        else
            local ps4 = Enum.Platform.PS4
            bool3 = none == ps4
        end
    end

    if not bool3 then
        local wiiU = Enum.Platform.WiiU
        bool3 = none == wiiU
    end

    return if bool1 then "client" elseif bool2 then "mobile" elseif bool3 then "console" else str1 .. tostring(none)
end or require(CorePackages.Workspace.Packages.Analytics).getPlatformTarget

return function(str1: string, str2: string, arg1)
    assert(type(str1) == "string", "Expected eventContext to be a string")
    assert(type(str2) == "string", "Expected eventName to be a string")
    assert(type(arg1) == "table", "Expected eventTable to be a table")

    local platformTarget = getPlatformTarget()

    arg1 = arg1 or {}

    local gameId = game.GameId
    arg1.universeId = tostring(gameId)

    EventIngestService:sendEventDeferred(platformTarget, str1, str2, arg1)
end
