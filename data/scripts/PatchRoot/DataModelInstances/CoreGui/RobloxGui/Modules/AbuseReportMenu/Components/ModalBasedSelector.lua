-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:50:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AbuseReportMenu = script:FindFirstAncestor("AbuseReportMenu")
local CorePackages = game:GetService("CorePackages")
local Foundation = require(CorePackages.Packages.Foundation)
local React = require(CorePackages.Packages.React)
local Icon = Foundation.Icon
local FoundationText = Foundation.Text
local View = Foundation.View

local ModalBasedSelectorDialogController = require(AbuseReportMenu.Components.ModalBasedSelectorDialogController)

local FFlagHideShortcutsOnReportDropdown = require(AbuseReportMenu.Flags.FFlagHideShortcutsOnReportDropdown)

local function ModalBasedSelector(arg1)
    local var1 = if FFlagHideShortcutsOnReportDropdown then React.useCallback(function()
        arg1.onMenuOpenChange(true)
    end, { arg1.onMenuOpenChange }) else nil

    local var2 = React.useCallback(function()
        ModalBasedSelectorDialogController.unmountModalSelector()
        if FFlagHideShortcutsOnReportDropdown then
            arg1.onMenuOpenChange(false)
        end
    end, { arg1.onMenuOpenChange })

    return React.createElement("Frame", {
        Size = UDim2.new(1, 0, 0, arg1.selectorHeight),
        BackgroundTransparency = 1
    }, {
        ControlButton = React.createElement(View, {
            tag = "size-full stroke-thicker stroke-emphasis radius-medium",
            onActivated = function()
                ModalBasedSelectorDialogController.mountModalSelector(
                    arg1.viewportHeight,
                    arg1.viewportWidth,
                    arg1.selections,
                    arg1.onSelect,
                    var2,
                    var1
                )
            end
        }, {
            Text = React.createElement(FoundationText, {
                Text = arg1.selectedValue or arg1.placeholderText,
                tag = "size-full anchor-center-center position-center-center",
                TextTruncate = Enum.TextTruncate.AtEnd
            }),
            Icon = React.createElement(
                Icon,
                {
                    name = "icons/actions/truncationExpand",
                    AnchorPoint = Vector2.new(1, 0),
                    Position = UDim2.new(1, 0, 0, 0)
                }
            )
        })
    })
end
return ModalBasedSelector
