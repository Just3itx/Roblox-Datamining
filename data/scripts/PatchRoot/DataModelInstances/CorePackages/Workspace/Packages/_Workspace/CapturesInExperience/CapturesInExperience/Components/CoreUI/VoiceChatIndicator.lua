-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T23:41:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local React = require(scriptParentParentParentParent.React)
local RoactUtils = require(scriptParentParentParentParent.RoactUtils)
local default = require(scriptParentParentParentParent.VoiceChatCore).CoreVoiceManager.default
local Foundation = require(scriptParentParentParentParent.Foundation)
local Localization = require(scriptParentParentParentParent.Localization)

local ControlState = Foundation.Enums.ControlState
local Icon = Foundation.Icon
local Popover = Foundation.Popover
local PopoverAlign = Foundation.Enums.PopoverAlign
local FoundationText = Foundation.Text
local View = Foundation.View

local useLocalization = Localization.Hooks.useLocalization
local useScaledValue = Foundation.Hooks.useScaledValue
local useSelector = RoactUtils.Hooks.RoactRodux.useSelector
local useTokens = Foundation.Hooks.useTokens

local CaptureTriggerType = require(scriptParentParentParent.Enums.CaptureTriggerType)
local Constants = require(scriptParentParentParent.Constants)

return function(tbl1)
    local var1 = useLocalization({
        voiceChatMutedLabel = "Feature.Captures.Label.VideoCaptureVoiceChatMutedTooltip",
        voiceChatMutedTitle = "Feature.Captures.Title.VideoCaptureVoiceChatMutedTooltip"
    })

    local x = useScaledValue(320)
    local var2 = useTokens()

    local isOpen, var4 = React.useState(false)

    local var5 = useSelector(function(arg1)
        return arg1[Constants.RoduxKey].IsVideoCaptureActive.triggerType
    end)

    local onStateChanged = React.useCallback(function(pressed)
        if pressed == ControlState.Pressed then
            var4(not isOpen)
        end
    end, { isOpen })

    local onPressedOutside = React.useCallback(function()
        var4(false)
    end, {})

    if not (default:UserVoiceEnabled() and default:IsInitialized())
        or var5 ~= CaptureTriggerType.UserCapture and var5 ~= CaptureTriggerType.DeveloperCapture
        or game:GetEngineFeature("ReenableMomentsVoice")
    then
        return nil
    end

    return React.createElement(View, {
        LayoutOrder = tbl1.layoutOrder,
        onStateChanged = onStateChanged,
        tag = "anchor-center-center clip position-center-center radius-circle size-700-700"
    }, {
        Popover = React.createElement(Popover.Root, { isOpen = isOpen }, {
            Anchor = React.createElement(
                Popover.Anchor,
                {
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Position = UDim2.fromScale(0.5, 0.5)
                },
                {
                    DeafenIcon = React.createElement(Icon, {
                        name = "icons/controls/headphoneDeafen_small",
                        size = Foundation.Enums.IconSize.Small,
                        style = var2.Color.Content.Emphasis
                    })
                }
            ),
            Content = React.createElement(Popover.Content, {
                align = PopoverAlign.Center,
                hasArrow = false,
                onPressedOutside = onPressedOutside,
                side = {
                    offset = var2.Size.Size_500,
                    position = tbl1.popoverSide
                }
            }, {
                Tooltip = React.createElement(View, {
                    sizeConstraint = {
                        MaxSize = Vector2.new(x, math.huge)
                    },
                    tag = "auto-xy col gap-xsmall padding-y-small padding-x-medium"
                }, {
                    Title = React.createElement(
                        FoundationText,
                        {
                            tag = "size-full-0 auto-y text-truncate-end text-align-x-left text-title-small",
                            Text = var1.voiceChatMutedTitle
                        }
                    ),
                    Subtitle = React.createElement(
                        FoundationText,
                        {
                            tag = "size-full-0 auto-y text-wrap text-align-x-left text-body-small",
                            Text = var1.voiceChatMutedLabel
                        }
                    )
                })
            })
        })
    })
end
