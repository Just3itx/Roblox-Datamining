-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:50:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local _createBuildLibraryStore = require(BuildExperience.Stores.BuildLibrary.createBuildLibraryStore)

local function getLibraryMatches(tbl1, kind, str1: string, folderId: string?, bool1: boolean)
    local libraryMatches = {}
    local str2 = string.lower(str1)
    local tbl2 = {}
    if bool1 and folderId ~= nil then
        for _, value in tbl1 do
            if value.className == "Folder" and value.folderId ~= nil then
                tbl2[value.id] = value.folderId
            end
        end
    end
    for _, value in tbl1 do
        local bool2 = value.folderId == folderId
        if bool1 then
            local folderId2 = value.folderId
            while folderId ~= nil and folderId2 ~= nil and folderId2 ~= folderId do
                folderId2 = tbl2[folderId2]
            end
            if value.className == "Folder" then
                bool2 = false
            else
                bool2 = folderId == nil or folderId2 == folderId
            end
        end

        if (kind == nil or value.kind == kind)
            and bool2
            and (str2 == "" or string.find(string.lower(value.displayName), str2, 1, true) ~= nil)
        then
            table.insert(libraryMatches, value)
        end
    end
    return libraryMatches
end

return getLibraryMatches
