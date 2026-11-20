-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T23:01:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppPageShell = script:FindFirstAncestor("AppPageShell")
local AppPageShellParent = AppPageShell.Parent

local AppComposition = require(AppPageShellParent.AppComposition)

local _PageTypes = require(AppPageShell.PageTypes)

local CompositionTags = AppComposition.CompositionTags

local var1 = table.freeze({})

local function resolveCompositionTags(arg1)
    if arg1 and arg1.enabled == false then
        return var1
    end

    local var2 = arg1 and arg1.layout or CompositionTags.Layout.Discovery

    return {
        root = `{CompositionTags.ContentRegion.Root} {var2}`,
        body = CompositionTags.ContentRegion.Body,
        header = CompositionTags.ContentRegion.Header
    }
end

return resolveCompositionTags
