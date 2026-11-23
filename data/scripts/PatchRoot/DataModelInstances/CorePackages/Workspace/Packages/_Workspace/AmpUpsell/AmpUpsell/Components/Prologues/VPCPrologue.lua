-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T05:41:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AmpUpsell = script:FindFirstAncestor("AmpUpsell")
local AmpUpsellParent = AmpUpsell.Parent

local React = require(AmpUpsellParent.React)
local useLocalization = require(AmpUpsellParent.Localization).Hooks.useLocalization

local Foundation = require(AmpUpsellParent.Foundation)
local ButtonVariant = Foundation.Enums.ButtonVariant
local Dialog = Foundation.Dialog
local DialogSize = Foundation.Enums.DialogSize
local EnumsOrientation = Foundation.Enums.Orientation

local vpcPrologueStrings = require(AmpUpsell.Common.LocalizationStrings).vpcPrologueStrings
local _Types = require(AmpUpsell.Common.Types)

local GetFFlagEnableReusableVPCPrologue = require(AmpUpsell.Flags.GetFFlagEnableReusableVPCPrologue)

local function getBodyLocalizationKey(bool1: boolean) -- Luacid: Inlined by compiler; 2 call sites recovered
    if bool1 then
        if bool1.enablePurchases == true then
            return vpcPrologueStrings.bodyPurchases
        end

        if bool1.contentAgeRestriction ~= nil then
            return vpcPrologueStrings.bodyContentRestriction
        end

        if bool1.friendManagementAction == "Unblock" then
            return vpcPrologueStrings.bodyUnblock
        end
    end
    return vpcPrologueStrings.bodyGeneric
end

local function ConfigurableVPCPrologue(tbl1)
    local bool1 = false
    local config = tbl1.config or {}
    local var1 = useLocalization
    local tbl2 = {
        title = vpcPrologueStrings.title,
        body = 0,
        buttonAsk = 0,
        buttonCancel = 0
    }
    local recourseData = tbl1.recourseData
    local var2

    if recourseData then
        if recourseData.enablePurchases == true then
            var2 = vpcPrologueStrings.bodyPurchases
        elseif recourseData.contentAgeRestriction == nil then
            if recourseData.friendManagementAction == "Unblock" then
                var2 = vpcPrologueStrings.bodyUnblock
            else
                bool1 = true
            end
        else
            var2 = vpcPrologueStrings.bodyContentRestriction
        end
    else
        bool1 = true
    end
    if bool1 then
        var2 = getBodyLocalizationKey(false)
    end

    tbl2.body = var2
    tbl2.buttonAsk = vpcPrologueStrings.buttonAsk
    tbl2.buttonCancel = vpcPrologueStrings.buttonCancel
    local var3 = var1(tbl2)

    local actions = {{
        text = config.confirmText or var3.buttonAsk,
        variant = ButtonVariant.Emphasis,
        onActivated = tbl1.onConfirm
    }}

    if not config.hideCancel then
        table.insert(
            actions,
            if config.cancelFirst then 1 else 2,
            {
                text = config.cancelText or var3.buttonCancel,
                variant = ButtonVariant.Standard,
                onActivated = tbl1.onCancel
            }
        )
    end
    local bool2 = not config.omitLayoutOrder

    local createElement = React.createElement
    local root = Dialog.Root
    local tbl4 = {
        size = if config.dialogSize == "Medium" then DialogSize.Medium else DialogSize.Small,
        hasBackdrop = config.hasBackdrop,
        closeOnClickOutside = config.closeOnClickOutside,
        onClose = if config.onClose then config.onClose elseif config.onCloseCancels then tbl1.onCancel else nil
    }
    local tbl5 = {
        Title = React.createElement(Dialog.Title, { LayoutOrder = if bool2 then 1 else nil, text = config.titleText or var3.title }),
        Content = React.createElement(
            Dialog.Content,
            {
                LayoutOrder = if bool2 then 2 else nil
            },
            {
                Text = config.bodyContent or React.createElement(Dialog.Text, { Text = config.bodyText or var3.body })
            }
        ),
        Buttons = React.createElement(Dialog.Actions, {
            LayoutOrder = if bool2 then 3 else nil,
            orientation = if config.actionOrientation == "Vertical" then EnumsOrientation.Vertical elseif config.actionOrientation == "Horizontal" then EnumsOrientation.Horizontal else nil,
            actions = actions
        })
    }
    return createElement(root, tbl4, tbl5)
end

