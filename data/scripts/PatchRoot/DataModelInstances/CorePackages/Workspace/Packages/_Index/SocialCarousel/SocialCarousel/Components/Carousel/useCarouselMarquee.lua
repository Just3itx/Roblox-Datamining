-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T18:00:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialCarousel = script:FindFirstAncestor("SocialCarousel")
local SocialCarouselParent = SocialCarousel.Parent
local React = require(SocialCarouselParent.React)
local CollectionViews = require(SocialCarouselParent.CollectionViews)
local Foundation = require(SocialCarouselParent.Foundation)
local RobloxAppHooks = require(SocialCarouselParent.RobloxAppHooks)
local RobloxAppEnums = require(SocialCarouselParent.RobloxAppEnums)

local useMarqueeActiveTiles = require(script.Parent.useMarqueeActiveTiles).useMarqueeActiveTiles
local MarqueeTextMotion = require(SocialCarousel.Components.MarqueeText.MarqueeTextMotion)
local useNavigationFocus = require(SocialCarouselParent.Navigation).useNavigationFocus
local createMarqueeSessionStore = require(SocialCarousel.Stores.MarqueeSession.createMarqueeSessionStore)

local getMarqueeSessionStore = require(SocialCarousel.Stores.MarqueeSession.getMarqueeSessionStore).getMarqueeSessionStore
local _MarqueeScrollContext = require(SocialCarousel.Stores.MarqueeSession.MarqueeScrollContext)
local Tile = require(SocialCarousel.Common.Enums).Tile
local FFlagSocialCarouselFixColdStartJitter = require(SocialCarousel.Flags.FFlagSocialCarouselFixColdStartJitter)
local FFlagSocialCarouselInGameTitleMarquee = require(SocialCarouselParent.SharedFlags).FFlagSocialCarouselInGameTitleMarquee

local tbl1 = {}

local function isHomeBlurredOrJoinCardOpen(bool1: boolean?, str1: string?): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return bool1 ~= true or str1 ~= nil
end

