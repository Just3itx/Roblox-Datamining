-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:51:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}
module.__index = module

function module:GetPropertyChangedSignal(arg1)
    if arg1 == "VRDeviceAvailable" then
        return self._vrDeviceAvailableChanged.Event
    end
    error(("%s is not a valid property name"):format(tostring(arg1)))
end

function module:toggleHeadsetConnectionState()
    local vrDeviceAvailable = not self.VRDeviceAvailable
    self.VRDeviceAvailable = vrDeviceAvailable

    self._vrDeviceAvailableChanged:Fire(vrDeviceAvailable)
end

function module.new()
    local tbl1 = {
        VRDeviceAvailable = true,
        _vrDeviceAvailableChanged = Instance.new("BindableEvent")
    }
    setmetatable(tbl1, { __index = module })

    return tbl1
end

return module
