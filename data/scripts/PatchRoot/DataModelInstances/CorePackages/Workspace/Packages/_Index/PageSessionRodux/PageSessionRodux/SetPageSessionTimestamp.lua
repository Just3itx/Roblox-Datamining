-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T08:41:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PageSessionRoduxParent = script:FindFirstAncestor("PageSessionRodux").Parent
local AppPage = require(PageSessionRoduxParent.RobloxAppEnums).AppPage
local makeActionCreator = require(PageSessionRoduxParent.Rodux).makeActionCreator
local mutedError = require(PageSessionRoduxParent.Loggers).mutedError

return makeActionCreator(script.Name, function(page)
    if AppPage[page] == nil then
        mutedError("SetPageSessionTimestamp action expects page to be a valid page type, %s is not in AppPage", page)
    end

    return {
        page = page,
        timestamp = tick()
    }
end)
