-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T11:51:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local EditProfile = script:FindFirstAncestor("EditProfile")
local EditProfileParent = EditProfile.Parent
local React = require(EditProfileParent.React)
local EditBio = require(script.Parent.EditBio)
local Promise = require(EditProfileParent.Promise)

local useLocalUserId = require(EditProfileParent.RobloxAppHooks).useLocalUserId
local EditProfileStore = require(EditProfile.Stores.EditProfileStore)
local useSignalState = require(EditProfileParent.SignalsReact).useSignalState
local AnalyticsServiceV2 = require(EditProfile.Analytics.AnalyticsServiceV2)

return function(tbl1)
    local var1 = useLocalUserId()
    local description = EditProfileStore.getDescription(var1)
    local var2 = useSignalState(description.data) or ""

    local bioText, var4 = React.useState(var2)
    local errorCode, var6 = React.useState(nil)

    local onDataChange = React.useCallback(function(arg1)
        var4(arg1)
        var6(nil)
    end, {})

    React.useEffect(function()
        var4(var2)
    end, { var2 })

    React.useEffect(function()
        tbl1.registerSaveHandler(function()
            return EditProfileStore.updateDescription(var1, bioText):catch(function(arg1)
                if not arg1 then
                    return
                end

                local var8 = nil
                if arg1.errors and arg1.errors[1] then
                    var8 = arg1.errors[1].code
                elseif arg1.statusCode then
                    var8 = arg1.statusCode
                end

                if var8 then
                    var6(var8)
                    AnalyticsServiceV2.sendError(var8)
                end
                return Promise.reject(arg1)
            end)
        end)
    end, { tbl1.registerSaveHandler, var1, bioText })

    return React.createElement(
        EditBio,
        {
            bioText = bioText,
            onDataChange = onDataChange,
            errorCode = errorCode,
            textBoxRef = tbl1.textBoxRef
        }
    )
end
