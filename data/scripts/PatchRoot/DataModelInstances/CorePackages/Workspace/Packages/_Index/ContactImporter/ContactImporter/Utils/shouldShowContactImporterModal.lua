-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:40:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local contactImporterModalInfo = require(script.Parent.contactImporterModalInfo)

return function(tbl1)
    local appStorageService = tbl1.appStorageService
    local userid = tbl1.userid
    if contactImporterModalInfo:isUserOptedInLocalStorage(appStorageService, userid) then
        return false
    end
    return contactImporterModalInfo:shouldUserSeeModalPotentiallyAgain(appStorageService, userid)
end
