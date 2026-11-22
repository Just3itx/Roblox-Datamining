-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:21:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxAppUpdateParent = script:FindFirstAncestor("RobloxAppUpdate").Parent
local Promise = require(RobloxAppUpdateParent.Promise)

local module = {}
module.__index = module

function module.new(_appUpdate)
    local tbl1 = { _appUpdate = _appUpdate }

    setmetatable(tbl1, module)
    return tbl1
end

function module.checkForUpdate(arg1)
    return Promise.new(function(callback, _)
        local success, result = pcall(function()
            arg1._appUpdate:CheckForUpdate(function(appUpdateStatus)
                callback({ appUpdateStatus = appUpdateStatus })
            end)
        end)

        if not success then
            callback({ errorMessage = result })
        end
    end)
end

function module:performManagedUpdate()
    self._appUpdate:PerformManagedUpdate()
end

function module:canPerformBinaryUpdate()
    return self._appUpdate:CanPerformBinaryUpdate()
end

return module
