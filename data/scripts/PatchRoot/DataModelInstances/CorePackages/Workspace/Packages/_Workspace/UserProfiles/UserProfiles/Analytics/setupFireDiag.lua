-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T20:31:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local SocialLuaAnalytics = require(scriptParentParentParent.SocialLuaAnalytics)
local fireDiagCounter = SocialLuaAnalytics.Analytics.FireEvent.fireDiagCounter
local fireDiag = SocialLuaAnalytics.Analytics.FireEvent.fireDiag

local FFlagUserProfilesLogErrorCodes = require(scriptParentParent.Flags.FFlagUserProfilesLogErrorCodes)

local DiagCountersList = require(script.Parent.DiagCountersList)
local _EventNames = require(script.Parent.EventNames)

return function(tbl1)
    if FFlagUserProfilesLogErrorCodes then
        local var1 = fireDiag({ diagImpl = tbl1.analytics.Diag, eventList = DiagCountersList })

        return function(arg1, arg2)
            if DiagCountersList[arg1] then
                return var1(arg1, arg2)
            end

            return arg1
        end
    end
    local var1 = fireDiagCounter({ diagImpl = tbl1.analytics.Diag, eventList = DiagCountersList })

    return function(arg1)
        if DiagCountersList[arg1] then
            return var1(arg1)
        end

        return arg1
    end
end
