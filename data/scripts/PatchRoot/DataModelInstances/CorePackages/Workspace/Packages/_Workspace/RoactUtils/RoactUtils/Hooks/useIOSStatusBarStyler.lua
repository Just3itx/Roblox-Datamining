-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T08:40:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RoactUtilsParent = script:FindFirstAncestor("RoactUtils").Parent
local GuiService = game:GetService("GuiService")
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")

local NotificationType = require(RoactUtilsParent.RobloxAppEnums).NotificationType

local React = require(RoactUtilsParent.React)

local function func1(style: string)
    if UserInputService:GetPlatform() == Enum.Platform.IOS then
        GuiService:BroadcastNotification(HttpService:JSONEncode({ style = style }), NotificationType.SET_STATUS_BAR_STYLE)
    end
end

local function useIOSStatusBarStyler(bool1: boolean, func2: ((...any) -> (...any))?)
    local var1 = func2 or func1

    React.useEffect(function()
        var1(if bool1 then "lightcontent" else "default")
        return function()
            var1("default")
        end
    end, { bool1 })
end

return useIOSStatusBarStyler
