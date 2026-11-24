-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T01:00:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local Roact = require(scriptParentParent.Roact)
local Foundation = require(scriptParentParent.Foundation)
local useTokens = Foundation.Hooks.useTokens
local usePreferences = Foundation.Hooks.usePreferences
local withStyle = require(scriptParentParent.UIBlox).Style.withStyle

local FFlagCoreUiMigrateUIBloxToFoundation = require(scriptParentParent.SharedFlags).FFlagCoreUiMigrateUIBloxToFoundation

local function FoundationStyleAdapter(arg1)
    local var1 = useTokens()
    local var2 = usePreferences()
    local var3 = arg1.tokenMapper(var1, var2)
    return arg1.renderContent(var3)
end

local function withFoundationOrUIBloxStyle(tokenMapper, renderContent)
    if FFlagCoreUiMigrateUIBloxToFoundation then
        return Roact.createElement(FoundationStyleAdapter, { tokenMapper = tokenMapper, renderContent = renderContent })
    end

    return withStyle(function(arg1)
        return renderContent(arg1)
    end)
end

return withFoundationOrUIBloxStyle
