-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T04:50:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent

local React = require(ProfilePlatformParent.React)

local HorizontalPageMargin = require(ProfilePlatformParent.UIBlox).App.Container.HorizontalPageMargin

local CTAButtonsRow = require(ProfilePlatform.Components.CTARow.CTAButtonsRow)
local useMapJsonToButtonList = require(ProfilePlatform.Components.CTARow.useMapJsonToButtonList)
local useProfileWrapperContext = require(ProfilePlatform.Contexts.useProfileWrapperContext)
local useIsMeTab = require(ProfilePlatform.Hooks.useIsMeTab)
local useProfileAnalyticsContext = require(ProfilePlatform.Contexts.useProfileAnalyticsContext)
local EventNames = require(ProfilePlatform.Analytics.EventNames)
local SocialStopwatch = require(ProfilePlatformParent.SocialStopwatch)
local LoadingStagesExtension = require(ProfilePlatform.Analytics.LoadingStagesExtension)
local useEffectOnMount = require(ProfilePlatformParent.RoactUtils).Hooks.useEffectOnMount
local FFlagAXEnableProfileTab = require(ProfilePlatformParent.SharedFlags).FFlagAXEnableProfileTab

local function CTAButtonRowContainer(tbl1)
    local profileId = useProfileWrapperContext().profileId
    local buttonList = useMapJsonToButtonList(profileId)
    local var2 = if FFlagAXEnableProfileTab then useIsMeTab() else nil
    local var3 = useProfileAnalyticsContext()
    useEffectOnMount(function()
        local var4 = SocialStopwatch.Stopwatch.get(SocialStopwatch.Events.ProfileOpened)

        var3.fireAnalyticsEvent(EventNames.ProfileLoadingStage, {
            statValue = if var4 then var4.timeElapsed else nil,
            status = LoadingStagesExtension.CTALoaded,
            isProfilePlatform = true
        })
    end)

    if FFlagAXEnableProfileTab and var2 then
        return React.createElement(CTAButtonsRow, { buttonList = buttonList, layoutOrder = tbl1.layoutOrder })
    end

    return React.createElement(
        HorizontalPageMargin,
        {
            size = UDim2.new(1, 0, 0, 0),
            backgroundTransparency = 1,
            layoutOrder = tbl1.layoutOrder,
            useAutomaticSizing = true
        },
        {
            Content = React.createElement(CTAButtonsRow, { buttonList = buttonList, layoutOrder = 1 })
        }
    )
end

return CTAButtonRowContainer
