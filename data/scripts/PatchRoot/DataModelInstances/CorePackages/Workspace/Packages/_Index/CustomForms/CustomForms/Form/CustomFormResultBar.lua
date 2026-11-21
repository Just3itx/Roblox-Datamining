-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T09:41:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CustomFormsParent = script:FindFirstAncestor("CustomForms").Parent

local React = require(CustomFormsParent.React)
local Foundation = require(CustomFormsParent.Foundation)
local useLocalization = require(CustomFormsParent.Localization).Hooks.useLocalization
local ReactOtter = require(CustomFormsParent.ReactOtter)

local tbl1 = { dampingRatio = 1, frequency = 2.5 }

return React.memo(function(tbl2) -- name: CustomFormResultBar
    local reducedMotion = Foundation.Hooks.usePreferences().reducedMotion
    local var1 = Foundation.Hooks.useTokens()
    local var2 = useLocalization({ caption = { "Feature.CustomForms.Label.Percent", number = tbl2.percentage } })

    local var3, var4 = ReactOtter.useAnimatedBinding(0)
    local bool1 = tbl2.isSelected == true

    React.useEffect(function()
        var4(if reducedMotion then ReactOtter.instant(tbl2.percentage) else ReactOtter.spring(tbl2.percentage, tbl1))
    end, { tbl2.percentage, reducedMotion })

    local createElement = React.createElement
    local view = Foundation.View
    local tbl3 = {
        LayoutOrder = tbl2.layoutOrder,
        tag = {
            ["size-full-0 auto-y stroke-standard radius-medium clip"] = true,
            ["stroke-emphasis"] = bool1,
            ["stroke-default"] = not bool1
        },
        testId = tbl2.testId
    }

    local tbl4 = {
        Fill = React.createElement(Foundation.View, {
            Size = var3:map(function(num1: number)
                return UDim2.fromScale(math.clamp(num1 / 100, 0, 1), 1)
            end),
            ZIndex = 1,
            tag = {
                ["radius-medium"] = true,
                ["bg-shift-300"] = bool1,
                ["bg-shift-200"] = not bool1
            },
            testId = `{tbl2.testId}--bar`
        }),
        Content = 0
    }
    local createElement2 = React.createElement
    local view2 = Foundation.View
    local tbl5 = {
        ZIndex = 2,
        tag = "row align-y-center gap-small size-full-0 auto-y padding-x-medium padding-y-medium"
    }

    local tbl6 = {
        Label = React.createElement(Foundation.Text, {
            Text = tbl2.label,
            LayoutOrder = 1,
            tag = {
                ["fill auto-y text-body-large text-wrap text-align-x-left content-emphasis"] = true
            }
        }),
        Check = 0,
        Caption = 0
    }
    local element

    if bool1 and tbl2.viewerUserId then
        element = React.createElement(Foundation.AvatarIcon, {
            userId = tbl2.viewerUserId,
            size = Foundation.Enums.AvatarIconSize.Medium,
            backgroundStyle = var1.Color.Shift.Shift_400,
            LayoutOrder = 2,
            testId = `{tbl2.testId}--selected`
        })
    elseif bool1 then
        element = React.createElement(Foundation.Icon, {
            name = Foundation.Enums.IconName.CircleCheck,
            size = Foundation.Enums.IconSize.Small,
            LayoutOrder = 2,
            testId = `{tbl2.testId}--selected`
        })
    else
        element = nil
    end

    tbl6.Check = element

    tbl6.Caption = React.createElement(Foundation.Text, {
        Text = var2.caption,
        LayoutOrder = 3,
        testId = `{tbl2.testId}--caption`,
        tag = {
            ["auto-xy text-body-large text-align-x-right"] = true,
            ["content-emphasis"] = bool1,
            ["content-default"] = not bool1
        }
    })
    tbl4.Content = createElement2(view2, tbl5, tbl6)
    return createElement(view, tbl3, tbl4)
end)
