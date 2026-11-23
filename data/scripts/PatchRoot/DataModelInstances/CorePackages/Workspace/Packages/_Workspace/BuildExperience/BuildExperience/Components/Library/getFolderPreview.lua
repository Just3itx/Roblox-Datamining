-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:50:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _LibraryTypes = require(script.Parent.LibraryTypes)

local function getFolderPreview(arg1, tbl1)
    if arg1.className ~= "Folder" then
        return nil
    end
    local tbl2 = {}
    for _, value in tbl1 do
        if value.folderId ~= arg1.id or value.kind ~= arg1.kind then
            continue
        end

        if value.className ~= "Folder" then
            return value
        end
        table.insert(tbl2, value)
    end

    for _, value in tbl2 do
        local folderPreview = getFolderPreview(value, tbl1)
        if folderPreview ~= nil then
            return folderPreview
        end
    end
    return nil
end

return getFolderPreview
