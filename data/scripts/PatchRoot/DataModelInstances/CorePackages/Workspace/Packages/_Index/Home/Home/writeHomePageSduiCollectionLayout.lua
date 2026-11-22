-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T00:31:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local AppStorageService = game:GetService("AppStorageService")

local function writeHomePageSduiCollectionLayout(tbl1)
    local str1 = HttpService:JSONEncode({ itemsPerRow = tbl1.items_per_row, rowsAboveFold = tbl1.rows_above_fold })

    local success, result = pcall(function(): string
        return AppStorageService:GetItem("HomePageSduiCollectionLayout")
    end)
    if success and result == str1 then
        return
    end

    pcall(function()
        AppStorageService:SetItem("HomePageSduiCollectionLayout", str1)
        AppStorageService:Flush()
    end)
end

return writeHomePageSduiCollectionLayout
