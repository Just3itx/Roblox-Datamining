-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:40:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local script = script
local scriptParent = script.Parent
local llama = require(scriptParent.llama)
local RoduxNetworking = require(scriptParent.RoduxNetworking)
local AliasNetworking = require(scriptParent.AliasNetworking)

local AliasesReducer = require(script.Reducers.AliasesReducer)
local Actions = require(script.Actions)
local Selectors = require(script.Selectors)

local _RoduxAliasesTypes = require(script.RoduxAliasesTypes)

return {
    config = function(arg1)
        local var1 = llama.Dictionary.join(arg1, { aliasNetworking = AliasNetworking.config({ roduxNetworking = RoduxNetworking.mock() }) })

        return {
            installReducer = function()
                return AliasesReducer(var1)
            end,
            Actions = Actions,
            Selectors = Selectors(var1)
        }
    end
}
