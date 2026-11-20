-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:01:06Z
-- Luau bytecode version: 14 | Luau type version: 3
local scriptParentParentParentParentParent = script.Parent.Parent.Parent.Parent.Parent
local var1 = require(scriptParentParentParentParentParent.UIBlox.Core.Utility.GetEngineFeatureSafe)("EnablePreferredTextSizeSetting")

local t = require(scriptParentParentParentParentParent.t)

return (t.strictInterface({
    PreferredTransparency = t.optional(t.number),
    ReducedMotion = t.optional(t.boolean),
    PreferredTextSize = if var1 then t.optional(t.enum(Enum.PreferredTextSize)) else nil,
    Scale = t.optional(t.number)
}))
