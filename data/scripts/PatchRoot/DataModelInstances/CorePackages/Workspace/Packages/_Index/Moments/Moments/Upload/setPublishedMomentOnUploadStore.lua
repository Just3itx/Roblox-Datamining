-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T05:40:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local refreshOwnMomentsAfterPublish = require(script.Parent.refreshOwnMomentsAfterPublish)

local function setPublishedMomentOnUploadStore(num1: number, tbl1, arg1)
    local var1 = refreshOwnMomentsAfterPublish(num1, arg1)
    if var1 ~= nil then
        tbl1.setSuccess(var1)
        return
    end
    tbl1.setSuccess(num1)
end

return setPublishedMomentOnUploadStore
