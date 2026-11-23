-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:01:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)
local ReactRoblox = require(BuildExperienceParent.ReactRoblox)

local FoundationText = Foundation.Text
local View = Foundation.View

local function AdCampaignCreatedToast(tbl1)
    local var1 = Foundation.Hooks.useOverlay()
    local var2 = Foundation.Hooks.useTokens()

    React.useEffect(function()
        local var3 = task.delay(5, tbl1.onClose)
        return function()
            task.cancel(var3)
        end
    end, { tbl1.onClose })

    if var1 == nil then
        return nil
    end

    local testId = tbl1.testId or "AdCampaignCreatedToast"
    local bool1 = not (tbl1.actionText == nil) and tbl1.onActionActivated ~= nil
    return ReactRoblox.createPortal(
        React.createElement(View, {
            Position = UDim2.new(0.5, 0, 1, -var2.Padding.XLarge),
            ZIndex = 999,
            tag = "row align-y-center gap-medium anchor-bottom-center auto-xy padding-x-large padding-y-xsmall radius-medium bg-system-contrast",
            testId = testId
        }, {
            Title = React.createElement(
                FoundationText,
                {
                    LayoutOrder = 1,
                    Text = tbl1.title,
                    tag = "auto-xy padding-y-small text-body-medium content-inverse-emphasis"
                }
            ),
            Action = if bool1 then React.createElement(
                View,
                {
                    LayoutOrder = 2,
                    onActivated = tbl1.onActionActivated,
                    tag = "auto-xy",
                    testId = `{testId}.Action`
                },
                {
                    Label = React.createElement(FoundationText, {
                        RichText = true,
                        Text = `<u>{tbl1.actionText}</u>`,
                        tag = "auto-xy text-body-medium content-inverse-emphasis"
                    })
                }
            ) else nil
        }),
        var1
    )
end

return AdCampaignCreatedToast
