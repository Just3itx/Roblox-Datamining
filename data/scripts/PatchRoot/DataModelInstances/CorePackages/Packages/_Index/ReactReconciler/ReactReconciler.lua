-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:21:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _ReactInternalTypes = require(script.ReactInternalTypes)
local _ReactRootTags = require(script.ReactRootTags)

local _ReactFiberHostConfig = require(script.ReactFiberHostConfig)

local _ReactFiberHotReloadingNew = require(script["ReactFiberHotReloading.new"])

local function initialize(arg1)
    local reactFiberHostConfig = require(script.ReactFiberHostConfig)
    for value, value2 in arg1 do
        reactFiberHostConfig[value] = value2
    end

    return require(script.ReactFiberReconciler)
end

return initialize
