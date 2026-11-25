-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:10:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent

local React = require(ProfilePlatformParent.React)
local CollectionViews = require(ProfilePlatformParent.CollectionViews)
local Foundation = require(ProfilePlatformParent.Foundation)
local Navigation = require(ProfilePlatformParent.Navigation)

local _MomentsStoreTypes = require(ProfilePlatformParent.DataHydration.MomentsStoreTypes)

local MomentTile = require(script.Parent.MomentTile)
local MomentsCarouselMediaProvider = require(script.Parent.MomentsCarouselMediaProvider)
local getVisibleTileRange = require(script.Parent.getVisibleTileRange)
local isPlayableVideoMoment = require(script.Parent.isPlayableVideoMoment)
local useDynamicSizeMargin = require(ProfilePlatform.Hooks.useDynamicSizeMargin)
local useProfileFormFactor = require(ProfilePlatform.Hooks.useProfileFormFactor)
local Enums = require(ProfilePlatform.Common.Enums)
local FFlagProfileMomentSceneOutfitPoster = require(ProfilePlatformParent.SharedFlags).FFlagProfileMomentSceneOutfitPoster

local CollectionCarousel = CollectionViews.CollectionCarousel
local useNavigationFocus = Navigation.useNavigationFocus
local useTokens = Foundation.Hooks.useTokens

local function MomentsCarousel(tbl1)
    local moments = tbl1.moments
    local var1 = useTokens()
    local bool1 = useProfileFormFactor().formFactor == Enums.ProfileFormFactor.Wide
    local var2 = useNavigationFocus()
    local sideMargin, var4 = useDynamicSizeMargin()
    local var5, var6 = React.useState(0)

    local activeIndex, var8 = React.useState(1)
    local scrollingFrameRef = React.useRef(nil)
    local var10 = React.useRef(nil)
    local handoffRef = React.useRef(nil)

    local numColumns = if bool1 then 4 else 3
    local fractionalItemAmount = if bool1 then nil else 0.2

    local onTileImpression = tbl1.onTileImpression

    local var13 = React.useRef({})

    local var14 = React.useRef(nil)

    local var15 = React.useMemo(function()
        for _, moment in moments do
            if if FFlagProfileMomentSceneOutfitPoster then isPlayableVideoMoment(moment) else moment.metadata.captureType == Enum.CaptureType.Video then
                return true
            end
        end
        return false
    end, { moments })

    local moment = moments[activeIndex]
    local playbackActive = if FFlagProfileMomentSceneOutfitPoster then not (moment == nil) and isPlayableVideoMoment(moment) else not (moment == nil) and moment.metadata.captureType == Enum.CaptureType.Video

    local getItemHeight = React.useCallback(function(num2: number): number
        var6(num2)
        return num2 * 1.5 + 48
    end, {})

    local var17 = React.useCallback(function()
        if onTileImpression == nil or var5 <= 0 then
            return
        end
        local current = scrollingFrameRef.current
        local var17 = if current == nil then 0 else current.CanvasPosition.X

        local var18, var19 = getVisibleTileRange(var17, var5, 12, numColumns, fractionalItemAmount, #moments)
        for i = var18, var19 do
            if not var13.current[i] then
                var13.current[i] = true
                onTileImpression(i)
            end
        end
    end, {
        onTileImpression,
        var5,
        numColumns,
        fractionalItemAmount,
        #moments
    })
    React.useEffect(function()
        if var14.current ~= moments then
            var14.current = moments
            var13.current = {}
        end

        var17()
    end, { moments, var17 })

    local onChangeCanvasPosition = React.useCallback(function()
        if scrollingFrameRef.current == nil or var5 <= 0 then
            return
        end
        if var10.current ~= nil then
            task.cancel(var10.current)
        end
        var10.current = task.delay(0.2, function()
            var10.current = nil
            local current = scrollingFrameRef.current
            if current == nil then
                return
            end
            local var18 = var5 + 12
            local num2 = math.clamp(math.round(current.CanvasPosition.X / var18) + 1, 1, #moments)
            var8(num2)

            var17()
        end)
    end, { var5, #moments, var17 })

    React.useEffect(function()
        return function()
            if var10.current ~= nil then
                task.cancel(var10.current)
                var10.current = nil
            end
        end
    end, {})

    local renderItem = React.useCallback(function(moment2, layoutOrder: number, uDim2: UDim2)
        return React.createElement(MomentTile, {
            moment = moment2,
            layoutOrder = layoutOrder,
            itemSize = uDim2,
            isActive = var2 and layoutOrder == activeIndex,
            onActivated = function()
                local current = handoffRef.current
                if current ~= nil then
                    current.release()
                end
                tbl1.onSelectMoment(layoutOrder)
            end
        }), moment2.momentId
    end, { var2, activeIndex, tbl1.onSelectMoment })

    local carousel = React.createElement("Frame", {
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        LayoutOrder = tbl1.layoutOrder,
        Size = UDim2.new(1, 0, 0, var5 * 1.5 + 48),
        [React.Change.AbsoluteSize] = var4
    }, {
        CollectionCarousel = React.createElement(CollectionCarousel, {
            LayoutOrder = 1,
            title = "Moments",
            items = moments,
            renderItem = renderItem,
            getItemHeight = getItemHeight,
            scrollingFrameRef = scrollingFrameRef,
            onChangeCanvasPosition = onChangeCanvasPosition,
            numColumns = numColumns,
            fractionalItemAmount = fractionalItemAmount,
            columnGap = 12,
            sideMargin = sideMargin,
            onActivateHeader = tbl1.onActivateHeader
        })
    })

    if not (var2 and var15) then
        return carousel
    end

    return React.createElement(MomentsCarouselMediaProvider, {
        moments = moments,
        activeIndex = activeIndex,
        playbackActive = playbackActive,
        mediaCornerRadius = var1.Radius.Large,
        handoffRef = handoffRef
    }, { Carousel = carousel })
end

return MomentsCarousel
