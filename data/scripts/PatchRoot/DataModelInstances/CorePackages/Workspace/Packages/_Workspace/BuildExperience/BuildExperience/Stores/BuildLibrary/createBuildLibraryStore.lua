-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:51:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local Signals = require(BuildExperience.Parent.Signals)

local str1 = game:DefineFastString("BuildExperienceLibraryImageClasses", "Decal,Texture,ImageLabel,ImageButton")
local str2 = game:DefineFastString("BuildExperienceLibrarySoundClasses", "Sound")
local str3 = game:DefineFastString(
    "BuildExperienceLibraryRoots",
    "Workspace,ReplicatedStorage,ReplicatedFirst,Lighting,SoundService,StarterGui,StarterPack,StarterPlayer"
)

local str4 = game:DefineFastString("BuildExperienceLibraryDescriptionAttribute", "SemanticDescription")

local tbl1 = {
    Decal = "Texture",
    Texture = "Texture",
    ImageLabel = "Image",
    ImageButton = "Image",
    ParticleEmitter = "Texture",
    Beam = "Texture",
    Trail = "Texture"
}

local tbl2 = { Sound = "SoundId", AudioPlayer = "Asset" }

local tbl3 = { Model = 1, Image = 2, Sound = 3 }

local function parseList(str5: string)
    local result = {}
    for value in string.gmatch(str5, "[^,]+") do
        local var1 = string.match(value, "^%s*(.-)%s*$")
        if var1 ~= "" and not table.find(result, var1) then
            table.insert(result, var1)
        end
    end
    return result
end

local function createBuildLibraryStore(arg1)
    local var1 = arg1 or game
    local tbl4 = parseList(str1)
    local tbl5 = parseList(str2)
    local tbl6 = parseList(str3)
    local getItems, var3 = Signals.createSignal({})
    local var4 = (setmetatable({}, { __mode = "k" }))
    local num1 = 0
    local var5 = nil
    local function getId(arg2) -- Luacid: Inlined by compiler; 2 call sites recovered
        if var4[arg2] == nil then
            num1 += 1
            var4[arg2] = `Instance:{num1}`
        end
        return var4[arg2]
    end

    local tbl7 = {}

    local function sameItems(tbl8, tbl9)
        if #tbl8 ~= #tbl9 then
            return false
        end
        for value, value2 in tbl9 do
            local var6 = tbl8[value]
            for value3, value4 in value2 do
                if var6[value3] ~= value4 then
                    return false
                end
            end
            for value3 in var6 do
                if value2[value3] == nil then
                    return false
                end
            end
        end
        return true
    end

    return {
        refresh = function()
            local tbl8 = {}
            local tbl9 = ({})
            var5 = nil
            local function parentFolderId(arg2, arg3, rootName: string, kind: string)
                local parent = arg2.Parent
                while parent ~= nil and parent ~= arg3 do
                    if parent.ClassName == "Folder" then
                        local id = `{getId(parent)}:{kind}`
                        if not tbl9[id] then
                            tbl9[id] = true
                            table.insert(tbl8, {
                                id = id,
                                instance = parent,
                                displayName = parent.Name,
                                path = parent:GetFullName(),
                                className = "Folder",
                                kind = kind,
                                folderId = parentFolderId(parent, arg3, rootName, kind),
                                rootName = rootName
                            })
                        end
                        return id
                    end
                    parent = parent.Parent
                end
                return nil
            end
            for _, rootName in tbl6 do
                local success, result = pcall(function()
                    return var1:GetService(rootName)
                end)
                if not success or result == nil then
                    continue
                end

                if rootName == "Workspace" then
                    var5 = result
                end
                local children = result:GetChildren()
                local num2 = 1

                while num2 <= #children do
                    local child = children[num2]
                    num2 += 1
                    local className = child.ClassName
                    if className ~= "Model" then
                        for _, child2 in child:GetChildren() do
                            table.insert(children, child2)
                        end
                    end

                    local var6 = if table.find(tbl4, className) then tbl1[className] else nil
                    local var7 = if table.find(tbl5, className) then tbl2[className] else nil
                    local str5

                    if className == "Model" then
                        str5 = "Model"
                    elseif var7 == nil then
                        if var6 == nil then
                            continue
                        end

                        str5 = "Image"
                    else
                        var6 = var7
                        str5 = "Sound"
                    end

                    local var8 = if var6 == nil then nil else child[var6]

                    if var8 == "" then
                        continue
                    end

                    local var9 = child:GetAttribute(str4)
                    local tbl10 = {
                        id = getId(child),
                        instance = child,
                        displayName = child.Name,
                        path = child:GetFullName(),
                        className = className,
                        kind = str5,
                        folderId = parentFolderId(child, result, rootName, str5),
                        rootName = rootName,
                        description = 0,
                        image = 0,
                        soundId = 0,
                        model = 0
                    }

                    if type(var9) ~= "string" or var9 == "" then
                        var9 = nil
                    end

                    tbl10.description = var9
                    tbl10.image = if str5 == "Image" then var8 else nil
                    if str5 ~= "Sound" then
                        var8 = nil
                    end

                    tbl10.soundId = var8
                    if str5 ~= "Model" then
                        child = nil
                    end

                    tbl10.model = child
                    table.insert(tbl8, tbl10)
                end
            end

            local tbl10 = ({})
            for _, value in tbl8 do
                tbl10[value] = string.lower(value.displayName)
            end
            table.sort(tbl8, function(arg2, arg3): boolean
                if arg2.kind ~= arg3.kind then
                    return tbl3[arg2.kind] < tbl3[arg3.kind]
                end
                local var6 = tbl10[arg2]
                local var7 = tbl10[arg3]

                if var6 == var7 then
                    if arg2.path == arg3.path then
                        return arg2.id < arg3.id
                    end

                    return arg2.path < arg3.path
                end

                return var6 < var7
            end)

            if sameItems(getItems(false), tbl8) then
                return
            end
            tbl7 = {}
            for _, value in tbl8 do
                tbl7[value.id] = value
            end
            var3(tbl8)
        end,
        getItems = getItems,
        getItem = function(arg2, str5: string)
            getItems(arg2)
            return tbl7[str5]
        end,
        resolveWorldItem = function(arg2)
            while arg2 ~= nil do
                local var6 = var4[arg2]
                local var7 = if var6 == nil then nil else tbl7[var6]

                if var7 ~= nil and var7.model == arg2 then
                    return if var5 == nil or not arg2:IsDescendantOf(var5) then nil else var7
                end
                arg2 = arg2.Parent
            end
            return nil
        end
    }
end
return createBuildLibraryStore
