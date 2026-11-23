-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T23:40:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local Dash = require(scriptParentParentParentParent.Dash)
local Foundation = require(scriptParentParentParentParent.Foundation)
local Localization = require(scriptParentParentParentParent.Localization)
local React = require(scriptParentParentParentParent.React)
local RoactUtils = require(scriptParentParentParentParent.RoactUtils)
local RobloxAppHooks = require(scriptParentParentParentParent.RobloxAppHooks)
local UIBlox = require(scriptParentParentParentParent.UIBlox)

local Images = UIBlox.App.ImageSet.Images
local ImageSetButton = UIBlox.Core.ImageSet.ImageSetButton
local GridView = UIBlox.App.Grid.GridView
local useStyle = UIBlox.Core.Style.useStyle

local ScrollBarVisibility = Foundation.Enums.ScrollBarVisibility
local ScrollView = Foundation.ScrollView
local FoundationText = Foundation.Text
local View = Foundation.View

local useAnalytics = require(scriptParentParentParent.Analytics.useAnalytics)
local useCallback = React.useCallback
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local useLocalization = Localization.Hooks.useLocalization
local useScreenSize = RobloxAppHooks.useScreenSize
local useSelector = RoactUtils.Hooks.RoactRodux.useSelector
local useState = React.useState
local useTopbarInsetHeight = require(scriptParentParentParent.Hooks.useTopbarInsetHeight)

local CaptureManagerClosed = require(scriptParentParentParent.Actions.CaptureManagerClosed)
local CaptureManagerItem = require(scriptParentParentParent.Components.CaptureManager.CaptureManagerItem)
local CaptureManagerCTAContainer = require(scriptParentParentParent.Components.CaptureManager.CaptureManagerCTAContainer)
local Constants = require(scriptParentParentParent.Constants)
local DeleteCaptures = require(scriptParentParentParent.Thunks.DeleteCaptures)
local DeleteWarningModal = require(scriptParentParentParent.Components.Common.DeleteWarningModal)
local EventNames = require(scriptParentParentParent.Analytics.EventNames)
local PermissionModal = require(scriptParentParentParent.Components.Common.PermissionModal)
local ShowMoreButton = require(scriptParentParentParent.Components.Common.ShowMoreButton)
local ToastContainer = require(scriptParentParentParent.Components.Common.ToastContainer)
local _Types = require(scriptParentParentParent.Types)
local UpdateSelectedCaptures = require(scriptParentParentParent.Actions.UpdateSelectedCaptures)

local uDim2 = UDim2.fromOffset(32, 32)

local function getItemsPerRow(num1: number): number -- Luacid: Inlined by compiler; 3 call sites recovered
    return math.clamp(math.floor(num1 / 90), 1, 3)
end

local function getGalleryItemSize(num1: number, num2: number): Vector2 -- Luacid: Inlined by compiler; 1 call site recovered
    local itemsPerRow = getItemsPerRow(num2)
    local num3 = (num2 - (itemsPerRow - 1) * 4) / itemsPerRow
    local num4 = num3 * num1

    return Vector2.new(math.floor(num3), math.floor(num4))
end

local function renderItem(capture, captureIndex: number)
    return React.createElement(CaptureManagerItem, { capture = capture, captureIndex = captureIndex })
end

