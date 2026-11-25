-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T20:01:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local PolicyProvider = require(scriptParentParent.PolicyProvider)
local Logger = PolicyProvider.Logger
local React = require(scriptParentParent.React)
local Cryo = require(scriptParentParent.Cryo)
local _PolicyTypes = require(script.Parent.PolicyTypes)

local bool1 = game:DefineFastFlag("UniversalAppPolicySkipUnchangedPolicy2", false)

local function sameValues(current, tbl1) -- Luacid: Inlined by compiler; 1 call site recovered
    if current.n ~= tbl1.n then
        return false
    end
    for i = 1, current.n do
        if current[i] ~= tbl1[i] then
            return false
        end
    end
    return true
end

local function mergePolicies(arg1, presentationPolicy)
    local result = {}

    for _, value in ipairs(presentationPolicy) do
        result = Cryo.Dictionary.join(result, value(arg1))
    end

    return result
end

return function(arg1)
    assert(arg1, "expected getPolicyImpl")

    local function useAppPolicy(current: (...any) -> (...any))
        local var1 = React.useContext(PolicyProvider.AppPolicyContext)
        assert(var1, "Not a descendent of PolicyProvider")

        local var2, var3 = React.useState(function() -- name: getInitialPolicy
            if var1.staticExternalPolicy then
                return (mergePolicies(var1.staticExternalPolicy, var1.presentationPolicy))
            end

            local var2 = arg1.read()
            if var2 then
                return (mergePolicies(var2, var1.presentationPolicy))
            end

            Logger:trace("No app policy data available")
            return (mergePolicies({}, var1.presentationPolicy))
        end)

        local var4 = nil
        local var5 = nil
        local var6 = nil
        if bool1 then
            var4 = React.useRef(current)
            assert(var4, "latestMapPolicies")
            var4.current = current
            var5 = React.useRef(var2)
            var6 = React.useRef(nil)
        end

        React.useEffect(function()
            local var7 = if var1.staticExternalPolicy then nil else arg1.onPolicyChanged(function(arg2)
                Logger:trace("Received policy update")

                if not bool1 or not var4 or not var5 or not var6 then
                    var3((mergePolicies(arg2, var1.presentationPolicy)))
                    return
                end

                local var7 = mergePolicies(arg2, var1.presentationPolicy)
                var5.current = var7
                local current2 = var6.current

                if current2 == nil or not sameValues(current2, table.pack(var4.current(var7))) then
                    var3(var7)
                end
            end)

            return function()
                if var7 then
                    var7:Disconnect()
                end
            end
        end, { var1 })

        if not (bool1 and var5 and var6) then
            return current(var2)
        end

        local tbl1 = table.pack(current(var5.current))
        var6.current = tbl1

        return table.unpack(tbl1, 1, tbl1.n)
    end

    return useAppPolicy
end
