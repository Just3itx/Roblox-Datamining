-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T12:21:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProgressLoadingParent = script:FindFirstAncestor("ProgressLoading").Parent

local React = require(ProgressLoadingParent.React)
local Foundation = require(ProgressLoadingParent.Foundation)
local useLocalization = require(ProgressLoadingParent.Localization).Hooks.useLocalization

local View = Foundation.View
local FoundationText = Foundation.Text
local Image = Foundation.Image
local useTokens = Foundation.Hooks.useTokens

local function Footer(tbl1)
    local var1 = useTokens()
    local size300 = var1.Size.Size_300
    local var2 = useLocalization({ poweredBy = "Feature.Landing.Label.PoweredBy" })

    return React.createElement(View, {
        tag = tbl1.tag or "auto-xy",
        LayoutOrder = tbl1.LayoutOrder,
        layout = {
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            Padding = UDim.new(0, var1.Size.Size_150),
            SortOrder = Enum.SortOrder.LayoutOrder
        },
        testId = tbl1.testId
    }, {
        Label = React.createElement(
            FoundationText,
            {
                Text = var2.poweredBy,
                tag = "auto-xy text-body-medium content-default",
                LayoutOrder = 1,
                testId = tbl1.textTestId
            }
        ),
        Wordmark = React.createElement(Image, {
            Image = "icons/logo/letterform",
            imageStyle = var1.Color.Content.Default,
            Size = UDim2.fromOffset(size300 * (47 / 9), size300),
            LayoutOrder = 2,
            testId = tbl1.wordmarkTestId
        })
    })
end

return Footer
