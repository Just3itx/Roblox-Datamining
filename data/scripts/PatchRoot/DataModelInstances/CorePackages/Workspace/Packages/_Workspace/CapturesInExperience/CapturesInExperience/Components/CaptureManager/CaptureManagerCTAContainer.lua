-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T23:40:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local Localization = require(scriptParentParentParentParent.Localization)
local React = require(scriptParentParentParentParent.React)
local RoactUtils = require(scriptParentParentParentParent.RoactUtils)
local SocialStopwatch = require(scriptParentParentParentParent.SocialStopwatch)
local UIBlox = require(scriptParentParentParentParent.UIBlox)
local normalizeFontFace = require(scriptParentParentParentParent.Foundation).Utility.normalizeFontFace

local IconButton = UIBlox.App.Button.IconButton
local IconSize = UIBlox.App.Constant.IconSize
local Images = UIBlox.App.ImageSet.Images
local useStyle = UIBlox.Core.Style.useStyle

local useAnalytics = require(scriptParentParentParent.Analytics.useAnalytics)
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local useLocalization = Localization.Hooks.useLocalization
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

local num1 = game:DefineFastInt("CapturesSaveToExternalStorageLimit", 10)

local FFlagEnableCapturesGalleryRetrievalCoreScript = require(scriptParentParentParent.Flags.FFlagEnableCapturesGalleryRetrievalCoreScript)

