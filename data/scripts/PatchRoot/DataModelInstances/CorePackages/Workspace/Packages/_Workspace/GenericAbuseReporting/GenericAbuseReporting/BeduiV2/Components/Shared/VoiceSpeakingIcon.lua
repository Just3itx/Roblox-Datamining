-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:41:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReportingParent = script:FindFirstAncestor("GenericAbuseReporting").Parent

local Foundation = require(GenericAbuseReportingParent.Foundation)
local React = require(GenericAbuseReportingParent.React)
local _Signals = require(GenericAbuseReportingParent.Signals)
local SignalsReact = require(GenericAbuseReportingParent.SignalsReact)

local Icon = Foundation.Icon
local IconName = Foundation.Enums.IconName
local IconVariant = Foundation.Enums.IconVariant
local useTokens = Foundation.Hooks.useTokens
local View = Foundation.View

local function useDelayedFalse(bool1: boolean, time1000: number)
    local var1, var2 = React.useState(bool1)

    React.useEffect(function()
        if bool1 then
            var2(true)
            return
        end

        local var3 = task.delay(time1000, function()
            var2(false)
        end)

        return function()
            task.cancel(var3)
        end
    end, { bool1, time1000 })

    return var1
end

local function useOscillatingWidth(bool1: boolean, num1: number, num2: number)
    local var1, var2 = React.useState(num2)

    React.useEffect(function()
        if not bool1 then
            var2(num2)
            return
        end

        local var3 = nil
        local function scheduleNext() -- Luacid: Inlined by compiler; 1 call site recovered
            var3 = task.delay(0.15, function()
                local num3 = num1 + math.random() * (num2 - num1)
                var2(num3)
                scheduleNext()
            end)
        end

        scheduleNext()

        return function()
            if var3 then
                task.cancel(var3)
            end
        end
    end, { bool1, num1, num2 })

    return if bool1 then var1 else num2
end

return React.memo(function(tbl1) -- name: VoiceSpeakingIcon
    local var1 = useTokens()
    local time1000 = var1.Time.Time_1000
    local var2 = SignalsReact.useSignalState(tbl1.isSpeakingSignal)

    local var3 = useDelayedFalse(var2, time1000)
    local xScale = useOscillatingWidth(var3, 0.2, 1)

    return React.createElement(View, {
        tag = "auto-xy",
        LayoutOrder = tbl1.layoutOrder
    }, {
        GreenFilledIconContainer = if var3 then React.createElement(
            "Frame",
            {
                ClipsDescendants = true,
                Size = UDim2.fromScale(xScale, 1),
                BackgroundTransparency = 1,
                ZIndex = 2
            },
            {
                GreenFilledIcon = React.createElement(Icon, { name = IconName.Speaker, variant = IconVariant.Filled, style = var1.Color.System.Success })
            }
        ) else nil,
        Icon = React.createElement(Icon, { name = IconName.Speaker, style = var1.Color.Content.Default })
    })
end)
