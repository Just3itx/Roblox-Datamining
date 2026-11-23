-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T22:31:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BulkPurchaseApp = script:FindFirstAncestor("BulkPurchaseApp")
local BulkPurchaseAppParent = BulkPurchaseApp.Parent
local React = require(BulkPurchaseAppParent.React)
local useDesignTokens = require(BulkPurchaseAppParent.Style).useDesignTokens
local useUiModeInfo = require(BulkPurchaseAppParent.RobloxAppHooks).useUiModeInfo
local UiMode = require(BulkPurchaseAppParent.RobloxAppEnums).UiMode
local UIBlox = require(BulkPurchaseAppParent.UIBlox)

local StyledTextLabel = UIBlox.App.Text.StyledTextLabel
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local Images = UIBlox.App.ImageSet.Images
local useCursor = UIBlox.App.SelectionCursor.useCursor
local useScreenSize = require(BulkPurchaseAppParent.EconomyCommonCoreScriptHooks).useScreenSize
local constants = require(BulkPurchaseApp.constants)
local useCloseOnEscapeEffect = require(BulkPurchaseApp.Hooks.useCloseOnEscapeEffect)
local FFlagBulkPurchaseCloseOnEscape = require(BulkPurchaseApp.Flags.FFlagBulkPurchaseCloseOnEscape)

local Scrim = require(script.Parent.Scrim)
local Box = require(script.Parent.Box)

local function CloseButton(tbl1)
    local var1 = useDesignTokens()
    local selectionImageObject = useCursor(UDim.new(0, var1.Radius.Medium), 0)

    return React.createElement(
        "TextButton",
        {
            Size = UDim2.fromOffset(var1.Size.Size_900, var1.Size.Size_900),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            [React.Event.Activated] = tbl1.onActivated,
            Text = "",
            [React.Tag] = "data-testid=BulkPurchaseApp_FullPagePromptCloseButton",
            SelectionImageObject = selectionImageObject,
            Position = UDim2.fromScale(1, 0.5),
            AnchorPoint = Vector2.new(0.5, 0.5)
        },
        React.createElement(ImageSetLabel, {
            Size = UDim2.fromOffset(var1.Size.Size_700, var1.Size.Size_700),
            BackgroundTransparency = 1,
            Image = Images["icons/navigation/close"],
            ImageColor3 = var1.Color.Content.Emphasis.Color3,
            ImageTransparency = var1.Color.Content.Emphasis.Transparency,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.5, 0.5)
        })
    )
end

local function func1(arg1)
    return {
        background = arg1.Color.Surface.Surface_0.Color3,
        padding = arg1.Size.Size_600,
        cornerRadius = arg1.Radius.Medium,
        headerFontStyle = arg1.Typography.HeadingSmall,
        headerColorStyle = arg1.Color.Content.Emphasis,
        headerMarginBottom = arg1.Size.Size_800,
        headerHeight = arg1.Size.Size_700
    }
end

return (React.forwardRef(function(tbl1, ref)
    if FFlagBulkPurchaseCloseOnEscape then
        useCloseOnEscapeEffect("BulkPurchaseCloseFullPagePrompt", tbl1.onClose)
    end

    local var1 = useScreenSize()
    local var2 = useDesignTokens(func1)
    local var3 = useUiModeInfo()
    local var4 = if var3.uiMode == UiMode.TenFoot then constants.MAX_WIDTH * constants.TEN_FOOT_MULTIPLIER else constants.MAX_WIDTH
    local var5 = if var3.uiMode == UiMode.TenFoot then constants.MAX_HEIGHT * constants.TEN_FOOT_MULTIPLIER else constants.MAX_HEIGHT
    local bool1 = var1.X < constants.MOBILE_BREAKPOINT and var1.X < var1.Y
    local createElement = React.createElement
    local var6 = Scrim
    local tbl2 = { ref = ref }
    local createElement2 = React.createElement
    local var7 = Box
    local tbl3 = {
        padding = {
            var2.padding,
            var2.padding,
            var2.padding,
            var2.padding
        },
        cornerRadius = UDim.new(0, var2.cornerRadius),
        Size = 0,
        BackgroundColor3 = 0,
        BorderSizePixel = 0,
        Position = 0,
        AnchorPoint = 0
    }
    local new = UDim2.new
    local num1 = if bool1 then 1 else 0
    local var8 = if bool1 then 0 else math.min(var4, var1.X)
    tbl3.Size = new(num1, var8, 0, math.min(var5, var1.Y))

    tbl3.BackgroundColor3 = var2.background

    tbl3.Position = UDim2.fromScale(0.5, if bool1 then 1 else 0.5)
    tbl3.AnchorPoint = Vector2.new(0.5, if bool1 then 1 else 0.5)
    return createElement(
        var6,
        tbl2,
        createElement2(var7, tbl3, {
            Header = React.createElement(
                "Frame",
                {
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    Size = UDim2.new(1, 0, 0, var2.headerHeight)
                },
                React.createElement(StyledTextLabel, {
                    fontStyle = var2.headerFontStyle,
                    colorStyle = var2.headerColorStyle,
                    textXAlignment = Enum.TextXAlignment.Center,
                    textYAlignment = Enum.TextYAlignment.Center,
                    text = tbl1.title,
                    size = UDim2.new(1, 0, 1, 0)
                }),
                React.createElement(CloseButton, { onActivated = tbl1.onClose })
            ),
            Content = React.createElement("Frame", {
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Size = UDim2.new(1, 0, 1, -var2.headerHeight - var2.headerMarginBottom),
                Position = UDim2.fromOffset(0, var2.headerHeight + var2.headerMarginBottom)
            }, tbl1.children)
        })
    )
end))
