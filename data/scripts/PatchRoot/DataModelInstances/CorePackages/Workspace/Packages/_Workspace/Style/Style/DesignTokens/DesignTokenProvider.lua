-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T18:21:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local StyleParent = script:FindFirstAncestor("Style").Parent
local ArgCheck = require(StyleParent.ArgCheck)
local Cryo = require(StyleParent.Cryo)
local React = require(StyleParent.React)
local RobloxAppHooks = require(StyleParent.RobloxAppHooks)
local _RobloxAppEnums = require(StyleParent.RobloxAppEnums)
local useUiModeInfo = RobloxAppHooks.useUiModeInfo
local Context = require(StyleParent.UIBlox).Style.Context
local DesignTokenContext = require(script.Parent.DesignTokenContext)

local function DesignTokenProvider(tbl1)
    local var1 = React.useContext(Context)
    local var2 = useUiModeInfo()
    local var3 = tbl1.uiModeInfo or var2

    local tokenMappers = tbl1.tokenMappers
    local var4 = Cryo.Dictionary.keys(tokenMappers)
    local tokens = var1.style.Tokens

    ArgCheck.assert(tokens, "Design Tokens not found, ensure AppStyleProvider has been configured correctly.")

    if not tokens.LuaApps then
        tokens = Cryo.Dictionary.join(tokens, { LuaApps = {} })
    end

    tokens = Cryo.List.foldLeft(var4, function(arg1, arg2)
        local luaApps = table.clone(arg1.LuaApps)
        luaApps[arg2] = tokenMappers[arg2](var3, tokens)

        return Cryo.Dictionary.join(arg1, { LuaApps = luaApps })
    end, tokens)

    return React.createElement(DesignTokenContext.Provider, { value = tokens }, tbl1.children)
end

return DesignTokenProvider
