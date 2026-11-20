-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:21:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local R15plusUtils = require(scriptParentParent.util.R15plusUtils)

local module = {}

local tbl1 = {
    "Head",
    "UpperTorso",
    "LeftFoot",
    "RightFoot",
    "LeftHand",
    "RightHand"
}
local var1 = nil
local var2 = nil
local var3 = nil

local function ensureCaches()
    if var3 then
        return
    end

    local tbl2 = ({})
    local tbl3 = ({})
    local tbl4 = ({})

    local function traverse(arg1, str1: string?, str2: string)
        for value, value2 in arg1 do
            if value2.ClassName ~= "Bone" then
                continue
            end

            tbl2[value] = true

            if str1 == nil then
                if not tbl3[str2] then
                    tbl3[str2] = {}
                end
                table.insert(tbl3[str2], value)
            else
                if not tbl4[str1] then
                    tbl4[str1] = {}
                end
                table.insert(tbl4[str1], value)
            end

            if value2._children then
                traverse(value2._children, value, str2)
            end
        end
    end

    for _, value in tbl1 do
        traverse(R15plusUtils.getAvatarBoneSchema(value), nil, value)
    end

    var1 = tbl3
    var2 = tbl4
    var3 = tbl2
end

function module.hasBoneFolders(arg1)
    for _, descendant in arg1:GetDescendants() do
        if descendant:IsA("Folder") and module.isBoneFolderName(descendant.Name) then
            return true
        end
    end
    return false
end

function module.isBoneFolderName(name: string): boolean
    ensureCaches()
    return var3[name] == true
end

function module.getRootBoneNamesForBodyPart(str1: string)
    ensureCaches()
    return var1[str1] or {}
end

function module.getChildBoneNames(str1: string)
    ensureCaches()
    return var2[str1] or {}
end

return module
