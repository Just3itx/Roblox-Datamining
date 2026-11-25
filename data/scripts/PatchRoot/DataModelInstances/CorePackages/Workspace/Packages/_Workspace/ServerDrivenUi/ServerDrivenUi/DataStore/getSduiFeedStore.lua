-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:31:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUi = script:FindFirstAncestor("ServerDrivenUi")
local ServerDrivenUiParent = ServerDrivenUi.Parent
local _RobloxAppEnums = require(ServerDrivenUiParent.RobloxAppEnums)
local _SduiFeedStoreTypes = require(ServerDrivenUi.DataStore.SduiFeedStoreTypes)
local createSduiFeedStore = require(ServerDrivenUi.DataStore.createSduiFeedStore)

local tbl1 = ({})

return function(str1: string)
    local var1 = tbl1[str1]
    if var1 == nil then
        tbl1[str1] = createSduiFeedStore()
        var1 = tbl1[str1]
    end
    return var1
end
