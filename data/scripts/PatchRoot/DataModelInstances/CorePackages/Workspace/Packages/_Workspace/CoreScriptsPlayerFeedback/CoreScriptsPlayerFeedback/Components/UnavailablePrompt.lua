-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T01:11:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreScriptsPlayerFeedback = script:FindFirstAncestor("CoreScriptsPlayerFeedback")
local CoreScriptsPlayerFeedbackParent = CoreScriptsPlayerFeedback.Parent

local React = require(CoreScriptsPlayerFeedbackParent.React)
local UIBlox = require(CoreScriptsPlayerFeedbackParent.UIBlox)
local normalizeFontFace = require(CoreScriptsPlayerFeedbackParent.Foundation).Utility.normalizeFontFace
local useStyle = UIBlox.Core.Style.useStyle

local InteractiveAlert = UIBlox.App.Dialog.Alert.InteractiveAlert
local ButtonType = UIBlox.App.Button.Enum.ButtonType
local useScreenSize = require(CoreScriptsPlayerFeedbackParent.CoreScriptsRoactCommon).useScreenSize
local useLastInputMethod = require(CoreScriptsPlayerFeedbackParent.FocusNavigationUtils).useLastInputMethod

local GuiService = game:GetService("GuiService")

local useEscapeDismiss = require(CoreScriptsPlayerFeedback.Hooks.useEscapeDismiss)

local useLocalization = require(CoreScriptsPlayerFeedbackParent.Localization).Hooks.useLocalization

return (React.memo(function(tbl1)
    local screenSize = useScreenSize()
    local var2 = useStyle()
    local var3 = React.useRef(nil)

    local var4 = useLastInputMethod()
    local var5, var6 = React.useState(false)

    React.useEffect(function()
        if not var5 and (var4 == "Keyboard" or var4 == "Gamepad") then
            var6(true)
        end
    end, { var5, var4 })

    local var7 = useLocalization({
        Title = "CoreScripts.FeedbackPrompt.FeedbackPrompt.Unavailable.Title",
        HeaderUnder13 = "CoreScripts.FeedbackPrompt.FeedbackPrompt.Unavailable.Header.Under13",
        HintUnder13 = "CoreScripts.FeedbackPrompt.FeedbackPrompt.Unavailable.Hint.Under13",
        HeaderRateLimited = "CoreScripts.FeedbackPrompt.FeedbackPrompt.Unavailable.Header.RateLimited",
        HintRateLimited = "CoreScripts.FeedbackPrompt.FeedbackPrompt.Unavailable.Hint.RateLimited",
        HeaderDefault = "CoreScripts.FeedbackPrompt.FeedbackPrompt.Unavailable.Header.Default",
        HintDefault = "CoreScripts.FeedbackPrompt.FeedbackPrompt.Unavailable.Hint.Default",
        OkayButton = "CoreScripts.FeedbackPrompt.FeedbackPrompt.Unavailable.OkayButton"
    })

    local _title = var7.Title
    local var8, var9

    if tbl1.reason == "Under13" then
        var8 = var7.HeaderUnder13
        var9 = var7.HintUnder13
    elseif tbl1.reason == "RateLimited" then
        var8 = var7.HeaderRateLimited
        var9 = var7.HintRateLimited
    else
        var8 = var7.HeaderDefault
        var9 = var7.HintDefault
    end

    local middleContent = React.useCallback(function()
        local body = var2.Font.Body
        local var10 = var2.Font.Header2 or var2.Font.Body
        local baseSize = var2.Font.BaseSize
        local textSize = math.floor(var10.RelativeSize * baseSize)
        local num1 = math.floor(body.RelativeSize * baseSize)
        return React.createElement(
            "Frame",
            {
                BackgroundTransparency = 1,
                AutomaticSize = Enum.AutomaticSize.Y,
                Size = UDim2.new(1, 0, 0, 0)
            },
            {
                Layout = React.createElement("UIListLayout", {
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    Padding = UDim.new(0, 10),
                    FillDirection = Enum.FillDirection.Vertical,
                    HorizontalAlignment = Enum.HorizontalAlignment.Left
                }),
                Header = React.createElement("TextLabel", {
                    BackgroundTransparency = 1,
                    Text = var8,
                    TextWrapped = true,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextYAlignment = Enum.TextYAlignment.Top,
                    TextColor3 = var2.Theme.TextEmphasis.Color,
                    TextTransparency = var2.Theme.TextEmphasis.Transparency,
                    FontFace = normalizeFontFace(var2.Tokens.Typography.TitleLarge.Font),
                    TextSize = textSize,
                    Size = UDim2.new(1, 0, 0, 0),
                    AutomaticSize = Enum.AutomaticSize.Y,
                    LayoutOrder = 1
                }),
                Hint = React.createElement("TextLabel", {
                    BackgroundTransparency = 1,
                    Text = var9,
                    TextWrapped = true,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextYAlignment = Enum.TextYAlignment.Top,
                    TextColor3 = var2.Theme.TextMuted.Color,
                    TextTransparency = var2.Theme.TextMuted.Transparency,
                    FontFace = normalizeFontFace(var2.Tokens.Typography.BodyLarge.Font),
                    TextSize = num1,
                    Size = UDim2.new(1, 0, 0, 0),
                    AutomaticSize = Enum.AutomaticSize.Y,
                    LayoutOrder = 2
                })
            }
        )
    end, { var2, var8, var9 })

    local var11 = React.useCallback(function()
        tbl1.closePrompt()
    end, { tbl1.closePrompt })

    useEscapeDismiss("UnavailablePromptCancel", var11)

    local buttonRef = React.useCallback(function(selectionParent: Instance)
        var3.current = selectionParent
        if var5 and selectionParent then
            pcall(function()
                GuiService:Select(selectionParent)
            end)
        end
    end, { var5 })

    React.useEffect(function()
        if not var5 then
            return
        end
        local current = var3.current
        if current then
            pcall(function()
                GuiService:Select(current)
            end)
        end
    end, { var5 })

    local buttonStackInfo = React.useMemo(function()
        return {
            buttons = {{
                buttonType = ButtonType.PrimarySystem,
                props = {
                    onActivated = var11,
                    text = var7.OkayButton,
                    isDelayedInput = false,
                    enableInputDelayed = false,
                    delayInputSeconds = 1,
                    isDisabled = false,
                    buttonRef = buttonRef
                },
                isDefaultChild = var5
            }}
        }
    end, {
        var11,
        var7.OkayButton,
        var5,
        buttonRef
    })
    return React.createElement(InteractiveAlert, {
        title = var7.Title,
        buttonStackInfo = buttonStackInfo,
        isMiddleContentFocusable = false,
        middleContent = middleContent,
        position = UDim2.fromScale(0.5, 0.5),
        screenSize = screenSize,
        defaultChildRef = if var5 then var3 else nil,
        isRoactGamepadEnabled = var5,
        onCloseClicked = var11
    })
end))
