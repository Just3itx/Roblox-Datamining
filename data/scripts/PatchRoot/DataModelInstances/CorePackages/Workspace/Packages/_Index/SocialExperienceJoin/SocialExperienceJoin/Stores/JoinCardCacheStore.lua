-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T18:51:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialExperienceJoinParent = script:FindFirstAncestor("SocialExperienceJoin").Parent

local Cryo = require(SocialExperienceJoinParent.Cryo)
local Signals = require(SocialExperienceJoinParent.Signals)

local createSignal = Signals.createSignal
local computed = Signals.createComputed(function(_)
    local getPlayabilityEntries, var2 = createSignal({})
    local getUserSettings, var4 = createSignal(nil)

    return {
        getPlayabilityEntries = getPlayabilityEntries,
        getUserSettings = getUserSettings,
        setPlayabilityEntry = function(str1: string, arg1)
            if not str1 or str1 == "" then
                return
            end
            local var5 = getPlayabilityEntries(false)
            var2(Cryo.Dictionary.join(var5, { [str1] = arg1 }))
        end,
        setUserSettings = function(arg1) -- name: setUserSettingsAction
            var4(arg1)
        end,
        clearPlayabilityEntry = function(str1: string)
            if not str1 or str1 == "" then
                return
            end
            local var5 = getPlayabilityEntries(false)
            if var5[str1] == nil then
                return
            end
            var2(Cryo.Dictionary.join(var5, { [str1] = Cryo.None }))
        end,
        clearCache = function(str1: string?)
            if str1 and str1 ~= "" then
                local var5 = getPlayabilityEntries(false)
                var2(Cryo.Dictionary.join(var5, { [str1] = Cryo.None }))
            else
                var2({})
            end
            var4(nil)
        end
    }
end)
return {
    get = function()
        return computed(false)
    end
}
