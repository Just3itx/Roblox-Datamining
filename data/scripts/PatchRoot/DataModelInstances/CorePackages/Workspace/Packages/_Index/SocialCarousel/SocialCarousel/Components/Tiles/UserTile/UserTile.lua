-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T18:01:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialCarousel = script:FindFirstAncestor("SocialCarousel")
local SocialCarouselParent = SocialCarousel.Parent
local React = require(SocialCarouselParent.React)
local SocialCommon = require(SocialCarouselParent.SocialCommon)
local UserTile = require(SocialCarouselParent.UserTile).UserTile
local LayoutMode = require(SocialCarouselParent.UserTile).LayoutMode
local Foundation = require(SocialCarouselParent.Foundation)

local useTokens = Foundation.Hooks.useTokens
local View = Foundation.View
local IconButton = Foundation.IconButton
local ButtonVariant = Foundation.Enums.ButtonVariant
local InputSize = Foundation.Enums.InputSize
local convertToFoundationPresenceEnum = SocialCommon.Utils.convertToFoundationPresenceEnum
local PresenceTypes = SocialCommon.Enums.PresenceTypes
local Enums = require(SocialCarousel.Common.Enums)
local MarqueePlayStatus = Enums.MarqueePlayStatus

local FFlagFriendsCarouselProfileFrameEnabled = require(SocialCarousel.Flags.FFlagFriendsCarouselProfileFrameEnabled)
local FFlagSocialCarouselShowPlusBadge = require(SocialCarousel.Flags.FFlagSocialCarouselShowPlusBadge)
local FFlagSocialCarouselInGameTitleMarquee = require(SocialCarouselParent.SharedFlags).FFlagSocialCarouselInGameTitleMarquee
local FFlagShowRequestsInCarouselForAllUsers = require(SocialCarouselParent.SharedFlags).FFlagShowRequestsInCarouselForAllUsers
local FFlagSocialCarouselBuildPresence = require(SocialCarouselParent.SharedFlags).FFlagSocialCarouselBuildPresence
local FFlagSocialCarouselXSmallTileText = require(SocialCarousel.Flags.FFlagSocialCarouselXSmallTileText)
local FFlagSocialCarouselInGamePlayIcon = require(SocialCarouselParent.SharedFlags).FFlagSocialCarouselInGamePlayIcon
local useXSmallTileTypography = require(SocialCarousel.Hooks.useXSmallTileTypography)
local MarqueeScrollContext = require(SocialCarousel.Stores.MarqueeSession.MarqueeScrollContext).MarqueeScrollContext

local MarqueeText = if FFlagSocialCarouselInGameTitleMarquee then require(SocialCarousel.Components.MarqueeText.MarqueeText) else nil

local function UserTileMarqueeListener(tbl1)
    local tileRef = tbl1.tileRef
    local buttonRef = tbl1.buttonRef
    local onManualMarqueeStart = tbl1.onManualMarqueeStart
    local onManualMarqueeEnd = tbl1.onManualMarqueeEnd
    local friendId = tbl1.friendId
    local marqueeOnFocusEnabled = tbl1.marqueeOnFocusEnabled

    React.useEffect(function()
        local current = if tileRef == nil then nil else tileRef.current

        if current == nil or not current:IsA("GuiObject") then
            return
        end

        current:SetAttribute(Enums.MarqueeFriendIdAttribute, friendId)
        local current2 = if FFlagSocialCarouselInGamePlayIcon and buttonRef ~= nil then buttonRef.current else nil

        if current2 == nil then
            if current:IsA("GuiButton") then
                current2 = current
            else
                current2 = current

                for _, descendant in current:GetDescendants() do
                    if descendant:IsA("GuiButton") then
                        current2 = descendant
                        break
                    end
                end
            end
        end

        local connection = current2.MouseEnter:Connect(function()
            onManualMarqueeStart(friendId)
        end)
        local connection2 = current2.MouseLeave:Connect(function()
            if onManualMarqueeEnd then
                onManualMarqueeEnd(friendId)
            end
        end)
        local connection3 = nil
        local connection4 = nil
        if marqueeOnFocusEnabled then
            if game:GetService("GuiService").SelectedCoreObject == current2 then
                onManualMarqueeStart(friendId)
            end
            connection3 = current2.SelectionGained:Connect(function()
                onManualMarqueeStart(friendId)
            end)
            connection4 = current2.SelectionLost:Connect(function()
                if onManualMarqueeEnd then
                    onManualMarqueeEnd(friendId)
                end
            end)
        end
        return function()
            current:SetAttribute(Enums.MarqueeFriendIdAttribute, nil)
            connection:Disconnect()
            connection2:Disconnect()
            if connection3 then
                connection3:Disconnect()
            end
            if connection4 then
                connection4:Disconnect()
            end

            if onManualMarqueeEnd then
                onManualMarqueeEnd(friendId)
            end
        end
    end, {
        tileRef,
        buttonRef,
        onManualMarqueeStart,
        onManualMarqueeEnd,
        friendId,
        marqueeOnFocusEnabled
    })

    return nil
