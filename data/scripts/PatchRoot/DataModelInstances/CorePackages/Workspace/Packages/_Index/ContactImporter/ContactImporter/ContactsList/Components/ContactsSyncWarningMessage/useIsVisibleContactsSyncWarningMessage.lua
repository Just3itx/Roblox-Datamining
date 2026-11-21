-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:30:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ContactImporterParent = script:FindFirstAncestor("ContactImporter").Parent

local React = require(ContactImporterParent.React)

local ContactsSyncWarningCache = require(script.Parent.ContactsSyncWarningCache)
local num1 = game:DefineFastInt("ContactsSyncWarningImpressionsCountCap", 1)

local function isMessageHiddenInitState(): boolean
    local value = ContactsSyncWarningCache.getValue() or 0
    return value < 0 or num1 <= value
end

local function useIsVisibleContactsSyncWarningMessage(): boolean
    local var1 = React.useState(isMessageHiddenInitState)

    React.useEffect(function()
        if not var1 then
            ContactsSyncWarningCache.incrementValue()
        end
    end, { var1 })

    return not var1
end

return useIsVisibleContactsSyncWarningMessage
