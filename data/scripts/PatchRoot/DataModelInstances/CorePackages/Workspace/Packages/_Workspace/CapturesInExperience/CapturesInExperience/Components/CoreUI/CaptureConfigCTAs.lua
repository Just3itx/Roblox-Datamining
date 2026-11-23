-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T23:41:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local GuiService = game:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")

local Localization = require(scriptParentParentParentParent.Localization)
local React = require(scriptParentParentParentParent.React)
local UIBlox = require(scriptParentParentParentParent.UIBlox)
local Foundation = require(scriptParentParentParentParent.Foundation)
local GetTextSize = require(scriptParentParentParentParent.Style).GetTextSize
local normalizeFontFace = Foundation.Utility.normalizeFontFace

local useLocalization = Localization.Hooks.useLocalization
local useStyle = UIBlox.Core.Style.useStyle

local CapturesContext = require(scriptParentParentParent.Context.CapturesContext)
local CapturesPolicy = require(scriptParentParentParent.App.CapturesPolicy)
local OnOffButton = require(scriptParentParentParent.Components.CoreUI.OnOffButton)
local VideoCaptureCTA = require(scriptParentParentParent.Components.CoreUI.VideoCaptureCTA)

local useKeyboardEnabled = require(scriptParentParentParent.Hooks.useKeyboardEnabled)

local uDim = UDim.new(0, 8)

local keyOne = if UserInputService:GetPlatform() == Enum.Platform.OSX then "Opt" else "Alt"

