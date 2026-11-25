-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T20:01:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UniversalFeatureRestrictions = script:FindFirstAncestor("UniversalFeatureRestrictions")
local UniversalFeatureRestrictionsParent = UniversalFeatureRestrictions.Parent

local React = require(UniversalFeatureRestrictionsParent.React)

local _AbuseVector = require(UniversalFeatureRestrictions.Common.AbuseVector)
local runUnlessFeatureRestricted = require(UniversalFeatureRestrictions.Utils.runUnlessFeatureRestricted)
local _showFeatureRestrictionDirect = require(UniversalFeatureRestrictions.Utils.showFeatureRestrictionDirect)

local function useRunUnlessFeatureRestricted(arg1)
    local var1, var2 = React.useState("Settled")
    local var3 = React.useRef(false)
    local var4 = React.useRef(true)

    React.useEffect(function()
        var4.current = true
        return function()
            var4.current = false
        end
    end, {})

    return React.useCallback(function(tbl1)
        if var3.current then
            return
        end
        var3.current = true

        local onRestricted = tbl1.onRestricted
        runUnlessFeatureRestricted(arg1, {
            onProceed = function(arg2)
                if var4.current then
                    tbl1.onProceed(arg2)
                end
            end,
            onRestricted = function(arg2)
                if var4.current and onRestricted then
                    onRestricted(arg2)
                end
            end,
            dialogOptions = tbl1.dialogOptions,
            timeoutSeconds = tbl1.timeoutSeconds,
            onPhaseChanged = function(arg2)
                if arg2 == "Settled" then
                    var3.current = false
                end
                if var4.current then
                    var2(arg2)
                end
            end
        })
    end, { arg1 }), var1 == "Checking" or var1 == "Acknowledging"
end

return useRunUnlessFeatureRestricted
