-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:31:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitivesParent = script:FindFirstAncestor("ChatUIPrimitives").Parent
local React = require(ChatUIPrimitivesParent.React)
local Foundation = require(ChatUIPrimitivesParent.Foundation)

local Sizing = require(script.Parent.Parent.Parent.Sizing)
local getBubbleTone = require(script.Parent.getBubbleTone)

local Context = React.createContext(nil)

local function createBubbleStyle(bool1: boolean, arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    return {
        textStyle = getBubbleTone(bool1, arg1).textStyle
    }
end

local function useBubbleStyle()
    local var1 = React.useContext(Context)
    local var2 = Foundation.Hooks.useTokens()
    local var3 = React.useMemo(function()
        return createBubbleStyle(false, var2)
    end, { var2 })
    return if var1 == nil then var3 else var1
end

return {
    Context = Context,
    createBubbleStyle = createBubbleStyle,
    useBubbleStyle = useBubbleStyle,
    useBubbleFontStyle = function()
        return useBubbleStyle(), Sizing.useSizing().bubble.fontStyle
    end
}