end

local function UserTile2(tbl1)
    local var1 = useTokens()
    local var2 = if FFlagSocialCarouselXSmallTileText then useXSmallTileTypography() else nil
    local buttonRef = if FFlagSocialCarouselInGamePlayIcon then React.useRef(nil) else nil
    local userPresenceType = if tbl1.item.presence ~= nil then Foundation.Enums.UserPresence[convertToFoundationPresenceEnum(tbl1.item.presence.userPresenceType)] else Foundation.Enums.UserPresence.None
    local contextualText = tbl1.contextualText
    if FFlagSocialCarouselInGameTitleMarquee then
        local var5 = React.useContext(MarqueeScrollContext)
        React.useEffect(function()
            if var5 ~= nil and tbl1.playStatus == MarqueePlayStatus.Idle then
                var5.clearCurrentScroll(tbl1.item.id)
            end
        end, { var5, tbl1.playStatus, tbl1.item.id })
        local presence = tbl1.item.presence
        local lastLocation = if presence and presence.userPresenceType == PresenceTypes.InGame then presence.lastLocation else nil

        if lastLocation ~= nil
            and lastLocation ~= ""
            and tbl1.contextualText == lastLocation
            and tbl1.playStatus ~= nil
            and MarqueeText
        then
            local onMarqueeFinished = tbl1.onMarqueeFinished
            local playStatus = if tbl1.playStatus ~= nil then tbl1.playStatus else MarqueePlayStatus.Idle
            local id = tbl1.item.id
            local bool1 = playStatus ~= MarqueePlayStatus.Idle
            local createElement = React.createElement
            local var7 = MarqueeText

            local tbl2 = {
                text = lastLocation,
                playStatus = playStatus,
                fontStyle = if var2 then var2.label else var1.Typography.LabelSmall,
                LayoutOrder = 2,
                maxLoops = if onMarqueeFinished ~= nil then 1 else nil,
                runId = tbl1.marqueeRunId,
                holdForNextLoop = onMarqueeFinished ~= nil,
                marqueeShortTitlesEnabled = tbl1.marqueeShortTitlesEnabled == true,
                initialOffset = if var5 == nil or not bool1 then nil else var5.initialOffsetFor(id),
                saveOffset = var5 ~= nil and bool1 and function(num1: number)
                    var5.saveOffset(id, num1)
                end or nil,
                onFinished = (var5 ~= nil or onMarqueeFinished ~= nil) and function()
                    if var5 ~= nil then
                        var5.clearCurrentScroll(id)
                    end
                    if onMarqueeFinished ~= nil then
                        onMarqueeFinished(id)
                    end
                end or nil
            }

            contextualText = createElement(var7, tbl2)
        end
    end

    local createElement = React.createElement
    local var5 = View
    local tbl2 = {
        tag = "auto-none",
        Size = tbl1.itemSize,
        LayoutOrder = tbl1.index,
        ref = tbl1.tileRef,
        selection = tbl1.selectionOrder and {
            SelectionOrder = tbl1.selectionOrder,
            Selectable = true
        } or nil
    }

    local tbl3 = {
        MarqueeListener = if FFlagSocialCarouselInGameTitleMarquee and tbl1.onManualMarqueeStart ~= nil then React.createElement(
            UserTileMarqueeListener,
            {
                tileRef = tbl1.tileRef,
                buttonRef = buttonRef,
                friendId = tbl1.item.id,
                onManualMarqueeStart = tbl1.onManualMarqueeStart,
                onManualMarqueeEnd = tbl1.onManualMarqueeEnd,
                marqueeOnFocusEnabled = tbl1.marqueeOnFocusEnabled
            }
        ) else nil,
        Content = React.createElement(UserTile, {
            layoutMode = LayoutMode.compact,
            userId = tbl1.item.id,
            title = tbl1.name,
            subtitle = contextualText,
            titleStyle = if var2 then var2.title else var1.Typography.TitleSmall,
            subtitleStyle = if var2 then var2.label else var1.Typography.LabelSmall,
            contextualInfo = if FFlagSocialCarouselBuildPresence then tbl1.contextualInfo else nil,
            contextualInfoIcon = if FFlagSocialCarouselBuildPresence then tbl1.contextualInfoIcon else nil,
            contextualInfoStyle = if FFlagSocialCarouselBuildPresence then if var2 then var2.label else var1.Typography.LabelSmall else nil,
            userPresenceType = userPresenceType,
            onActivated = tbl1.onActivated,
            titleIcon = tbl1.titleIcon,
            overlayIcon = if FFlagShowRequestsInCarouselForAllUsers then tbl1.overlayIcon else nil,
            includeProfileFrame = FFlagFriendsCarouselProfileFrameEnabled,
            isRobloxSubscriber = if FFlagSocialCarouselShowPlusBadge then tbl1.isRobloxSubscriber else nil,
            buttonRef = buttonRef
        }),
        TextTapTarget = 0,
        AvatarTapTarget = 0,
        PlayIconOverlay = 0
    }
    local element

    if FFlagSocialCarouselInGamePlayIcon and tbl1.onTextActivated then
        element = React.createElement(View, {
            tag = "size-full-full",
            ZIndex = 2,
            onActivated = tbl1.onTextActivated,
            testId = `--social-social-carousel-view-tile-text-{tbl1.item.id}`,
            stateLayer = {
                affordance = Foundation.Enums.StateLayerAffordance.None
            },
            selection = { Selectable = false }
        })
    else
        element = nil
    end

    tbl3.TextTapTarget = element
    local element2

    if FFlagSocialCarouselInGamePlayIcon and tbl1.onTextActivated then
        element2 = React.createElement(View, {
            tag = "size-full-full aspect-1-1",
            ZIndex = 3,
            onActivated = tbl1.onActivated,
            testId = `--social-social-carousel-view-tile-avatar-{tbl1.item.id}`,
            stateLayer = {
                affordance = Foundation.Enums.StateLayerAffordance.None
            },
            selection = { Selectable = false }
        })
    else
        element2 = nil
    end

    tbl3.AvatarTapTarget = element2
    local element3

    if FFlagSocialCarouselInGamePlayIcon and tbl1.showPlayIcon then
        element3 = React.createElement(View, { tag = "size-full-full aspect-1-1", ZIndex = 4 }, {
            PlayIconBackplate = React.createElement(View, {
                tag = "anchor-center-center size-800-800 radius-circle bg-surface-0",
                Position = UDim2.new(0.5, 0, 1, -var1.Gap.Small)
            }, {
                PlayIcon = React.createElement(IconButton, {
                    icon = "play-large",
                    variant = ButtonVariant.Standard,
                    size = InputSize.XSmall,
                    isCircular = true,
                    onActivated = tbl1.onPlayIconActivated or tbl1.onActivated,
                    testId = `--social-social-carousel-iconbutton-play-{tbl1.item.id}`,
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Position = UDim2.fromScale(0.5, 0.5),
                    Selectable = false
                })
            })
        })
    else
        element3 = nil
    end

    tbl3.PlayIconOverlay = element3
    return createElement(var5, tbl2, tbl3)
end

return UserTile2
