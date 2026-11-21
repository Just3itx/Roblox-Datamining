-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T12:10:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local EditProfile = script:FindFirstAncestor("EditProfile")
local EditProfileParent = EditProfile.Parent
local React = require(EditProfileParent.React)
local Enums = require(EditProfile.Common.Enums)
local EditDisplayName = require(EditProfile.Components.EditDisplayName)
local EditBio = require(EditProfile.Components.EditBio)
local TextKeys = require(EditProfile.Common.TextKeys)
local FFlagEditProfileAlignBioTranslationKeys = require(EditProfile.Flags.FFlagEditProfileAlignBioTranslationKeys)
local useRealNamesInDisplayNamesEnabled = require(EditProfile.Hooks.useRealNamesInDisplayNamesEnabled)
local useNavigation = require(EditProfileParent.Navigation).useNavigation
local Promise = require(EditProfileParent.Promise)
local ProfileRefreshSignal = require(EditProfileParent.ProfilePlatformCommon).Signals.ProfileRefreshSignal

local tbl1 = {
    [Enums.Screens.EditDisplayName] = {
        component = EditDisplayName,
        titleKey = TextKeys.EditDisplayName
    },
    [Enums.Screens.EditBio] = {
        component = EditBio,
        titleKey = if FFlagEditProfileAlignBioTranslationKeys then TextKeys.EditBio else TextKeys.About
    }
}

return function(editDisplayName)
    local var1 = tbl1[editDisplayName]
    local var2 = useNavigation()
    local var3 = useRealNamesInDisplayNamesEnabled()

    local var4 = React.useRef(nil)
    local isLoading, var6 = React.useState(false)
    local hasError, var8 = React.useState(false)

    local updateErrorState = React.useCallback(function(bool1: boolean)
        var8(bool1)
    end, {})

    local onClose = React.useCallback(function()
        ProfileRefreshSignal.notifyProfileRefresh()
        var2.goBack()
    end, { var2 })

    local registerSaveHandler = React.useCallback(function(current: (...any) -> (...any))
        var4.current = current
    end, {})

    local onSave = React.useCallback(function()
        if not var4.current or hasError then
            return
        end

        var6(true)
        Promise.resolve(var4.current()):andThen(function()
            var6(false)
            onClose()
        end):catch(function(_)
            var6(false)
        end)
    end, { hasError })

    local titleKey = if editDisplayName ~= Enums.Screens.EditDisplayName then var1.titleKey elseif var3 then TextKeys.EditAgedUpDisplayName else TextKeys.EditDisplayName
    return {
        component = var1.component,
        titleKey = titleKey,
        saveKey = TextKeys.SaveButtonText,
        onClose = onClose,
        onSave = onSave,
        isLoading = isLoading,
        registerSaveHandler = registerSaveHandler,
        updateErrorState = updateErrorState,
        hasError = hasError
    }
end