return function(_)
    local var1 = useAnalytics()
    local var2 = useDispatch()
    local var3 = useStyle()

    local yOffset = useTopbarInsetHeight()

    local var4 = useSelector(function(arg1)
        return arg1[Constants.RoduxKey].Captures
    end)

    local var5 = useSelector(function(arg1)
        return arg1[Constants.RoduxKey].CaptureManager.SelectedCaptures
    end)

    local var6 = useSelector(function(arg1)
        return arg1[Constants.RoduxKey].CaptureManager.IsOpen
    end)

    local var7 = useLocalization({
        cancelSelectAllAction = "Feature.Captures.Action.CancelSelectAllCaptures",
        selectAllAction = "Feature.Captures.Action.SelectAllCaptures"
    })

    local ref = React.useRef(nil)
    local var9, var10 = useState(Vector2.new(0, 0))
    local isDisabled, var12 = useState(false)
    local visible, var14 = useState(false)
    local var15, var16 = React.useState(24)
    local var17 = if #var5 == 0 then var7.selectAllAction else var7.cancelSelectAllAction
    local var18 = useScreenSize()

    React.useEffect(function()
        if ref.current then
            var10(ref.current.AbsoluteSize)
        end
    end, {})

    local onAbsoluteSizeChanged = useCallback(function(arg1)
        var10(arg1.AbsoluteSize)
    end, {})

    local var20 = useCallback(function()
        var12(false)
        var2(CaptureManagerClosed())
    end, {})

    local openPermissionModal = useCallback(function()
        var14(true)
    end, {})

    local closeModal = useCallback(function()
        var14(false)
    end, {})

    local deleteItem = useCallback(function()
        var2(DeleteCaptures(var5))
    end, { var5 })

    local onActivated = useCallback(function()
        if #var5 == 0 then
            var2(UpdateSelectedCaptures(var4))
            var1.fireEvent(EventNames.CapturesManagerSelectAllActivated)
            return
        end
        var2(UpdateSelectedCaptures({}))
    end, { var5, var4 })

    local var8 = React.useCallback(function()
        var16(var15 + 24)
    end, { var15 })

    local items = React.useMemo(function()
        local num1 = math.min(#var4, var15)
        return Dash.slice(var4, 1, num1)
    end, { var4, var15 })

    if not var6 then
        return nil
    end

    local bool1 = var9.X > 0 and var9.Y > 0
    local num1 = math.clamp(var18.Y / var18.X, 3 / 7, 1)
    local y = var9.Y
    local width = var9.X - 41
    local vector2 = getGalleryItemSize(num1, width)
    local isHorizontal = y < width
    local height = if isHorizontal then 44 else 82
    local maxHeight = (vector2.Y + 4) * math.ceil(#var4 / getItemsPerRow(width))

    local createElement = React.createElement
    local var28 = View
    local tbl1 = {
        BorderSizePixel = 0,
        onAbsoluteSizeChanged = onAbsoluteSizeChanged,
        Position = UDim2.fromOffset(0, -yOffset),
        ref = ref,
        Size = UDim2.new(1, 0, 1, yOffset),
        tag = "bg-surface-100"
    }
    local tbl2 = {
        CaptureManagerContainer = 0,
        DeleteWarningModal = 0,
        PermissionModal = 0,
        ToastsFrame = 0
    }
    local createElement2 = React.createElement
    local var29 = View
    local tbl3 = {
        tag = "bg-action-subtle size-full padding-bottom-small padding-right-small padding-left-xxlarge padding-top-xxlarge gap-xsmall col align-x-center align-y-top"
    }
    local tbl4 = { TitleFrame = 0, ScrollingFrame = 0, CTAContainer = 0 }
    local createElement3 = React.createElement
    local var30 = View
    local tbl5 = {
        LayoutOrder = 1,
        Size = UDim2.new(1, 0, 0, 32),
        tag = "bg-action-subtle",
        ZIndex = 2
    }

    local tbl6 = {
        CloseButton = React.createElement(ImageSetButton, {
            AnchorPoint = Vector2.new(0, 0.5),
            BackgroundTransparency = 1,
            Image = Images["icons/navigation/close"],
            ImageColor3 = var3.Theme.IconEmphasis.Color,
            ImageTransparency = var3.Theme.IconEmphasis.Transparency,
            Position = UDim2.new(0, 0, 0.5, 0),
            Size = uDim2,
            [React.Event.Activated] = var20
        }),
        SelectOrDeselectAllButton = React.createElement(FoundationText, {
            LayoutOrder = 1,
            onActivated = onActivated,
            Position = UDim2.new(1, -16, 0.5, 2),
            tag = "auto-x anchor-center-right bg-action-subtle size-0-full text-defaults text-align-x-center text-align-y-center text-title-large",
            Text = var17,
            ZIndex = 2
        })
    }
    tbl4.TitleFrame = createElement3(var30, tbl5, tbl6)

    tbl4.ScrollingFrame = React.createElement(ScrollView, {
        BorderSizePixel = 0,
        LayoutOrder = 2,
        scroll = {
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
            CanvasSize = UDim2.fromScale(1, 0),
            ScrollingDirection = Enum.ScrollingDirection.Y,
            scrollBarVisibility = ScrollBarVisibility.None
        },
        Size = UDim2.new(1, 0, 1, -(height + 40)),
        tag = "bg-action-subtle gap-xsmall col align-x-center align-y-top"
    }, {
        GridView = bool1
            and React.createElement(GridView, {
                itemPadding = Vector2.new(4, 4),
                items = items,
                itemSize = vector2,
                LayoutOrder = 1,
                maxHeight = maxHeight,
                renderItem = renderItem,
                Size = UDim2.fromScale(1, 0.9)
            }),
        ShowMoreButton = var15 < #var4 and React.createElement(ShowMoreButton, { buttonHeight = 40, LayoutOrder = 2, onActivated = var8 })
    })

    tbl4.CTAContainer = React.createElement(CaptureManagerCTAContainer, {
        deleteItem = deleteItem,
        height = height,
        isDisabled = isDisabled,
        isHorizontal = isHorizontal,
        LayoutOrder = 3,
        openPermissionModal = openPermissionModal,
        width = width,
        ZIndex = 2
    })
    tbl2.CaptureManagerContainer = createElement2(var29, tbl3, tbl4)

    tbl2.DeleteWarningModal = React.createElement(DeleteWarningModal, { deleteItem = deleteItem, zIndex = 3 })

    tbl2.PermissionModal = React.createElement(PermissionModal, { closeModal = closeModal, visible = visible, zIndex = 3 })

    tbl2.ToastsFrame = React.createElement(
        View,
        {
            tag = "bg-action-subtle size-full",
            ZIndex = Constants.ZIndex.Toasts
        },
        {
            ToastContainer = React.createElement(ToastContainer)
        }
    )
    return createElement(var28, tbl1, tbl2)
end
