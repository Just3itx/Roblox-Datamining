-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T23:40:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local React = require(scriptParentParentParentParent.React)
local RoactUtils = require(scriptParentParentParentParent.RoactUtils)
local SocialStopwatch = require(scriptParentParentParentParent.SocialStopwatch)
local UIBlox = require(scriptParentParentParentParent.UIBlox)

local IconButton = UIBlox.App.Button.IconButton
local Images = UIBlox.App.ImageSet.Images
local useStyle = UIBlox.Core.Style.useStyle

local useAnalytics = require(scriptParentParentParent.Analytics.useAnalytics)
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local useRef = React.useRef
local useSelector = RoactUtils.Hooks.RoactRodux.useSelector

local CapturesPolicy = require(scriptParentParentParent.App.CapturesPolicy)
local CaptureType = require(scriptParentParentParent.Enums.CaptureType)
local Constants = require(scriptParentParentParent.Constants)
local DeleteWarningModalOpened = require(scriptParentParentParent.Actions.DeleteWarningModalOpened)
local EventNames = require(scriptParentParentParent.Analytics.EventNames)
local ExternalShareSourceType = require(scriptParentParentParent.Enums.ExternalShareSourceType)
local getIsDeleteWarningModalOptedOut = require(scriptParentParentParent.Utils.getIsDeleteWarningModalOptedOut)
local getSaveToStoragePermission = require(scriptParentParentParent.Utils.getSaveToStoragePermission)
local ShareCapture = require(scriptParentParentParent.Thunks.ShareCapture)
local _Types = require(scriptParentParentParent.Types)

local FFlagEnableCapturesGalleryRetrievalCoreScript = require(scriptParentParentParent.Flags.FFlagEnableCapturesGalleryRetrievalCoreScript)

local uDim = UDim.new(0.12, 0)
local uDim2 = UDim2.fromOffset(36, 36)
local uDim3 = UDim.new(0, 8)

return (CapturesPolicy.connect(function(arg1)
    return {
        enableShareCaptureCTA = arg1.enableShareCaptureCTA()
    }
end)(function(tbl1)
    local var1 = useAnalytics()
    local var2 = useDispatch()
    local var3 = useStyle()

    local var4 = useRef(0)

    local var5 = useSelector(function(arg1)
        local selectedCaptureIndex = arg1[Constants.RoduxKey].Carousel.SelectedCaptureIndex
        return arg1[Constants.RoduxKey].Captures[selectedCaptureIndex]
    end)

    local var6 = React.useCallback(function(): boolean
        return if tbl1.isDisabled then true else DateTime.now().UnixTimestampMillis - var4.current < 500
    end, { tbl1.isDisabled })

    local var7 = React.useCallback(function()
        var4.current = DateTime.now().UnixTimestampMillis
    end, {})

    local onActivated = React.useCallback(function()
        if var6() then
            return
        end

        getSaveToStoragePermission(
            FFlagEnableCapturesGalleryRetrievalCoreScript and { var5 } or var5,
            tbl1.openPermissionModal,
            var2
        )
        var7()

        if if FFlagEnableCapturesGalleryRetrievalCoreScript then var5.CaptureType == Enum.CaptureType.Video else var5.type == CaptureType.Video then
            var1.fireEvent(EventNames.CapturesCarouselVideoSaveToExternalStorageActivated)
            return
        end
        var1.fireEvent(EventNames.CapturesCarouselSaveToExternalStorageActivated)
    end, {
        var5,
        var6,
        var7,
        tbl1.openPermissionModal
    })
    local var8 = React.useCallback(function()
        if var6() then
            return
        end

        var7()

        if if FFlagEnableCapturesGalleryRetrievalCoreScript then var5.CaptureType == Enum.CaptureType.Video else var5.type == CaptureType.Video then
            var1.fireEvent(EventNames.CapturesCarouselVideoShareActivated)
        else
            var1.fireEvent(EventNames.CapturesCarouselShareActivated)
        end

        if SocialStopwatch.Stopwatch.get(SocialStopwatch.Events.CaptureShared) == nil then
            SocialStopwatch.Stopwatch.start(SocialStopwatch.Events.CaptureShared)
        end

        var2(ShareCapture(var5, ExternalShareSourceType.CapturesCarousel))
    end, {
        var5,
        tbl1.isDisabled,
        var6,
        var7
    })
    local var9 = React.useCallback(function()
        if var6() then
            return
        end

        var7()

        if if FFlagEnableCapturesGalleryRetrievalCoreScript then var5.CaptureType == Enum.CaptureType.Video else var5.type == CaptureType.Video then
            var1.fireEvent(EventNames.CapturesVideoDeleteActivatedInCarousel)
        else
            var1.fireEvent(EventNames.CapturesDeleteActivatedInCarousel)
        end

        if getIsDeleteWarningModalOptedOut() then
            assert(tbl1.deleteItem ~= nil, "props.deleteItem should not be nil")
            tbl1.deleteItem()
            return
        end
        var2(DeleteWarningModalOpened())
    end, {
        var5,
        tbl1.deleteItem,
        tbl1.isDisabled,
        var6,
        var7
    })
    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        AutomaticSize = Enum.AutomaticSize.None,
        BackgroundColor3 = var3.Theme.BackgroundContrast.Color,
        BackgroundTransparency = var3.Theme.BackgroundContrast.Transparency,
        BorderSizePixel = 0,
        LayoutOrder = tbl1.LayoutOrder,
        Size = UDim2.new(1, 0, 0, tbl1.height),
        ZIndex = tbl1.ZIndex
    }
    local tbl3 = {
        UICorner = React.createElement("UICorner", { CornerRadius = uDim3 }),
        UIPadding = React.createElement("UIPadding", { PaddingLeft = UDim.new(0, 12), PaddingRight = UDim.new(0, 12) }),
        Layout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            Padding = uDim,
            SortOrder = Enum.SortOrder.LayoutOrder,
            VerticalAlignment = Enum.VerticalAlignment.Center
        }),
        SaveButton = 0,
        ShareButton = 0,
        DeleteButton = 0
    }
    local element

    if FFlagEnableCapturesGalleryRetrievalCoreScript then
        element = React.createElement(IconButton, {
            backgroundColor = var3.Theme.BackgroundUIContrast,
            icon = Images["icons/actions/download_medium"],
            layoutOrder = 1,
            onActivated = onActivated,
            showBackground = false,
            size = uDim2
        })
    else
        element = React.createElement(IconButton, {
            backgroundColor = var3.Theme.BackgroundUIContrast,
            icon = Images["icons/actions/download_medium"],
            layoutOrder = 1,
            onActivated = onActivated,
            showBackground = false,
            size = uDim2
        })
    end

    tbl3.SaveButton = element

    tbl3.ShareButton = tbl1.enableShareCaptureCTA
        and React.createElement(IconButton, {
            backgroundColor = var3.Theme.BackgroundUIContrast,
            icon = Images["icons/actions/share"],
            layoutOrder = 2,
            onActivated = var8,
            showBackground = false,
            size = uDim2
        })

    tbl3.DeleteButton = React.createElement(IconButton, {
        icon = Images["icons/actions/edit/delete"],
        layoutOrder = 4,
        onActivated = var9,
        showBackground = false,
        size = uDim2
    })
    return createElement(str1, tbl2, tbl3)
end))
