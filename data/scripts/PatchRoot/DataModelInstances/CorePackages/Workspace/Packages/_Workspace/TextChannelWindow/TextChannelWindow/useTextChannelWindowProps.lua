-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T19:10:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local React = require(scriptParentParent.React)
local useEventConnection = require(scriptParentParent.ReactUtils).useEventConnection

local FFlagExpChatTextChannelWindowFontOverride = require(script.Parent.Flags.FFlagExpChatTextChannelWindowFontOverride)

local function resolveTarget(arg1): TextChannel? -- Luacid: Inlined by compiler; 2 call sites recovered
    local target = arg1.Target
    return if target and target:IsA("TextChannel") then target else nil
end

local function resolveFontOverride(arg1) -- Luacid: Inlined by compiler; 3 call sites recovered
    return if FFlagExpChatTextChannelWindowFontOverride then if arg1.UseDefaultFont then nil else arg1.FontFace else nil
end

local function useTextChannelWindowProps(arg1)
    local target, var2 = React.useState(function()
        return resolveTarget(arg1)
    end)

    local backgroundColor, var4 = React.useState(function()
        return arg1.BackgroundColor3
    end)

    local var5 = React.useRef(target)

    useEventConnection(arg1:GetPropertyChangedSignal("Target"), function()
        local current = resolveTarget(arg1)
        var5.current = current

        var2(current)
    end, { arg1 })

    useEventConnection(arg1:GetPropertyChangedSignal("BackgroundColor3"), function()
        var4(arg1.BackgroundColor3)
    end, { arg1 })

    local var6

    if FFlagExpChatTextChannelWindowFontOverride then
        local var7

        var6, var7 = React.useState(function()
            return resolveFontOverride(arg1)
        end)

        useEventConnection(arg1:GetPropertyChangedSignal("FontFace"), function()
            var7((resolveFontOverride(arg1)))
        end, { arg1 })

        useEventConnection(arg1:GetPropertyChangedSignal("UseDefaultFont"), function()
            var7((resolveFontOverride(arg1)))
        end, { arg1 })
    else
        var6 = nil
    end

    return { target = target, backgroundColor = backgroundColor, fontOverride = var6 }
end

return useTextChannelWindowProps
