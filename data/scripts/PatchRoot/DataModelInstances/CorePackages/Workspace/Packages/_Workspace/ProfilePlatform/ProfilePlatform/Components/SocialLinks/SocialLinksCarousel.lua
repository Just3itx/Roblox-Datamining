-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:20:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local TelemetryService = game:GetService("TelemetryService")
local ProfilePlatformParent = ProfilePlatform.Parent
local React = require(ProfilePlatformParent.React)
local CollectionViews = require(ProfilePlatformParent.CollectionViews)
local useRoactService = require(ProfilePlatformParent.RobloxAppHooks).useRoactService
local AppLinking = require(ProfilePlatformParent.RoactServiceTags).AppLinking
local useLocalization = require(ProfilePlatformParent.Localization).Hooks.useLocalization

local SocialLinkTile = require(ProfilePlatform.Components.SocialLinks.SocialLinkTile)
local useProfileWrapperContext = require(ProfilePlatform.Contexts.useProfileWrapperContext)
local TextKeys = require(ProfilePlatform.Common.TextKeys)
local useDynamicSizeMargin = require(ProfilePlatform.Hooks.useDynamicSizeMargin)
local sendSocialLinkClickEvent = require(ProfilePlatformParent.DiscoveryAnalytics).Events.sendSocialLinkClickEvent

local CollectionCarousel = CollectionViews.CollectionCarousel
local CollectionViewTypes = CollectionViews.CollectionViewTypes
local useCollectionLayoutParams = CollectionViews.useCollectionLayoutParams
local CollectionItemSize = CollectionViewTypes.CollectionItemSize

local FFlagLuaAppAddSocialLinkClickTelemetryToEdp = require(ProfilePlatformParent.SharedFlags).FFlagLuaAppAddSocialLinkClickTelemetryToEdp
local throttlingPercentage = if FFlagLuaAppAddSocialLinkClickTelemetryToEdp then nil else game:DefineFastInt("SocialLinkClickTelemetryThrottlePermyriad", 0)

return function(tbl1)
    local var2 = useProfileWrapperContext()
    local openLeaveRobloxAlertUiBlox = var2.navigateTo.openLeaveRobloxAlertUIBlox
    local closeLeaveRobloxAlert = var2.navigateTo.closeLeaveRobloxAlert
    local var3 = useRoactService(AppLinking)
    local var4, containerRef = React.useState(nil)
    local scrollingFrameRef = React.useRef(nil)
    local var7 = useLocalization({ title = TextKeys.SocialMedia })

    local sideMargin, var9 = useDynamicSizeMargin()
    local var10 = useCollectionLayoutParams(CollectionItemSize.XSmall, var4, true, { sideMargin = sideMargin })

    local getItemHeight = React.useCallback(function(num1: number): number
        return num1 + 36
    end, {})

    local function func1(socialLinkType, socialLinkUrl) -- Luacid: Inlined by compiler; 1 call site recovered
        return function()
            if FFlagLuaAppAddSocialLinkClickTelemetryToEdp then
                sendSocialLinkClickEvent({
                    assignment_id = var2.profileId,
                    assignment_type = "group",
                    social_link_type = socialLinkType,
                    social_link_url = socialLinkUrl,
                    social_link_display_type = "badge"
                })
            else
                local config = {
                    eventName = "socialLinkClickEvent",
                    backends = { "EventIngest" },
                    throttlingPercentage = throttlingPercentage,
                    lastUpdated = { 25, 5, 20 },
                    description = "Event fired from the client every time a social link is clicked",
                    links = "https://github.rbx.com/Roblox/proto-schemas/blob/master/production/eventstream/usercommunities/social_link_click_event.proto"
                }

                local customFields = {
                    assignment_id = var2.profileId,
                    assignment_type = "group",
                    social_link_type = socialLinkType,
                    social_link_url = socialLinkUrl,
                    social_link_display_type = "badge"
                }

                TelemetryService:LogEvent(config, { customFields = customFields })
            end
            if var3 then
                var3:openURL(socialLinkUrl):andThen(function(arg1)
                    if arg1 == false then
                        var3:openURL(socialLinkUrl)
                    end
                end)
            end

            if closeLeaveRobloxAlert then
                closeLeaveRobloxAlert()
            end
        end
    end

    local var12 = React.useCallback(function(arg1)
        return function()
            if openLeaveRobloxAlertUiBlox and var3 and arg1.url then
                local func2 = func1(arg1.key, arg1.url)
                openLeaveRobloxAlertUiBlox(func2)
            end
        end
    end, { openLeaveRobloxAlertUiBlox, var3 })

    local renderItem = React.useCallback(function(arg1, layoutOrder, _)
        return React.createElement(
            SocialLinkTile,
            {
                name = arg1.name,
                icon = arg1.logo,
                tileSize = 80,
                onActivated = var12(arg1),
                layoutOrder = layoutOrder
            }
        ), arg1.key
    end, { var12 })

    return React.createElement("Frame", {
        AutomaticSize = Enum.AutomaticSize.Y,
        Size = UDim2.new(1, 0, 0, 0),
        BackgroundTransparency = 1,
        LayoutOrder = tbl1.layoutOrder,
        [React.Change.AbsoluteSize] = var9
    }, {
        UIPadding = React.createElement("UIPadding", { PaddingLeft = UDim.new(0, 0), PaddingRight = UDim.new(0, 0) }),
        CollectionCarousel = React.createElement(CollectionCarousel, {
            containerRef = containerRef,
            scrollingFrameRef = scrollingFrameRef,
            LayoutOrder = 1,
            title = var7.title,
            items = tbl1.items,
            renderItem = renderItem,
            getItemHeight = getItemHeight,
            numColumns = var10.numColumns,
            fractionalItemAmount = var10.fractionalItemAmount,
            columnGap = var10.columnGap,
            sideMargin = var10.sideMargin,
            maxItemsToShow = var10.maxTilesToShow,
            thresholdFromEnd = var10.loadMoreThreshold
        })
    })
end
