-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T08:51:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxAppHooks = script:FindFirstAncestor("RobloxAppHooks")
local RobloxAppHooksParent = RobloxAppHooks.Parent
local useCurrentCamera = require(RobloxAppHooks.useCurrentCamera)
local useProperty = require(RobloxAppHooksParent.GuiObjectUtils).useProperty
local DeviceOrientationMode = require(RobloxAppHooksParent.RobloxAppEnums).DeviceOrientationMode

local function useDeviceOrientation()
    local var1 = useCurrentCamera()
    local var2 = useProperty(var1, "ViewportSize")

    if var2 and var2.X > 1 and var2.Y > 1 then
        return var2.X > var2.Y and DeviceOrientationMode.Landscape or DeviceOrientationMode.Portrait
    end

    return nil
end

return useDeviceOrientation
