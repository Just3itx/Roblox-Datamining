-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T01:31:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TeleportService = game:GetService("TeleportService")

local CoreScriptsRoactCommon = script:FindFirstAncestor("CoreScriptsRoactCommon")
local CoreScriptsRoactCommonParent = CoreScriptsRoactCommon.Parent

local React = require(CoreScriptsRoactCommonParent.React)
local Foundation = require(CoreScriptsRoactCommonParent.Foundation)

local View = Foundation.View
local FoundationText = Foundation.Text
local Icon = Foundation.Icon
local IconName = Foundation.Enums.IconName
local IconSize = Foundation.Enums.IconSize

local useTeleportBack = require(CoreScriptsRoactCommon.Hooks.useTeleportBack)
local TraversalTelemetry = require(script.Parent.TraversalTelemetry)

return React.memo(React.forwardRef(function(tbl1, ref) -- name: TeleportBackButton
    local destinationUniverseId, var2 = TeleportService:GetThirdPartyTeleportInfo(false)
    local var3 = useTeleportBack(var2)
    local var4 = Foundation.Hooks.useTokens()

    local foreground = var4.Color.ActionStandard.Foreground

    return React.createElement(View, {
        tag = "padding-left-small padding-right-medium align-x-center align-y-center auto-x bg-over-media-0 radius-circle row size-0-1100",
        onActivated = function()
            TraversalTelemetry.sendBackButtonActionEvent(
                {
                    integration_id = "back_button",
                    destination_universe_id = destinationUniverseId,
                    event_type = "click"
                }
            )
            var3()
        end,
        ref = ref
    }, {
        TeleportBackIcon = React.createElement(
            Icon,
            {
                name = IconName.ChevronLargeLeft,
                style = foreground,
                size = IconSize.Medium,
                LayoutOrder = 1
            }
        ),
        TeleportText = tbl1.text
            and React.createElement(FoundationText, {
                Text = tbl1.text,
                tag = "auto-x size-0-full text-truncate-split text-label-medium",
                sizeConstraint = tbl1.textLimitWidth and {
                    MaxSize = Vector2.new(tbl1.textLimitWidth, var4.Size.Size_1100)
                },
                textStyle = foreground,
                LayoutOrder = 2
            })
    })
end))
