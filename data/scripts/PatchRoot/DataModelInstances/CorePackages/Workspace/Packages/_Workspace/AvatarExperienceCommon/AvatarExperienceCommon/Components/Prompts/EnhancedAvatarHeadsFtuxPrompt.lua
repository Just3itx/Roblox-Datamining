-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:21:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommon = script:FindFirstAncestor("AvatarExperienceCommon")
local AvatarExperienceCommonParent = AvatarExperienceCommon.Parent

local React = require(AvatarExperienceCommonParent.React)
local useNavigation = require(AvatarExperienceCommonParent.Navigation).useNavigation
local useLocalization = require(AvatarExperienceCommonParent.Localization).Hooks.useLocalization
local AXPartialPageModal = require(AvatarExperienceCommon.Components.AXPartialPageModal.AXPartialPageModal)
local Foundation = require(AvatarExperienceCommonParent.Foundation)
local View = Foundation.View
local FoundationText = Foundation.Text
local ButtonVariant = Foundation.Enums.ButtonVariant
local InputSize = Foundation.Enums.InputSize

local ReactFocusNavigation = require(AvatarExperienceCommonParent.ReactFocusNavigation)
local InputHandlers = require(AvatarExperienceCommonParent.InputHandlers)
local FocusNavigationEventNameEnum = require(AvatarExperienceCommonParent.FocusNavigationUtils).FocusNavigationEventNameEnum
local useFocusOnMountEffect = require(AvatarExperienceCommon.Hooks.useFocusOnMountEffect)

local tbl1 = {
    [Enum.KeyCode.ButtonB] = FocusNavigationEventNameEnum.NavigateBack,
    [Enum.KeyCode.Escape] = FocusNavigationEventNameEnum.NavigateBack
}

local function EnhancedAvatarHeadsFtuxPrompt(tbl2)
    local var1 = useNavigation()
    local var2 = useLocalization({
        confirmButtonText = "Feature.Avatar.Action.GotIt",
        enhancedAvatarHeadsTitle = "Feature.Avatar.Title.EnhancedAvatarHeads",
        enhancedAvatarHeadsMessage = "Feature.Avatar.Message.EnhancedAvatarHeads"
    })

    local var3 = var1.state.params or {}
    local onConfirm = tbl2.onConfirm or var3.onConfirm

    local var4 = React.useCallback(function()
        var1.goBack()
    end, { var1 })

    local var5 = React.useCallback(function()
        var4()
        if onConfirm then
            onConfirm()
        end
    end, { onConfirm, var4 })

    local visible, var7 = React.useState(false)
    local ref = React.useRef(nil)

    local var9 = ReactFocusNavigation.useEventMap(tbl1, ref)
    local var10 = React.useMemo(function()
        return {
            [FocusNavigationEventNameEnum.NavigateBack] = {
                handler = InputHandlers.onRelease(function(arg1)
                    arg1.cancelled = true
                    var5()
                end)
            }
        }
    end, { var5 })
    ReactFocusNavigation.useEventHandlerMap(var10, var9)

    React.useEffect(function()
        var7(true)
    end, {})

    useFocusOnMountEffect(ref, 0.15)

    local tbl3 = {
        ViewFrame = React.createElement(
            View,
            { tag = "col align-x-left align-y-top size-full-0 auto-y padding-bottom-xxlarge" },
            {
                PromptBodyTitle = React.createElement(FoundationText, {
                    tag = "auto-xy padding-bottom-small padding-top-medium text-heading-small text-wrap text-align-x-left",
                    Text = var2.enhancedAvatarHeadsTitle,
                    LayoutOrder = 1
                }),
                PromptBodyText = React.createElement(
                    FoundationText,
                    {
                        tag = "auto-xy text-body-large text-wrap text-align-x-left",
                        Text = var2.enhancedAvatarHeadsMessage,
                        LayoutOrder = 2
                    }
                )
            }
        )
    }
    return React.createElement("Frame", {
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
        ref = ref,
        SelectionGroup = true,
        SelectionBehaviorUp = Enum.SelectionBehavior.Stop,
        SelectionBehaviorDown = Enum.SelectionBehavior.Stop,
        SelectionBehaviorLeft = Enum.SelectionBehavior.Stop,
        SelectionBehaviorRight = Enum.SelectionBehavior.Stop
    }, {
        Modal = React.createElement(AXPartialPageModal, {
            visible = visible,
            onBackgroundPress = var5,
            buttonStackProps = {
                rowLayout = false,
                buttons = {{
                    props = {
                        onActivated = var5,
                        text = var2.confirmButtonText,
                        variant = ButtonVariant.Emphasis,
                        size = InputSize.Medium
                    }
                }}
            }
        }, tbl3)
    })
end

return EnhancedAvatarHeadsFtuxPrompt