local function isIdleMarqueeEnabled(arg1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return arg1 == RobloxAppEnums.DeviceType.Phone or arg1 == RobloxAppEnums.DeviceType.Tablet
end

local function isDesktopHoverEnabled(desktop, bool1: boolean, joinPopoverUserId: string?): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return desktop == RobloxAppEnums.DeviceType.Desktop and bool1 == true and joinPopoverUserId == nil
end

local function isConsoleFocusEnabled(console, bool1: boolean, joinPopoverUserId: string?): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return console == RobloxAppEnums.DeviceType.Console and bool1 == true and joinPopoverUserId == nil
end

return {
    useCarouselMarquee = function(tbl2, tbl3, joinPopoverUserId: string?, tbl4, joinPopoverUserIdRef, joinSheetUserIdRef, str1: string?, bool1: boolean?)
        local var1 = RobloxAppHooks.useDeviceType()
        local reducedMotion = Foundation.Hooks.usePreferences().reducedMotion
        local var2 = useNavigationFocus()
        local bool2 = if isHomeBlurredOrJoinCardOpen(var2, nil) then true else not not isHomeBlurredOrJoinCardOpen(true, joinPopoverUserId)

        local bool3 = bool1 == true
        local bool4 = bool3 and isIdleMarqueeEnabled(var1)
        local desktopEnabled = bool3 and isDesktopHoverEnabled(var1, var2, joinPopoverUserId)

        local consoleEnabled = bool3 and isConsoleFocusEnabled(var1, var2, joinPopoverUserId)

        local manualMarqueeEnabled = desktopEnabled or consoleEnabled
        local marqueeShortTitlesEnabled = bool3 and (var1 == RobloxAppEnums.DeviceType.Phone or var1 == RobloxAppEnums.DeviceType.Tablet)

        local var3 = React.useMemo(function()
            return createMarqueeSessionStore()
        end, {})
        if bool3 and str1 ~= nil then
            var3 = getMarqueeSessionStore(str1)
        end
        local var4 = React.useRef(nil)
        local var5 = React.useRef(false)
        local var6 = React.useRef(0)
        if not var5.current then
            var5.current = true
            if bool3 then
                var6.current = var3.beginMount()
                local current = var3.getCurrentScroll()
                local heldScroll = var3.getHeldScroll()
                if bool2 and current ~= nil then
                    var4.current = current
                    var3.holdCurrentScroll()
                elseif heldScroll ~= nil then
                    var4.current = heldScroll
                    var3.discardHeldScroll()
                end
            end
        end
        local var7 = React.useRef(var3)
        var7.current = var3
        local var8 = React.useRef(bool2)
        var8.current = bool2
        local var9 = React.useRef(bool3)
        var9.current = bool3

        local useEffect = React.useEffect
        local function func1()
            if var2 ~= true then
                return
            end
            if FFlagSocialCarouselInGameTitleMarquee and joinSheetUserIdRef ~= nil then
                joinSheetUserIdRef.current = nil
            end
            var3.notifyHomeFocused()
        end

        local var10 = if FFlagSocialCarouselInGameTitleMarquee then joinSheetUserIdRef else nil
        useEffect(func1, { var2, var3, var10 })

        React.useEffect(function()
            if not bool3 then
                return
            end

            if bool2 then
                var3.holdCurrentScroll()
            elseif var3.isCurrentMount(var6.current) then
                var3.discardHeldScroll()
            end
        end, {
            bool2,
            var3,
            bool3,
            var6
        })

        React.useEffect(function()
            return function()
                if var9.current ~= true or not var8.current then
                    return
                end
                if var7.current.isCurrentMount(var6.current) then
                    var7.current.holdCurrentScroll()
                end
            end
        end, {})
        local scrollContext = React.useMemo(function(): {clearCurrentScroll: (string) -> (), initialOffsetFor: (string) -> any, saveOffset: (string, number) -> ()}?
            return if bool3 then {
                initialOffsetFor = function(tileId: string)
                    local current = var4.current
                    return if current == nil or current.tileId ~= tileId then nil else current.offset
                end,
                saveOffset = function(str2: string, num1: number)
                    var7.current.setCurrentScroll(str2, num1)
                end,
                clearCurrentScroll = function(tileId: string)
                    local current = var4.current
                    if current ~= nil and current.tileId == tileId then
                        var4.current = nil
                    end
                    var7.current.clearCurrentScroll(tileId)
                end
            } else nil
        end, { bool3, var4, var7 })
        local tiles = React.useMemo(function()
            local result = {}
            if tbl3 == nil then
                return result
            end
            for _, value in ipairs(tbl3) do
                local presence = value.presence
                local lastLocation = if value.tileType == Tile.Friend and presence ~= nil and presence.userPresenceType == "InGame" then presence.lastLocation else nil
                local tbl5 = {
                    id = if value.id == nil then "" else value.id,
                    tileType = value.tileType,
                    subtitle = lastLocation,
                    presence = if presence == nil then nil else {
                        userPresenceType = presence.userPresenceType,
                        lastLocation = presence.lastLocation
                    }
                }
                table.insert(result, tbl5)
            end

            return result
        end, { tbl3 })

        local direction = MarqueeTextMotion.textDirectionFromLocale(game:GetService("LocalizationService").RobloxLocaleId)
        local var14 = if tbl4.containerFrame then tbl4.containerFrame.AbsoluteSize.X else 0
        local columnGap = if tbl4.appCompositionEnabled then tbl4.gutter else tbl4.columnGap
        local var16 = if tbl4.appCompositionEnabled then 0 else tbl4.sideMargin
        local var17 = if FFlagSocialCarouselFixColdStartJitter and not tbl4.isColdStartLayoutReady then 0 elseif tbl4.showSkeleton then (tbl4.itemsPerRow or tbl4.defaultSkeletonCount) + 1 else tbl3 and #tbl3 or 0
        local num1 = math.min(tbl4.maxTilesToShow or var17, var17)
        local var18 = if tbl4.appCompositionEnabled then 0 else tbl4.fractionalItemAmount or 0
        local var19 = if (tbl4.itemsPerRow or 0) < num1 then var18 else 0
        local var20 = if tbl4.appCompositionEnabled then tbl4.carouselPeek else 0
        local tileWidth = if tbl4.itemsPerRow > 0 then if var14 > 0 then CollectionViews.calculateItemWidth(tbl4.itemsPerRow, columnGap or 0, var16 or 0, var14, var19 or 0, var20 or 0) else 0 else 0

        local tileCount = if tbl4.showSkeleton then 0 else tbl3 and #tbl3 or 0

        local containerWidth = math.max(0, var14 - 2 * (var16 or 0))
        local var22 = useMarqueeActiveTiles(tbl2, {
            tileCount = tileCount,
            containerWidth = containerWidth,
            tileWidth = tileWidth,
            columnGap = columnGap or 0,
            tiles = tiles,
            direction = direction,
            reducedMotion = reducedMotion,
            idleSequenceEnabled = bool4,
            manualMarqueeEnabled = manualMarqueeEnabled,
            homeBlurredOrJoinCardOpen = bool2,
            joinPopoverUserId = joinPopoverUserId,
            joinPopoverUserIdRef = joinPopoverUserIdRef,
            joinSheetUserIdRef = joinSheetUserIdRef,
            isDesktop = var1 == RobloxAppEnums.DeviceType.Desktop,
            loopsRemainingStore = var3,
            restoredTileId = if var4.current == nil then nil else var4.current.tileId,
            marqueeEnabled = bool3
        })

        return {
            activeByIndex = if bool3 then var22.activeByIndex else tbl1,
            isPaused = var22.isPaused or bool2,
            onMarqueeFinished = if bool3 then var22.onMarqueeFinished else nil,
            onManualMarqueeStart = if bool3 then var22.onManualMarqueeStart else nil,
            onManualMarqueeEnd = if bool3 then var22.onManualMarqueeEnd else nil,
            marqueeRunId = if bool3 then var22.marqueeRunId else nil,
            handsOff = bool4,
            desktopEnabled = desktopEnabled,
            consoleEnabled = consoleEnabled,
            marqueeShortTitlesEnabled = marqueeShortTitlesEnabled,
            scrollContext = scrollContext
        }
    end
}
