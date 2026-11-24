-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T01:11:08Z
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
local Images = UIBlox.App.ImageSet.Images
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel

local MouseIconOverrideService = require(CoreScriptsPlayerFeedbackParent.CoreScriptsCommon).MouseIconOverrideService

local constants = require(CoreScriptsPlayerFeedback.constants)
local useEscapeDismiss = require(CoreScriptsPlayerFeedback.Hooks.useEscapeDismiss)

local useScreenSize = require(CoreScriptsPlayerFeedbackParent.CoreScriptsRoactCommon).useScreenSize
local useLastInputMethod = require(CoreScriptsPlayerFeedbackParent.FocusNavigationUtils).useLastInputMethod

local GuiService = game:GetService("GuiService")
local ContextActionService = game:GetService("ContextActionService")
local TelemetryService = game:GetService("TelemetryService")

local useLocalization = require(CoreScriptsPlayerFeedbackParent.Localization).Hooks.useLocalization

local component_assetsCircle_21 = Images["component_assets/circle_21"]

return (React.memo(function(tbl1)
    local screenSize = useScreenSize()
    local var2 = useStyle()
    local var3 = useLastInputMethod()
    local isRoactGamepadEnabled, var5 = React.useState(false)

    React.useEffect(function()
        if not isRoactGamepadEnabled and (var3 == "Keyboard" or var3 == "Gamepad") then
            var5(true)
        end
    end, { isRoactGamepadEnabled, var3 })

    local var6 = useLocalization({
        Title = "CoreScripts.FeedbackPrompt.FeedbackPrompt.Title",
        Submit = "CoreScripts.FeedbackPrompt.FeedbackPrompt.Submit",
        Submitting = "CoreScripts.FeedbackPrompt.FeedbackPrompt.Submitting",
        Placeholder = "CoreScripts.FeedbackPrompt.FeedbackPrompt.Placeholder",
        Intro = "CoreScripts.FeedbackPrompt.FeedbackPrompt.Intro",
        Footer = "CoreScripts.FeedbackPrompt.FeedbackPrompt.Footer"
    })

    local var7, var8 = React.useState("")
    local isLoading, var10 = React.useState(false)
    local ref = React.useRef(nil)

    React.useEffect(function()
        if not isRoactGamepadEnabled then
            return
        end

        local current = ref.current
        if current then
            pcall(function()
                GuiService:Select(current)
            end)
        end
    end, { isRoactGamepadEnabled })

    local minFeedbackLength = constants.MIN_FEEDBACK_LENGTH
    local maxFeedbackLength = constants.MAX_FEEDBACK_LENGTH
    local delayedInputAnimSec = constants.DELAYED_INPUT_ANIM_SEC

    React.useEffect(function()
        MouseIconOverrideService.push("PlayerFeedbackPromptOverride", Enum.OverrideMouseIconBehavior.ForceShow)
        return function()
            MouseIconOverrideService.pop("PlayerFeedbackPromptOverride")
        end
    end, {})

    local onActivated = React.useCallback(function()
        if #var7 < minFeedbackLength or #var7 > maxFeedbackLength then
            return
        end

        var10(true)
        pcall(function()
            TelemetryService:LogCounter(
                {
                    eventName = "FeedbackPrompt_Submitted",
                    backends = { "RobloxTelemetryCounter" }
                },
                {
                    customFields = {}
                },
                1
            )
        end)
        pcall(function()
            local SocialService = game:GetService("SocialService")
            if SocialService.SignalFeedbackSubmissionCompleted then
                SocialService:SignalFeedbackSubmissionCompleted(var7)
            end
        end)
        tbl1.closePrompt()
    end, { var7 })

    local onCloseClicked = React.useCallback(function()
        pcall(function()
            TelemetryService:LogCounter(
                {
                    eventName = "FeedbackPrompt_Cancelled",
                    backends = { "RobloxTelemetryCounter" }
                },
                {
                    customFields = {}
                },
                1
            )
        end)
        pcall(function()
            local SocialService = game:GetService("SocialService")
            if SocialService.SignalFeedbackSubmissionPermissionDenied then
                SocialService:SignalFeedbackSubmissionPermissionDenied()
            end
        end)
        tbl1.closePrompt()
    end, {})

    useEscapeDismiss("FeedbackPromptCancel", onCloseClicked)

    React.useEffect(function()
        ContextActionService:BindCoreActionAtPriority("FeedbackPromptDisableGameControls", function(_, _, arg1): Enum.ContextActionResult
            return if arg1 and arg1.KeyCode == Enum.KeyCode.Escape then Enum.ContextActionResult.Pass else Enum.ContextActionResult.Sink
        end, false, Enum.ContextActionPriority.Low.Value, Enum.PlayerActions.CharacterForward, Enum.PlayerActions.CharacterBackward, Enum.PlayerActions.CharacterLeft, Enum.PlayerActions.CharacterRight, Enum.PlayerActions.CharacterJump)

        ContextActionService:BindCoreAction("FeedbackPromptSubmit", function(_, userInputState)
            if userInputState ~= Enum.UserInputState.Begin then
                return Enum.ContextActionResult.Pass
            end

            local selectedCoreObject = GuiService.SelectedCoreObject
            if selectedCoreObject and selectedCoreObject:IsA("TextBox") then
                return Enum.ContextActionResult.Pass
            end
            onActivated()
            return Enum.ContextActionResult.Sink
        end, false, Enum.KeyCode.ButtonA, Enum.KeyCode.Return)

        return function()
            ContextActionService:UnbindCoreAction("FeedbackPromptDisableGameControls")
            ContextActionService:UnbindCoreAction("FeedbackPromptSubmit")
        end
    end, { onActivated, onCloseClicked })

    React.useEffect(function()
        local function trySelect() -- Luacid: Inlined by compiler; 1 call site recovered
            local current = ref.current
            if current then
                pcall(function()
                    GuiService:Select(current)
                end)
            end
        end

        task.delay(0.05, trySelect)
        task.delay(0.1, trySelect)
        task.delay(0.15000000000000002, trySelect)
        task.delay(0.2, trySelect)
        task.delay(0.25, trySelect)

        local connection = GuiService:GetPropertyChangedSignal("SelectedCoreObject"):Connect(function()
            local selectedCoreObject = GuiService.SelectedCoreObject
            if selectedCoreObject == nil or selectedCoreObject and not selectedCoreObject.Parent then
                trySelect()
            end
        end)

        return function()
            connection:Disconnect()
        end
    end, {})

    local title = var6.Title
    local text = isLoading and var6.Submitting or var6.Submit
    local placeholder = var6.Placeholder
    local bool1 = minFeedbackLength <= #var7 and #var7 <= maxFeedbackLength

    local var15 = React.useCallback(function(arg1)
        local text = arg1.Text
        var8(text)
    end, {})

    local middleContent = React.useCallback(function()
        local body = var2.Font.Body
        local baseSize = var2.Font.BaseSize
        local textSize = math.floor(body.RelativeSize * baseSize)

        local num2 = math.clamp(screenSize.Y - 320, constants.MIN_TEXTBOX_HEIGHT, constants.MAX_TEXTBOX_HEIGHT)

        local yOffset = math.max(constants.MIN_TEXTBOX_HEIGHT, math.min(constants.MAX_TEXTBOX_HEIGHT, num2))

        local createElement = React.createElement
        local tbl2 = {
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, yOffset + 16 + 24),
            Selectable = false
        }
        local tbl3 = {
            Layout = React.createElement("UIListLayout", {
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 16),
                FillDirection = Enum.FillDirection.Vertical,
                HorizontalAlignment = Enum.HorizontalAlignment.Left
            }),
            Intro = React.createElement("TextLabel", {
                BackgroundTransparency = 1,
                Text = var6.Intro,
                TextWrapped = true,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Top,
                TextColor3 = var2.Theme.TextEmphasis.Color,
                TextTransparency = var2.Theme.TextEmphasis.Transparency,
                FontFace = normalizeFontFace(var2.Tokens.Typography.BodyLarge.Font),
                TextSize = textSize,
                Size = UDim2.new(1, 0, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                LayoutOrder = 0,
                Selectable = false
            }),
            TextBoxFrame = 0
        }

        local createElement2 = React.createElement
        local tbl4 = {
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, yOffset),
            LayoutOrder = 1,
            Selectable = false
        }

        local tbl5 = { InputBg = 0 }
        local createElement3 = React.createElement
        local var16 = ImageSetLabel
        local tbl6 = {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            Image = component_assetsCircle_21,
            ImageTransparency = var2.Theme.UIMuted.Transparency,
            ImageColor3 = var2.Theme.UIMuted.Color,
            ScaleType = Enum.ScaleType.Slice,
            SliceCenter = Rect.new(8, 8, 9, 9),
            Selectable = false
        }
        local tbl7 = {
            Padding = React.createElement("UIPadding", {
                PaddingTop = UDim.new(0, 12),
                PaddingBottom = UDim.new(0, 12),
                PaddingLeft = UDim.new(0, 12),
                PaddingRight = UDim.new(0, 12)
            }),
            TextBox = React.createElement("TextBox", {
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                Text = var7,
                PlaceholderText = placeholder,
                TextWrapped = true,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Top,
                TextColor3 = var2.Theme.TextEmphasis.Color,
                TextTransparency = var2.Theme.TextEmphasis.Transparency,
                PlaceholderColor3 = var2.Theme.TextMuted.Color,
                FontFace = normalizeFontFace(var2.Tokens.Typography.BodyLarge.Font),
                TextSize = textSize,
                ClearTextOnFocus = false,
                MultiLine = true,
                OverlayNativeInput = true,
                ref = ref,
                [React.Change.Text] = var15,
                [React.Tag] = "data-testid=feedbackTextBox"
            })
        }
        tbl5.InputBg = createElement3(var16, tbl6, tbl7)
        tbl3.TextBoxFrame = createElement2("Frame", tbl4, tbl5)
        return createElement("Frame", tbl2, tbl3)
    end, { var2, var7, var15 })

    local buttonStackInfo = React.useMemo(function()
        return {
            buttons = {{
                buttonType = ButtonType.PrimaryContextual,
                props = {
                    onActivated = onActivated,
                    text = text,
                    isDelayedInput = tbl1.enableInputDelayed,
                    enableInputDelayed = tbl1.enableInputDelayed,
                    delayInputSeconds = delayedInputAnimSec,
                    isDisabled = not bool1,
                    isLoading = isLoading
                }
            }}
        }
    end, {
        onActivated,
        text,
        tbl1.enableInputDelayed,
        bool1,
        isLoading
    })
    local footer = var6.Footer

    local footerContent = React.useCallback(function()
        local var18 = footer
        if type(var18) == "string" and string.find(var18, "Roblox Terms of Use", 1, true) then
            var18 = string.gsub(var18, "Roblox Terms of Use", "<u>Roblox Terms of Use</u>", 1)
        end

        local createElement = React.createElement
        local tbl2 = {
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y
        }
        local tbl3 = {
            Pad = React.createElement("UIPadding", { PaddingTop = UDim.new(0, 12) }),
            Note = React.createElement("TextLabel", {
                BackgroundTransparency = 1,
                Text = var18,
                RichText = true,
                TextWrapped = true,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Top,
                TextSize = math.floor(var2.Font.CaptionHeader.RelativeSize * var2.Font.BaseSize),
                FontFace = normalizeFontFace(var2.Tokens.Typography.CaptionLarge.Font),
                TextColor3 = var2.Theme.TextMuted.Color,
                TextTransparency = var2.Theme.TextMuted.Transparency,
                Size = UDim2.new(1, 0, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                LayoutOrder = 1,
                Selectable = false
            })
        }
        return createElement("Frame", tbl2, tbl3)
    end, { var2, footer })

    return React.createElement(InteractiveAlert, {
        title = title,
        onCloseClicked = onCloseClicked,
        buttonStackInfo = buttonStackInfo,
        isMiddleContentFocusable = true,
        middleContent = middleContent,
        position = UDim2.fromScale(0.5, 0.5),
        screenSize = screenSize,
        defaultChildRef = if isRoactGamepadEnabled then ref else nil,
        isRoactGamepadEnabled = isRoactGamepadEnabled,
        footerContent = footerContent
    })
end))
