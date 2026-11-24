-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:21:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CurrencyTransfers = script:FindFirstAncestor("CurrencyTransfers")
local CurrencyTransfersParent = CurrencyTransfers.Parent

local React = require(CurrencyTransfersParent.React)

local Foundation = require(CurrencyTransfersParent.Foundation)
local Button = Foundation.Button
local View = Foundation.View
local ButtonVariant = Foundation.Enums.ButtonVariant
local Enums = Foundation.Enums

local GetFFlagCurrencyTransferFlowUIImprovementFix = require(CurrencyTransfers.Flags.GetFFlagCurrencyTransferFlowUIImprovementFix)

local function TransferAmountOptionChips(tbl1)
    local var1 = React.useMemo(function()
        local result = ({})
        local fFlagCurrencyTransferFlowUiImprovementFix = GetFFlagCurrencyTransferFlowUIImprovementFix()

        for layoutOrder, chip in ipairs(tbl1.chips) do
            local bool1 = tbl1.selectedAmount == chip.amount

            if fFlagCurrencyTransferFlowUiImprovementFix then
                local createElement = React.createElement
                local str1 = "Frame"
                local tbl2 = {
                    AutomaticSize = Enum.AutomaticSize.X,
                    Size = UDim2.new(0, 0, 0, 52),
                    BackgroundTransparency = 1,
                    LayoutOrder = layoutOrder
                }
                local tbl3 = { ChipFrame = 0, TouchTarget = 0 }
                local createElement2 = React.createElement
                local str2 = "Frame"
                local tbl4 = {
                    AutomaticSize = Enum.AutomaticSize.X,
                    Size = UDim2.new(0, 0, 0, 52),
                    BackgroundTransparency = 1
                }
                local tbl5 = {
                    Layout = React.createElement("UIListLayout", {
                        FillDirection = Enum.FillDirection.Vertical,
                        HorizontalAlignment = Enum.HorizontalAlignment.Center,
                        VerticalAlignment = Enum.VerticalAlignment.Center
                    }),
                    ChipButton = 0
                }
                local createElement3 = React.createElement
                local var1 = Button
                local tbl6 = {
                    text = chip.text,
                    icon = Enums.IconName.Robux,
                    variant = if bool1 then ButtonVariant.Subtle else ButtonVariant.Standard,
                    size = Enums.ChipSize.Medium,
                    onActivated = 0
                }

                function tbl6.onActivated() end

                tbl5.ChipButton = createElement3(var1, tbl6)
                tbl3.ChipFrame = createElement2(str2, tbl4, tbl5)

                local createElement4 = React.createElement
                local tbl7 = {
                    Size = UDim2.new(1, 0, 0, 52),
                    BackgroundTransparency = 1,
                    Text = "",
                    ZIndex = 5
                }
                tbl7[React.Event.Activated] = function()
                    tbl1.onChipSelected(chip.amount)
                end

                tbl7[React.Event.InputBegan] = function(_, arg1)
                    if arg1.UserInputType == Enum.UserInputType.Touch then
                        tbl1.onChipSelected(chip.amount)
                    end
                end

                tbl3.TouchTarget = createElement4("TextButton", tbl7)
                result[layoutOrder] = createElement(str1, tbl2, tbl3)
            else
                local createElement = React.createElement
                local var1 = Button
                local tbl2 = {
                    text = chip.text,
                    icon = Enums.IconName.Robux,
                    onActivated = 0,
                    LayoutOrder = 0,
                    variant = 0,
                    size = 0
                }

                function tbl2.onActivated()
                    tbl1.onChipSelected(chip.amount)
                end
                tbl2.LayoutOrder = layoutOrder
                tbl2.variant = if bool1 then ButtonVariant.Subtle else ButtonVariant.Standard
                tbl2.size = Enums.ChipSize.Medium
                result[layoutOrder] = createElement(var1, tbl2)
            end
        end

        return result
    end, { tbl1.chips, tbl1.selectedAmount, tbl1.onChipSelected })

    return React.createElement(
        View,
        {
            tag = "row align-x-center align-y-center gap-small auto-xy padding-y-medium",
            LayoutOrder = tbl1.layoutOrder or 1
        },
        {
            ChipsContainer = React.createElement(View, { tag = "row align-x-center align-y-center gap-small auto-xy" }, table.unpack(var1))
        }
    )
end
return TransferAmountOptionChips