return (CapturesPolicy.connect(function(arg1)
    return {
        eligibleForVideoCapture = arg1.eligibleForVideoCapture()
    }
end)(function(tbl1)
    local var1 = useStyle()
    local chromeEnabled = React.useContext(CapturesContext).chromeEnabled

    local var2, var3 = React.useState(Vector2.new(0, 0))
    local var4, var5 = React.useState(GuiService.PreferredTextSize)

    React.useEffect(function()
        local function onPreferredTextSizeChangedSignal()
            var5(GuiService.PreferredTextSize)
        end
        local connection = GuiService:GetPropertyChangedSignal("PreferredTextSize"):Connect(onPreferredTextSizeChangedSignal)

        return function()
            connection:Disconnect()
        end
    end, {})

    local var6 = useLocalization({
        capturesTitle = "Feature.Captures.Title.Captures",
        educationalText = "Feature.Captures.Label.EducationalText",
        hotkeyEducationalText = {
            "Feature.Captures.Label.HotkeyEducationalText",
            keyOne = keyOne,
            keyTwo = UserInputService:GetStringForKeyCode(Enum.KeyCode.One)
        }
    })
    local var7 = if useKeyboardEnabled() then var6.hotkeyEducationalText else var6.educationalText
    local backgroundDefaultColor = var1.Theme.BackgroundDefault.Color
    local backgroundDefaultTransparency = var1.Theme.BackgroundDefault.Transparency

    local textDefaultColor = var1.Theme.TextDefault.Color
    local font = var1.Tokens.Typography.BodySmall.Font
    local textSize = var1.Font.BaseSize * var1.Font.CaptionBody.RelativeSize

    local textEmphasisColor = var1.Theme.TextEmphasis.Color
    local font2 = var1.Tokens.Typography.TitleLarge.Font
    local var8 = var1.Font.BaseSize * var1.Font.Header2.RelativeSize

    local var10 = React.useCallback(function(arg1)
        var3(arg1.AbsoluteSize)
        if tbl1.onAbsoluteSizeChanged then
            tbl1.onAbsoluteSizeChanged(arg1.AbsoluteSize)
        end
    end, {})

    local var11 = React.useMemo(function()
        return GetTextSize(var7, textSize, font, Vector2.new(10000, 10000)).X
    end, {
        font,
        textSize,
        var4,
        var7
    })
    local x = var2.X
    local bool1 = var11 < x - 224 - 24

    local yOffset = if bool1 or var11 < x - 24 then 20 else GetTextSize(var7, textSize, font, Vector2.new(x - 24, 10000)).Y + 10

    local createElement = React.createElement
    local str2 = "Frame"
    local tbl2 = {
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundColor3 = backgroundDefaultColor,
        BackgroundTransparency = backgroundDefaultTransparency,
        BorderSizePixel = 0,
        LayoutOrder = tbl1.LayoutOrder,
        Size = UDim2.fromScale(1, 0),
        [React.Change.AbsoluteSize] = var10
    }
    local tbl3 = {
        UICorner = React.createElement("UICorner", { CornerRadius = uDim }),
        UIPadding = React.createElement("UIPadding", {
            PaddingBottom = UDim.new(0, 12),
            PaddingLeft = UDim.new(0, 12),
            PaddingRight = UDim.new(0, 12),
            PaddingTop = UDim.new(0, 12)
        }),
        Layout = if chromeEnabled then nil else React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder,
            VerticalAlignment = Enum.VerticalAlignment.Top
        }),
        CapturesToggleCTA = 0,
        Space = 0,
        VideoCaptureCTA = 0
    }
    local var12

    if chromeEnabled then
        var12 = nil
    else
        local createElement2 = React.createElement
        local str3 = "Frame"
        local tbl4 = {
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundColor3 = backgroundDefaultColor,
            BackgroundTransparency = backgroundDefaultTransparency,
            BorderSizePixel = 0,
            LayoutOrder = 1,
            Size = UDim2.fromScale(1, 0)
        }
        local tbl5 = {
            TextFrame = React.createElement(
                "Frame",
                {
                    AutomaticSize = Enum.AutomaticSize.Y,
                    BackgroundTransparency = 1,
                    Size = UDim2.fromScale(1, 0)
                },
                {
                    Layout = React.createElement("UIListLayout", {
                        FillDirection = Enum.FillDirection.Vertical,
                        HorizontalAlignment = Enum.HorizontalAlignment.Center,
                        SortOrder = Enum.SortOrder.LayoutOrder,
                        VerticalAlignment = Enum.VerticalAlignment.Top
                    }),
                    Title = React.createElement("TextLabel", {
                        BackgroundTransparency = 1,
                        FontFace = normalizeFontFace(font2),
                        LayoutOrder = 1,
                        Size = UDim2.new(1, 0, 0, 30),
                        Text = var6.capturesTitle,
                        TextColor3 = textEmphasisColor,
                        TextSize = var8,
                        TextXAlignment = Enum.TextXAlignment.Left
                    }),
                    EducationalLabel = React.createElement("TextLabel", {
                        BackgroundTransparency = 1,
                        FontFace = normalizeFontFace(font),
                        LayoutOrder = 2,
                        Size = UDim2.new(1, 0, 0, yOffset),
                        Text = var7,
                        TextColor3 = textDefaultColor,
                        TextSize = textSize,
                        TextWrapped = true,
                        TextXAlignment = Enum.TextXAlignment.Left
                    })
                }
            ),
            CapturesToggleFrame = React.createElement(
                "Frame",
                {
                    AnchorPoint = if bool1 then Vector2.new(1, 0.5) else Vector2.new(1, 0),
                    BackgroundTransparency = 1,
                    Position = if bool1 then UDim2.fromScale(1, 0.5) else UDim2.new(1, 0, 0, -10),
                    Size = UDim2.fromOffset(224, 44)
                },
                {
                    OnOffButton = React.createElement(OnOffButton, { height = 44, width = 224 })
                }
            )
        }
        var12 = createElement2(str3, tbl4, tbl5)
    end

    tbl3.CapturesToggleCTA = var12

    tbl3.Space = if tbl1.eligibleForVideoCapture and not chromeEnabled then React.createElement(
        "Frame",
        {
            BorderSizePixel = 0,
            BackgroundTransparency = 1,
            Size = UDim2.new(0, 0, 0, 20),
            LayoutOrder = 2
        }
    ) else nil

    tbl3.VideoCaptureCTA = if tbl1.eligibleForVideoCapture then React.createElement(VideoCaptureCTA, { closeSettingsMenu = tbl1.closeSettingsMenu, LayoutOrder = 3 }) else nil
    return createElement(str2, tbl2, tbl3)
end))
