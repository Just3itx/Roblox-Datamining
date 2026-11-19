-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T11:40:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppCommonLibParent = script:FindFirstAncestor("AppCommonLib").Parent

local VRService = require(AppCommonLibParent.MockableProxyServices).VRService

local isSpatial = require(script.Parent.isSpatial)

local function connectToIsSpatialChanged(callback: (...any) -> (...any), bool1: boolean?)
    local var1 = isSpatial()

    local connection = VRService:GetPropertyChangedSignal("VREnabled"):Connect(function()
        local var2 = isSpatial()
        if var2 == var1 then
            return
        end
        var1 = var2
        callback(var2)
    end)

    if bool1 then
        callback(var1)
    end

    return connection
end

return connectToIsSpatialChanged
