-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:41:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceProfilePictureEditor = script:FindFirstAncestor("AvatarExperienceProfilePictureEditor")
local AvatarExperienceProfilePictureEditorParent = AvatarExperienceProfilePictureEditor.Parent
local FFlagEditProfileFramesEnabled = require(AvatarExperienceProfilePictureEditorParent.SharedFlags).FFlagEditProfileFramesEnabled
local React = require(AvatarExperienceProfilePictureEditorParent.React)
local _useUserAvatarConfigurations = require(AvatarExperienceProfilePictureEditor.Hooks.useUserAvatarConfigurations)

local Constants = require(AvatarExperienceProfilePictureEditor.Constants)

local function useEditProfileImageDraft(tbl1)
    local savedCloseupConfig = tbl1.savedCloseupConfig
    local savedFrameAssetId = tbl1.savedFrameAssetId
    local isSavedConfigLoading = tbl1.isSavedConfigLoading
    local showFrames = tbl1.showFrames
    local initialFrameAssetId = tbl1.initialFrameAssetId
    local initialFrameSelectionRequestId = tbl1.initialFrameSelectionRequestId
    local isInitialFrameSelectionLoading = tbl1.isInitialFrameSelectionLoading
    local isInitialFrameAvailable = tbl1.isInitialFrameAvailable

    local selectedEmoteId, var2 = React.useState(nil)
    local selectedFrameId, var4 = React.useState(nil)
    local yRotDeg, onYRotDegChanged = React.useState(0)
    local distanceScale, onDistanceScaleChanged = React.useState(1)

    local var9 = React.useRef(false)
    local var10 = React.useRef(false)
    local var11 = React.useRef(nil)

    local resetFromSavedConfig = React.useCallback(function()
        if isSavedConfigLoading then
            return
        end

        var2(savedCloseupConfig.emoteAssetId)
        onYRotDegChanged(savedCloseupConfig.yRotDeg)
        onDistanceScaleChanged(savedCloseupConfig.distanceScale)

        if FFlagEditProfileFramesEnabled and showFrames then
            var4(savedFrameAssetId or Constants.ProfileFrameNoneId)
            return
        end
        var4(nil)
    end, {
        savedCloseupConfig,
        savedFrameAssetId,
        isSavedConfigLoading,
        showFrames
    })

    React.useEffect(function()
        if var9.current or isSavedConfigLoading then
            return
        end
        var9.current = true
        if savedCloseupConfig.emoteAssetId then
            var2(savedCloseupConfig.emoteAssetId)
        end
        onYRotDegChanged(savedCloseupConfig.yRotDeg)
        onDistanceScaleChanged(savedCloseupConfig.distanceScale)
    end, {
        savedCloseupConfig.emoteAssetId,
        savedCloseupConfig.yRotDeg,
        savedCloseupConfig.distanceScale,
        isSavedConfigLoading
    })

    React.useEffect(function()
        local bool1 = not (initialFrameSelectionRequestId == nil) and initialFrameSelectionRequestId ~= var11.current

        if not FFlagEditProfileFramesEnabled
            or not showFrames
            or var10.current and not bool1
            or isSavedConfigLoading
            or isInitialFrameSelectionLoading
        then
            return
        end

        var10.current = true
        var11.current = initialFrameSelectionRequestId
        var4(
            if initialFrameAssetId ~= nil and isInitialFrameAvailable then initialFrameAssetId else savedFrameAssetId or Constants.ProfileFrameNoneId
        )
    end, {
        initialFrameAssetId,
        initialFrameSelectionRequestId,
        isInitialFrameSelectionLoading,
        isInitialFrameAvailable,
        savedFrameAssetId,
        isSavedConfigLoading,
        showFrames
    })

    return {
        selectedEmoteId = selectedEmoteId,
        selectedFrameId = selectedFrameId,
        yRotDeg = yRotDeg,
        distanceScale = distanceScale,
        onSelectEmote = React.useCallback(function(str1: string)
            var2(function(arg1): string?
                return if arg1 == str1 then nil else str1
            end)
        end, {}),
        onSelectFrame = React.useCallback(function(str1: string)
            var4(function(arg1)
                return if arg1 == str1 then Constants.ProfileFrameNoneId else str1
            end)
        end, {}),
        onYRotDegChanged = onYRotDegChanged,
        onDistanceScaleChanged = onDistanceScaleChanged,
        clearSelectedEmote = React.useCallback(function()
            var2(nil)
        end, {}),
        resetFromSavedConfig = resetFromSavedConfig
    }
end

return useEditProfileImageDraft
