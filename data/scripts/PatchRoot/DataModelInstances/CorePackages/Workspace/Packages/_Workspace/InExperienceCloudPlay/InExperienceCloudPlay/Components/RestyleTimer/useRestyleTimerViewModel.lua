-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T18:31:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceCloudPlay = script:FindFirstAncestor("InExperienceCloudPlay")
local InExperienceCloudPlayParent = InExperienceCloudPlay.Parent

local React = require(InExperienceCloudPlayParent.React)
local _RestyleTimerView = require(script.Parent.RestyleTimerView)
local getCloudClientService = require(InExperienceCloudPlay.getCloudClientService)
local useSecondsLeft = require(InExperienceCloudPlay.Hooks.useSecondsLeft)
local useServiceProperty = require(InExperienceCloudPlay.Hooks.useServiceProperty)

local function formatTimeLeft(num1: number): string -- Luacid: Inlined by compiler; 1 call site recovered
    return string.format("%02d:%02d", num1 // 60, num1 % 60)
end

local function useRestyleTimerViewModel(tbl1): {buttonSize: number, isPopoverOpen: number, isRestyleEnabled: number, layoutOrder: number, onAreaChanged: number, onChipActivated: number, onPopoverClosed: number, onRestyleToggled: number, timeLeft: number}?
    local var1 = React.useMemo(getCloudClientService, {})
    local var2 = useServiceProperty(var1, "IsRobloxRealityEnvironment")
    local var3 = useServiceProperty(var1, "RobloxRealityFilterEnabled")
    local var4 = useServiceProperty(var1, "SessionTimeLimit")
    local bool1 = var2 == true and not tbl1.isHidden
    local var5 = useSecondsLeft
    local var6 = if bool1 then var1 else nil

    if typeof(var4) ~= "number" then
        var4 = nil
    end

    local var7 = var5(var6, var4)

    local isPopoverOpen, var9 = React.useState(false)

    local onChipActivated = React.useCallback(function()
        var9(function(arg1): boolean
            return not arg1
        end)
    end, {})
    local onPopoverClosed = React.useCallback(function()
        var9(false)
    end, {})
    local onRestyleToggled = React.useCallback(function(robloxRealityFilterEnabled: boolean)
        if var1 then
            var1.RobloxRealityFilterEnabled = robloxRealityFilterEnabled
        end
    end, { var1 })
    local onAreaChanged = tbl1.onAreaChanged
    local var8 = React.useCallback(function(arg1)
        if onAreaChanged then
            onAreaChanged("restyle-timer", arg1.AbsolutePosition, arg1.AbsoluteSize)
        end
    end, { onAreaChanged })

    local var14 = React.useRef(tbl1.onAreaRemoved)
    var14.current = tbl1.onAreaRemoved
    React.useEffect(function()
        if not bool1 then
            var9(false)
            return nil
        end
        return function()
            local current = var14.current
            if current then
                current("restyle-timer")
            end
        end
    end, { bool1 })

    if not bool1 then
        return nil
    end

    return {
        timeLeft = if var7 then formatTimeLeft(var7) else nil,
        isPopoverOpen = isPopoverOpen,
        isRestyleEnabled = var3 == true,
        buttonSize = tbl1.buttonSize,
        layoutOrder = tbl1.layoutOrder,
        onChipActivated = onChipActivated,
        onPopoverClosed = onPopoverClosed,
        onRestyleToggled = onRestyleToggled,
        onAreaChanged = var8
    }
end

return useRestyleTimerViewModel
