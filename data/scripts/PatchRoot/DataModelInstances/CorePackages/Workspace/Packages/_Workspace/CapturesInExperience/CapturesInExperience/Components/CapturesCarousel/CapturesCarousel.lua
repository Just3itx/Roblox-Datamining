-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T23:40:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local UserGameSettings = UserSettings():GetService("UserGameSettings")
local UserInputService = game:GetService("UserInputService")

local _AppCommonLib = require(scriptParentParentParentParent.AppCommonLib)
local React = require(scriptParentParentParentParent.React)
local RoactUtils = require(scriptParentParentParentParent.RoactUtils)
local RobloxAppHooks = require(scriptParentParentParentParent.RobloxAppHooks)

local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local useScreenSize = RobloxAppHooks.useScreenSize
local useSelector = RoactUtils.Hooks.RoactRodux.useSelector
local useSignal = RoactUtils.Hooks.useSignal

local CaptureType = require(scriptParentParentParent.Enums.CaptureType)
local CarouselItem = require(scriptParentParentParent.Components.CapturesCarousel.CarouselItem)
local CarouselNavArrow = require(scriptParentParentParent.Components.CapturesCarousel.CarouselNavArrow)
local CarouselScrolled = require(scriptParentParentParent.Thunks.CarouselScrolled)
local Constants = require(scriptParentParentParent.Constants)
local EventNames = require(scriptParentParentParent.Analytics.EventNames)
local getClosestItemToCenter = require(scriptParentParentParent.Utils.getClosestItemToCenter)
local _Types = require(scriptParentParentParent.Types)
local useAnalytics = require(scriptParentParentParent.Analytics.useAnalytics)
local useCarouselController = require(scriptParentParentParent.Hooks.useCarouselController)

local FFlagUseRbxstorageInGallery = require(scriptParentParentParent.Flags.FFlagUseRbxstorageInGallery)

local FFlagEnableCapturesGalleryRetrievalCoreScript = require(scriptParentParentParent.Flags.FFlagEnableCapturesGalleryRetrievalCoreScript)

local function getMargins(vector2: Vector2, vector2_2: Vector2): (number, number) -- Luacid: Inlined by compiler; 1 call site recovered
    local x = (vector2_2 - vector2).X

    if x % 2 == 0 then
        local var1 = x / 2
        return var1, var1
    end

    local num1 = math.floor(x / 2)
    return num1 + 1, num1
end

local function getTouchScrollingEnabled(): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    local platform = UserInputService:GetPlatform()
    local bool1 = platform == Enum.Platform.IOS or platform == Enum.Platform.Android
    local touchEnabled = UserInputService.TouchEnabled
    local reducedMotion = UserGameSettings.ReducedMotion
    return bool1 and touchEnabled and not reducedMotion
end

