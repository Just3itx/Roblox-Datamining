-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T12:00:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local EditProfile = script:FindFirstAncestor("EditProfile")
local EditProfileParent = EditProfile.Parent
local React = require(EditProfileParent.React)
local EditDisplayName = require(script.Parent.EditDisplayName)

local useLocalUserId = require(EditProfileParent.RobloxAppHooks).useLocalUserId
local var1 = require(EditProfileParent.UserProfiles).Stores.UserProfileStore.get()
local useSignalState = require(EditProfileParent.SignalsReact).useSignalState
local updateUserDisplayName = require(EditProfile.Stores.Requests.updateUserDisplayName)
local validateUserDisplayName = require(EditProfile.Stores.Requests.validateUserDisplayName)
local AnalyticsServiceV2 = require(EditProfile.Analytics.AnalyticsServiceV2)

return function(tbl1)
    local var2 = useLocalUserId()
    local var3 = React.useMemo(function()
        return var1.fetchNamesByUserIds({ tostring(var2) })
    end, { var2 })
    local var4 = useSignalState(var3)

    local initialDisplayName = React.useMemo(function()
        if var4 and var4.status == "success" and var4.data and #var4.data > 0 then
            return var4.data[1].names.getDisplayName(false) or ""
        end

        return ""
    end, { var4 })

    local var6, var7 = React.useState(initialDisplayName)
    local onDataChange = React.useCallback(function(arg1)
        var7(arg1)
    end, {})

    React.useEffect(function()
        AnalyticsServiceV2.sendDisplayNameModalLoaded()
    end, {})

    React.useEffect(function()
        tbl1.registerSaveHandler(function()
            return updateUserDisplayName(tostring(var2), var6):andThen(function(arg1)
                AnalyticsServiceV2.sendDisplayNameSaved(var6)
                if not var4 or not var4.data or not (#var4.data > 0) then
                    return
                end

                local var9 = var4.data[1]
                if var9.names.setDisplayName then
                    var9.names.setDisplayName(arg1)
                end
            end)
        end)
    end, {
        tbl1.registerSaveHandler,
        var2,
        var6,
        var4
    })
    return React.createElement(EditDisplayName, {
        initialDisplayName = initialDisplayName,
        onDataChange = onDataChange,
        validateDisplayName = function(str1: string)
            return validateUserDisplayName(tostring(var2), str1)
        end,
        updateErrorState = tbl1.updateErrorState,
        textBoxRef = tbl1.textBoxRef
    })
end
