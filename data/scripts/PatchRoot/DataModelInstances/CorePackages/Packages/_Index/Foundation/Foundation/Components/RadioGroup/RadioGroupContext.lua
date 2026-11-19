-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:41:02Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local FoundationParent = script:FindFirstAncestor("Foundation").Parent

return require(FoundationParent.React).createContext({
    value = nil,
    onValueChanged = function(_: string)
        warn("No RadioGroupProvider found for RadioGroup")
    end,
    Selectable = true,
    testId = ""
})
