-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:41:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceProfilePictureEditor = script:FindFirstAncestor("AvatarExperienceProfilePictureEditor")
local AvatarExperienceProfilePictureEditorParent = AvatarExperienceProfilePictureEditor.Parent

local React = require(AvatarExperienceProfilePictureEditorParent.React)

local fetchInternal = require(AvatarExperienceProfilePictureEditor.Api.fetchInternal)
local EditProfileImageAnalytics = require(AvatarExperienceProfilePictureEditor.Analytics.EditProfileImageAnalytics)
local profileFramesWidgetsApi = require(AvatarExperienceProfilePictureEditor.Api.profileFramesWidgetsApi)
local mapWidgetContentToFrameItems = require(AvatarExperienceProfilePictureEditor.Utils.mapWidgetContentToFrameItems)

local function useProfileFrames()
    local frameItems, var2 = React.useState({})
    local isLoading, var4 = React.useState(true)
    local hasError, var6 = React.useState(false)

    local var7 = React.useCallback(function()
        profileFramesWidgetsApi.fetchProfileFramesWidgets(fetchInternal):andThen(function(arg1)
            local var7 = not (arg1 and arg1.widgetContent) and {} or arg1.widgetContent
            local hydrateResponseBody = if arg1 then arg1.hydrateResponseBody else nil
            local var8 = mapWidgetContentToFrameItems.mapWidgetContentToFrameItems(var7, hydrateResponseBody)

            var6(false)
            var2(var8)
            var4(false)
        end):catch(function(_)
            EditProfileImageAnalytics.logFetchFailure({ assetType = "frames" })

            var6(true)
            var2({})
            var4(false)
        end)
    end, {})

    local refetch = React.useCallback(function()
        var4(true)
        var6(false)
        var7()
    end, { var7 })

    React.useEffect(function()
        var7()
    end, { var7 })

    return {
        frameItems = frameItems,
        isLoading = isLoading,
        hasError = hasError,
        refetch = refetch
    }
end

return useProfileFrames
