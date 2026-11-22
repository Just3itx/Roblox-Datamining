-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:50:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreation = script:FindFirstAncestor("MomentsCreation")
local MomentsCreationParent = MomentsCreation.Parent

local Foundation = require(MomentsCreationParent.Foundation)
local React = require(MomentsCreationParent.React)

local Dialog = Foundation.Dialog
local RadioGroup = Foundation.RadioGroup
local FoundationText = Foundation.Text
local View = Foundation.View

local useCreationFlowStrings = require(MomentsCreation.Hooks.useCreationFlowStrings)

local function GenerateTextOptionsDialog(tbl1)
    local var1 = useCreationFlowStrings()
    local value, onValueChanged = React.useState("hype")

    local onActivated = React.useCallback(function()
        local var4 = if tbl1.showTone then value else nil
        tbl1.onSelect(var4)
    end, { tbl1.showTone, value, tbl1.onSelect })

    local tbl2 = { Layout = 0 }
    local createElement = React.createElement
    local var5 = View
    local tbl3 = { tag = "col gap-medium size-full-0 auto-y" }

    local tbl4 = { TonePanel = 0 }
    local element

    if tbl1.showTone then
        element = React.createElement(View, {
            tag = "col gap-small size-full-0 auto-y",
            LayoutOrder = 1
        }, {
            Heading = React.createElement(
                FoundationText,
                {
                    Text = var1.ToneHeading,
                    tag = "auto-xy text-title-medium content-default",
                    LayoutOrder = 1
                }
            ),
            Radios = React.createElement(RadioGroup.Root, {
                value = value,
                onValueChanged = onValueChanged,
                LayoutOrder = 2
            }, {
                Hype = React.createElement(RadioGroup.Item, { value = "hype", label = var1.ToneHype, LayoutOrder = 1 }),
                Neutral = React.createElement(RadioGroup.Item, { value = "neutral", label = var1.ToneNeutral, LayoutOrder = 2 }),
                Cinematic = React.createElement(RadioGroup.Item, { value = "cinematic", label = var1.ToneCinematic, LayoutOrder = 3 }),
                Funny = React.createElement(RadioGroup.Item, { value = "funny", label = var1.ToneFunny, LayoutOrder = 4 })
            })
        })
    else
        element = nil
    end

    tbl4.TonePanel = element
    tbl2.Layout = createElement(var5, tbl3, tbl4)

    return React.createElement(
        Dialog.Root,
        {
            disablePortal = false,
            hasBackdrop = true,
            onClose = tbl1.onCancel,
            size = Foundation.Enums.DialogSize.Medium
        },
        {
            DialogTitle = React.createElement(Dialog.Title, { text = var1.GenerateTextOptionsTitle, LayoutOrder = 1 }),
            DialogContent = React.createElement(Dialog.Content, { LayoutOrder = 2 }, tbl2),
            DialogActions = React.createElement(Dialog.Actions, {
                LayoutOrder = 3,
                actions = {
                    {
                        text = var1.GenerateTextCta,
                        variant = Foundation.Enums.ButtonVariant.Emphasis,
                        onActivated = onActivated
                    },
                    {
                        text = var1.GeneralCtaCancel,
                        variant = Foundation.Enums.ButtonVariant.Standard,
                        onActivated = tbl1.onCancel
                    }
                }
            })
        }
    )
end

return GenerateTextOptionsDialog
