-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T04:50:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent

local _Types = require(ProfilePlatform.Components.CTARow.Types)
local _Enums = require(ProfilePlatform.Common.Enums)

local React = require(ProfilePlatformParent.React)
local CTAButton = require(ProfilePlatform.Components.CTARow.CTAButton)

local Foundation = require(ProfilePlatformParent.Foundation)
local View = Foundation.View
local FoundationText = Foundation.Text
local PopoverAlign = Foundation.Enums.PopoverAlign
local useTokens = Foundation.Hooks.useTokens

local useDisabledReasonText = require(ProfilePlatform.Components.ProfileActionBar.useDisabledReasonText)

local FFlagEnableProfilePlatformDisabledReasonText = require(ProfilePlatform.Flags.FFlagEnableProfilePlatformDisabledReasonText)

local function CTAButtonsRow(tbl1)
    local var1 = if FFlagEnableProfilePlatformDisabledReasonText then useTokens() else nil

    local var2 = if FFlagEnableProfilePlatformDisabledReasonText then React.useMemo(function()
        for _, value in tbl1.buttonList do
            if value.disabledReason then
                return value.disabledReason
            end
        end
        return nil
    end, { tbl1.buttonList }) else nil

    local var3 = if FFlagEnableProfilePlatformDisabledReasonText then useDisabledReasonText(var2) else nil

    local var4 = React.useMemo(function()
        local result = ({})
        for layoutOrder, buttonItem in tbl1.buttonList do
            local str1 = `CTAButton_{layoutOrder}`
            result[str1] = React.createElement(CTAButton, {
                buttonItem = buttonItem,
                layoutOrder = layoutOrder,
                align = if layoutOrder <= #tbl1.buttonList / 2 then PopoverAlign.Start else PopoverAlign.End
            })
        end
        return result
    end, { tbl1.buttonList })

    return React.createElement(View, {
        tag = "col gap-small size-full-0 auto-y",
        LayoutOrder = tbl1.layoutOrder
    }, {
        ButtonRow = React.createElement(View, { tag = "row gap-small size-full-0 auto-y", LayoutOrder = 0 }, var4),
        DisabledReasonText = if FFlagEnableProfilePlatformDisabledReasonText and var3 and var1 then React.createElement(
            FoundationText,
            {
                LayoutOrder = 1,
                Text = var3,
                TextWrapped = true,
                fontStyle = var1.Typography.CaptionMedium,
                colorStyle = var1.Color.Content.Emphasis,
                tag = "size-full-0 auto-y text-align-x-left text-align-y-bottom"
            }
        ) else nil
    })
end

return CTAButtonsRow