return function(tbl1)
    local var1 = useAnalytics()
    local var2 = useDispatch()
    local var3 = useScreenSize()
    local var4, var5 = React.useState(false)
    local var6, var7 = React.useState(0)

    local var8 = useSelector(function(arg1)
        return arg1[Constants.RoduxKey].Captures
    end)

    local var9 = useSelector(function(arg1)
        return arg1[Constants.RoduxKey].Carousel.SelectedCaptureIndex
    end)

    local var10, var11 = React.useState(var9)

    local num1 = if var3.X / var3.Y > 1 then 0.15 else 0.075
    local num2 = math.clamp(math.floor(var3.X * num1), 50, 200)
    local imagePadding = math.floor(num2 * 0.2)

    local maxHeight = tbl1.maxHeight
    local var12 = var3.X - num2 * 2

    local vector2 = Vector2.new(math.floor(var12), math.floor(maxHeight))
    local xOffset = vector2.X * #var8
    local xOffset2, var13 = getMargins(vector2, var3)

    local var14 = React.useCallback(function(num4: number)
        if num4 < 1 or #var8 < num4 then
            return
        end

        local direction = num4 < var9 and Constants.CarouselDirection.Left or Constants.CarouselDirection.Right
        var1.fireEvent(EventNames.CapturesCarouselScrolled, { direction = direction })

        var2(CarouselScrolled(num4))
    end, { var8, var9 })

    local var15 = useCarouselController(vector2, var9, var14)

    local carouselRef = var15.carouselRef
    local carouselInputBegan = var15.carouselInputBegan
    local carouselInputEnded = var15.carouselInputEnded
    local deleteSelectedItem = var15.deleteSelectedItem
    local selectedItemFadeOutBinding = var15.selectedItemFadeOutBinding
    local postDeletionItemBinding = var15.postDeletionItemBinding
    local selectedItemRef = var15.selectedItemRef
    local setIsNavigationLocked = var15.setIsNavigationLocked

    local bool1 = var10 > 1
    local bool2 = var10 < #var8
    local bool3 = (bool1 or bool2) and not tbl1.isDisabled

    React.useEffect(function()
        setIsNavigationLocked(not bool3)
    end, { bool3, setIsNavigationLocked })

    local var16 = React.useCallback(function(arg1)
        deleteSelectedItem(arg1)
    end, { deleteSelectedItem })
    useSignal(tbl1.deleteItemSignal, var16)

    local var17 = React.useCallback(function(arg1)
        local closestItemToCenter = getClosestItemToCenter(vector2, arg1)
        if closestItemToCenter ~= var10 then
            var11(closestItemToCenter)
        end
    end, { vector2, var10, var11 })

    local onMuteCallback = React.useCallback(function()
        var1.fireEvent(EventNames.CapturesCarouselVideoMuteButtonActivated)
    end, {})

    local onExpandCallback = React.useCallback(function(arg1)
        var5(not var4)
        var7(arg1)
        if not var4 then
            var1.fireEvent(EventNames.CapturesCarouselVideoExpanded)
            return
        end
        var1.fireEvent(EventNames.CapturesCarouselVideoShrank)
    end, { var4 })

    local var20 = React.useCallback(function(capture, itemIndex: number)
        if var10 + 3 < itemIndex or itemIndex < var10 - 3 then
            return nil
        end

        local bool4 = itemIndex == var10 - 1 or var10 == 1 and itemIndex == 2
        return React.createElement(CarouselItem, {
            capture = capture,
            fadeOutBinding = if itemIndex == var9 then selectedItemFadeOutBinding else nil,
            transitionBinding = if itemIndex == var9 then selectedItemFadeOutBinding elseif bool4 then postDeletionItemBinding else nil,
            imagePadding = imagePadding,
            isDisabled = if FFlagUseRbxstorageInGallery then tbl1.isDisabled and var9 == itemIndex else nil,
            isSelected = var9 == itemIndex,
            itemIndex = itemIndex,
            itemSize = vector2,
            onExpandCallback = onExpandCallback,
            onMuteCallback = onMuteCallback,
            unfocusedSizeMultiplier = 0.8
        })
    end, {
        vector2,
        var10,
        imagePadding,
        tbl1.isDisabled,
        onExpandCallback,
        onMuteCallback,
        postDeletionItemBinding,
        var9,
        selectedItemFadeOutBinding
    })

    local var21 = React.useMemo(function()
        local tbl2 = {
            Layout = React.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Horizontal,
                SortOrder = Enum.SortOrder.LayoutOrder,
                VerticalAlignment = Enum.VerticalAlignment.Center
            })
        }

        for layoutOrder, value2 in var8 do
            local var21 = if FFlagEnableCapturesGalleryRetrievalCoreScript then tostring(value2.CaptureTime.UnixTimestampMillis) elseif FFlagUseRbxstorageInGallery and value2.type == CaptureType.Video then value2.thumbnailKey else value2.contentId
            local createElement = React.createElement
            local str1 = "Frame"
            local tbl3 = {
                BackgroundTransparency = 1,
                LayoutOrder = layoutOrder,
                Size = UDim2.fromOffset(vector2.X, vector2.Y),
                ref = if layoutOrder == var9 then selectedItemRef else nil,
                ZIndex = if var4 and var6 == layoutOrder then 2 else 1
            }
            local tbl4 = {
                Item = var20(value2, layoutOrder)
            }
            tbl2[var21] = createElement(str1, tbl3, tbl4)
        end

        return tbl2
    end, {
        var8,
        vector2,
        var6,
        var4,
        var20,
        var9
    })

    local yOffset = math.floor(vector2.Y * 0.8)

    local createElement = React.createElement
    local tbl2 = {
        BackgroundTransparency = 1,
        LayoutOrder = tbl1.LayoutOrder,
        Size = UDim2.new(1, 0, 0, tbl1.maxHeight),
        ZIndex = tbl1.ZIndex
    }
    local tbl3 = {
        AnimatedCarousel = React.createElement("ScrollingFrame", {
            BackgroundTransparency = 1,
            CanvasSize = UDim2.new(0, xOffset, 1, 0),
            ClipsDescendants = false,
            Position = UDim2.fromOffset(xOffset2, 0),
            ScrollBarThickness = 0,
            ScrollingDirection = Enum.ScrollingDirection.X,
            ScrollingEnabled = not var4 and bool3 and getTouchScrollingEnabled(),
            Size = UDim2.fromOffset(vector2.X, vector2.Y),
            [React.Change.CanvasPosition] = var17,
            [React.Event.InputBegan] = carouselInputBegan,
            [React.Event.InputEnded] = carouselInputEnded,
            ref = carouselRef
        }, var21),
        LeftArrow = not var4
            and bool1
            and React.createElement(CarouselNavArrow, {
                direction = Constants.CarouselDirection.Left,
                isDisabled = tbl1.isDisabled,
                Size = UDim2.fromOffset(xOffset2 - imagePadding, yOffset),
                ZIndex = 2
            }),
        RightArrow = not var4
            and bool2
            and React.createElement(CarouselNavArrow, {
                direction = Constants.CarouselDirection.Right,
                isDisabled = tbl1.isDisabled,
                Size = UDim2.fromOffset(var13 - imagePadding, yOffset),
                ZIndex = 2
            })
    }
    return createElement("Frame", tbl2, tbl3)
end