local uDim2 = UDim2.new(0.33, 0, 0, 36)

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
        return arg1[Constants.RoduxKey].CaptureManager.SelectedCaptures
    end)

    local var6, var7 = React.useState(false)

    local numberOfCaptures = #var5
    local isDisabled = #var5 == 0 or #var5 > 1
    local bool2

    if #var5 == 0 then
        bool2 = true
    else
        local num3 = #var5
        bool2 = num1 < num3
    end

    local bool1 = #var5 == 0
    local fillDirection = if tbl1.isHorizontal then Enum.FillDirection.Horizontal else Enum.FillDirection.Vertical
    local textXAlignment = if tbl1.isHorizontal then Enum.TextXAlignment.Left else Enum.TextXAlignment.Center
    local uDim2_2 = if tbl1.isHorizontal then UDim2.new(0, tbl1.width - 279, 0, tbl1.height) else UDim2.new(1, 0, 0, 38)
    local uDim2_3 = if tbl1.isHorizontal then UDim2.new(0, 279, 0, tbl1.height) else UDim2.new(1, 0, 0, 44)
    local var8 = useLocalization({
        selectCaptureLabel = "Feature.Captures.Label.SelectCapture",
        oneCaptureSelectedLabel = "Feature.Captures.Label.OneCaptureSelected",
        multipleCapturesSelectedLabel = {
            "Feature.Captures.Label.MultipleCapturesSelected",
            numberOfCaptures = numberOfCaptures
        }
    })

    React.useEffect(function()
        local bool4 = false
        if FFlagEnableCapturesGalleryRetrievalCoreScript then
            for _, value in var5 do
                if value.CaptureType == Enum.CaptureType.Video then
                    bool4 = true
                    break
                end
            end
        else
            for _, value in var5 do
                if value.type == CaptureType.Video then
                    bool4 = true
                    break
                end
            end
        end

        var7(bool4)
    end, { var5 })

    local var9 = React.useCallback(function()
        if numberOfCaptures == 0 then
            return var8.selectCaptureLabel
        elseif numberOfCaptures == 1 then
            return var8.oneCaptureSelectedLabel
        end

        return var8.multipleCapturesSelectedLabel
    end, { numberOfCaptures })

    local var10 = React.useCallback(function(): boolean
        return if tbl1.isDisabled then true else DateTime.now().UnixTimestampMillis - var4.current < 500
    end, { tbl1.isDisabled })

    local var11 = React.useCallback(function()
        var4.current = DateTime.now().UnixTimestampMillis
    end, {})

    local onActivated = React.useCallback(function()
        if var10() or #var5 == 0 then
            return
        end

        getSaveToStoragePermission(var5, tbl1.openPermissionModal, var2)
        var1.fireEvent(EventNames.CapturesManagerBulkSaveToExternalStorageActivated)
        var11()
    end, {
        var5,
        var10,
        var11,
        tbl1.openPermissionModal
    })
    local var12 = React.useCallback(function()
        if var10() or isDisabled then
            return
        end

        local var13 = var5[1]
        var11()

        if var6 then
            var1.fireEvent(EventNames.CapturesManagerShareVideoActivated)
        end
        var1.fireEvent(EventNames.CapturesManagerShareActivated)
        if not SocialStopwatch.Stopwatch.get(SocialStopwatch.Events.CaptureShared) then
            SocialStopwatch.Stopwatch.start(SocialStopwatch.Events.CaptureShared)
        end
        var2(ShareCapture(var13, ExternalShareSourceType.CapturesManager))
    end, {
        var10,
        isDisabled,
        var6,
        tbl1.isDisabled,
        var11,
        var5
    })

    local var13 = React.useCallback(function()
        if var10() or bool1 then
            return
        end

        var11()

        var1.fireEvent(EventNames.CapturesDeleteActivatedInCaptureManager)
        if getIsDeleteWarningModalOptedOut() then
            assert(tbl1.deleteItem ~= nil, "props.deleteItem should not be nil")
            tbl1.deleteItem()
            return
        end
        var2(DeleteWarningModalOpened())
    end, {
        var10,
        bool1,
        tbl1.deleteItem,
        tbl1.isDisabled,
        var11
    })

    return React.createElement("Frame", {
        BackgroundColor3 = var3.Theme.BackgroundContrast.Color,
        BackgroundTransparency = var3.Theme.BackgroundContrast.Transparency,
        BorderSizePixel = 0,
        LayoutOrder = tbl1.LayoutOrder,
        Size = UDim2.new(1, 0, 0, tbl1.height),
        ZIndex = tbl1.ZIndex
    }, {
        Layout = React.createElement("UIListLayout", {
            FillDirection = fillDirection,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            Padding = UDim.new(0, 0),
            SortOrder = Enum.SortOrder.LayoutOrder,
            VerticalAlignment = Enum.VerticalAlignment.Center
        }),
        Padding = React.createElement("UIPadding", { PaddingRight = UDim.new(0, 16) }),
        CapturesLabel = React.createElement("TextLabel", {
            AnchorPoint = Vector2.new(1, 0.5),
            AutomaticSize = Enum.AutomaticSize.X,
            BackgroundTransparency = 1,
            FontFace = normalizeFontFace(var3.Tokens.Typography.TitleLarge.Font),
            LayoutOrder = 1,
            Position = UDim2.new(1, 0, 1, 0),
            Size = uDim2_2,
            Text = var9(),
            TextColor3 = var3.Theme.TextEmphasis.Color,
            TextSize = var3.Font.BaseSize * var3.Font.CaptionHeader.RelativeSize,
            TextXAlignment = textXAlignment,
            TextYAlignment = Enum.TextYAlignment.Center,
            ZIndex = 1
        }),
        CTAContainer = React.createElement("Frame", {
            BackgroundColor3 = var3.Theme.BackgroundContrast.Color,
            BackgroundTransparency = var3.Theme.BackgroundContrast.Transparency,
            BorderSizePixel = 0,
            LayoutOrder = tbl1.LayoutOrder,
            Size = uDim2_3,
            ZIndex = tbl1.ZIndex
        }, {
            Layout = React.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Horizontal,
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                SortOrder = Enum.SortOrder.LayoutOrder,
                VerticalAlignment = Enum.VerticalAlignment.Center
            }),
            BulkSaveButton = React.createElement(IconButton, {
                backgroundColor = var3.Theme.BackgroundUIContrast,
                icon = Images["icons/actions/download_medium"],
                iconSize = IconSize.Medium,
                isDisabled = bool2,
                layoutOrder = 1,
                onActivated = onActivated,
                size = uDim2
            }),
            BulkShareButton = tbl1.enableShareCaptureCTA
                and React.createElement(IconButton, {
                    backgroundColor = var3.Theme.BackgroundUIContrast,
                    icon = Images["icons/actions/share"],
                    iconSize = IconSize.Medium,
                    isDisabled = isDisabled,
                    layoutOrder = 1,
                    onActivated = var12,
                    size = uDim2
                }),
            BulkDeleteButton = React.createElement(IconButton, {
                icon = Images["icons/actions/edit/delete"],
                iconSize = IconSize.Medium,
                isDisabled = bool1,
                layoutOrder = 2,
                onActivated = var13,
                size = uDim2
            })
        })
    })
end))
