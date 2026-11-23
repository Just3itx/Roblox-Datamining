-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T06:21:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppBloxParent = script:FindFirstAncestor("AppBlox").Parent
local Foundation = require(AppBloxParent.Foundation)
local PeekView = require(AppBloxParent.PeekView)
local PeekView2 = PeekView.PeekView
local PeekViewState = PeekView.PeekViewState
local React = require(AppBloxParent.React)

local useNavigation = require(AppBloxParent.Navigation).useNavigation
local useNavigationProps = require(AppBloxParent.RobloxAppNavigation).useNavigationProps
local useTokens = Foundation.Hooks.useTokens
local normalizeFontFace = Foundation.Utility.normalizeFontFace

local function InfoPeekView(tbl1)
    local var1 = useNavigationProps(function(_, arg1)
        return {
            title = arg1.title,
            body = arg1.body
        }
    end)

    local contentFrameRef = React.useRef(nil)

    local var3 = useNavigation()
    local var4 = useTokens()

    local title = tbl1.title or var1.title
    local body = tbl1.body or var1.body

    local headingSmall = var4.Typography.HeadingSmall
    local emphasis = var4.Color.Content.Emphasis
    local bodyLarge = var4.Typography.BodyLarge
    local default = var4.Color.Content.Default

    local viewStateChanged = React.useCallback(function(arg1, _)
        if arg1 == PeekViewState.Closed or arg1 == PeekViewState.Hidden then
            var3.goBack()
        end
    end, { var3 })

    return React.createElement(PeekView2, {
        briefViewContentHeight = UDim.new(0, 0),
        contentFrameRef = contentFrameRef,
        hasScrim = true,
        mountAsFullView = true,
        returnToFullView = true,
        showDraggerInClosedState = false,
        thumbstickScrollEnabled = true,
        viewStateChanged = viewStateChanged
    }, {
        Layout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, var4.Padding.Medium)
        }),
        ContentPadding = React.createElement("UIPadding", {
            PaddingTop = UDim.new(0, var4.Padding.XXLarge),
            PaddingLeft = UDim.new(0, var4.Padding.XXLarge),
            PaddingRight = UDim.new(0, var4.Padding.XXLarge),
            PaddingBottom = UDim.new(0, var4.Padding.XXLarge)
        }),
        TitleText = React.createElement("TextLabel", {
            BackgroundTransparency = 1,
            Text = title,
            FontFace = normalizeFontFace(headingSmall.Font),
            TextSize = headingSmall.FontSize,
            TextColor3 = emphasis.Color3,
            TextTransparency = emphasis.Transparency,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextWrapped = true,
            Size = UDim2.fromScale(1, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            LayoutOrder = 1
        }),
        BodyText = React.createElement("TextLabel", {
            BackgroundTransparency = 1,
            Text = body,
            FontFace = normalizeFontFace(bodyLarge.Font),
            TextSize = bodyLarge.FontSize,
            TextColor3 = default.Color3,
            TextTransparency = default.Transparency,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextWrapped = true,
            Size = UDim2.fromScale(1, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            LayoutOrder = 2
        })
    })
end

return InfoPeekView
