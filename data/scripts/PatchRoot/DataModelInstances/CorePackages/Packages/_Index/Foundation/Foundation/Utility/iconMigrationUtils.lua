-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T10:20:44Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local scriptParent = script.Parent
local FoundationParent = Foundation.Parent

local uiblox = require(FoundationParent.BuilderIcons).Migration.uiblox

local isBuilderIcon = require(scriptParent.isBuilderIcon)

local function isMigrated(str1: string): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return uiblox[str1] ~= nil
end
return {
    isMigrated = isMigrated,
    isBuilderOrMigratedIcon = function(str1: string)
        return isBuilderIcon(str1) or not not isMigrated(str1)
    end,
    normalizeIconName = function(name: string)
        if not isMigrated(name) then
            return { name = name, variant = nil }
        end

        local var1 = uiblox[name]
        return {
            name = var1.name,
            variant = var1.variant
        }
    end
}
