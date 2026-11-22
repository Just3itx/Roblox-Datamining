-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:21:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")

local function getOrCreateFolder(parent, folderName: string): Folder -- Luacid: Inlined by compiler; 2 call sites recovered
    local var1 = parent:FindFirstChild(folderName)
    if var1 and var1:IsA("Folder") then
        return var1
    end

    local folder = Instance.new("Folder")
    folder.Name = folderName
    folder.Parent = parent
    return folder
end

local function createMediaRoot(name: string, arg1)
    local folder = getOrCreateFolder(arg1 or CoreGui, "MomentMedia")
    local folder2 = getOrCreateFolder(folder, name)

    return {
        folder = folder2,
        dispose = function()
            folder2:Destroy()

            if #folder:GetChildren() == 0 then
                folder:Destroy()
            end
        end
    }
end

return createMediaRoot
