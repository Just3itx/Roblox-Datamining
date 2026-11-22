-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T23:51:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TimeToInteractiveTracker = script:FindFirstAncestor("TimeToInteractiveTracker")

local constants = require(TimeToInteractiveTracker.Milestones.constants)

local _types = require(TimeToInteractiveTracker.Stores.types)

local function hasNavigationCommitted(arg1)
    if arg1 == nil or arg1.milestones == nil then
        return false
    end
    for _, value in arg1.milestones do
        if value.name == constants.NavigationCommitted then
            return true
        end
    end
    return false
end

return hasNavigationCommitted
