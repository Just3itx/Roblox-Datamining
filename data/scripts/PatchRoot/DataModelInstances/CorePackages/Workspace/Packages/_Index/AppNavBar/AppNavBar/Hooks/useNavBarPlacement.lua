-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T22:50:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local React = require(scriptParentParentParent.React)
local useDeviceOrientation = require(scriptParentParentParent.RobloxAppHooks).useDeviceOrientation
local DeviceOrientationMode = require(scriptParentParentParent.RobloxAppEnums).DeviceOrientationMode

local UserInputService = require(scriptParentParentParent.MockableProxyServices).UserInputService

local Placement = require(scriptParentParent.Enum.Placement)
local Mocks = require(scriptParentParent.Mocks)

local function useNavBarPlacement()
    local bool1 = useDeviceOrientation() == DeviceOrientationMode.Portrait

    local var1, var2 = React.useState(UserInputService.TouchEnabled)
    React.useEffect(function()
        var2(UserInputService.TouchEnabled)
        local connection = UserInputService:GetPropertyChangedSignal("TouchEnabled"):Connect(function()
            var2(UserInputService.TouchEnabled)
        end)
        return function()
            connection:Disconnect()
        end
    end, {})

    if Mocks.navBarPlacement == nil then
        if var1 and bool1 then
            return Placement.Bottom
        end

        return Placement.Left
    end

    return Mocks.navBarPlacement
end

return useNavBarPlacement
