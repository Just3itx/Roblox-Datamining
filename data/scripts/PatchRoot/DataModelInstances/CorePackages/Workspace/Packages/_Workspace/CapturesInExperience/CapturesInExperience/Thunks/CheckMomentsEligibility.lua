-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:01:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local MomentsEligibilityReceived = require(scriptParentParent.Actions.MomentsEligibilityReceived)
local Constants = require(scriptParentParent.Constants)
local FFlagCreateMomentsToast = require(scriptParentParent.Flags.FFlagCreateMomentsToast)
local FFlagMomentsCaptureEndIxpEnabled = require(scriptParentParent.Flags.FFlagMomentsCaptureEndIxpEnabled)
local ContentSharingNetworking = require(scriptParentParent.App.Networking).ContentSharingNetworking

return function(num1: number)
    return function(arg1)
        if not FFlagCreateMomentsToast and not FFlagMomentsCaptureEndIxpEnabled
            or ContentSharingNetworking == nil
            or type(arg1:getState()[Constants.RoduxKey].MomentsEligibility.byUniverseId[num1]) == "boolean"
        then
            return
        end

        arg1:dispatch(
            ContentSharingNetworking.CheckMomentsEligibility.API({ contentType = "experience", experienceId = tostring(num1) })
        ):andThen(
            function(arg2)
                local responseBody = arg2.responseBody
                local bool1 = type(responseBody) == "table" and responseBody.isEligible == true
                arg1:dispatch(MomentsEligibilityReceived(num1, bool1))
            end
        ):catch(
            function() end
        )
    end
end
