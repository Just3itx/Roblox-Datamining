-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T00:21:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserInputService = game:GetService("UserInputService")

local NotificationsCommon = script:FindFirstAncestor("NotificationsCommon")
local isTenFootInterface = require(NotificationsCommon.Parent.AppCommonLib).isTenFootInterface

return {
    isDesktopDevice = function(): boolean
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

            if none == osx then
                bool1 = true
            else
                local uwp = Enum.Platform.UWP
                bool1 = none == uwp
            end
        end

        return bool1
    end,
    isConsole = function()
        return isTenFootInterface()
    end
}
