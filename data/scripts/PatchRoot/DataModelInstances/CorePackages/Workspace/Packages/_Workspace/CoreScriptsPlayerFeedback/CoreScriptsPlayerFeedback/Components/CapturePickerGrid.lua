-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T01:11:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreScriptsPlayerFeedback = script:FindFirstAncestor("CoreScriptsPlayerFeedback")
local CoreScriptsPlayerFeedbackParent = CoreScriptsPlayerFeedback.Parent

local React = require(CoreScriptsPlayerFeedbackParent.React)
local Foundation = require(CoreScriptsPlayerFeedbackParent.Foundation)
local Checkbox = Foundation.Checkbox
local ScrollView = Foundation.ScrollView
local FoundationText = Foundation.Text
local View = Foundation.View
local ScrollBarVisibility = Foundation.Enums.ScrollBarVisibility

local useLocalization = require(CoreScriptsPlayerFeedbackParent.Localization).Hooks.useLocalization

local _CaptureTypes = require(CoreScriptsPlayerFeedback.CaptureTypes)
local getCaptureKey = require(CoreScriptsPlayerFeedback.Utils.getCaptureKey)

local var1 = React.memo(function(tbl1)
    local capture = tbl1.capture
    local bool1 = capture.CaptureType == Enum.CaptureType.Video
    local bool2 = tbl1.isDisabled == true

    local onActivated = React.useCallback(function()
        if not bool2 then
            tbl1.onToggle()
        end
    end, { bool2, tbl1.onToggle })

    local var2 = React.useCallback(function()
        tbl1.onPreview()
    end, { tbl1.onPreview })

    return React.createElement("ImageButton", {
        BackgroundColor3 = Color3.fromRGB(30, 30, 30),
        BackgroundTransparency = 0,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        Image = "",
        LayoutOrder = tbl1.LayoutOrder,
        Size = UDim2.fromScale(1, 1),
        [React.Event.Activated] = var2
    }, {
        DisabledOverlay = if bool2 then React.createElement("Frame", {
            BackgroundColor3 = Color3.fromRGB(0, 0, 0),
            BackgroundTransparency = 0.5,
            BorderSizePixel = 0,
            Size = UDim2.fromScale(1, 1),
            ZIndex = 3
        }) else nil,
        Preview = if bool1 then nil else React.createElement("ImageLabel", {
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ImageContent = Content.fromObject(capture),
            ScaleType = Enum.ScaleType.Crop,
            Size = UDim2.fromScale(1, 1),
            ZIndex = 1
        }),
        CheckboxOverlay = React.createElement(
            "Frame",
            {
                BackgroundTransparency = 1,
                Size = UDim2.fromScale(1, 1),
                ZIndex = 2
            },
            {
                Checkbox = React.createElement(Checkbox, {
                    AnchorPoint = Vector2.new(1, 0),
                    isChecked = tbl1.isSelected,
                    label = "",
                    onActivated = onActivated,
                    Position = UDim2.new(1, -4, 0, 4)
                })
            }
        )
    })
end)

return (React.memo(function(tbl1)
    local num1 = 0
    for _, selectedKey in tbl1.selectedKeys do
        if selectedKey then
            num1 += 1
        end
    end
    local bool1 = tbl1.maxSelections <= num1

    local var2 = useLocalization({
        selectionHint = {
            "CoreScripts.FeedbackPrompt.PlayerSupportPrompt.Captures.Picker.NumSelected",
            count = tostring(num1),
            max = tostring(tbl1.maxSelections)
        },
        loading = "CoreScripts.FeedbackPrompt.PlayerSupportPrompt.Captures.Loading",
        empty = "CoreScripts.FeedbackPrompt.PlayerSupportPrompt.Captures.Empty"
    })

    local tbl2 = {
        UIPadding = React.createElement("UIPadding", {
            PaddingTop = UDim.new(0, 2),
            PaddingBottom = UDim.new(0, 2),
            PaddingLeft = UDim.new(0, 2),
            PaddingRight = UDim.new(0, 2)
        }),
        UIGridLayout = React.createElement("UIGridLayout", {
            CellPadding = UDim2.new(0, 4, 0, 4),
            CellSize = UDim2.new(1 / 3, -3, 0, 100),
            FillDirection = Enum.FillDirection.Horizontal,
            SortOrder = Enum.SortOrder.LayoutOrder
        })
    }
    for layoutOrder, capture in tbl1.captures do
        local captureKey = getCaptureKey(capture)
        local isSelected = tbl1.selectedKeys[captureKey] == true

        tbl2[captureKey] = React.createElement(var1, {
            capture = capture,
            isSelected = isSelected,
            isDisabled = bool1 and not isSelected,
            onToggle = function()
                tbl1.onToggle(capture)
            end,
            onPreview = function()
                tbl1.onPreview(capture)
            end,
            LayoutOrder = layoutOrder
        })
    end

    local createElement = React.createElement
    local var3 = View
    local tbl3 = {
        tag = "col gap-small size-full-0 auto-y",
        Size = UDim2.new(1, 0, 0, 360)
    }
    local tbl4 = {
        Hint = React.createElement(FoundationText, {
            Text = var2.selectionHint,
            tag = "size-full-0 auto-y text-caption-small text-wrap text-align-x-right content-muted",
            LayoutOrder = 1
        }),
        Scroll = 0
    }

    local createElement2 = React.createElement
    local var4 = ScrollView

    local tbl5 = {
        tag = "fill size-full-0",
        scroll = {
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
            CanvasSize = UDim2.fromScale(1, 0),
            ScrollingDirection = Enum.ScrollingDirection.Y,
            scrollBarVisibility = ScrollBarVisibility.Auto
        },
        onCanvasPositionChanged = function(arg1)
            if not tbl1.hasMore or tbl1.isLoading then
                return
            end
            local absoluteCanvasSizeY = arg1.AbsoluteCanvasSize.Y
            local absoluteWindowSizeY = arg1.AbsoluteWindowSize.Y
            if absoluteCanvasSizeY <= absoluteWindowSizeY then
                return
            end
            if absoluteCanvasSizeY - absoluteWindowSizeY - arg1.CanvasPosition.Y <= 20 then
                tbl1.onLoadMore()
            end
        end,
        LayoutOrder = 2
    }

    local tbl6 = { Content = 0 }
    local createElement3 = React.createElement
    local str1 = "Frame"
    local tbl7 = {
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -12, 0, 0)
    }
    local tbl8 = { Grid = 0 }
    local element

    if tbl1.isLoading and #tbl1.captures == 0 then
        element = React.createElement(
            FoundationText,
            {
                Text = var2.loading,
                tag = "size-full-0 auto-y text-body-medium text-align-x-center content-muted"
            }
        )
    elseif #tbl1.captures == 0 then
        element = React.createElement(
            FoundationText,
            {
                Text = var2.empty,
                tag = "size-full-0 auto-y text-body-medium text-align-x-center content-muted"
            }
        )
    else
        element = React.createElement(
            "Frame",
            {
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 0, 0)
            },
            tbl2
        )
    end

    tbl8.Grid = element
    tbl6.Content = createElement3(str1, tbl7, tbl8)
    tbl4.Scroll = createElement2(var4, tbl5, tbl6)
    return createElement(var3, tbl3, tbl4)
end))
