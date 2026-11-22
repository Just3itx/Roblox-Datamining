-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T08:20:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local NextDataExpirationTimeRodux = script:FindFirstAncestor("NextDataExpirationTimeRodux")
local SetNextDataExpirationTime = require(NextDataExpirationTimeRodux.SetNextDataExpirationTime)
local ExpirationTimeNamespace = require(NextDataExpirationTimeRodux.ExpirationTimeNamespace)

local NextDataExpirationTimeRoduxParent = NextDataExpirationTimeRodux.Parent
local _DiscoveryTypes = require(NextDataExpirationTimeRoduxParent.DiscoveryTypes)

local function initializeExpirationTimes()
    local result = ({})
    for _, value in ExpirationTimeNamespace do
        result[value] = {}
    end

    return result
end

return {
    key = "NextDataExpirationTimeKey",
    reducer = function(arg1, arg2)
        arg1 = arg1 or initializeExpirationTimes()

        if arg2.type ~= SetNextDataExpirationTime.name then
            return arg1
        end

        assert(arg1, "state should always exist, assert for linter")
        local namespace = arg2.namespace
        local key = arg2.key
        assert(namespace, "SetNextDataExpirationTime does not have a valid namespace")
        assert(key, `SetNextDataExpirationTime does not have a valid key for namespace {namespace}`)

        local var1 = arg1[namespace]
        if not var1 then
            warn(`No namespace {namespace} defined in NextDataExpirationTimeReducer for action`)
            return arg1
        end
        assert(var1, "namespaceState should always exist, assert for linter")

        local var2 = table.clone(var1)
        var2[key] = arg2.nextDataExpirationTime

        local var3 = table.clone(arg1)
        var3[namespace] = var2
        return var3
    end
}
