-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:01:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedContentParent = script:FindFirstAncestor("SduiSharedContent").Parent

local React = require(SduiSharedContentParent.React)
local ReactOtter = require(SduiSharedContentParent.ReactOtter)

local Sine = Enum.EasingStyle.Sine

local tbl1 = {
    isPlaceholder = true,
    real = true,
    placeholder = true,
    transitionDurationSeconds = true,
    mountRealDuringPlaceholder = true,
    layoutOrder = true,
    zIndex = true,
    componentConfig = true,
    sduiContext = true,
    debugName = true,
    analyticsContext = true
}

local function PlaceholderHost(tbl2)
    local fadeOut = tbl2.fadeOut
    local durationSeconds = tbl2.durationSeconds
    local onFadeComplete = tbl2.onFadeComplete

    local var1 = React.useCallback(function(num1: number)
        if num1 >= 1 then
            onFadeComplete()
        end
    end, { onFadeComplete })

    local transparencyBinding, var3 = ReactOtter.useAnimatedBinding(if fadeOut then 1 else 0, var1)

    local var4 = React.useRef(fadeOut)

    React.useEffect(function()
        local current = var4.current
        var4.current = fadeOut
        if current == fadeOut then
            return
        end
        var3((ReactOtter.ease(if fadeOut then 1 else 0, { duration = durationSeconds, easingStyle = Sine })))
    end, { fadeOut, durationSeconds, var3 })

    return React.cloneElement(tbl2.placeholder, { transparencyBinding = transparencyBinding, zIndex = tbl2.zIndex })
end

return React.memo(function(tbl2) -- name: SduiPlaceholderWrapper
    local bool1 = tbl2.isPlaceholder == true
    local transitionDurationSeconds = tbl2.transitionDurationSeconds or 0.15

    local var1, var2 = React.useState(bool1)

    React.useEffect(function()
        if bool1 and not var1 then
            var2(true)
        end
    end, { bool1, var1 })

    local onFadeComplete = React.useCallback(function()
        var2(false)
    end, {})

    local bool2 = tbl2.mountRealDuringPlaceholder == true
    local real

    if (not var1 or not bool1 or bool2) and tbl2.real then
        local var4 = nil
        for value, value2 in tbl2 do
            if not tbl1[value] then
                var4 = var4 == nil and {} or var4

                var4[value] = value2
            end
        end
        if var4 then
            real = React.cloneElement(tbl2.real, var4)
        else
            real = tbl2.real
        end
    else
        real = nil
    end

    local placeholder = if var1 and tbl2.placeholder then React.createElement(PlaceholderHost, {
        placeholder = tbl2.placeholder,
        fadeOut = not bool1,
        durationSeconds = transitionDurationSeconds,
        onFadeComplete = onFadeComplete,
        zIndex = math.huge
    }) else nil
    return React.createElement("Frame", {
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        LayoutOrder = tbl2.layoutOrder,
        Size = UDim2.fromScale(1, 0),
        ZIndex = tbl2.zIndex
    }, { Real = real, Placeholder = placeholder })
end)
