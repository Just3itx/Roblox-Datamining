-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:11:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommonParent = script:FindFirstAncestor("AvatarExperienceCommon").Parent
local React = require(AvatarExperienceCommonParent.React)
local useAXAnimateScrollFrame = require(script.Parent.useAXAnimateScrollFrame)

return React.forwardRef(function(arg1, arg2) -- name: AnimatedScrollingFrame
    local var1 = React.useRef(nil)
    useAXAnimateScrollFrame(var1)
    local ref = React.useCallback(function(current)
        var1.current = current
        if typeof(arg2) == "table" then
            arg2.current = current
        elseif typeof(arg2) == "function" then
            arg2(current)
        end
    end, { arg2 })

    local var3 = table.clone(arg1)
    var3.children = nil
    var3.ref = ref
    return React.createElement("ScrollingFrame", var3, arg1.children)
end)
