-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:01:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local TelemetryService = game:GetService("TelemetryService")
local ProfilePlatformParent = ProfilePlatform.Parent
local React = require(ProfilePlatformParent.React)
local useRoactService = require(ProfilePlatformParent.RobloxAppHooks).useRoactService
local RoactAnalyticsCommonGameEvents = require(ProfilePlatformParent.RoactServiceTags).RoactAnalyticsCommonGameEvents

local useLocalization = require(ProfilePlatformParent.Localization).Hooks.useLocalization
local TextKeys = require(ProfilePlatform.Common.TextKeys)
local ContentType = require(ProfilePlatformParent.UnifiedLogging).ContentType
local Cryo = require(ProfilePlatformParent.Cryo)
local SquareCollectionGridView = require(ProfilePlatform.BaseComponents.CollectionGridViews.SquareCollectionGridView)

local Enums = require(ProfilePlatform.Common.Enums)
local useRenderExperienceTile = require(ProfilePlatform.Hooks.Tiles.useRenderExperienceTile)
local useProfileAnalyticsContext = require(ProfilePlatform.Contexts.useProfileAnalyticsContext)
local useProfileWrapperContext = require(ProfilePlatform.Contexts.useProfileWrapperContext)
local formatExperienceDetailsForImpressions = require(ProfilePlatform.Hooks.formatExperienceDetailsForImpressions)
local useGenerateImpressionsTag = require(ProfilePlatform.Hooks.useGenerateImpressionsTag)
local useSendItemImpressions = require(ProfilePlatform.Hooks.useSendItemImpressions)
local EventNames = require(ProfilePlatform.Analytics.EventNames)
local _Types = require(ProfilePlatform.Common.Types)
local AppPage = require(ProfilePlatformParent.RobloxAppEnums).AppPage

local useTextSizeOffset = require(ProfilePlatformParent.Foundation).Hooks.useTextSizeOffset

local throttlingPercentage = game:DefineFastInt("CommunityProfileAffiliatedExperienceTelemetryThrottlePermyriad", 0)

local function getTextSizeAdjustedSquareExperienceTileHeight(num2: number): (number) -> number -- Luacid: Inlined by compiler; 1 call site recovered
    return function(num3: number): number
        return num3 + 80 + num2 * 3
    end
end

local function Experiences(tbl1)
    local experienceDetails = tbl1.experienceDetails

    local var1 = useTextSizeOffset()
    local getItemHeight = React.useMemo(function(): (number) -> number
        return getTextSizeAdjustedSquareExperienceTileHeight(var1)
    end, { var1 })
    local var3 = useProfileAnalyticsContext()
    local var4 = useProfileWrapperContext()
    local var5 = useRoactService(RoactAnalyticsCommonGameEvents)

    local impressionsTag = useGenerateImpressionsTag(Enums.Components.Experiences)
    local var7 = React.useMemo(function()
        return formatExperienceDetailsForImpressions(experienceDetails)
    end, { experienceDetails })

    local sendImpressions = useSendItemImpressions(var7, 3, ContentType.Game, tbl1.layoutOrder, Enums.Components.Experiences)

    local var9 = React.useCallback(function(arg1, positionInComponent: number, num2: number?)
        var3.fireAnalyticsEvent(
            EventNames.ExperienceOpened,
            {
                experienceId = arg1.experienceId,
                positionInComponent = positionInComponent
            }
        )
        local config = {
            eventName = "communityAffiliatedExperienceClick",
            backends = { "EventIngest" },
            throttlingPercentage = throttlingPercentage,
            lastUpdated = { 25, 6, 5 },
            description = "Event fired from the client every time an experience is clicked from a community profile",
            links = "https://github.rbx.com/Roblox/proto-schemas/pull/6250"
        }

        local customFields = {
            community_id = var4.profileId,
            affiliationType = "owner",
            place_id = arg1.rootPlaceId,
            universe_id = arg1.experienceId
        }
        TelemetryService:LogEvent(config, { customFields = customFields })

        local experienceDetailsLen = experienceDetails and #experienceDetails or 0

        var5.reportOpenGameDetailFromProfile(
            arg1.rootPlaceId,
            positionInComponent,
            experienceDetailsLen,
            arg1.experienceId,
            AppPage.ProfilePlatform,
            tbl1.layoutOrder,
            num2 or 1,
            nil
        )
    end, {
        var3,
        experienceDetails,
        var5,
        tbl1.layoutOrder
    })
    local renderItem = useRenderExperienceTile(impressionsTag, "ProfileExperienceTile", var9, true)

    local var11 = useLocalization({ title = TextKeys.Experiences })

    return if experienceDetails and not Cryo.isEmpty(experienceDetails) then React.createElement(
        SquareCollectionGridView,
        {
            getItemHeight = getItemHeight,
            hideHeaderButton = true,
            maxNumRows = 1,
            items = experienceDetails,
            layoutOrder = tbl1.layoutOrder,
            renderItem = renderItem,
            title = var11.title,
            impressionsTag = impressionsTag,
            sendImpressions = sendImpressions,
            overrides = { numColumns = 3 }
        }
    ) else nil
end

return Experiences