local function LegacyVPCPrologue(tbl1)
    local recourseData = tbl1.recourseData
    local var1, var2

    if not recourseData then
        var1 = getBodyLocalizationKey(false)

        var2 = useLocalization({
            title = vpcPrologueStrings.title,
            body = var1,
            buttonAsk = vpcPrologueStrings.buttonAsk,
            buttonCancel = vpcPrologueStrings.buttonCancel
        })

        return React.createElement(Dialog.Root, {
            size = DialogSize.Small
        }, {
            Title = React.createElement(Dialog.Title, { LayoutOrder = 1, text = var2.title }),
            Content = React.createElement(
                Dialog.Content,
                { LayoutOrder = 2 },
                {
                    Text = React.createElement(Dialog.Text, { Text = var2.body })
                }
            ),
            Buttons = React.createElement(Dialog.Actions, {
                LayoutOrder = 3,
                actions = {
                    {
                        text = var2.buttonAsk,
                        variant = ButtonVariant.Emphasis,
                        onActivated = tbl1.onConfirm
                    },
                    {
                        text = var2.buttonCancel,
                        variant = ButtonVariant.Standard,
                        onActivated = tbl1.onCancel
                    }
                }
            })
        })
    end

    if recourseData.enablePurchases == true then
        var1 = vpcPrologueStrings.bodyPurchases
    else
        if recourseData.contentAgeRestriction == nil then
            if recourseData.friendManagementAction == "Unblock" then
                var1 = vpcPrologueStrings.bodyUnblock

                var2 = useLocalization({
                    title = vpcPrologueStrings.title,
                    body = var1,
                    buttonAsk = vpcPrologueStrings.buttonAsk,
                    buttonCancel = vpcPrologueStrings.buttonCancel
                })

                return React.createElement(Dialog.Root, {
                    size = DialogSize.Small
                }, {
                    Title = React.createElement(Dialog.Title, { LayoutOrder = 1, text = var2.title }),
                    Content = React.createElement(
                        Dialog.Content,
                        { LayoutOrder = 2 },
                        {
                            Text = React.createElement(Dialog.Text, { Text = var2.body })
                        }
                    ),
                    Buttons = React.createElement(Dialog.Actions, {
                        LayoutOrder = 3,
                        actions = {
                            {
                                text = var2.buttonAsk,
                                variant = ButtonVariant.Emphasis,
                                onActivated = tbl1.onConfirm
                            },
                            {
                                text = var2.buttonCancel,
                                variant = ButtonVariant.Standard,
                                onActivated = tbl1.onCancel
                            }
                        }
                    })
                })
            end

            var1 = getBodyLocalizationKey(false)

            var2 = useLocalization({
                title = vpcPrologueStrings.title,
                body = var1,
                buttonAsk = vpcPrologueStrings.buttonAsk,
                buttonCancel = vpcPrologueStrings.buttonCancel
            })

            return React.createElement(Dialog.Root, {
                size = DialogSize.Small
            }, {
                Title = React.createElement(Dialog.Title, { LayoutOrder = 1, text = var2.title }),
                Content = React.createElement(
                    Dialog.Content,
                    { LayoutOrder = 2 },
                    {
                        Text = React.createElement(Dialog.Text, { Text = var2.body })
                    }
                ),
                Buttons = React.createElement(Dialog.Actions, {
                    LayoutOrder = 3,
                    actions = {
                        {
                            text = var2.buttonAsk,
                            variant = ButtonVariant.Emphasis,
                            onActivated = tbl1.onConfirm
                        },
                        {
                            text = var2.buttonCancel,
                            variant = ButtonVariant.Standard,
                            onActivated = tbl1.onCancel
                        }
                    }
                })
            })
        end

        var1 = vpcPrologueStrings.bodyContentRestriction
    end

    var2 = useLocalization({
        title = vpcPrologueStrings.title,
        body = var1,
        buttonAsk = vpcPrologueStrings.buttonAsk,
        buttonCancel = vpcPrologueStrings.buttonCancel
    })

    return React.createElement(Dialog.Root, {
        size = DialogSize.Small
    }, {
        Title = React.createElement(Dialog.Title, { LayoutOrder = 1, text = var2.title }),
        Content = React.createElement(
            Dialog.Content,
            { LayoutOrder = 2 },
            {
                Text = React.createElement(Dialog.Text, { Text = var2.body })
            }
        ),
        Buttons = React.createElement(Dialog.Actions, {
            LayoutOrder = 3,
            actions = {
                {
                    text = var2.buttonAsk,
                    variant = ButtonVariant.Emphasis,
                    onActivated = tbl1.onConfirm
                },
                {
                    text = var2.buttonCancel,
                    variant = ButtonVariant.Standard,
                    onActivated = tbl1.onCancel
                }
            }
        })
    })
end

local function VPCPrologue(tbl1)
    return React.createElement(if GetFFlagEnableReusableVPCPrologue() then ConfigurableVPCPrologue else LegacyVPCPrologue, tbl1)
end

return VPCPrologue
