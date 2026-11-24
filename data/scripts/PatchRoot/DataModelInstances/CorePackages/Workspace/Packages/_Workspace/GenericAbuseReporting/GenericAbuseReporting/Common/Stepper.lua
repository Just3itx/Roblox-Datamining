-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:51:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReportingParent = script:FindFirstAncestor("GenericAbuseReporting").Parent

local Cryo = require(GenericAbuseReportingParent.Cryo)
local React = require(GenericAbuseReportingParent.React)
local Foundation = require(GenericAbuseReportingParent.Foundation)
local Button = Foundation.Button
local View = Foundation.View
local ButtonVariant = Foundation.Enums.ButtonVariant

local function validateSteps(steps)
    if not steps or type(steps) ~= "table" then
        return "Steps must not be nil and be a table", false
    end
    for k, step in pairs(steps) do
        if k ~= step.stepId then
            return `Step id mismatch: key {k} does not match step.stepId {step.stepId}`, false
        end
    end
    return "", true
end

return React.memo(function(tbl1) -- name: Stepper
    local var1, var2 = React.useState(tbl1.currentStep)
    local var3, var4 = React.useState({ tbl1.currentStep })

    local var5 = React.useCallback(function(arg1)
        if tbl1.onErrorCallback then
            tbl1.onErrorCallback(arg1)
            return
        end
        warn(arg1)
    end, { tbl1.onErrorCallback })

    React.useEffect(function()
        local str1, bool1 = validateSteps(tbl1.steps)
        if not bool1 then
            var5(str1)
        end
    end, { tbl1.steps, tbl1.onErrorCallback, var5 })

    local var6 = React.useMemo(function()
        return tbl1.steps and tbl1.steps[var1]
    end, { var1, tbl1.steps })

    local var7 = React.useCallback(function(arg1): boolean
        if not tbl1.steps[arg1] then
            return false
        end
        var2(arg1)

        local var7 = table.find(var3, arg1)
        if var7 then
            var4(function(arg2)
                if #arg2 == 0 then
                    return arg2
                end
                return Cryo.List.removeRange(arg2, var7 + 1, #arg2)
            end)
        else
            var4(function(arg2)
                local var8 = table.clone(arg2)
                table.insert(var8, arg1)
                return var8
            end)
        end
        return true
    end, { tbl1.steps, var3 })

    local onActivated = React.useCallback(function()
        if not var6 or var6.validateState and not var6.validateState() then
            return
        end

        if var7(var6.predefinedNextStepId) and var6.onStepContinue then
            var6.onStepContinue()
        end
    end, { var6, var7 })

    local var8 = React.useCallback(function()
        local var9 = var3[#var3 - 1]
        if var9 and var7(var9) and var6 and var6.onStepCancel then
            var6.onStepCancel()
        end
    end, { var3, var6, var7 })

    if var6 == nil then
        return nil
    end

    local createElement = React.createElement
    local var10 = View
    local tbl2 = { tag = "auto-xy col flex-between" }

    local tbl3 = {
        ContentContainer = React.createElement(View, { tag = "size-full-0 auto-y", LayoutOrder = 0 }, var6.content),
        ButtonRow = 0,
        FooterContainer = 0
    }
    local createElement2 = React.createElement
    local var11 = View
    local tbl4 = {
        tag = `size-full-0 auto-y padding-y-small gap-small row {var6.stepStyle and var6.stepStyle.buttonXAlignment}`,
        LayoutOrder = 1
    }
    local tbl5 = { BackButton = 0, ContinueButton = 0 }
    local element

    if var6.labels and var6.labels.backButton then
        element = React.createElement(Button, {
            onActivated = var8,
            text = var6.labels.backButton,
            variant = var6.stepStyle and var6.stepStyle.backButton and var6.stepStyle.backButton.variant or ButtonVariant.Text,
            fillBehavior = if var6.stepStyle and var6.stepStyle.backButton then var6.stepStyle.backButton.fillBehavior or nil else nil,
            LayoutOrder = 0
        })
    else
        element = nil
    end

    tbl5.BackButton = element
    local element2

    if var6.labels and var6.labels.continueButton then
        element2 = React.createElement(Button, {
            onActivated = onActivated,
            text = var6.labels.continueButton,
            variant = var6.stepStyle and var6.stepStyle.continueButton and var6.stepStyle.continueButton.variant or ButtonVariant.Standard,
            fillBehavior = if var6.stepStyle and var6.stepStyle.continueButton then var6.stepStyle.continueButton.fillBehavior or nil else nil,
            LayoutOrder = 1
        })
    else
        element2 = nil
    end

    tbl5.ContinueButton = element2
    tbl3.ButtonRow = createElement2(var11, tbl4, tbl5)

    tbl3.FooterContainer = if var6.footer then React.createElement(
        View,
        { tag = "size-full-0 auto-y col", LayoutOrder = 2 },
        {
            Divider = React.createElement(View, { tag = "size-full-50 bg-shift-100 padding-bottom-medium", LayoutOrder = 0 }),
            Footer = React.createElement(View, { tag = "auto-xy padding-top-medium" }, var6.footer)
        }
    ) else nil
    return (createElement(var10, tbl2, tbl3))
end)
