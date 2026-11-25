-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:01:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent

local Promise = require(ProfilePlatformParent.Promise)
local React = require(ProfilePlatformParent.React)
local RoactNavigation = require(ProfilePlatformParent.RoactNavigation)
local HorizontalPageMargin = require(ProfilePlatformParent.UIBlox).App.Container.HorizontalPageMargin

local Responsive = require(ProfilePlatformParent.Responsive)
local usePreferredInput = Responsive.usePreferredInput

local SduiSharedUtilities = require(ProfilePlatformParent.SduiSharedUtilities)
local SduiFeatureEntryPoint = SduiSharedUtilities.SduiFeatureEntryPoint
local useComponentConfig = SduiSharedUtilities.useComponentConfig
local usePublishContainerWidth = SduiSharedUtilities.usePublishContainerWidth

local Enums = require(ProfilePlatform.Common.Enums)
local useProfileWrapperContext = require(ProfilePlatform.Contexts.useProfileWrapperContext)

local FFlagGroupPeekEngagementTelemetry = require(ProfilePlatformParent.SharedFlags).FFlagGroupPeekEngagementTelemetry
local FFlagGroupSduiPublishContainerWidth = require(ProfilePlatformParent.SharedFlags).FFlagGroupSduiPublishContainerWidth

local GroupPeekSdui = nil
local function getGroupPeekSdui() -- Luacid: Inlined by compiler; 3 call sites recovered
    if GroupPeekSdui == nil then
        GroupPeekSdui = require(ProfilePlatformParent.GroupPeekSdui)
    end
    return GroupPeekSdui
end

local function getIdentifier(groupPeekSdui, announcements: string) -- Luacid: Inlined by compiler; 1 call site recovered
    return if announcements == Enums.Components.Announcements then groupPeekSdui.Identifiers.Announcement else groupPeekSdui.Identifiers.ForumsDiscovery
end

local function ContainerWidthFrame(tbl1)
    local ref = usePublishContainerWidth(tbl1.configKey)
    return React.createElement("Frame", {
        Size = UDim2.fromScale(1, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        LayoutOrder = 1,
        ref = ref
    }, tbl1.children)
end

local function SectionEntry(tbl1)
    local groupPeekSdui = getGroupPeekSdui()
    local configKey = groupPeekSdui.getConfigKey(tbl1.groupId)

    local identifier = getIdentifier(groupPeekSdui, tbl1.section)
    local var1 = useComponentConfig(configKey, identifier)

    local additionalAnalyticsData = if FFlagGroupPeekEngagementTelemetry then React.useMemo(function()
        return {
            sessionId = tbl1.sessionId,
            groupId = tonumber(tbl1.groupId),
            locationTab = "peek",
            pageRoute = "/peek"
        }
    end, { tbl1.sessionId, tbl1.groupId }) else nil

    if var1 == nil then
        return nil
    end

    local element = React.createElement(SduiFeatureEntryPoint, {
        appPage = groupPeekSdui.AppPage,
        configKey = configKey,
        identifier = identifier,
        shouldDisplayLoading = false,
        shouldDisplayError = false,
        LayoutOrder = 1,
        additionalAnalyticsData = additionalAnalyticsData
    })

    local createElement = React.createElement
    local var3 = HorizontalPageMargin
    local tbl2 = {
        size = UDim2.new(1, 0, 0, 0),
        backgroundTransparency = 1,
        layoutOrder = tbl1.layoutOrder,
        useAutomaticSizing = true
    }
    local tbl3 = { Sdui = 0 }
    if FFlagGroupSduiPublishContainerWidth then
        element = React.createElement(ContainerWidthFrame, { configKey = configKey }, { Sdui = element })
    end

    tbl3.Sdui = element
    return createElement(var3, tbl2, tbl3)
end

return React.memo(function(tbl1) -- name: GroupPeekSduiSection
    local var1 = useProfileWrapperContext()

    local profileId = var1.profileId

    local bool1 = usePreferredInput() ~= Responsive.Input.Directional

    if bool1 then
        if profileId == nil then
            bool1 = false
        else
            bool1 = profileId ~= ""
        end
    end

    local var2 = React.useCallback(function(bool2: boolean)
        Promise.try(function()
            return getGroupPeekSdui().fetchGroupPeekPage(profileId, bool2)
        end):catch(function() end)
    end, { profileId })

    React.useEffect(function()
        if not bool1 then
            return
        end
        getGroupPeekSdui().registerGroupAnnouncementActions()
        var2(false)
    end, { bool1, var2 })

    if not bool1 then
        return nil
    end

    return React.createElement(React.Fragment, nil, {
        NavEvents = React.createElement(RoactNavigation.NavigationEvents, {
            onDidFocus = function()
                var2(true)
            end
        }),
        Section = React.createElement(
            SectionEntry,
            {
                groupId = profileId,
                layoutOrder = tbl1.layoutOrder,
                section = tbl1.section,
                sessionId = var1.profileSessionId
            }
        )
    })
end)
