-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:20:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserInputService = game:GetService("UserInputService")

local MomentsCommonParent = script:FindFirstAncestor("MomentsCommon").Parent

local React = require(MomentsCommonParent.React)

local shouldUseDeviceSafeInsets = require(MomentsCommonParent.Display).shouldUseDeviceSafeInsets

local function readStatusBarHeight() -- Luacid: Inlined by compiler; 3 call sites recovered
    if shouldUseDeviceSafeInsets then
        return 0
    end
    local statusBarSize = UserInputService.StatusBarSize
    return if statusBarSize then statusBarSize.Y else 0
end

return function()
    local var1, var2 = React.useState(function(): number
        return readStatusBarHeight()
    end)

    React.useEffect(function()
        var2((readStatusBarHeight()))

        local connection = UserInputService:GetPropertyChangedSignal("StatusBarSize"):Connect(function()
            var2((readStatusBarHeight()))
        end)

        return function()
            connection:Disconnect()
        end
    end, {})

    return var1
end
