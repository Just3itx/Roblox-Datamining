-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T16:01:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialLibraries = script:FindFirstAncestor("SocialLibraries")
local dependencies = require(SocialLibraries.dependencies)
local llama = dependencies.llama
local Enums = require(script.Parent.Parent.Analytics.Enums)
local Contexts = Enums.Contexts
local EventTypes = Enums.EventTypes
local SubPages = Enums.SubPages
local Pages = Enums.Pages
local _Types = require(script.Parent.Parent.Analytics.FireEvent.Types)
local isEnum = require(script.Parent.Parent.Utils.isEnum)
local t = dependencies.t
local formatKeyValidationError = require(script.Parent.formatKeyValidationError)
local formatErrorForIncorrectKey = require(script.Parent.formatErrorForIncorrectKey)

local var1 = t.strictInterface({
    context = t.any,
    eventType = t.any,
    additionalInfo = t.optional(t.table),
    formatRulesForAdditionalInfo = t.optional(t.table)
})

return function(arg1, tbl1): boolean
    llama.Dictionary.map(arg1, function(arg2, arg3)
        if isEnum(arg3) then
            arg3 = arg3.rawValue()
        end
        assert(Contexts.isEnumValue(arg2.context), formatKeyValidationError("context", "a Context enum", arg3))
        assert(EventTypes.isEnumValue(arg2.eventType), formatKeyValidationError("eventType", "an EventType enum", arg3))

        assert(
            type(arg2.additionalInfo) == "table" or arg2.additionalInfo == nil,
            formatKeyValidationError("additionalInfo", "nil or a table", arg3)
        )
        assert(
            type(arg2.formatRulesForAdditionalInfo) == "table" or arg2.formatRulesForAdditionalInfo == nil,
            formatKeyValidationError("formatRulesForAdditionalInfo", "nil or a table", arg3)
        )
        assert(formatErrorForIncorrectKey(var1)(arg2, arg3))

        if not arg2.additionalInfo then
            return
        end

        assert(
            arg2.additionalInfo.subpage == nil or SubPages.isEnumValue(arg2.additionalInfo.subpage),
            formatKeyValidationError("subpage additional info", "SubPages enum", arg3)
        )

        assert(
            arg2.additionalInfo.page == nil or Pages.isEnumValue(arg2.additionalInfo.page),
            formatKeyValidationError("page additional info", "Pages enum", arg3)
        )

        llama.Dictionary.map(tbl1 or {}, function(arg4, arg5)
            assert(arg4(arg2.additionalInfo[arg5]), arg5 .. " key is invalid. Issue with: " .. arg3)
        end)
    end)

    return true
end
