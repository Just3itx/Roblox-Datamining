-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T12:01:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedUtilitiesParent = script:FindFirstAncestor("SduiSharedUtilities").Parent
local React = require(SduiSharedUtilitiesParent.React)
local Foundation = require(SduiSharedUtilitiesParent.Foundation)
local FoundationText = Foundation.Text
local Button = Foundation.Button
local ButtonVariant = Foundation.Enums.ButtonVariant
local ButtonSize = Foundation.Enums.ButtonSize
local useTokens = Foundation.Hooks.useTokens
local useLocalization = require(SduiSharedUtilitiesParent.Localization).Hooks.useLocalization

local function SduiFeatureErrorUi(tbl1)
    local var1 = useTokens()
    local var2 = useLocalization(
        {
            errorMessage = "Feature.Toast.NetworkingError.SomethingIsWrong",
            retryButtonText = "InGame.CommonUI.Button.Retry"
        }
    )

    return React.createElement(
        "Frame",
        {
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            BorderSizePixel = 0
        },
        {
            Layout = React.createElement("UIListLayout", {
                SortOrder = Enum.SortOrder.LayoutOrder,
                FillDirection = Enum.FillDirection.Vertical,
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                Padding = UDim.new(0, var1.Gap.Large)
            }),
            ErrorText = React.createElement(
                FoundationText,
                {
                    tag = "auto-xy text-body-medium content-default text-align-x-center",
                    Text = var2.errorMessage,
                    LayoutOrder = 1
                }
            ),
            RetryButton = if tbl1.onRetry then React.createElement(Button, {
                text = var2.retryButtonText,
                onActivated = tbl1.onRetry,
                LayoutOrder = 2,
                size = ButtonSize.Medium,
                variant = ButtonVariant.Emphasis
            }) else nil
        }
    )
end

return SduiFeatureErrorUi
